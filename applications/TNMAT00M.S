; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00C.PRN" MSG='post process auto access connectors'
FILEI LOOKUPI[3] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\tempnode.csv"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\statdata.csv"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\TNMAT00D.PRN"
FILEI RECI = "{SCENARIO_DIR}\output\TNPTR00A.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (park-ride access time)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))
;s23='XN=1'

; LOOKUP for coefficient file
LOOKUP NAME=COEFF, LOOKUP[1]=1, RESULT=3,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=3
ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

; LOOKUP for station data information 
LOOKUP, NAME=PNRSTATIONS, LOOKUP[1]=2, RESULT=3, LOOKUP[2]=2, RESULT=4, LOOKUP[3]=2, RESULT=7, LOOKUP[4]=2, RESULT=8,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0, list=n, LOOKUPI=1
        stnzone=PNRSTATIONS(1,zonej)
        maxd = PNRSTATIONS(2,zonej)     ; range for the parking lot
        prkcost=PNRSTATIONS(3,zonej)
        pnrtermtime=PNRSTATIONS(4,zonej)

;*************************************************************
; soft range logic in autocon (adjust time on the connectors)
;*************************************************************
   deletecon=0
   orgtime=time ; reporting purposes
   if (dist > maxd)
    outtime=((dist-maxd)/dist)*time
    intime =time-outtime
    adjtime=intime+pow((1+outtime),3)
    if (adjtime > 60.0) 
     deletecon=1
    else
     time=adjtime
    endif
    print list='***** in*********',dist(5.2),',',maxd(5.2),',',outtime,',',intime,',',orgtime,',',adjtime,',',deletecon
   endif

;*******************************************************************************************
; take care of auto connectors (include other costs on these connectors)
;; this cost contains auto access time, terminal time, parking cost and the operating cost
;*******************************************************************************************
   if (prkcost < 9999)
    cost=aatfactor*time + ovtfactor*pnrtermtime + ((0.6/valtime)*prkcost/{OCCPNRAccess}/2.0) + ((0.6/valtime)*{hwyopcost}/{OCCPNRAccess}*dist)
   endif

;************************************
; backtracking logic in autocon
;************************************
lookup lookupi=2,name=netcoord, lookup[1]=1, result=2, lookup[2]=1, result=3, list=n, fail=0,0,0, interpolate=n

backd=4.0
backpc=0.3
cbd={CBDZONE}
xback=0
bx=1
by=1
xb=0
yb=0
xt=0
xpc=0

xcbd=netcoord(1,cbd,0)
ycbd=netcoord(2,cbd,0)
xzonei=netcoord(1,zonei,0)
yzonei=netcoord(2,zonei,0)
xzonej=netcoord(1,zonej,0)
yzonej=netcoord(2,zonej,0)

if ((xzonej >= xzonei) & (xzonej <= xcbd)) bx=0
if ((xzonej >= xcbd) & (xzonej <= xzonei)) bx=0
if ((yzonej >= yzonei) & (yzonej <= ycbd)) by=0
if ((yzonej >= ycbd) & (yzonej <= yzonei)) by=0

dcbd = sqrt((xzonei-xcbd)^2+(yzonei-ycbd)^2)

if (bx=1) then
 if ((xcbd >= xzonei) & (xcbd <= xzonej)) bx=2
 if ((xzonei >= xzonej) & (xzonei <= xcbd)) bx=3
 if ((xcbd >= xzonej) & (xcbd <= xzonei)) bx=2
 if ((xzonei >= xcbd) & (xzonei <= xzonej)) bx=3
endif
if(bx=2) xb=abs(xcbd-xzonej)
if(bx=3) xb=abs(xzonei-xzonej)

if (by=1) then
 if ((ycbd >= yzonei) & (ycbd <= yzonej)) by=2
 if ((yzonei >= yzonej) & (yzonei <= ycbd)) by=3
 if ((ycbd >= yzonej) & (ycbd <= yzonei)) by=2
 if ((yzonei >= ycbd) & (yzonei <= yzonej)) by=3
endif
if(by=2) yb=abs(ycbd-yzonej)
if(by=3) yb=abs(yzonei-yzonej)

xt=xb+yb
if (dcbd > 0) xpc=xt/dcbd
if (xt > backd) xback=1
if (xpc > backpc) xback=1
if (zonei=cbd) xback=1

print list=zonei,',',zonej,',',xzonei(10.6),',',yzonei(10.6),',',xzonej(10.6),',',yzonej(10.6),',',xcbd(10.6),',',ycbd(10.6),',',dcbd(10.6),',',xt(10.6),',',xpc(10.6),',',xback


if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  _ctr = _ctr + 1
endif
if (mode=2 & deletecon=0 & xback=0) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",cost(6.2)," DIST=",dist(5.2)," ",s23,PRINTO=1

 
ENDRUN
