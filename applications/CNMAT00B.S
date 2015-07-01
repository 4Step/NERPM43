; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B.PRN" MSG='OffPeak walk, pnr, knr connectors'

FILEI RECI = "{SCENARIO_DIR}\output\NTLEGOP_{YEAR}{ALT}.NTL"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG3OP_{alt}{year}.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\NTLEG2OP_{alt}{year}.NTL"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1OP_TEM.NTL"

FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEO PRINTO[5] = "{Scenario_Dir}\output\NTLEG12OP_{alt}{year}.NTL"
FILEO PRINTO[4] = "{Scenario_Dir}\output\NTLEG11OP_{alt}{year}.NTL"

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

; get the time on the connector (cost field in the NT leg file)
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

; ############# check for error in time field #################
if (time > 999)
 time=999
 print list='*****Error in the time field, Time exceeds 999 min *****', zonei(5.0),'-',zonej(5.0),mode(3.0)
endif
;##############################################################

; LOOKUP for coefficient file
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=2
ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  PRINT LIST=";;<<PT>>;;", PRINTO=2
  PRINT LIST=";;<<PT>>;;", PRINTO=3
  _ctr = _ctr + 1
endif

if (mode=1) PRINT FORM=L, LIST="NT LEG=",zonei,"-",zonej," MODE=",mode," COST=",time(6.2L)," DIST=",dist(6.2L)," ",s23,PRINTO=1
if (mode=2) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=2
if (mode=3) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=3
if (mode=11) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=4
if (mode=12) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=5

ENDRUN
