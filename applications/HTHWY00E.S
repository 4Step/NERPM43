; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\HTHWY00I.PRN" MSG='OldTry-PM Period Hwy Assignment'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "C:\NERPM43_Delivered\APPLICATIONS\HTHWY00E.TRN"
FILEO PRINTO[1] = "C:\NERPM43_Delivered\APPLICATIONS\HTHWY00J.PRN"
FILEO NETO = "C:\NERPM43_Delivered\APPLICATIONS\HTHWY00E.NET"

PAR ZONEMSG=100 COMBINE=EQUI MAXITERS={iter} GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;
;PAR ZONEMSG=100 COMBINE=EQUI MAXITERS=5 GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;

;TURNS N=1-999999
TURNS N=39782,40555,40265,40258,40241,40568

; look up deceleration rate based on approach speed
LOOKUP,
 INTERPOLATE=Y, LIST=Y, NAME=DECEL,
        LOOKUP[1]=1,RESULT=2,
R = '30 4',
    '70 6.2'

PROCESS PHASE=LINKREAD

;Basics...
  lw.distance=li.distance
  DISTANCE=LW.DISTANCE
  T0=li.TIME
  LW.FFTIME=LI.TIME                                         ; USE FOR PRELOAD PURPOSES (FFTIME)
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/LI.CONFACPMP
;Save PM Period Total capacity
  CAPACITY_PMP=C

;Set EXCLUDE VOLUME GROUP for PATHLOAD...
  IF (li.FACILITY_TYPE=86,88,89 & LI.HOT=0) ADDTOGROUP=1         ;HOV 2 & 3+ Facilities (FT=87 AM Only) => Exclude DA and Truck Volume Groups  
  IF (li.FACILITY_TYPE=82 & LI.HOT=0) ADDTOGROUP=3               ;HOV 3+ Facilities => Exclude HOV2 Volume Groups
  IF (li.HOT=2) ADDTOGROUP=4                                     ;Dummy Entrance and Exit from HOT facility

  IF (li.EECODE>0) ADDTOGROUP=2                                  ;EE PROHIBITED LINKS =>Exclude External Volume Groups
;  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE

  IF (li.HOT=1) ADDTOGROUP=8                                     ;HOT Lane Facility
  IF (li.FACILITY_TYPE=49,59,69) ADDTOGROUP=9                    ;TRANSIT ONLY FACILITIES =>Exclude all Highway Volume Groups

; classify links based on presence/absence of tolls
      LINKCLASS=1                                        ;no toll
      if (li.cartoll>0)           
       LINKCLASS=2                                       ;with toll

       T0=({CTOLL}*LI.CARTOLL)*60 + LI.SVCMINUTES + LI.SVCSECONDS/60

       if (iteration=0)
        LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACPMP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
        LW.SERVT=LI.SVCMINUTES+(LI.SVCSECONDS/60)                ; Plaza lane service time in minutes per vehicle
        LW.SERVR=(1/LW.SERVT)*60                                 ; Plaza lane service rate in vehicle per hour
        PRINT LIST='ARRIVR= ',LW.ARRIVR
        PRINT LIST='SERVT= ',LW.SERVT
        PRINT LIST='SERVR= ',LW.SERVR
        if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.99*LW.SERVR         ; prevent infinite or negative queue
       endif

      endif

      if (li.TOLL_ACC>0)
       LINKCLASS=3                                               ; Toll Plaza Acceleration link
       T0= T0 + (LI.SPEED/2.5)/60
      endif

      if (li.TOLL_DEC>0)
       LINKCLASS=4                                               ; Toll Plaza Deceleration link
       T0 = T0 + (LI.SPEED/DECEL(1,LI.SPEED))/60
      endif

     IF (li.FACILITY_TYPE=49,59,69) LINKCLASS=5                   ;Transit non-Highway optional links


ENDPROCESS

PROCESS PHASE=ILOOP
  MW[1]=MI.1.PM_DA_IEII             ;Table 1 
  MW[2]=MI.1.PM_SR2_IEII            ;Table 2 
  MW[3]=MI.1.PM_SR3_IEII            ;Table 3 
  MW[4]=MI.1.PM_TRK_IEII            ;Table 4 
  MW[5]=MI.1.PM_TRK_EE              ;Table 5 
  MW[6]=MI.1.PM_DA_EE               ;Table 6 
  MW[7]=MI.1.PM_SR2_EE              ;Table 7 
  MW[8]=MI.1.PM_SR3_EE              ;Table 8 
  MW[9]=MI.1.PM_PortTrk             ;Table 9 

if ({SELLINK}=1)  ;Select Zone/Link Analysis

    PATHLOAD PATH=COST, PENI=1, VOL[1]=MW[1], VOL[4]=MW[4],  EXCLUDEGROUP=1,4,9,                  ;IE&II- DA(1) & TRK(4) 
       MW[11]=MW[1], SELECTLINK=({SEL_LINK}), MW[14]=MW[4], SELECTLINK=({SEL_LINK}),
       VOL[11]=MW[11], VOL[14]=MW[14]                                                             ;SEl_IE&II- DA(11) & TRK(14)

    PATHLOAD PATH=COST, PENI=1, VOL[2]=MW[2], EXCLUDEGROUP=3,4,9,                                 ;IE&II - SR2(2)
       MW[12]=MW[2], SELECTLINK=({SEL_LINK}),
       VOL[12]=MW[12]                                                                             ;SEL_IE&II - SR2(12)

    PATHLOAD PATH=TIME, PENI=1, VOL[3]=MW[3], EXCLUDEGROUP=4,9,                                   ;IE&II - SR3(3)
       MW[13]=MW[3], SELECTLINK=({SEL_LINK}),
       VOL[13]=MW[13]                                                                             ;SEL_IE&II - SR3(13)

    PATHLOAD PATH=COST, PENI=1, VOL[5]=MW[5], VOL[6]=MW[6], VOL[9]=MW[9], EXCLUDEGROUP=1,2,4,9,   ;EE -TRK(5) & DA(6); JaxPrtTrk(9)
       MW[15]=MW[5], SELECTLINK=({SEL_LINK}), MW[16]=MW[6], SELECTLINK=({SEL_LINK}),
       MW[19]=MW[9], SELECTLINK=({SEL_LINK}),
       VOL[15]=MW[15], VOL[16]=MW[16], VOL[19]=MW[19]                                           ;SEL_EE -TRK(15) & DA(16); JaxPrtTrk(19)

   PATHLOAD PATH=COST, PENI=1, VOL[7]=MW[7], EXCLUDEGROUP=2,3,4,9,                              ;EE - SR2(7) 
       MW[17]=MW[7], SELECTLINK=({SEL_LINK}),
       VOL[17]=MW[17]                                                                           ;SEL_EE - SR2(17)

   PATHLOAD PATH=TIME, PENI=1, VOL[8]=MW[8], EXCLUDEGROUP=2,4,9,                                ;EE - SR3(8) 
       MW[18]=MW[8], SELECTLINK=({SEL_LINK}),
       VOL[18]=MW[18]                                                                           ;SEL_EE - SR3(18)

else

  PATHLOAD PATH=COST, PENI=1, VOL[1]=MW[1], VOL[4]=MW[4], EXCLUDEGROUP=1,4,9                   ;IE&II- DA(1) & TRK(4)      
  PATHLOAD PATH=COST, PENI=1, VOL[2]=MW[2], EXCLUDEGROUP=3,4,9                                 ;IE&II - SR2(2)
  PATHLOAD PATH=TIME, PENI=1, VOL[3]=MW[3], EXCLUDEGROUP=4,9                                   ;IE&II - SR3(3)
  PATHLOAD PATH=COST, PENI=1, VOL[5]=MW[5], VOL[6]=MW[6], VOL[9]=MW[9], EXCLUDEGROUP=1,2,4,9   ;EE- TRK(5)& DA(6); JaxportTrk(9)
  PATHLOAD PATH=COST, PENI=1, VOL[7]=MW[7], EXCLUDEGROUP=2,3,4,9                               ;EE - SR2(7)
  PATHLOAD PATH=TIME, PENI=1, VOL[8]=MW[8], EXCLUDEGROUP=2,4,9                                 ;EE - SR3(8)

endif

ENDPROCESS


PROCESS PHASE=ADJUST
;Define volume to be used for V/C calculation
FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]+VOL[8]+VOL[9]

if (time>0) LW.CGSTSPEED=(LW.DISTANCE/TIME)*60

if (li.cartoll>0)
 LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACPMP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
 LW.SERVT=LI.SVCMINUTES+(LI.SVCSECONDS/60)                ; Plaza lane service time in minutes per vehicle
 LW.SERVR=(1/LW.SERVT)*60                                 ; Plaza lane service rate in vehicle per hour
 if (LW.ARRIVR>=LW.SERVR) LW.ARRIVR=0.99*LW.SERVR         ; prevent infinite or negative queue
PRINT LIST='ARRIVR= ',LW.ARRIVR
PRINT LIST='SERVT= ',LW.SERVT
PRINT LIST='SERVR= ',LW.SERVR
PRINT LIST='TOLLTIME= ',TIME
endif
if (lw.servr-lw.arrivr=0.0) lw.servr=lw.servr+0.01

;Update Time and Cost for PATHLOAD
;---TIME is TIME plus regular toll time and toll equivalent time
;---COST is Time plus HOT toll time equivalent
;Capture HOT toll time equivalent
IF(LI.HOT=1)
  LW.VCVAL=V/C ; V/C CALCULATION
  MINHOTTOLL=0.12          ; Minimum HOT lane toll 12 cents per mile
  MAXHOTTOLL=0.25          ; Maximum HOT lane toll 25 cents per mile
  LW.HOTTOLL = MINHOTTOLL+(MAXHOTTOLL-MINHOTTOLL)/(1+EXP(6-9*LW.VCVAL))    ;LOGIT EQN APPLIED
ELSE
    LW.HOTTOLL=0
ENDIF

;Define EACH LINKCLASS TC and COST Functions
; Link Class 1 - Non Regular Toll (it may be a HOT link)
 FUNCTION TC[1]   = LI.TIME*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)
 FUNCTION COST[1] = LI.TIME*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)+LI.DISTANCE*(LW.HOTTOLL)*60*{CTOLL}

;Link Class 2 - Regular Tollplaza Link (Never HOT link)
 FUNCTION   TC[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links
 FUNCTION COST[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links

; Link Class 3 - Regular Toll Accln Link (Never HOT link)
 FUNCTION   TC[3]=LI.TIME*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION COST[3]=LI.TIME*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links

; Link Class 4 - Regular Toll Decln Link (Never HOT link)
 FUNCTION   TC[4]=LI.TIME*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 FUNCTION COST[4]=LI.TIME*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 
; Link Class 5 - Transit Optional Link 
 FUNCTION   TC[5]=LI.TIME                                                            ;congested time transit-only optional links
 FUNCTION COST[5]=LI.TIME                                                            ;congested time transit-only optional links

 
if (li.cartoll>0) print list="Iter:",iteration(2.0)," TOLLFM Summary, A=",A(6.0)," B=",B(6.0)," PLAZAID=",li.TOLL(3.0)," NAME=",li.PLAZADESC(24)," MAX LNS=",li.PLZALNSMAX," GCOST=",TIME(6.2),
        printo=1


ENDPROCESS

; Converge phase is new for Cube 4.0.
PHASE=CONVERGE
  IF (ITERATION < 6) BREAK; Do not even test for Iterations 2-5
  IF (GAP[ITERATION]<GAPCUTOFF & GAP[ITERATION-1]<GAPCUTOFF & GAP[ITERATION-2]<GAPCUTOFF)
     BALANCE = 1
  ENDIF

ENDPROCESS




ENDRUN
