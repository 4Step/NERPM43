; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\PAHWY00A.PRN" MSG='Preassignment for Mode'
DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PRETOLLS.PRN"
FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD.NET"

PAR ZONEMSG=100 MAXITERS={ITER} GAP=0.0000005 RAAD=0.0000 AAD=0.00000 RMSE=0.000000

; look up deceleration rate based on approach speed
LOOKUP,
 INTERPOLATE=Y, LIST=Y, NAME=DECEL,
        LOOKUP[1]=1,RESULT=2,
R = '30 4',
    '70 6.2'

PROCESS PHASE=LINKREAD
  T0=li.TIME
  LW.DISTANCE=LI.DISTANCEFT/5280
  LW.FFTIME=LI.TIME ; USE FOR PRELOAD PURPOSES (FFTIME)
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/LI.CONFAC
  IF (li.FACILITY_TYPE=80-89) ADDTOGROUP=1
  IF (li.EECODE>0) ADDTOGROUP=2
  IF (li.FACILITY_TYPE=49 | LI.FACILITY_TYPE=59 | LI.FACILITY_TYPE=69) ADDTOGROUP=9
; classify links based on presence/absence of tolls
      LINKCLASS=1 ; no toll
      if (li.cartoll>0)
       LINKCLASS=2 ; with toll
       T0=({CTOLL}*LI.CARTOLL)*60 ; + LI.SVCMINUTES + LI.SVCSECONDS/60
/*      if (iteration=0)
        LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFAC/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
        LW.SERVT=LI.SVCMINUTES+(LI.SVCSECONDS/60)           ; Plaza lane service time in minutes per vehicle
        LW.SERVR=(1/LW.SERVT)*60                            ; Plaza lane service rate in vehicle per hour
        PRINT LIST='ARRIVR= ',LW.ARRIVR
        PRINT LIST='SERVT= ',LW.SERVT
        PRINT LIST='SERVR= ',LW.SERVR
        if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.99*LW.SERVR    ; prevent infinite or negative queue
       endif
*/
      endif
/*
      if (li.TOLL_ACC>0)
       LINKCLASS=3 ; Toll Plaza Acceleration link
       T0= T0 + (LI.SPEED/2.5)/60
      endif

      if (li.TOLL_DEC>0)
       LINKCLASS=4 ; Toll Plaza Deceleration link
       T0 = T0 + (LI.SPEED/DECEL(1,LI.SPEED))/60
      endif
*/
ENDPROCESS

PROCESS PHASE=ILOOP
  PATHLOAD PATH=TIME, PENI=1, VOL[1]=MI.1.1, VOL[2]=MI.1.2, EXCLUDEGROUP=1,9
  PATHLOAD PATH=TIME, PENI=1, VOL[3]=MI.1.3, EXCLUDEGROUP=9
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5,  EXCLUDEGROUP=1-2,9
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=2,9
ENDPROCESS


PROCESS PHASE=ADJUST

if (time>0) LW.CGSTSPEED=(LW.DISTANCE/TIME)*60
/*
if (li.cartoll>0)
 LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFAC/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
 LW.SERVT=LI.SVCMINUTES+(LI.SVCSECONDS/60)           ; Plaza lane service time in minutes per vehicle
 LW.SERVR=(1/LW.SERVT)*60                            ; Plaza lane service rate in vehicle per hour
 if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.99*LW.SERVR    ; prevent infinite or negative queue
PRINT LIST='ARRIVR= ',LW.ARRIVR
PRINT LIST='SERVT= ',LW.SERVT
PRINT LIST='SERVR= ',LW.SERVR
PRINT LIST='TOLLTIME= ',TIME
endif
*/
 FUNCTION   TC[1]=LI.TIME*(1+LI.BPRCOEFFICIENT*MIN((V/C),10)^LI.BPREXPONENT) ; congested time for non-toll links
; FUNCTION   TC[2]=(1/(LW.SERVR-LW.ARRIVR))*60 + {CTOLL}*LI.CARTOLL*60 ; congested time for toll links
 FUNCTION   TC[2]={CTOLL}*LI.CARTOLL*60 ; congested time for toll links
 FUNCTION   TC[3]=LI.TIME*(1+LI.BPRCOEFFICIENT*MIN((V/C),10)^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION   TC[4]=LI.TIME*(1+LI.BPRCOEFFICIENT*MIN((V/C),10)^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links

if (li.cartoll>0) print list="Iter:",iteration(2.0)," TOLLFM Summary, A=",A(6.0)," B=",B(6.0)," PLAZAID=",li.TOLL(3.0)," NAME=",li.PLAZADESC(24)," MAX LNS=",li.PLZALNSMAX," GCOST=",TIME(6.2),
        printo=1


ENDPROCESS


ENDRUN
