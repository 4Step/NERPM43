; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\HAHWY00A.PRN" MSG='Final 24-hour Assignment'
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEI MATI[1] = "{SCENARIO_DIR}\Output\HWYTTAB_{alt}{year}.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO PATHO[1] = "{SCENARIO_DIR}\output\fullpath{alt}{year}.pth"
FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "{SCENARIO_DIR}\output\TURNS.BIN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\HAHWY00B.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\FINAL ASGN.NET"

PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} RAAD=0.00000 AAD=0.000000 RMSE=0.000000 GAP=0.00025; RELATIVEGAP=0.001
;PAR ZONEMSG=100 COMBINE=EQUI MAXITERS={iter} GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;
;PAR ZONEMSG=100 COMBINE=EQUI MAXITERS=7 GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;


;TURNS N=1-999999
TURNS N=39782,40555,40265,40258,40241,40568

; look up deceleration rate based on approach speed
LOOKUP,
 INTERPOLATE=Y, LIST=Y, NAME=DECEL,
        LOOKUP[1]=1,RESULT=2,
R = '30 4',
    '70 6.2'

PROCESS PHASE=LINKREAD
  lw.distance=li.distance
  DISTANCE=LW.DISTANCE
  T0=li.TIME
  LW.FFTIME=LI.TIME ; USE FOR PRELOAD PURPOSES (FFTIME)
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/LI.CONFAC

;Save 24-hour total capacity
  CAPACITY_24H=C

  IF (li.FACILITY_TYPE=80-89) ADDTOGROUP=1 ; HOV FACILITIES
  IF (li.EECODE>0) ADDTOGROUP=2 ; EE PROHIBITED LINKS
  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE
  IF (li.FACILITY_TYPE=49,59,69) ADDTOGROUP=9 ; TRANSIT ONLY FACILITIES
; classify links based on presence/absence of tolls
      LINKCLASS=1 ; no toll
      if (li.cartoll>0)
       LINKCLASS=2 ; with toll
       T0=({CTOLL}*LI.CARTOLL)*60 ; + LI.SVCMINUTES + LI.SVCSECONDS/60
/*
       if (iteration=0)
        LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFAC/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
        LW.SERVT=LI.SVCMINUTES+(LI.SVCSECONDS/60)             ; Plaza lane service time in minutes per vehicle
        LW.SERVR=(1/LW.SERVT)*60                              ; Plaza lane service rate in vehicle per hour
        PRINT LIST='ARRIVR= ',LW.ARRIVR
        PRINT LIST='SERVT= ',LW.SERVT
        PRINT LIST='SERVR= ',LW.SERVR
        if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.99*LW.SERVR      ; prevent infinite or negative queue
       endif
*/
      endif
;sks- /*
      if (li.TOLL_ACC>0)
       LINKCLASS=3 ; Toll Plaza Acceleration link
       T0= T0 + (LI.SPEED/2.5)/60
      endif

      if (li.TOLL_DEC>0)
       LINKCLASS=4 ; Toll Plaza Deceleration link
       T0 = T0 + (LI.SPEED/DECEL(1,LI.SPEED))/60
      endif
;sks- */
ENDPROCESS

PROCESS PHASE=ILOOP

;Trip Tables=>>  T1=DA_IEII, T2:SR_IEII, T3: TRK_IEII, T4: TRK_EE, T5:DA_EE, T6:SR_EE, T7:PortTrk

if ({SELLINK}=1)  ;Select Zone/Link Analysis

    PATHLOAD PATH=TIME, PENI=1, VOL[1]=MI.1.1, VOL[3]=MI.1.3,  EXCLUDEGROUP=1,9,                       ;IE&II- SOV(1) & TRK(3) 
       MW[8]=MI.1.1, SELECTLINK=({SEL_LINK}), MW[10]=MI.1.3, SELECTLINK=({SEL_LINK}),
       VOL[8]=MW[8], VOL[10]=MW[10]                                                                    ;SEl_IE&II- SOV(8) & TRK(10)

    PATHLOAD PATH=TIME, PENI=1, VOL[2]=MI.1.2, EXCLUDEGROUP=9,                                         ;IE&II - HOV(2)
       MW[9]=MI.1.2, SELECTLINK=({SEL_LINK}),
       VOL[9]=MW[9]                                                                                    ;SEL_IE&II - HOV(9)

    PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5, VOL[7]=MI.1.7, EXCLUDEGROUP=1-2,9,  ;EE -TRK(4) & SOV(5); JaxPrtTrk(7)
       MW[11]=MI.1.4, SELECTLINK=({SEL_LINK}), MW[12]=MI.1.5, SELECTLINK=({SEL_LINK}),
       MW[14]=MI.1.7, SELECTLINK=({SEL_LINK}),
       VOL[11]=MW[11], VOL[12]=MW[12], VOL[14]=MW[14]                                                  ;SEL_EE -TRK(11) & SOV(12); JaxPrtTrk(14)

   PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=2,9,                                   ;EE - HOV(6) 
       MW[13]=MI.1.6, SELECTLINK=({SEL_LINK}),
       VOL[13]=MW[13]                                                                                  ;SEL_EE - HOV(13)
else

if ({pathfile}=1)
/* -sks: comment this block to initiate cluster run...
  PATHLOAD PATH=TIME, PENI=1, VOL[1]=MI.1.1, VOL[3]=MI.1.3, EXCLUDEGROUP=1,9, patho=1, name='DA_TRKIEII',ALLJ=F,INCLUDECOSTS=F, PATHOGROUP=7
  PATHLOAD PATH=TIME, PENI=1, VOL[2]=MI.1.2, EXCLUDEGROUP=9, patho=1, name='HOVIEII',ALLJ=F,INCLUDECOSTS=F, PATHOGROUP=7
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5, VOL[7]=MI.1.7, EXCLUDEGROUP=1-2,9, patho=1, name='TRKEE_PRTTRK',ALLJ=F,INCLUDECOSTS=F, PATHOGROUP=7
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=2,9, patho=1, name='HOVEE',ALLJ=F,INCLUDECOSTS=F, PATHOGROUP=7
*/
else
  PATHLOAD PATH=TIME, PENI=1, VOL[1]=MI.1.1, VOL[3]=MI.1.3, EXCLUDEGROUP=1,9                       ;IE&II- SOV(1) & TRK(3)      
  PATHLOAD PATH=TIME, PENI=1, VOL[2]=MI.1.2, EXCLUDEGROUP=9                                        ;IE&II - HOV(2)
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5, VOL[7]=MI.1.7, EXCLUDEGROUP=1-2,9 ;EE -TRK(4) & SOV (5); JaxportTrk(7)
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=2,9                                 ;EE - HOV(6)
 
endif

endif

ENDPROCESS


PROCESS PHASE=ADJUST

if (time>0) LW.CGSTSPEED=(LW.DISTANCE/TIME)*60
/*
if (li.cartoll>0)
 LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFAC/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
 LW.SERVT=LI.SVCMINUTES+(LI.SVCSECONDS/60)             ; Plaza lane service time in minutes per vehicle
 LW.SERVR=(1/LW.SERVT)*60                              ; Plaza lane service rate in vehicle per hour
 if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.99*LW.SERVR      ; prevent infinite or negative queue
PRINT LIST='ARRIVR= ',LW.ARRIVR
PRINT LIST='SERVT= ',LW.SERVT
PRINT LIST='SERVR= ',LW.SERVR
PRINT LIST='TOLLTIME= ',TIME
endif
*/
 FUNCTION   TC[1]=LI.TIME*(1+LI.BPRCOEFFICIENT*MIN((V/C),{VCMAX})^LI.BPREXPONENT) ; congested time for non-toll links
; FUNCTION   TC[2]=(1/(LW.SERVR-LW.ARRIVR))*60 + {CTOLL}*LI.CARTOLL*60 ; congested time for toll links
 FUNCTION   TC[2]={CTOLL}*LI.CARTOLL*60 ; congested time for toll links
 FUNCTION   TC[3]=LI.TIME*(1+LI.BPRCOEFFICIENT*MIN((V/C),{VCMAX})^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION   TC[4]=LI.TIME*(1+LI.BPRCOEFFICIENT*MIN((V/C),{VCMAX})^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]
if (li.cartoll>0) print list="Iter:",iteration(2.0)," TOLLFM Summary, A=",A(6.0)," B=",B(6.0)," PLAZAID=",li.TOLL(3.0)," NAME=",li.PLAZADESC(24)," MAX LNS=",li.PLZALNSMAX," GCOST=",TIME(6.2),
        printo=1


ENDPROCESS

; Converge phase is new for Cube 4.0.
PHASE=CONVERGE
  IF (ITERATION < 6) BREAK; Do not even test for Iterations 2-5
  IF (GAP[ITERATION]<GAPCUTOFF & GAP[ITERATION-1]<GAPCUTOFF & GAP[ITERATION-2]<GAPCUTOFF)
;  IF (RGAP[ITERATION]<RGAPCUTOFF & RGAP[ITERATION-1]<RGAPCUTOFF & RGAP[ITERATION-2]<RGAPCUTOFF)
     BALANCE = 1
  ENDIF

ENDPROCESS




ENDRUN
