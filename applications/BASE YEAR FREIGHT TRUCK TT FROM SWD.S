; Script for program HIGHWAY in file "C:\NERPM50\APPLICATIONS\BFHWY00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{CATALOG_DIR}\output_SWM\base_SWM\BFHWY00A.PRN" MSG='SWM - Base Year - Assign Auto & Trucks to Extract Subarea TT'
;Using node 1 for base run
;DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO SUBAREAMATO = "{Catalog_Dir}\output_SWM\base_SWM\nerpm4tt.mat",
  NAME=Short,ShortXBEI,LT,LDB,InSTour,OutSTour,MT,HT,FrtTrk
FILEI SUBAREANETI = "{Catalog_Dir}\input_SWM\base_SWM\Nerpm4 Extract.net"
FILEI NETI = "{Catalog_Dir}\input_SWM\base_SWM\UNLOADED_B05.NET"
FILEI MATI[3] = "{Catalog_Dir}\input_SWM\base_SWM\FREIGHT.B05"
FILEI MATI[2] = "{Catalog_Dir}\input_SWM\base_SWM\TRUCKS-OD.B05"
FILEI MATI[1] = "{Catalog_Dir}\input_SWM\base_SWM\XTT_OD_05B.MAT"
FILEI TURNPENI = "{Catalog_Dir}\input_SWM\base_SWM\TURN_05B.PEN"
FILEO NETO = "{CATALOG_DIR}\output_SWM\base_SWM\XLOD_05B.NET"

;PAR ZONEMSG=10 COMBINE=EQUI MAXITERS=50 GAP=0.001 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 
PAR ZONEMSG=10 COMBINE=EQUI MAXITERS=5 GAP=0.001 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 

; look up deceleration rate based on approach speed
LOOKUP,
 INTERPOLATE=Y, LIST=Y, NAME=DECEL,
        LOOKUP[1]=1,RESULT=2,
R = '30 4',
    '70 6.2'

PHASE=LINKREAD
     LW.BPRCOEFFICIENT=LI.BPRCOEFFICIENT
     LW.BPREXPONENT=LI.BPREXPONENT

  if (LI.FTYPE_05=10-19,70-79) ADDTOGROUP=7
;USER SUPPLIED ALPHA AND BETA FOR THE BPR CURVE
   LW.DAILYCAP=((LI.LANE_05*LI.CAPACITY)/LI.CONFAC)* LI.UROADFACTOR
   LW.FFTIME=LI.TIME
   T0=LI.TIME
  
C=LW.DAILYCAP
;IF (LI.FTYPE_05=80-89)C=LW.DAILYCAP*0.75; HOV Agginment Reduction by adjusting Capacity at 75%
LINKCLASS=1 ; no toll

T0=LW.FFTIME
      if (LI.TOLL>0 & LI.TOLL_ACC=0 & LI.TOLL_DEC=0&LI.TOLLTYPE=1-3)
       LINKCLASS=2 ; with toll
       LW.TOLLTIME=(Li.Ctoll*LI.CARTOLL)*60
       T0=(LI.Ctoll*LI.CARTOLL)*60 + LI.SVCMINUTES + LI.SVCSECONDS/60

       if (iteration=0)
        ;If ((LI.SVCMINUTES+LI.SVCSECONDS)=0)SVCSECONDS=LI.SVCSECONDS+1       
        LW.ARRIVR=V*LI.CONFAC/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
        LW.SERVT=LI.SVCMINUTES+(Li.SVCSECONDS/60)           ; Plaza lane service time in minutes per vehicle
        LW.SERVR=(1/LW.SERVT)*60
       If (LW.SERVT<0.001)
          LW.SERVR=100
          ;LW.ARRIVR=1
       ENDIF
        PRINT LIST='ARRIVR= ',LW.ARRIVR
        PRINT LIST='SERVT= ',LW.SERVT
        PRINT LIST='SERVR= ',LW.SERVR
        if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.95*LW.SERVR    ; prevent infinite or negative queue 
       endif

     endif

if (li.TOLL_ACC>0) 
  LINKCLASS=3 ; Toll Plaza Acceleration link
  T0= T0 + (LI.SPEED_05/3.5)/60
endif

if (li.TOLL_DEC>0) 
  LINKCLASS=4 ; Toll Plaza Deceleration link
  T0 = T0 + (LI.SPEED_05/DECEL(1,LI.SPEED_05))/60
endif
if (LI.TOLL>0 & LI.TOLL_ACC=0 & LI.TOLL_DEC=0 & LI.TOLLTYPE=4-6)
LINKCLASS=5 ; Open Road Toll
T0=(LI.Ctoll*LI.CARTOLL)*60
endif

IF (LI.OUTSTATE=1) ADDTOGROUP=1
IF (LI.EXCLUDE<>0) ADDTOGROUP=2
ENDPROCESS



PROCESS PHASE=ILOOP
      PATHLOAD  PATH=TIME, EXCLUDEGROUP=1,
         VOL[1]=MI.1.1,subareamat[1]=MI.1.1, ; URBAN AND RURAL SHORT TRIPS
         VOL[4]=MI.1.4,subareamat[2]=MI.1.4, ; Short-Cross-border EI
         VOL[8]=MI.2.Light*1.0,subareamat[3]=MI.2.Light*1.0 ;light trucks 
         
         
      PATHLOAD  PATH=TIME, EXCLUDEGROUP=1-2,
         VOL[2]=MI.1.2,subareamat[4]=MI.1.2, ; LONG DISTANCE BUSINESS
         VOL[3]=MI.1.3,subareamat[5]=MI.1.3  ; Long Distance In-state Tourists
         
         
      PATHLOAD  PATH=LW.FFTIME, EXCLUDEGROUP=1-2,
         VOL[5]=MI.1.5,subareamat[6]=MI.1.5, ; FL-US, US-FL. Canada-FL
         VOL[6]=MI.2.Medium*1.5,subareamat[7]=MI.2.Medium*1.5; Medium Trucks
         
      PATHLOAD  PATH=LW.FFTIME, EXCLUDEGROUP=2,
         VOL[7]=MI.2.Heavy*1.5,subareamat[8]=MI.2.Heavy*1.5,; Heavy  Trucks
         VOL[9]=MI.3.1*1.5,subareamat[9]=MI.3.1*1.5; Freight  Trucks, added based on the Freight Model

if ({SELLINK}=1)  ;Select Zone & Link Analysis
      PATH=TIME, EXCLUDEGROUP=1,MW[10]=MI.1.1,SELECTLINK=({SEL_LINK}),VOL[10]=MW[10]; URBAN AND RURAL SHORT TRIPS
      PATH=TIME, EXCLUDEGROUP=1,MW[13]=MI.1.4,SELECTLINK=({SEL_LINK}),VOL[13]=MW[13]; Short-Cross-border EI
      PATH=TIME, EXCLUDEGROUP=1,MW[17]=MI.2.Light*1.0,SELECTLINK=({SEL_LINK}),VOL[17]=MW[17]; light trucks 
         
      PATH=TIME, EXCLUDEGROUP=1-2,MW[11]=MI.1.2, SELECTLINK=({SEL_LINK}),VOL[11]=MW[11] ; LONG DISTANCE BUSINESS
      PATH=TIME, EXCLUDEGROUP=1-2,MW[12]=MI.1.3,SELECTLINK=({SEL_LINK}),VOL[12]=MW[12] ; Long Distance In-state Tourists
         
      PATH=LW.FFTIME, EXCLUDEGROUP=1-2,MW[14]=MI.1.5, SELECTLINK=({SEL_LINK}),VOL[14]=MW[14] ; FL-US, US-FL. Canada-FL
      PATH=LW.FFTIME, EXCLUDEGROUP=1-2,MW[15]=MI.2.Medium*1.5,SELECTLINK=({SEL_LINK}),VOL[15]=MW[15]; Medium Trucks
         
      PATH=LW.FFTIME, EXCLUDEGROUP=2,MW[16]=MI.2.Heavy*1.5,SELECTLINK=({SEL_LINK}),VOL[16]=MW[16]; Heavy  Trucks
      PATH=LW.FFTIME, EXCLUDEGROUP=2,MW[18]=MI.3.1*1.5,SELECTLINK=({SEL_LINK}),VOL[18]=MW[18]; Freight  Trucks, added based on the Freight Model

else
   VOL[10]=0
   VOL[11]=0
   VOL[12]=0
   VOL[13]=0
   VOL[14]=0
   VOL[15]=0
   VOL[16]=0
   VOL[17]=0
   VOL[18]=0
endif


ENDPROCESS


PROCESS PHASE=ADJUST
 FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]+VOL[8]+VOL[9]

  if (TIME>0) LW.CGSTSPEED=(LI.DISTANCE/TIME)*60
if (LI.TOLL>0 & LI.TOLL_ACC=0 & LI.TOLL_DEC=0&LI.TOLLTYPE=1-3)
   LW.ARRIVR=V*LI.CONFAC/LI.PLZALNSMAX      ; hourly volume per toll lane ie. arrival rate in vehicles per hour
   LW.SERVT=LI.SVCMINUTES+(Li.SVCSECONDS/60)                  ; Plaza lane service time in minutes per vehicle
   LW.SERVR=(1/LW.SERVT)*60  
       If (LW.SERVT<0.001)
          LW.SERVR=100
          LW.ARRIVR=1
       ENDIF
if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.95*LW.SERVR            ; prevent infinite or negative queue
print list="****",LI.PLAZADESC,"****"
PRINT LIST='ARRIVR= ',LW.ARRIVR
PRINT LIST='SERVT= ',LW.SERVT
PRINT LIST='SERVR= ',LW.SERVR
PRINT LIST='TOLLTIME= ',TIME
endif
if (lw.servr-lw.arrivr=0.0) lw.servr=lw.servr+0.01


  FUNCTION TC[1]=T0*(1+LW.BPRCOEFFICIENT*(V/C)^LW.BPREXPONENT) ; CONGESTED TIME, NO TOLL MODEL
                                                         ; Freeflow for tourists
                                                         ; Freeflow for medium trucks
                                                       ; Freeflow for heavy trucks
  FUNCTION TC[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + LI.CTOLL*LI.CARTOLL*60 
  FUNCTION TC[3]=T0*(1+LW.BPRCOEFFICIENT*(MIN(V/C,10))^LW.BPREXPONENT) + (LW.CGSTSPEED/3.5)/60; congested time toll acceleration links  FUNCTION TC[3]=T0*(1+LW.BPRCOEFFICIENT*(V/C)^LW.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60 = ; congested time toll deceleration links
  FUNCTION TC[4]=T0*(1+LW.BPRCOEFFICIENT*(MIN(V/C,10))^LW.BPREXPONENT) +((LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60); congested time toll deceleration links
  FUNCTION TC[5]=LI.CTOLL*LI.CARTOLL*60 
ENDPROCESS

ENDRUN


; Script for program NETWORK in file "C:\NERPM50\APPLICATIONS\BFNET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM50\APPLICATIONS\BFNET00A.PRN" MSG='Fix N4 Extracted Subnet for double coding freeway external stations'
FILEO PRINTO[1] = "{CATALOG_DIR}\output_SWM\base_SWM\EQ.csv"
FILEO NETO = "{Catalog_Dir}\input_SWM\base_SWM\Nerpm4 Extractx.net"
FILEI LINKI[1] = "{Catalog_Dir}\input_SWM\base_SWM\Nerpm4 Extract.net"

PROCESS  PHASE=INPUT,filei=LI.1
if(A=503) A=504
if(B=503) B=504
if(A=479) A=480
if(B=479) B=480
ENDPROCESS

PROCESS  PHASE=INPUT,filei=NI.1
if(N=503) N=504
if(N=479) N=480
ENDPROCESS


PROCESS  PHASE=NODEMERGE  
; Use this phase to make computations and selections of any data on the NODEI files.

if(n<=508) print csv=T, list=n(5.0),old_node(5.0),printo=1

ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\BFMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\BFMAT00A.PRN" MSG='Generate a record file to fix freeway external stations zones'
FILEO RECO[1] = "{CATALOG_DIR}\output_SWM\base_SWM\jaxext.dbf",
fields=n,m
zones=1
loop n=1,508
  m=n
  if(n=479) 
     m=480
  endif
  if(n=503) 
     m=504
  endif
  write reco=1
endloop

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\BFMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\BFMAT00B.PRN" MSG='Fix Extracted N4 TT to  fix freeway external stations zones'
FILEO MATO[1] = "{Catalog_Dir}\output_SWM\base_SWM\nerpm4ttx.mat",
    mo=1
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\base_SWM\nerpm4tt.mat"
FILEI ZDATI[1] = "{CATALOG_DIR}\output_SWM\base_SWM\jaxext.dbf",
    z=n

mw[1]=mi.1.9
renumber, zoneo=zi.1.m,
  MISSINGZI=M,
  MISSINGZO=w


; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\BFMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\BFMAT00C.PRN" MSG='Process to develop JaxPort Freight Truck Od tables'
FILEO RECO[2] = "{Catalog_Dir}\output_SWM\base_SWM\FTE_TT.DBF",
   fields=az,bz,tr
FILEO RECO[1] = "{Catalog_Dir}\output_SWM\base_SWM\FTE.DBF",
   fields=z,FTE
FILEI LOOKUPI[1] = "{Catalog_Dir}\input_SWM\base_SWM\JAXPORT.DBF"
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\base_SWM\nerpm4ttx.mat"
FILEO MATO[1] = "{Catalog_Dir}\output_SWM\base_SWM\JAX_PORTS.MAT",
mo=1,name=Port_trk_veh


Array prod=zones,attr=zones,jport=zones
Array zt=99,TE=99,HFR=99,IFR=99,JFR=99,TYP=99,Htrp=99,Itrp=99,Iterm=99

LOOKUP LOOKUPI=1,
       NAME=JaxPort,
         LOOKUP[1]=INDEX, RESULT=ZONE,
         LOOKUP[2]=INDEX, RESULT=TRIPENDS,
         LOOKUP[3]=INDEX, RESULT=HWY_FRAC,
         LOOKUP[4]=INDEX, RESULT=IM_FRAC,
         LOOKUP[5]=INDEX, RESULT=TYPE,
       FAIL[1]=-1,FAIL[2]=-1,FAIL[3]=-1
;ZONE     = FLSWM (JAX extract 1-508) TAZ
;TRIPENDS = daily port truck units
;HWY_FRAC = fraction of port trip ends that leave the port area by truck
;IM_FRAC  = fraction of trucks leaving the port bound to intermodal terminals for type 1
;IM_FRAC  = fraction of trucks leaving the ports bound to this intermodal terminal for type 2 (file sum for type 2 must total 1.00)
;TYPE     = 1=port, 2= intermodal yard

if(i=1)
loop k=1,99
  zt[k]=JaxPort(1,k)
  if(zt[k]=-1) break
  numports=k
  TE[k]=JaxPort(2,k)
  HFR[k]=JaxPort(3,k)
  IFR[k]=JaxPort(4,k)
  TYP[k]=JaxPort(5,k)
  Htrp[k]=TE[k]*HFR[k]*(1-IFR[k])
  Itrp[k]=TE[k]*HFR[k]*IFR[k]
  Htsum=Htsum+Htrp[k]    ; highway trips
  Itsum=Itsum+Itrp[k]    ; trips to intermodal yards
  if(TYP[k]=2)
     nim=nim+1 ; number of intermodal facilities
     JFR[nim]=IFR[k]
     Iterm[nim]=zt[k]
     imftot=imftot+IFR[k]
  endif
  dex=zt[k]
  if(TYP[k]=1) jport[dex]=1
endloop
if(imftot<>1.0 & imftot<>1.0)
   print list='\n\n**************************** FATAL ERROR **************************'
   print list='IM_FRAC for TYPE=2 must total 1.0 or 0.0 but sums to ',imftot(5.2)
   print list='*******************************************************************\n\n'
   ABORT
endif
endif

mw[3]=mi.1.1.T

; find ports
/*
isport=0
loop k=1,numports
  if(TYP[k]=1 & i=ZT[k]) isport=1
endloop
if(isport=1)
*/ 
   mw[1]=mi.1.1/1.5  ;PCE_HT=1.5
   mw[2]= mw[3]/1.5  ;PCE_HT=1.5
;endif

/*
Jloop
  if(jport[j]=1) 
      mw[1]=mi.1.1/1.5  ;PCE_HT=1.5
      mw[2]= mw[3]/1.5  ;PCE_HT=1.5
  endif
endJloop
*/

;z=i
FTE=rowsum(1)+rowsum(2)
isport=0
loop k=1,numports
  if(i=ZT[k]) isport=1
endloop
if(isport=0) 
   attr[i]=FTE
   SA=SA+FTE
endif
;
write reco=1

if(i=zones)

loop p=1,numports
  if(TYP[p]=1)
     factor=Htrp[p]/SA
     loop k=1,zones
         attr1=attr[k]*factor
         isim=0
         loop n=1,nim
             if(Iterm[n]=k)attr1=JFR[n]*Itrp[p]
         endloop
         az=zt[p]
         bz=k
         tr=attr1
         if(tr>0) write reco=2
         alltr=alltr+attr1
     endloop
  endif
endloop

endif

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\BFMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\BFMAT00D.PRN" MSG='Develop Jaxport Truck PA table'
FILEO MATO[1] = "{Catalog_Dir}\output_SWM\base_SWM\Port_trk.mat",
  MO=1 NAME=TRIPSPA
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\base_SWM\FTE_TT.DBF",
    PATTERN=IJ:V, FIELDS=AZ,BZ,TR

PARAMETERS ZONES=508

 MW[1]=MI.1.1

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\BFMAT00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\BFMAT00E.PRN" MSG='Develop Jaxport Truck Od table in SWM N4 extract zones'
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\base_SWM\Port_trk.mat"
FILEO MATO[1] = "{CATALOG_DIR}\output_SWM\base_SWM\Port_trk_od.mat",
  MO=1,2 NAME=TRIPSPA,TRIPSOD

PARAMETERS ZONES=508

 MW[1]=MI.1.1
 MW[2]=0.5*(MW[1]+MI.1.1.T)

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\BFMAT00F.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\BFMAT00F.PRN" MSG='Convert Jaxport Truck OD tables in NERPM4 zones'
FILEI ZDATI[1] = "{Catalog_Dir}\input_SWM\base_SWM\N4EXTRACT_EQ.DBF",
   z=SWTAZ_EX
FILEI MATI[1] = "{CATALOG_DIR}\output_SWM\base_SWM\Port_trk_od.mat"
FILEO MATO[1] = "{CATALOG_DIR}\output_SWM\base_SWM\2005_Port_trk_od_N4.mat",
   mo=1 NAME=Base_N4_PortTrk


  mw[1]=mi.1.2
renumber, zoneo=zi.1.N4_TAZ,
  MISSINGZI=M,
  MISSINGZO=w


; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN


; Script for program HIGHWAY in file "C:\NERPM50\APPLICATIONS\BFHWY00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM50\APPLICATIONS\BFHWY00B.PRN" MSG='A Free flow extrated net and Port Trk to see bandwidth'
FILEO NETO = "{Catalog_Dir}\output_SWM\base_SWM\PORT_LOD_Base.NET"
FILEI NETI = "{Catalog_Dir}\input_SWM\base_SWM\Nerpm4 Extractx.net"
FILEI MATI[1] = "{CATALOG_DIR}\output_SWM\base_SWM\Port_trk_od.mat"

PAR MAXITERS=1

PHASE=LINKREAD
T0=LI.TIME
ENDPHASE

PROCESS PHASE=ILOOP
      PATHLOAD  PATH=COST, VOL[1]=MI.1.2    ; load trips
ENDPROCESS


ENDRUN


