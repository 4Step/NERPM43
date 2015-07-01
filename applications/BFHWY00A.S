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
