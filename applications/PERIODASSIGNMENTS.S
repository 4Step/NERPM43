; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\HTHWY00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\HTHWY00A.PRN" MSG='AM Period Hwy Assignment'
FILEI MATI[2] = "{SCENARIO_DIR}\Output\HWYTTBP_AM_A10.MAT"
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEI MATI[1] = "{SCENARIO_DIR}\Output\HWYTTAB_AM_A10.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\HOT_TOLL.dbf"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TCHOICE_AM.dbf"

FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "{SCENARIO_DIR}\output\TURNS_AM.BIN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\AMPeriod_TollReport.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\FINAL_ASGN_AM.NET"

PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} RAAD=0.00000 AAD=0.000000 RMSE=0.000000 GAP=0.00025; RELATIVEGAP=0.001
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS=7 GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;

;TURNS N=1-999999
TURNS N=39782,40555,40265,40258,40241,40568

;Per-KDK
LOOKUP LOOKUPI=1,
       NAME=KON,
       LOOKUP[1]=REC, RESULT=CT,
       LOOKUP[2]=REC, RESULT=CC,
       LOOKUP[3]=REC, RESULT=TFK,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

LOOKUP LOOKUPI=2,
       NAME=HOTTOLL,
       LOOKUP[1]=HOT, RESULT=AM_TOLL_MI,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

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
 C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/LI.CONFACAMP
;Save AM Period Total capacity
  CAPACITY_AMP=C

;Per-KDK
; HOT TOLL RATE/mile from lookup table
HOT_TOLL_PMILE = HOTTOLL(1,LI.HOT)
IF(LI.HOT>=1)
  LW.HOTTOLL = DISTANCE*HOT_TOLL_PMILE
ELSE
    LW.HOTTOLL=0
ENDIF
LW.MYTOLL=LW.HOTTOLL+LI.CARTOLL
LW.MYTOLL2=0.5*LW.MYTOLL

;Set EXCLUDE VOLUME GROUP for PATHLOAD...
  IF (li.FACILITY_TYPE=86,87,89 & LI.HOT=0) ADDTOGROUP=1         ;HOV 2 & 3+ Facilities (FT=88 PM Only) => Exclude DA and Truck Volume Groups  
  IF (li.FACILITY_TYPE=82 & LI.HOT=0) ADDTOGROUP=3               ;HOV 3+ Facilities => Exclude HOV2 Volume Groups
;Note Dummy HOT ramps are coded as HOT=-1 and their facility_type changed to 69 (transit only)
;  IF (li.HOT=2) ADDTOGROUP=4                                     ;Dummy Entrance and Exit from HOT facility

  IF (li.EECODE>0) ADDTOGROUP=2                                  ;EE PROHIBITED LINKS =>Exclude External Volume Groups
;  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE

  IF (li.HOT>=1) ADDTOGROUP=8                                    ;HOT Lane Facility
  IF (li.FACILITY_TYPE=49,59,69) ADDTOGROUP=9                    ;TRANSIT ONLY FACILITIES =>Exclude all Highway Volume Groups

;Per-KDK
   IF (LI.HOT>=1 | li.FACILITY_TYPE=91-99) ADDTOGROUP=5       ;Any kind of toll road -- KDK
   IF (li.FACILITY_TYPE=91-99) ADDTOGROUP=6                   ;Non-HOT toll road -- KDK

; classify links based on presence/absence of tolls
      LINKCLASS=1                                        ;no toll
      if (li.cartoll>0)           
       LINKCLASS=2                                       ;with toll

       T0=({CTOLL}*LI.CARTOLL)*60 + LI.SVCMINUTES + LI.SVCSECONDS/60

       if (iteration=0)
        LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACAMP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
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

  MW[2]=MI.2.AM_HBW_DA             ;Table 2 
  MW[3]=MI.2.AM_HBW_SR2            ;Table 3 
  MW[4]=MI.2.AM_HBW_SR3P           ;Table 4 
  MW[5]=MI.2.AM_HBO_DA             ;Table 5 
  MW[6]=MI.2.AM_HBO_SR2            ;Table 6 
  MW[7]=MI.2.AM_HBO_SR3P           ;Table 7 
  MW[8]=MI.2.AM_NHB_DA             ;Table 8 
  MW[9]=MI.2.AM_NHB_SR2            ;Table 9 
  MW[10]=MI.2.AM_NHB_SR3P          ;Table 10 

;                                           MW>VOL
  MW[1]=MI.1.AM_TRK_IEII             ;Table 1 >7
  MW[11]=MI.1.AM_TRK_EE              ;Table 11 >8
  MW[12]=MI.1.AM_DA_EE               ;Table 12 >9
  MW[13]=MI.1.AM_SR2_EE              ;Table 13 >10
  MW[14]=MI.1.AM_SR3_EE              ;Table 14 >11
  MW[15]=MI.1.AM_PortTrk             ;Table 15 >12

;=====================
;Per-KDK
;Skim Time and Cost, assuming auto operating costs is the same for toll and free links
; Get straight time skim for free paths (toll links excluded)
; Get straight time skim for free paths (toll links excluded)
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=5,9,MW[21]=PATHTRACE(TIME),NOACCESS=999
; Get time and cost skims for DA, which may include tolls
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=9,  MW[22]=PATHTRACE(TIME),NOACCESS=999,MW[23]=PATHTRACE(LW.MYTOLL),NOACCESS=999,
; Get time and cost skims for SR3+, which may include non-HOT tolls (HOT is free)
                                      MW[27]=PATHTRACE(LI.CARTOLL),NOACCESS=999,
; Set flag for use of HOT lanes
                                      MW[99]=PATHTRACE(LI.HOT),NOACCESS=0
; Get time and cost skims for SR2, which may include tolls
  MW[24]=MW[22]                  ;time- non-free
  MW[25]=0.5*MW[23]              ;mytoll=hottoll+cartoll
; Get time skims for SR3+
  MW[26]=MW[22]                  ;time- non-free 
; Get cost skims for SR3+, which may include non-HOT tolls
  MW[27]=0.3125*MW[27] ; assume 3.2 occ
;
; CHOICE MODEL
;kdk-S65:  c_o=CNTY(1,i);get county number
;  combinations by o & d
   loop p=1,3
   jloop
     if((MW[23]<=0) && (MW[21]<999)) ; if there is no toll skim, all must be free
       SfreeDA  = 1.0  
       SfreeSR2 = 1.0  
       SfreeSR3 = 1.0
     elseif(MW[21]>=999) ; if there is no free skim, all must be placed in the "toll" table
       SfreeDA  = 0.0  
       SfreeSR2 = 0.0  
       SfreeSR3 = 0.0
     else  
;kdk-S65:      c_d=CNTY(1,j)
       ;get coefficients
;xx       dexi = 3*(c_o-1)+p
;kdk-S65:       dexj = 3*(c_d-1)+p
;xx       cti =KON(1,dexi); time coef for i
;xx       cci =KON(2,dexi); cost coef for i
;xx       tfki=KON(3,dexi); toll free constant for i
;kdk-S65:       ctj =KON(1,dexj); time coef for j
;kdk-S65:       ccj =KON(2,dexj); cost coef for j
;kdk-S65:       tfkj=KON(3,dexj); toll free constant for j

       ctp =KON(1,p); time coef for purpose p
       ccp =KON(2,p); cost coef for purpose p
       tfkp=KON(3,p); toll free constant for purpose p

;xx
;xx
;xx       if(dexi=dexj) ; both ends in the same county
;xx          ct=cti
;xx          cc=cci
;xx         tfk=tfki
;xx       else          ; average 2 counties because true Home zone in O-D format is unknown
;xx          ct =0.5*(cti+ctj)
;xx          cc =0.5*(cci+ccj)
;xx          tfk=0.5*(tfki+tfkj)
;xx       endif
;xx
;xx
; SET HOT LANES USE BIAS - 
       if(mw[99]>0) 
          hbias=KON(3,5); HOT bias stored in 5th record
       else
          hbias=0.0
       endif
; OVERRIDE EVERYTHING FOR TEST OF USING CONSTANTS FROM THE *DESTINATION* ZONE ****************
;     rationale - most origins are the non-home end in the PM peak
;kdk-S65:          ct=ctj
;kdk-S65:          cc=ccj
;kdk-S65:         tfk=tfkj + hbias
          ct=ctp
          cc=ccp
          tfk=tfkp + hbias
; ***************************************************************************************
       UfreeDA = ct*MW[21] + tfk
       UfreeSR2= UfreeDA;     ct*MW[21] + tfk
       UfreeSR3= UfreeDA;     ct*MW[21] + tfk
       UtollDA = ct*MW[22] + cc*MW[23]
       UtollSR2= ct*MW[24] + cc*MW[25]
       UtollSR3= ct*MW[26] + cc*MW[27]

       SfreeDA = 1.0/(1.0+exp(UtollDA-UfreeDA)); binary logit form
       ;StollDA = 1.0 - SfreeDA
       SfreeSR2= 1.0/(1.0+exp(UtollSR2-UfreeSR2))
       ;StollSR2= 1.0 - SfreeSR2
       SfreeSR3= 1.0/(1.0+exp(UtollSR3-UfreeSR3))
       ;StollSR3= 1.0 - SfreeSR3
; for test ****************************************************************************
;       if(mw[99]>0) 
;            SfreeDA =0
;            SfreeSR2=0
;            SfreeSR3=0
;       endif
; for test ****************************************************************************
     endif 
 
       dex = 3*(p-1)+2
       k3=3*(p-1)+31
       k4=k3+10; 2*(p-1)+41
       mw[k3] = mw[dex]*SfreeDA  ; free DA
       mw[k4] = mw[dex] - mw[k3] ; toll DA

       dex2 = dex+1; 3*(p-1)+3
       k5=k3+1;      3*(p-1)+32
       k6=k5+10;     2*(p-1)+42
       mw[k5] = mw[dex2]*SfreeSR2 ; free SR2
       mw[k6] = mw[dex2] - mw[k5] ; toll SR2

       dex3 = dex+2; 3*(p-1)+3
       k7=k5+1;      3*(p-1)+33
       k8=k7+10;     2*(p-1)+42
       mw[k7] = mw[dex3]*SfreeSR3 ; free SR3+
       mw[k8] = mw[dex3] - mw[k7] ; toll SR3+

       if(MW[23]<> 0);tabluate free trips when there is a choice - some toll on the path
          kf3=k3+70
          mw[kf3]=mw[k3]; choice free DA

          kf5=kf3+1
          mw[kf5]=mw[k5]; choice free SR2

          kf7=kf5+1
          mw[kf7]=mw[k7]; choice free SR3+
       endif

;EETRIPS Block- Using HBO shares for EE trips...
       if(p=2) ; use HBO shares
          mw[51]=mw[12]*SfreeDA  ; EE DA free
          mw[52]=mw[12]-mw[51]   ; EE DA toll

          mw[53]=mw[13]*SfreeSR2  ; EE SR2 free
          mw[54]=mw[13]-mw[53]   ; EE SR2 toll

          mw[55]=mw[14]*SfreeSR3  ; EE SR3 free
          mw[56]=mw[14]-mw[55]   ; EE SR3 toll
       endif
;EETRIPS Block

   endjloop
   endloop
 
   MW[61] = mw[31] +mw[34] + mw[37] ;drive alone free
   MW[62] = mw[32] +mw[35] + mw[38] ;SR2 free
   MW[63] = mw[33] +mw[36] + mw[39] ;SR3+free
   MW[64] = mw[41] +mw[44] + mw[47] ;drive alone toll
   MW[65] = mw[42] +mw[45] + mw[48] ;SR2 toll
   MW[66] = mw[43] +mw[46] + mw[49] ;SR3+toll
 
;kdk-S65: MW[01] = MW[01]/[PCE-TRK]        ;truck vehicles

;=====================
;SKS- The Select Link Volume sets exceed the maximimum limitation of 20. So assignment with select link was turned off here...
;Per CV documentation, Volume set index range is 1-20; there may be up to 20 volume sets in a single application of Highway. 

 ;FREE LINKS - toll links probibited
  PATHLOAD PATH=TIME, VOL[1]=MW[61], PENI=1, EXCLUDEGROUP=1,5,9  ;Without HOV (DA-Free)
  PATHLOAD PATH=TIME, VOL[2]=MW[62], PENI=1, EXCLUDEGROUP=3,5,9  ;With HOV2 (SR2-Free)
 ;ALL links -toll allowed
  PATHLOAD PATH=TIME, VOL[3]=MW[64], PENI=1, EXCLUDEGROUP=1,9    ;Without HOV (DA-Toll)
  PATHLOAD PATH=TIME, VOL[4]=MW[65], PENI=1, EXCLUDEGROUP=3,9    ;With HOV2  (SR2-Toll)
 ;SR3+ free
  PATHLOAD PATH=TIME, VOL[5]=MW[63], PENI=1, EXCLUDEGROUP=6,9    ;With HOV3+ (SR3-Free)
 ;SR3+ toll
  PATHLOAD PATH=TIME, VOL[6]=MW[66], PENI=1, EXCLUDEGROUP=9      ;With HOV3+ (SR3-Toll)

 ;Trucks
  PATHLOAD PATH=COST, PENI=1, VOL[7]=MW[1],   EXCLUDEGROUP=1,3,8,9    ;IE&II- TRK(7<1) - Not on HOV/HOT  
  PATHLOAD PATH=COST, PENI=1, VOL[12]=MW[15], EXCLUDEGROUP=1,2,3,8,9  ;JaxportTrk(12<15) -Not on HOV/HOT

 ;EE Trips
  if(i>{ZONESI})
   PATHLOAD PATH=COST, PENI=1, VOL[8]=MW[11],EXCLUDEGROUP=1,2,3,8,9, excludej=1-{ZONESI} ;EE- TRK(8<11)-Not on HOV/HOT
   PATHLOAD PATH=TIME, PENI=1, VOL[9]=MW[51],  EXCLUDEGROUP=1,2,5,9, excludej=1-{ZONESI} ;EE-DA-Free(9<51)
   PATHLOAD PATH=TIME, PENI=1, VOL[13]=MW[52], EXCLUDEGROUP=1,2,9,   excludej=1-{ZONESI} ;EE-DA-Toll(13<52)
   PATHLOAD PATH=TIME, PENI=1, VOL[10]=MW[53], EXCLUDEGROUP=2,3,5,9, excludej=1-{ZONESI} ;EE-SR2-Free(10<53)
   PATHLOAD PATH=TIME, PENI=1, VOL[14]=MW[54], EXCLUDEGROUP=2,3,9,   excludej=1-{ZONESI} ;EE-SR2-Toll(14<54)
   PATHLOAD PATH=TIME, PENI=1, VOL[11]=MW[55], EXCLUDEGROUP=2,6,9,   excludej=1-{ZONESI} ;EE-SR3-Free(11<55)
   PATHLOAD PATH=TIME, PENI=1, VOL[15]=MW[56], EXCLUDEGROUP=2,9,     excludej=1-{ZONESI} ;EE-SR3-Free(11<56)
  endif

ENDPROCESS


PROCESS PHASE=ADJUST
;Define volume to be used for V/C calculation
FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]+VOL[8]+VOL[9]+VOL[10]+VOL[11]+VOL[12]+VOL[13]+VOL[14]+VOL[15]


if (time>0) LW.CGSTSPEED=(LW.DISTANCE/TIME)*60

if (li.cartoll>0)
 LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACAMP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
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

; Dynamic HOTTOLL removed - now a fixed rate per mile in linkread
;IF(LI.HOT=1)
;  LW.VCVAL=V/C ; V/C CALCULATION
;  MINHOTTOLL=0.12          ; Minimum HOT lane toll 12 cents per mile
;  MAXHOTTOLL=0.25          ; Maximum HOT lane toll 25 cents per mile
;  LW.HOTTOLL = MINHOTTOLL+(MAXHOTTOLL-MINHOTTOLL)/(1+EXP(6-9*LW.VCVAL))    ;LOGIT EQN APPLIED
;ELSE
;    LW.HOTTOLL=0
;ENDIF

;KDK replace LI.TIME with T0 for toll choice
;Define EACH LINKCLASS TC and COST Functions
; Link Class 1 - Non Regular Toll (it may be a HOT link)
 FUNCTION TC[1]   = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)
 FUNCTION COST[1] = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)+LI.DISTANCE*(LW.HOTTOLL)*60*{CTOLL}

;Link Class 2 - Regular Tollplaza Link (Never HOT link)
 ;FUNCTION   TC[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links
 FUNCTION   TC[2]=T0; MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) ; don't include toll in toll choice time; congested time for toll links
;Ommit service time from toll choice: 
 FUNCTION COST[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links

; Link Class 3 - Regular Toll Accln Link (Never HOT link)
 FUNCTION   TC[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit accel from toll choice: + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION COST[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links

; Link Class 4 - Regular Toll Decln Link (Never HOT link)
 FUNCTION   TC[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit deccel from toll choice: + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 FUNCTION COST[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 
; Link Class 5 - Transit Optional Link 
 FUNCTION   TC[5]=T0                                                            ;congested time transit-only optional links
 FUNCTION COST[5]=T0                                                            ;congested time transit-only optional links

 
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


; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\HTHWY00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\HTHWY00B.PRN" MSG='Mid_Day Period Hwy Assignment'
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEI MATI[2] = "{SCENARIO_DIR}\Output\HWYTTBP_MD_A10.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\Output\HWYTTAB_MD_A10.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\HOT_TOLL.dbf"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TCHOICE_MD.dbf"

FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "{SCENARIO_DIR}\output\TURNS_MD.BIN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\MDPeriod_TollReport.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\FINAL_ASGN_MD.NET"

PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} RAAD=0.00000 AAD=0.000000 RMSE=0.000000 GAP=0.00025; RELATIVEGAP=0.001
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS=7 GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;

;TURNS N=1-999999
TURNS N=39782,40555,40265,40258,40241,40568

;Per-KDK
LOOKUP LOOKUPI=1,
       NAME=KON,
       LOOKUP[1]=REC, RESULT=CT,
       LOOKUP[2]=REC, RESULT=CC,
       LOOKUP[3]=REC, RESULT=TFK,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

LOOKUP LOOKUPI=2,
       NAME=HOTTOLL,
       LOOKUP[1]=HOT, RESULT=MD_TOLL_MI,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

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
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/LI.CONFACMDP
;Save Mid-Day Period Total capacity
  CAPACITY_MDP=C

;Per-KDK
; HOT TOLL RATE/mile from lookup table
HOT_TOLL_PMILE = HOTTOLL(1,LI.HOT)
IF(LI.HOT>=1)
  LW.HOTTOLL = DISTANCE*HOT_TOLL_PMILE
ELSE
    LW.HOTTOLL=0
ENDIF
LW.MYTOLL=LW.HOTTOLL+LI.CARTOLL
LW.MYTOLL2=0.5*LW.MYTOLL

;Set EXCLUDE VOLUME GROUP for PATHLOAD...
  IF (li.FACILITY_TYPE=89 & LI.HOT=0) ADDTOGROUP=1               ;HOV 2 & 3+ Facilities (FT=89 All Day) => Exclude DA and Truck Volume Groups  
  IF (li.FACILITY_TYPE=82 & LI.HOT=0) ADDTOGROUP=3               ;HOV 3+ Facilities => Exclude HOV2 Volume Groups
;Note Dummy HOT ramps are coded as HOT=-1 and their facility_type changed to 69 (transit only)
;  IF (li.HOT=2) ADDTOGROUP=4                                     ;Dummy Entrance and Exit from HOT facility

  IF (li.EECODE>0) ADDTOGROUP=2                                  ;EE PROHIBITED LINKS =>Exclude External Volume Groups
;  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE

  IF (li.HOT>=1) ADDTOGROUP=8                                     ;HOT Lane Facility
  IF (li.FACILITY_TYPE=49,59,69) ADDTOGROUP=9                    ;TRANSIT ONLY FACILITIES =>Exclude all Highway Volume Groups

;Per-KDK
   IF (LI.HOT>=1 | li.FACILITY_TYPE=91-99) ADDTOGROUP=5       ;Any kind of toll road -- KDK
   IF (li.FACILITY_TYPE=91-99) ADDTOGROUP=6                   ;Non-HOT toll road -- KDK

; classify links based on presence/absence of tolls
      LINKCLASS=1                                        ;no toll
      if (li.cartoll>0)           
       LINKCLASS=2                                       ;with toll

       T0=({CTOLL}*LI.CARTOLL)*60 + LI.SVCMINUTES + LI.SVCSECONDS/60

       if (iteration=0)
        LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACMDP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
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

  MW[2]=MI.2.MD_HBW_DA             ;Table 2 
  MW[3]=MI.2.MD_HBW_SR2            ;Table 3 
  MW[4]=MI.2.MD_HBW_SR3P           ;Table 4 
  MW[5]=MI.2.MD_HBO_DA             ;Table 5 
  MW[6]=MI.2.MD_HBO_SR2            ;Table 6 
  MW[7]=MI.2.MD_HBO_SR3P           ;Table 7 
  MW[8]=MI.2.MD_NHB_DA             ;Table 8 
  MW[9]=MI.2.MD_NHB_SR2            ;Table 9 
  MW[10]=MI.2.MD_NHB_SR3P          ;Table 10 

;                                           MW>VOL
  MW[1]=MI.1.MD_TRK_IEII             ;Table 1 >7
  MW[11]=MI.1.MD_TRK_EE              ;Table 11 >8
  MW[12]=MI.1.MD_DA_EE               ;Table 12 >9
  MW[13]=MI.1.MD_SR2_EE              ;Table 13 >10
  MW[14]=MI.1.MD_SR3_EE              ;Table 14 >11
  MW[15]=MI.1.MD_PortTrk             ;Table 15 >12

;=====================
;Per-KDK
;Skim Time and Cost, assuming auto operating costs is the same for toll and free links
; Get straight time skim for free paths (toll links excluded)
; Get straight time skim for free paths (toll links excluded)
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=5,9,MW[21]=PATHTRACE(TIME),NOACCESS=999
; Get time and cost skims for DA, which may include tolls
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=9,  MW[22]=PATHTRACE(TIME),NOACCESS=999,MW[23]=PATHTRACE(LW.MYTOLL),NOACCESS=999,
; Get time and cost skims for SR3+, which may include non-HOT tolls (HOT is free)
                                      MW[27]=PATHTRACE(LI.CARTOLL),NOACCESS=999,
; Set flag for use of HOT lanes
                                      MW[99]=PATHTRACE(LI.HOT),NOACCESS=0
; Get time and cost skims for SR2, which may include tolls
  MW[24]=MW[22]                  ;time- non-free
  MW[25]=0.5*MW[23]              ;mytoll=hottoll+cartoll
; Get time skims for SR3+
  MW[26]=MW[22]                  ;time- non-free 
; Get cost skims for SR3+, which may include non-HOT tolls
  MW[27]=0.3125*MW[27] ; assume 3.2 occ
;
; CHOICE MODEL
;kdk-S65:  c_o=CNTY(1,i);get county number
;  combinations by o & d
   loop p=1,3
   jloop
     if((MW[23]<=0) && (MW[21]<999)) ; if there is no toll skim, all must be free
       SfreeDA  = 1.0  
       SfreeSR2 = 1.0  
       SfreeSR3 = 1.0
     elseif(MW[21]>=999) ; if there is no free skim, all must be placed in the "toll" table
       SfreeDA  = 0.0  
       SfreeSR2 = 0.0  
       SfreeSR3 = 0.0
     else  
;kdk-S65:      c_d=CNTY(1,j)
       ;get coefficients
;xx       dexi = 3*(c_o-1)+p
;kdk-S65:       dexj = 3*(c_d-1)+p
;xx       cti =KON(1,dexi); time coef for i
;xx       cci =KON(2,dexi); cost coef for i
;xx       tfki=KON(3,dexi); toll free constant for i
;kdk-S65:       ctj =KON(1,dexj); time coef for j
;kdk-S65:       ccj =KON(2,dexj); cost coef for j
;kdk-S65:       tfkj=KON(3,dexj); toll free constant for j

       ctp =KON(1,p); time coef for purpose p
       ccp =KON(2,p); cost coef for purpose p
       tfkp=KON(3,p); toll free constant for purpose p

;xx
;xx
;xx       if(dexi=dexj) ; both ends in the same county
;xx          ct=cti
;xx          cc=cci
;xx         tfk=tfki
;xx       else          ; average 2 counties because true Home zone in O-D format is unknown
;xx          ct =0.5*(cti+ctj)
;xx          cc =0.5*(cci+ccj)
;xx          tfk=0.5*(tfki+tfkj)
;xx       endif
;xx
;xx
; SET HOT LANES USE BIAS - 
       if(mw[99]>0) 
          hbias=KON(3,5); HOT bias stored in 5th record
       else
          hbias=0.0
       endif
; OVERRIDE EVERYTHING FOR TEST OF USING CONSTANTS FROM THE *DESTINATION* ZONE ****************
;     rationale - most origins are the non-home end in the PM peak
;kdk-S65:          ct=ctj
;kdk-S65:          cc=ccj
;kdk-S65:         tfk=tfkj + hbias
          ct=ctp
          cc=ccp
          tfk=tfkp + hbias
; ***************************************************************************************
       UfreeDA = ct*MW[21] + tfk
       UfreeSR2= UfreeDA;     ct*MW[21] + tfk
       UfreeSR3= UfreeDA;     ct*MW[21] + tfk
       UtollDA = ct*MW[22] + cc*MW[23]
       UtollSR2= ct*MW[24] + cc*MW[25]
       UtollSR3= ct*MW[26] + cc*MW[27]

       SfreeDA = 1.0/(1.0+exp(UtollDA-UfreeDA)); binary logit form
       ;StollDA = 1.0 - SfreeDA
       SfreeSR2= 1.0/(1.0+exp(UtollSR2-UfreeSR2))
       ;StollSR2= 1.0 - SfreeSR2
       SfreeSR3= 1.0/(1.0+exp(UtollSR3-UfreeSR3))
       ;StollSR3= 1.0 - SfreeSR3
; for test ****************************************************************************
;       if(mw[99]>0) 
;            SfreeDA =0
;            SfreeSR2=0
;            SfreeSR3=0
;       endif
; for test ****************************************************************************
     endif 
 
       dex = 3*(p-1)+2
       k3=3*(p-1)+31
       k4=k3+10; 2*(p-1)+41
       mw[k3] = mw[dex]*SfreeDA  ; free DA
       mw[k4] = mw[dex] - mw[k3] ; toll DA

       dex2 = dex+1; 3*(p-1)+3
       k5=k3+1;      3*(p-1)+32
       k6=k5+10;     2*(p-1)+42
       mw[k5] = mw[dex2]*SfreeSR2 ; free SR2
       mw[k6] = mw[dex2] - mw[k5] ; toll SR2

       dex3 = dex+2; 3*(p-1)+3
       k7=k5+1;      3*(p-1)+33
       k8=k7+10;     2*(p-1)+42
       mw[k7] = mw[dex3]*SfreeSR3 ; free SR3+
       mw[k8] = mw[dex3] - mw[k7] ; toll SR3+

       if(MW[23]<> 0);tabluate free trips when there is a choice - some toll on the path
          kf3=k3+70
          mw[kf3]=mw[k3]; choice free DA

          kf5=kf3+1
          mw[kf5]=mw[k5]; choice free SR2

          kf7=kf5+1
          mw[kf7]=mw[k7]; choice free SR3+
       endif

;EETRIPS Block- Using HBO shares for EE trips...
       if(p=2) ; use HBO shares
          mw[51]=mw[12]*SfreeDA  ; EE DA free
          mw[52]=mw[12]-mw[51]   ; EE DA toll

          mw[53]=mw[13]*SfreeSR2  ; EE SR2 free
          mw[54]=mw[13]-mw[53]   ; EE SR2 toll

          mw[55]=mw[14]*SfreeSR3  ; EE SR3 free
          mw[56]=mw[14]-mw[55]   ; EE SR3 toll
       endif
;EETRIPS Block

   endjloop
   endloop
 
   MW[61] = mw[31] +mw[34] + mw[37] ;drive alone free
   MW[62] = mw[32] +mw[35] + mw[38] ;SR2 free
   MW[63] = mw[33] +mw[36] + mw[39] ;SR3+free
   MW[64] = mw[41] +mw[44] + mw[47] ;drive alone toll
   MW[65] = mw[42] +mw[45] + mw[48] ;SR2 toll
   MW[66] = mw[43] +mw[46] + mw[49] ;SR3+toll
 
;kdk-S65: MW[01] = MW[01]/[PCE-TRK]        ;truck vehicles

;=====================
;SKS- The Select Link Volume sets exceed the maximimum limitation of 20. So assignment with select link was turned off here...
;Per CV documentation, Volume set index range is 1-20; there may be up to 20 volume sets in a single application of Highway. 

 ;FREE LINKS - toll links probibited
  PATHLOAD PATH=TIME, VOL[1]=MW[61], PENI=1, EXCLUDEGROUP=1,5,9  ;Without HOV (DA-Free)
  PATHLOAD PATH=TIME, VOL[2]=MW[62], PENI=1, EXCLUDEGROUP=3,5,9  ;With HOV2 (SR2-Free)
 ;ALL links -toll allowed
  PATHLOAD PATH=TIME, VOL[3]=MW[64], PENI=1, EXCLUDEGROUP=1,9    ;Without HOV (DA-Toll)
  PATHLOAD PATH=TIME, VOL[4]=MW[65], PENI=1, EXCLUDEGROUP=3,9    ;With HOV2  (SR2-Toll)
 ;SR3+ free
  PATHLOAD PATH=TIME, VOL[5]=MW[63], PENI=1, EXCLUDEGROUP=6,9    ;With HOV3+ (SR3-Free)
 ;SR3+ toll
  PATHLOAD PATH=TIME, VOL[6]=MW[66], PENI=1, EXCLUDEGROUP=9      ;With HOV3+ (SR3-Toll)

 ;Trucks
  PATHLOAD PATH=COST, PENI=1, VOL[7]=MW[1],   EXCLUDEGROUP=1,3,8,9    ;IE&II- TRK(7<1) - Not on HOV/HOT  
  PATHLOAD PATH=COST, PENI=1, VOL[12]=MW[15], EXCLUDEGROUP=1,2,3,8,9  ;JaxportTrk(12<15) -Not on HOV/HOT

 ;EE Trips
  if(i>{ZONESI})
   PATHLOAD PATH=COST, PENI=1, VOL[8]=MW[11],EXCLUDEGROUP=1,2,3,8,9, excludej=1-{ZONESI} ;EE- TRK(8<11)-Not on HOV/HOT
   PATHLOAD PATH=TIME, PENI=1, VOL[9]=MW[51],  EXCLUDEGROUP=1,2,5,9, excludej=1-{ZONESI} ;EE-DA-Free(9<51)
   PATHLOAD PATH=TIME, PENI=1, VOL[13]=MW[52], EXCLUDEGROUP=1,2,9,   excludej=1-{ZONESI} ;EE-DA-Toll(13<52)
   PATHLOAD PATH=TIME, PENI=1, VOL[10]=MW[53], EXCLUDEGROUP=2,3,5,9, excludej=1-{ZONESI} ;EE-SR2-Free(10<53)
   PATHLOAD PATH=TIME, PENI=1, VOL[14]=MW[54], EXCLUDEGROUP=2,3,9,   excludej=1-{ZONESI} ;EE-SR2-Toll(14<54)
   PATHLOAD PATH=TIME, PENI=1, VOL[11]=MW[55], EXCLUDEGROUP=2,6,9,   excludej=1-{ZONESI} ;EE-SR3-Free(11<55)
   PATHLOAD PATH=TIME, PENI=1, VOL[15]=MW[56], EXCLUDEGROUP=2,9,     excludej=1-{ZONESI} ;EE-SR3-Free(11<56)
  endif

ENDPROCESS


PROCESS PHASE=ADJUST
;Define volume to be used for V/C calculation
FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]+VOL[8]+VOL[9]+VOL[10]+VOL[11]+VOL[12]+VOL[13]+VOL[14]+VOL[15]

if (time>0) LW.CGSTSPEED=(LW.DISTANCE/TIME)*60

if (li.cartoll>0)
 LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACMDP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
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

; Dynamic HOTTOLL removed - now a fixed rate per mile in linkread
;IF(LI.HOT=1)
;  LW.VCVAL=V/C ; V/C CALCULATION
;  MINHOTTOLL=0.12          ; Minimum HOT lane toll 12 cents per mile
;  MAXHOTTOLL=0.25          ; Maximum HOT lane toll 25 cents per mile
;  LW.HOTTOLL = MINHOTTOLL+(MAXHOTTOLL-MINHOTTOLL)/(1+EXP(6-9*LW.VCVAL))    ;LOGIT EQN APPLIED
;ELSE
;    LW.HOTTOLL=0
;ENDIF

;KDK replace LI.TIME with T0 for toll choice
;Define EACH LINKCLASS TC and COST Functions
; Link Class 1 - Non Regular Toll (it may be a HOT link)
 FUNCTION TC[1]   = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)
 FUNCTION COST[1] = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)+LI.DISTANCE*(LW.HOTTOLL)*60*{CTOLL}

;Link Class 2 - Regular Tollplaza Link (Never HOT link)
 ;FUNCTION   TC[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links
 FUNCTION   TC[2]=T0; MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) ; don't include toll in toll choice time; congested time for toll links
;Ommit service time from toll choice: 
 FUNCTION COST[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links

; Link Class 3 - Regular Toll Accln Link (Never HOT link)
 FUNCTION   TC[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit accel from toll choice: + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION COST[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links

; Link Class 4 - Regular Toll Decln Link (Never HOT link)
 FUNCTION   TC[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit deccel from toll choice: + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 FUNCTION COST[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 
; Link Class 5 - Transit Optional Link 
 FUNCTION   TC[5]=T0                                                            ;congested time transit-only optional links
 FUNCTION COST[5]=T0                                                            ;congested time transit-only optional links

 
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


; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\HTHWY00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\HTHWY00C.PRN" MSG='PM Period Hwy Assignment'
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEI MATI[2] = "C:\NERPM43\Base2005\INT2010\Output\HWYTTBP_PM_A10.MAT"
FILEI MATI[1] = "C:\NERPM43\Base2005\INT2010\Output\HWYTTAB_PM.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\HOT_TOLL.dbf"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TCHOICE_PM.dbf"

FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "{SCENARIO_DIR}\output\TURNS_PM.BIN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PMPeriod_TollReport.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\FINAL_ASGN_PM.NET"

PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} RAAD=0.00000 AAD=0.000000 RMSE=0.000000 GAP=0.00025; RELATIVEGAP=0.001
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS=7 GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;

;TURNS N=1-999999
TURNS N=39782,40555,40265,40258,40241,40568

;Per-KDK
LOOKUP LOOKUPI=1,
       NAME=KON,
       LOOKUP[1]=REC, RESULT=CT,
       LOOKUP[2]=REC, RESULT=CC,
       LOOKUP[3]=REC, RESULT=TFK,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

LOOKUP LOOKUPI=2,
       NAME=HOTTOLL,
       LOOKUP[1]=HOT, RESULT=PM_TOLL_MI,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

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

;Per-KDK
; HOT TOLL RATE/mile from lookup table
HOT_TOLL_PMILE = HOTTOLL(1,LI.HOT)
IF(LI.HOT>=1)
  LW.HOTTOLL = DISTANCE*HOT_TOLL_PMILE
ELSE
    LW.HOTTOLL=0
ENDIF
LW.MYTOLL=LW.HOTTOLL+LI.CARTOLL
LW.MYTOLL2=0.5*LW.MYTOLL

;Set EXCLUDE VOLUME GROUP for PATHLOAD...
  IF (li.FACILITY_TYPE=86,88,89 & LI.HOT=0) ADDTOGROUP=1         ;HOV 2 & 3+ Facilities (FT=87 AM Only) => Exclude DA and Truck Volume Groups  
  IF (li.FACILITY_TYPE=82 & LI.HOT=0) ADDTOGROUP=3               ;HOV 3+ Facilities => Exclude HOV2 Volume Groups
;Note Dummy HOT ramps are coded as HOT=-1 and their facility_type changed to 69 (transit only)
;  IF (li.HOT=2) ADDTOGROUP=4                                     ;Dummy Entrance and Exit from HOT facility

  IF (li.EECODE>0) ADDTOGROUP=2                                  ;EE PROHIBITED LINKS =>Exclude External Volume Groups
;  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE

  IF (li.HOT>=1) ADDTOGROUP=8                                     ;HOT Lane Facility
  IF (li.FACILITY_TYPE=49,59,69) ADDTOGROUP=9                    ;TRANSIT ONLY FACILITIES =>Exclude all Highway Volume Groups

;Per-KDK
   IF (LI.HOT>=1 | li.FACILITY_TYPE=91-99) ADDTOGROUP=5       ;Any kind of toll road -- KDK
   IF (li.FACILITY_TYPE=91-99) ADDTOGROUP=6                   ;Non-HOT toll road -- KDK

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

  MW[2]=MI.2.PM_HBW_DA             ;Table 2 
  MW[3]=MI.2.PM_HBW_SR2            ;Table 3 
  MW[4]=MI.2.PM_HBW_SR3P           ;Table 4 
  MW[5]=MI.2.PM_HBO_DA             ;Table 5 
  MW[6]=MI.2.PM_HBO_SR2            ;Table 6 
  MW[7]=MI.2.PM_HBO_SR3P           ;Table 7 
  MW[8]=MI.2.PM_NHB_DA             ;Table 8 
  MW[9]=MI.2.PM_NHB_SR2            ;Table 9 
  MW[10]=MI.2.PM_NHB_SR3P          ;Table 10 

;                                           MW>VOL
  MW[1]=MI.1.PM_TRK_IEII             ;Table 1 >7
  MW[11]=MI.1.PM_TRK_EE              ;Table 11 >8
  MW[12]=MI.1.PM_DA_EE               ;Table 12 >9
  MW[13]=MI.1.PM_SR2_EE              ;Table 13 >10
  MW[14]=MI.1.PM_SR3_EE              ;Table 14 >11
  MW[15]=MI.1.PM_PortTrk             ;Table 15 >12

;=====================
;Per-KDK
;Skim Time and Cost, assuming auto operating costs is the same for toll and free links
; Get straight time skim for free paths (toll links excluded)
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=5,9,MW[21]=PATHTRACE(TIME),NOACCESS=999
; Get time and cost skims for DA, which may include tolls
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=9,  MW[22]=PATHTRACE(TIME),NOACCESS=999,MW[23]=PATHTRACE(LW.MYTOLL),NOACCESS=999,
; Get time and cost skims for SR3+, which may include non-HOT tolls (HOT is free)
                                      MW[27]=PATHTRACE(LI.CARTOLL),NOACCESS=999,
; Set flag for use of HOT lanes
                                      MW[99]=PATHTRACE(LI.HOT),NOACCESS=0
; Get time and cost skims for SR2, which may include tolls
  MW[24]=MW[22]                  ;time- non-free
  MW[25]=0.5*MW[23]              ;mytoll=hottoll+cartoll
; Get time skims for SR3+
  MW[26]=MW[22]                  ;time- non-free 
; Get cost skims for SR3+, which may include non-HOT tolls
  MW[27]=0.3125*MW[27] ; assume 3.2 occ
;
; CHOICE MODEL
;kdk-S65:  c_o=CNTY(1,i);get county number
;  combinations by o & d
   loop p=1,3
   jloop
     if((MW[23]<=0) && (MW[21]<999)) ; if there is no toll skim, all must be free
       SfreeDA  = 1.0  
       SfreeSR2 = 1.0  
       SfreeSR3 = 1.0
     elseif(MW[21]>=999) ; if there is no free skim, all must be placed in the "toll" table
       SfreeDA  = 0.0  
       SfreeSR2 = 0.0  
       SfreeSR3 = 0.0
     else  
;kdk-S65:      c_d=CNTY(1,j)
       ;get coefficients
;xx       dexi = 3*(c_o-1)+p
;kdk-S65:       dexj = 3*(c_d-1)+p
;xx       cti =KON(1,dexi); time coef for i
;xx       cci =KON(2,dexi); cost coef for i
;xx       tfki=KON(3,dexi); toll free constant for i
;kdk-S65:       ctj =KON(1,dexj); time coef for j
;kdk-S65:       ccj =KON(2,dexj); cost coef for j
;kdk-S65:       tfkj=KON(3,dexj); toll free constant for j

       ctp =KON(1,p); time coef for purpose p
       ccp =KON(2,p); cost coef for purpose p
       tfkp=KON(3,p); toll free constant for purpose p

;xx
;xx
;xx       if(dexi=dexj) ; both ends in the same county
;xx          ct=cti
;xx          cc=cci
;xx         tfk=tfki
;xx       else          ; average 2 counties because true Home zone in O-D format is unknown
;xx          ct =0.5*(cti+ctj)
;xx          cc =0.5*(cci+ccj)
;xx          tfk=0.5*(tfki+tfkj)
;xx       endif
;xx
;xx
; SET HOT LANES USE BIAS - 
       if(mw[99]>0) 
          hbias=KON(3,5); HOT bias stored in 5th record
       else
          hbias=0.0
       endif
; OVERRIDE EVERYTHING FOR TEST OF USING CONSTANTS FROM THE *DESTINATION* ZONE ****************
;     rationale - most origins are the non-home end in the PM peak
;kdk-S65:          ct=ctj
;kdk-S65:          cc=ccj
;kdk-S65:         tfk=tfkj + hbias
          ct=ctp
          cc=ccp
          tfk=tfkp + hbias
; ***************************************************************************************
       UfreeDA = ct*MW[21] + tfk
       UfreeSR2= UfreeDA;     ct*MW[21] + tfk
       UfreeSR3= UfreeDA;     ct*MW[21] + tfk
       UtollDA = ct*MW[22] + cc*MW[23]
       UtollSR2= ct*MW[24] + cc*MW[25]
       UtollSR3= ct*MW[26] + cc*MW[27]

       SfreeDA = 1.0/(1.0+exp(UtollDA-UfreeDA)); binary logit form
       ;StollDA = 1.0 - SfreeDA
       SfreeSR2= 1.0/(1.0+exp(UtollSR2-UfreeSR2))
       ;StollSR2= 1.0 - SfreeSR2
       SfreeSR3= 1.0/(1.0+exp(UtollSR3-UfreeSR3))
       ;StollSR3= 1.0 - SfreeSR3
; for test ****************************************************************************
;       if(mw[99]>0) 
;            SfreeDA =0
;            SfreeSR2=0
;            SfreeSR3=0
;       endif
; for test ****************************************************************************
     endif 
 
       dex = 3*(p-1)+2
       k3=3*(p-1)+31
       k4=k3+10; 2*(p-1)+41
       mw[k3] = mw[dex]*SfreeDA  ; free DA
       mw[k4] = mw[dex] - mw[k3] ; toll DA

       dex2 = dex+1; 3*(p-1)+3
       k5=k3+1;      3*(p-1)+32
       k6=k5+10;     2*(p-1)+42
       mw[k5] = mw[dex2]*SfreeSR2 ; free SR2
       mw[k6] = mw[dex2] - mw[k5] ; toll SR2

       dex3 = dex+2; 3*(p-1)+3
       k7=k5+1;      3*(p-1)+33
       k8=k7+10;     2*(p-1)+42
       mw[k7] = mw[dex3]*SfreeSR3 ; free SR3+
       mw[k8] = mw[dex3] - mw[k7] ; toll SR3+

       if(MW[23]<> 0);tabluate free trips when there is a choice - some toll on the path
          kf3=k3+70
          mw[kf3]=mw[k3]; choice free DA

          kf5=kf3+1
          mw[kf5]=mw[k5]; choice free SR2

          kf7=kf5+1
          mw[kf7]=mw[k7]; choice free SR3+
       endif

;EETRIPS Block- Using HBO shares for EE trips...
       if(p=2) ; use HBO shares
          mw[51]=mw[12]*SfreeDA  ; EE DA free
          mw[52]=mw[12]-mw[51]   ; EE DA toll

          mw[53]=mw[13]*SfreeSR2  ; EE SR2 free
          mw[54]=mw[13]-mw[53]   ; EE SR2 toll

          mw[55]=mw[14]*SfreeSR3  ; EE SR3 free
          mw[56]=mw[14]-mw[55]   ; EE SR3 toll
       endif
;EETRIPS Block

   endjloop
   endloop
 
   MW[61] = mw[31] +mw[34] + mw[37] ;drive alone free
   MW[62] = mw[32] +mw[35] + mw[38] ;SR2 free
   MW[63] = mw[33] +mw[36] + mw[39] ;SR3+free
   MW[64] = mw[41] +mw[44] + mw[47] ;drive alone toll
   MW[65] = mw[42] +mw[45] + mw[48] ;SR2 toll
   MW[66] = mw[43] +mw[46] + mw[49] ;SR3+toll
 
;kdk-S65: MW[01] = MW[01]/[PCE-TRK]        ;truck vehicles

;=====================
;SKS- The Select Link Volume sets exceed the maximimum limitation of 20. So assignment with select link was turned off here...
;Per CV documentation, Volume set index range is 1-20; there may be up to 20 volume sets in a single application of Highway. 

 ;FREE LINKS - toll links probibited
  PATHLOAD PATH=TIME, VOL[1]=MW[61], PENI=1, EXCLUDEGROUP=1,5,9  ;Without HOV (DA-Free)
  PATHLOAD PATH=TIME, VOL[2]=MW[62], PENI=1, EXCLUDEGROUP=3,5,9  ;With HOV2 (SR2-Free)
 ;ALL links -toll allowed
  PATHLOAD PATH=TIME, VOL[3]=MW[64], PENI=1, EXCLUDEGROUP=1,9    ;Without HOV (DA-Toll)
  PATHLOAD PATH=TIME, VOL[4]=MW[65], PENI=1, EXCLUDEGROUP=3,9    ;With HOV2  (SR2-Toll)
 ;SR3+ free
  PATHLOAD PATH=TIME, VOL[5]=MW[63], PENI=1, EXCLUDEGROUP=6,9    ;With HOV3+ (SR3-Free)
 ;SR3+ toll
  PATHLOAD PATH=TIME, VOL[6]=MW[66], PENI=1, EXCLUDEGROUP=9      ;With HOV3+ (SR3-Toll)

 ;Trucks
  PATHLOAD PATH=COST, PENI=1, VOL[7]=MW[1],   EXCLUDEGROUP=1,3,8,9    ;IE&II- TRK(7<1) - Not on HOV/HOT  
  PATHLOAD PATH=COST, PENI=1, VOL[12]=MW[15], EXCLUDEGROUP=1,2,3,8,9  ;JaxportTrk(12<15) -Not on HOV/HOT

 ;EE Trips
  if(i>{ZONESI})
   PATHLOAD PATH=COST, PENI=1, VOL[8]=MW[11],EXCLUDEGROUP=1,2,3,8,9, excludej=1-{ZONESI} ;EE- TRK(8<11)-Not on HOV/HOT
   PATHLOAD PATH=TIME, PENI=1, VOL[9]=MW[51],  EXCLUDEGROUP=1,2,5,9, excludej=1-{ZONESI} ;EE-DA-Free(9<51)
   PATHLOAD PATH=TIME, PENI=1, VOL[13]=MW[52], EXCLUDEGROUP=1,2,9,   excludej=1-{ZONESI} ;EE-DA-Toll(13<52)
   PATHLOAD PATH=TIME, PENI=1, VOL[10]=MW[53], EXCLUDEGROUP=2,3,5,9, excludej=1-{ZONESI} ;EE-SR2-Free(10<53)
   PATHLOAD PATH=TIME, PENI=1, VOL[14]=MW[54], EXCLUDEGROUP=2,3,9,   excludej=1-{ZONESI} ;EE-SR2-Toll(14<54)
   PATHLOAD PATH=TIME, PENI=1, VOL[11]=MW[55], EXCLUDEGROUP=2,6,9,   excludej=1-{ZONESI} ;EE-SR3-Free(11<55)
   PATHLOAD PATH=TIME, PENI=1, VOL[15]=MW[56], EXCLUDEGROUP=2,9,     excludej=1-{ZONESI} ;EE-SR3-Free(11<56)
  endif

ENDPROCESS


PROCESS PHASE=ADJUST
;Define volume to be used for V/C calculation
FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]+VOL[8]+VOL[9]+VOL[10]+VOL[11]+VOL[12]+VOL[13]+VOL[14]+VOL[15]

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

; Dynamic HOTTOLL removed - now a fixed rate per mile in linkread
;IF(LI.HOT=1)
;  LW.VCVAL=V/C ; V/C CALCULATION
;  MINHOTTOLL=0.12          ; Minimum HOT lane toll 12 cents per mile
;  MAXHOTTOLL=0.25          ; Maximum HOT lane toll 25 cents per mile
;  LW.HOTTOLL = MINHOTTOLL+(MAXHOTTOLL-MINHOTTOLL)/(1+EXP(6-9*LW.VCVAL))    ;LOGIT EQN APPLIED
;ELSE
;    LW.HOTTOLL=0
;ENDIF

;KDK replace LI.TIME with T0 for toll choice
;Define EACH LINKCLASS TC and COST Functions
; Link Class 1 - Non Regular Toll (it may be a HOT link)
 FUNCTION TC[1]   = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)
 FUNCTION COST[1] = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)+LI.DISTANCE*(LW.HOTTOLL)*60*{CTOLL}

;Link Class 2 - Regular Tollplaza Link (Never HOT link)
 ;FUNCTION   TC[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links
 FUNCTION   TC[2]=T0; MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) ; don't include toll in toll choice time; congested time for toll links
;Ommit service time from toll choice: 
 FUNCTION COST[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links

; Link Class 3 - Regular Toll Accln Link (Never HOT link)
 FUNCTION   TC[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit accel from toll choice: + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION COST[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links

; Link Class 4 - Regular Toll Decln Link (Never HOT link)
 FUNCTION   TC[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit deccel from toll choice: + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 FUNCTION COST[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 
; Link Class 5 - Transit Optional Link 
 FUNCTION   TC[5]=T0                                                            ;congested time transit-only optional links
 FUNCTION COST[5]=T0                                                            ;congested time transit-only optional links

 
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


; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\HTHWY00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\HTHWY00D.PRN" MSG='Night Period Hwy Assignment'
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEI MATI[2] = "C:\NERPM43\Base2005\INT2010\Output\HWYTTBP_NT_A10.MAT"
FILEI MATI[1] = "C:\NERPM43\Base2005\INT2010\Output\HWYTTAB_NT_A10.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\HOT_TOLL.dbf"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TCHOICE_NT.dbf"

FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "{SCENARIO_DIR}\output\TURNS_NT.BIN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTPeriod_TollReport.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\FINAL_ASGN_NT.NET"

PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} RAAD=0.00000 AAD=0.000000 RMSE=0.000000 GAP=0.00025; RELATIVEGAP=0.001
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;
;PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS=7 GAP=0.0005 RAAD=0.00000 AAD=0.000000 RMSE=0.000000 ;

;TURNS N=1-999999
TURNS N=39782,40555,40265,40258,40241,40568

;Per-KDK
LOOKUP LOOKUPI=1,
       NAME=KON,
       LOOKUP[1]=REC, RESULT=CT,
       LOOKUP[2]=REC, RESULT=CC,
       LOOKUP[3]=REC, RESULT=TFK,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

LOOKUP LOOKUPI=2,
       NAME=HOTTOLL,
       LOOKUP[1]=HOT, RESULT=NT_TOLL_MI,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0

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
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/LI.CONFACNTP
;Save Night Period Total capacity
  CAPACITY_NTP=C

;Per-KDK
; HOT TOLL RATE/mile from lookup table
HOT_TOLL_PMILE = HOTTOLL(1,LI.HOT)
IF(LI.HOT>=1)
  LW.HOTTOLL = DISTANCE*HOT_TOLL_PMILE
ELSE
    LW.HOTTOLL=0
ENDIF
LW.MYTOLL=LW.HOTTOLL+LI.CARTOLL
LW.MYTOLL2=0.5*LW.MYTOLL

;Set EXCLUDE VOLUME GROUP for PATHLOAD...
  IF (li.FACILITY_TYPE=89 & LI.HOT=0) ADDTOGROUP=1               ;HOV 2 & 3+ Facilities (FT=89 All Day) => Exclude DA and Truck Volume Groups  
  IF (li.FACILITY_TYPE=82 & LI.HOT=0) ADDTOGROUP=3               ;HOV 3+ Facilities => Exclude HOV2 Volume Groups
;Note Dummy HOT ramps are coded as HOT=-1 and their facility_type changed to 69 (transit only)
;  IF (li.HOT=2) ADDTOGROUP=4                                     ;Dummy Entrance and Exit from HOT facility

  IF (li.EECODE>0) ADDTOGROUP=2                                  ;EE PROHIBITED LINKS =>Exclude External Volume Groups
;  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE

  IF (li.HOT>=1) ADDTOGROUP=8                                     ;HOT Lane Facility
  IF (li.FACILITY_TYPE=49,59,69) ADDTOGROUP=9                    ;TRANSIT ONLY FACILITIES =>Exclude all Highway Volume Groups

;Per-KDK
   IF (LI.HOT>=1 | li.FACILITY_TYPE=91-99) ADDTOGROUP=5       ;Any kind of toll road -- KDK
   IF (li.FACILITY_TYPE=91-99) ADDTOGROUP=6                   ;Non-HOT toll road -- KDK

; classify links based on presence/absence of tolls
      LINKCLASS=1                                        ;no toll
      if (li.cartoll>0)           
       LINKCLASS=2                                       ;with toll

       T0=({CTOLL}*LI.CARTOLL)*60 + LI.SVCMINUTES + LI.SVCSECONDS/60

       if (iteration=0)
        LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACNTP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
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

  MW[2]=MI.2.NT_HBW_DA             ;Table 2 
  MW[3]=MI.2.NT_HBW_SR2            ;Table 3 
  MW[4]=MI.2.NT_HBW_SR3P           ;Table 4 
  MW[5]=MI.2.NT_HBO_DA             ;Table 5 
  MW[6]=MI.2.NT_HBO_SR2            ;Table 6 
  MW[7]=MI.2.NT_HBO_SR3P           ;Table 7 
  MW[8]=MI.2.NT_NHB_DA             ;Table 8 
  MW[9]=MI.2.NT_NHB_SR2            ;Table 9 
  MW[10]=MI.2.NT_NHB_SR3P          ;Table 10 

;                                           MW>VOL
  MW[1]=MI.1.NT_TRK_IEII             ;Table 1 >7
  MW[11]=MI.1.NT_TRK_EE              ;Table 11 >8
  MW[12]=MI.1.NT_DA_EE               ;Table 12 >9
  MW[13]=MI.1.NT_SR2_EE              ;Table 13 >10
  MW[14]=MI.1.NT_SR3_EE              ;Table 14 >11
  MW[15]=MI.1.NT_PortTrk             ;Table 15 >12

;=====================
;Per-KDK
;Skim Time and Cost, assuming auto operating costs is the same for toll and free links
; Get straight time skim for free paths (toll links excluded)
; Get straight time skim for free paths (toll links excluded)
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=5,9,MW[21]=PATHTRACE(TIME),NOACCESS=999
; Get time and cost skims for DA, which may include tolls
PATHLOAD PATH=TIME PENI=1, EXCLUDEGROUP=9,  MW[22]=PATHTRACE(TIME),NOACCESS=999,MW[23]=PATHTRACE(LW.MYTOLL),NOACCESS=999,
; Get time and cost skims for SR3+, which may include non-HOT tolls (HOT is free)
                                      MW[27]=PATHTRACE(LI.CARTOLL),NOACCESS=999,
; Set flag for use of HOT lanes
                                      MW[99]=PATHTRACE(LI.HOT),NOACCESS=0
; Get time and cost skims for SR2, which may include tolls
  MW[24]=MW[22]                  ;time- non-free
  MW[25]=0.5*MW[23]              ;mytoll=hottoll+cartoll
; Get time skims for SR3+
  MW[26]=MW[22]                  ;time- non-free 
; Get cost skims for SR3+, which may include non-HOT tolls
  MW[27]=0.3125*MW[27] ; assume 3.2 occ
;
; CHOICE MODEL
;kdk-S65:  c_o=CNTY(1,i);get county number
;  combinations by o & d
   loop p=1,3
   jloop
     if((MW[23]<=0) && (MW[21]<999)) ; if there is no toll skim, all must be free
       SfreeDA  = 1.0  
       SfreeSR2 = 1.0  
       SfreeSR3 = 1.0
     elseif(MW[21]>=999) ; if there is no free skim, all must be placed in the "toll" table
       SfreeDA  = 0.0  
       SfreeSR2 = 0.0  
       SfreeSR3 = 0.0
     else  
;kdk-S65:      c_d=CNTY(1,j)
       ;get coefficients
;xx       dexi = 3*(c_o-1)+p
;kdk-S65:       dexj = 3*(c_d-1)+p
;xx       cti =KON(1,dexi); time coef for i
;xx       cci =KON(2,dexi); cost coef for i
;xx       tfki=KON(3,dexi); toll free constant for i
;kdk-S65:       ctj =KON(1,dexj); time coef for j
;kdk-S65:       ccj =KON(2,dexj); cost coef for j
;kdk-S65:       tfkj=KON(3,dexj); toll free constant for j

       ctp =KON(1,p); time coef for purpose p
       ccp =KON(2,p); cost coef for purpose p
       tfkp=KON(3,p); toll free constant for purpose p

;xx
;xx
;xx       if(dexi=dexj) ; both ends in the same county
;xx          ct=cti
;xx          cc=cci
;xx         tfk=tfki
;xx       else          ; average 2 counties because true Home zone in O-D format is unknown
;xx          ct =0.5*(cti+ctj)
;xx          cc =0.5*(cci+ccj)
;xx          tfk=0.5*(tfki+tfkj)
;xx       endif
;xx
;xx
; SET HOT LANES USE BIAS - 
       if(mw[99]>0) 
          hbias=KON(3,5); HOT bias stored in 5th record
       else
          hbias=0.0
       endif
; OVERRIDE EVERYTHING FOR TEST OF USING CONSTANTS FROM THE *DESTINATION* ZONE ****************
;     rationale - most origins are the non-home end in the PM peak
;kdk-S65:          ct=ctj
;kdk-S65:          cc=ccj
;kdk-S65:         tfk=tfkj + hbias
          ct=ctp
          cc=ccp
          tfk=tfkp + hbias
; ***************************************************************************************
       UfreeDA = ct*MW[21] + tfk
       UfreeSR2= UfreeDA;     ct*MW[21] + tfk
       UfreeSR3= UfreeDA;     ct*MW[21] + tfk
       UtollDA = ct*MW[22] + cc*MW[23]
       UtollSR2= ct*MW[24] + cc*MW[25]
       UtollSR3= ct*MW[26] + cc*MW[27]

       SfreeDA = 1.0/(1.0+exp(UtollDA-UfreeDA)); binary logit form
       ;StollDA = 1.0 - SfreeDA
       SfreeSR2= 1.0/(1.0+exp(UtollSR2-UfreeSR2))
       ;StollSR2= 1.0 - SfreeSR2
       SfreeSR3= 1.0/(1.0+exp(UtollSR3-UfreeSR3))
       ;StollSR3= 1.0 - SfreeSR3
; for test ****************************************************************************
;       if(mw[99]>0) 
;            SfreeDA =0
;            SfreeSR2=0
;            SfreeSR3=0
;       endif
; for test ****************************************************************************
     endif 
 
       dex = 3*(p-1)+2
       k3=3*(p-1)+31
       k4=k3+10; 2*(p-1)+41
       mw[k3] = mw[dex]*SfreeDA  ; free DA
       mw[k4] = mw[dex] - mw[k3] ; toll DA

       dex2 = dex+1; 3*(p-1)+3
       k5=k3+1;      3*(p-1)+32
       k6=k5+10;     2*(p-1)+42
       mw[k5] = mw[dex2]*SfreeSR2 ; free SR2
       mw[k6] = mw[dex2] - mw[k5] ; toll SR2

       dex3 = dex+2; 3*(p-1)+3
       k7=k5+1;      3*(p-1)+33
       k8=k7+10;     2*(p-1)+42
       mw[k7] = mw[dex3]*SfreeSR3 ; free SR3+
       mw[k8] = mw[dex3] - mw[k7] ; toll SR3+

       if(MW[23]<> 0);tabluate free trips when there is a choice - some toll on the path
          kf3=k3+70
          mw[kf3]=mw[k3]; choice free DA

          kf5=kf3+1
          mw[kf5]=mw[k5]; choice free SR2

          kf7=kf5+1
          mw[kf7]=mw[k7]; choice free SR3+
       endif

;EETRIPS Block- Using HBO shares for EE trips...
       if(p=2) ; use HBO shares
          mw[51]=mw[12]*SfreeDA  ; EE DA free
          mw[52]=mw[12]-mw[51]   ; EE DA toll

          mw[53]=mw[13]*SfreeSR2  ; EE SR2 free
          mw[54]=mw[13]-mw[53]   ; EE SR2 toll

          mw[55]=mw[14]*SfreeSR3  ; EE SR3 free
          mw[56]=mw[14]-mw[55]   ; EE SR3 toll
       endif
;EETRIPS Block

   endjloop
   endloop
 
   MW[61] = mw[31] +mw[34] + mw[37] ;drive alone free
   MW[62] = mw[32] +mw[35] + mw[38] ;SR2 free
   MW[63] = mw[33] +mw[36] + mw[39] ;SR3+free
   MW[64] = mw[41] +mw[44] + mw[47] ;drive alone toll
   MW[65] = mw[42] +mw[45] + mw[48] ;SR2 toll
   MW[66] = mw[43] +mw[46] + mw[49] ;SR3+toll
 
;kdk-S65: MW[01] = MW[01]/[PCE-TRK]        ;truck vehicles

;=====================
;SKS- The Select Link Volume sets exceed the maximimum limitation of 20. So assignment with select link was turned off here...
;Per CV documentation, Volume set index range is 1-20; there may be up to 20 volume sets in a single application of Highway. 

 ;FREE LINKS - toll links probibited
  PATHLOAD PATH=TIME, VOL[1]=MW[61], PENI=1, EXCLUDEGROUP=1,5,9  ;Without HOV (DA-Free)
  PATHLOAD PATH=TIME, VOL[2]=MW[62], PENI=1, EXCLUDEGROUP=3,5,9  ;With HOV2 (SR2-Free)
 ;ALL links -toll allowed
  PATHLOAD PATH=TIME, VOL[3]=MW[64], PENI=1, EXCLUDEGROUP=1,9    ;Without HOV (DA-Toll)
  PATHLOAD PATH=TIME, VOL[4]=MW[65], PENI=1, EXCLUDEGROUP=3,9    ;With HOV2  (SR2-Toll)
 ;SR3+ free
  PATHLOAD PATH=TIME, VOL[5]=MW[63], PENI=1, EXCLUDEGROUP=6,9    ;With HOV3+ (SR3-Free)
 ;SR3+ toll
  PATHLOAD PATH=TIME, VOL[6]=MW[66], PENI=1, EXCLUDEGROUP=9      ;With HOV3+ (SR3-Toll)

 ;Trucks
  PATHLOAD PATH=COST, PENI=1, VOL[7]=MW[1],   EXCLUDEGROUP=1,3,8,9    ;IE&II- TRK(7<1) - Not on HOV/HOT  
  PATHLOAD PATH=COST, PENI=1, VOL[12]=MW[15], EXCLUDEGROUP=1,2,3,8,9  ;JaxportTrk(12<15) -Not on HOV/HOT

 ;EE Trips
  if(i>{ZONESI})
   PATHLOAD PATH=COST, PENI=1, VOL[8]=MW[11],EXCLUDEGROUP=1,2,3,8,9, excludej=1-{ZONESI} ;EE- TRK(8<11)-Not on HOV/HOT
   PATHLOAD PATH=TIME, PENI=1, VOL[9]=MW[51],  EXCLUDEGROUP=1,2,5,9, excludej=1-{ZONESI} ;EE-DA-Free(9<51)
   PATHLOAD PATH=TIME, PENI=1, VOL[13]=MW[52], EXCLUDEGROUP=1,2,9,   excludej=1-{ZONESI} ;EE-DA-Toll(13<52)
   PATHLOAD PATH=TIME, PENI=1, VOL[10]=MW[53], EXCLUDEGROUP=2,3,5,9, excludej=1-{ZONESI} ;EE-SR2-Free(10<53)
   PATHLOAD PATH=TIME, PENI=1, VOL[14]=MW[54], EXCLUDEGROUP=2,3,9,   excludej=1-{ZONESI} ;EE-SR2-Toll(14<54)
   PATHLOAD PATH=TIME, PENI=1, VOL[11]=MW[55], EXCLUDEGROUP=2,6,9,   excludej=1-{ZONESI} ;EE-SR3-Free(11<55)
   PATHLOAD PATH=TIME, PENI=1, VOL[15]=MW[56], EXCLUDEGROUP=2,9,     excludej=1-{ZONESI} ;EE-SR3-Free(11<56)
  endif

ENDPROCESS


PROCESS PHASE=ADJUST
;Define volume to be used for V/C calculation
FUNCTION   V=VOL[1]+VOL[2]+VOL[3]+VOL[4]+VOL[5]+VOL[6]+VOL[7]+VOL[8]+VOL[9]+VOL[10]+VOL[11]+VOL[12]+VOL[13]+VOL[14]+VOL[15]

if (time>0) LW.CGSTSPEED=(LW.DISTANCE/TIME)*60

if (li.cartoll>0)
 LW.ARRIVR=(V/LI.UROADFACTOR)*LI.CONFACNTP/LI.PLZALNSMAX  ; hourly volume per toll lane ie. arrival rate in vehicles per hour
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

; Dynamic HOTTOLL removed - now a fixed rate per mile in linkread
;IF(LI.HOT=1)
;  LW.VCVAL=V/C ; V/C CALCULATION
;  MINHOTTOLL=0.12          ; Minimum HOT lane toll 12 cents per mile
;  MAXHOTTOLL=0.25          ; Maximum HOT lane toll 25 cents per mile
;  LW.HOTTOLL = MINHOTTOLL+(MAXHOTTOLL-MINHOTTOLL)/(1+EXP(6-9*LW.VCVAL))    ;LOGIT EQN APPLIED
;ELSE
;    LW.HOTTOLL=0
;ENDIF

;KDK replace LI.TIME with T0 for toll choice
;Define EACH LINKCLASS TC and COST Functions
; Link Class 1 - Non Regular Toll (it may be a HOT link)
 FUNCTION TC[1]   = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)
 FUNCTION COST[1] = T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT)+LI.DISTANCE*(LW.HOTTOLL)*60*{CTOLL}

;Link Class 2 - Regular Tollplaza Link (Never HOT link)
 ;FUNCTION   TC[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links
 FUNCTION   TC[2]=T0; MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) ; don't include toll in toll choice time; congested time for toll links
;Ommit service time from toll choice: 
 FUNCTION COST[2]=MIN(5,(1/(2.0*(LW.SERVR-LW.ARRIVR)))*60) + {CTOLL}*LI.CARTOLL*60        ; congested time for toll links

; Link Class 3 - Regular Toll Accln Link (Never HOT link)
 FUNCTION   TC[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit accel from toll choice: + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links
 FUNCTION COST[3]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/2.5)/60; congested time toll acceleration links

; Link Class 4 - Regular Toll Decln Link (Never HOT link)
 FUNCTION   TC[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) ;Omit deccel from toll choice: + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 FUNCTION COST[4]=T0*(1+LI.BPRCOEFFICIENT*(MIN(V/C,{VCMAX}))^LI.BPREXPONENT) + (LW.CGSTSPEED/DECEL(1,LW.CGSTSPEED))/60; congested time toll deceleration links
 
; Link Class 5 - Transit Optional Link 
 FUNCTION   TC[5]=T0                                                            ;congested time transit-only optional links
 FUNCTION COST[5]=T0                                                            ;congested time transit-only optional links

 
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


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\HTNET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00A.PRN" MSG='AM Period - Rename Loaded Netw Attributes & Minor Calc'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\FINAL_ASGN_AM.NET"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_AM_Period.NET",
 EXCLUDE=TIME_1 VC_1, CSPD_1 VDT_1 VHT_1,
          V_1 V1_1 V2_1 V3_1 V4_1 V5_1 V6_1 V7_1 V8_1 V9_1 V10_1 V11_1 V12_1 V13_1 V14_1 V15_1,
          VT_1 V1T_1 V2T_1 V3T_1 V4T_1 V5T_1 V6T_1 V7T_1 V8T_1 V9T_1 V10T_1 V11T_1 V12T_1 V13T_1 V14T_1 V15T_1
         
AM_VL_TOT_{YEAR}{ALT}=V_1                   ;Total

AM_VL_DA_{YEAR}{ALT}=V1_1+V3_1+V9_1+V13_1   ;DA-Free&Toll-II&IE+EE 
AM_F_DA_{YEAR}{ALT}=V1_1                    ;DA-II&IE-Free
AM_T_DA_{YEAR}{ALT}=V3_1                    ;DA-II&IE-Toll
AM_F_EDA_{YEAR}{ALT}=V9_1                   ;DA-EE-Free
AM_T_EDA_{YEAR}{ALT}=V13_1                  ;DA-EE-Toll

AM_VL_SR2_{YEAR}{ALT}=V2_1+V4_1+V10_1+V14_1 ;SR2-Free&Toll-II&IE+EE 
AM_F_SR2_{YEAR}{ALT}=V2_1                   ;SR2-II&IE-Free
AM_T_SR2_{YEAR}{ALT}=V4_1                   ;SR2-II&IE-Toll
AM_F_ESR2_{YEAR}{ALT}=V10_1                 ;SR2-EE-Free
AM_T_ESR2_{YEAR}{ALT}=V14_1                 ;SR2-EE-Toll

AM_VL_SR3_{YEAR}{ALT}=V5_1+V6_1+V11_1+V15_1 ;SR3-Free&Toll-II&IE+EE 
AM_F_SR3_{YEAR}{ALT}=V5_1                   ;SR3-II&IE-Free
AM_T_SR3_{YEAR}{ALT}=V6_1                   ;SR3-II&IE-Toll
AM_F_ESR3_{YEAR}{ALT}=V11_1                 ;SR3-EE-Free
AM_T_ESR3_{YEAR}{ALT}=V15_1                 ;SR3-EE-Toll

AM_VL_Trk_{YEAR}{ALT}=V7_1+V8_1+V12_1       ;Truck-II&IE+EE+Port
AM_VL_PrtTk_{YEAR}{ALT}=V12_1               ;Port-Truck

AM_VL_EXT_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V13_1+V14_1+V15_1 ;EXT-TRK + EE-Free&Toll(DA+SR2+SR3) -Note:Does not include ext-ext of Port Truck

AM_CGSPEED_{YEAR}{ALT}=CSPD_1
AM_VMT_{YEAR}{ALT}=VDT_1
AM_VHT_{YEAR}{ALT}=VHT_1

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (AM_CGSPEED_{YEAR}{ALT}>0)
   AM_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/AM_CGSPEED_{YEAR}{ALT}
 else 
   AM_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(AM_CGSPEED_{YEAR}{ALT}+0.01)
   AM_FlgCGSPDZero=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
;if ('{Year}'='05')
;   if (Li.1.Count>0)
;      VOLCNTRTO= V_1/LI.1.COUNT
;     else
;      VOLCNTRTO=0.0
;   endif 
;endif


if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  AM_VCcapRTO_{YEAR}{ALT}=(V_1*LI.1.CONFACAMP)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  AM_VCcapRTO_{YEAR}{ALT}=9999.0
endif



ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\HTNET00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00B.PRN" MSG='Mid_Day Period - Rename Loaded Netw Attributes & Minor Calc'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\FINAL_ASGN_MD.NET"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_MD_Period.NET",
 EXCLUDE=TIME_1 VC_1, CSPD_1 VDT_1 VHT_1,
          V_1 V1_1 V2_1 V3_1 V4_1 V5_1 V6_1 V7_1 V8_1 V9_1 V10_1 V11_1 V12_1 V13_1 V14_1 V15_1,
          VT_1 V1T_1 V2T_1 V3T_1 V4T_1 V5T_1 V6T_1 V7T_1 V8T_1 V9T_1 V10T_1 V11T_1 V12T_1 V13T_1 V14T_1 V15T_1
         
MD_VL_TOT_{YEAR}{ALT}=V_1                   ;Total

MD_VL_DA_{YEAR}{ALT}=V1_1+V3_1+V9_1+V13_1   ;DA-Free&Toll-II&IE+EE 
MD_F_DA_{YEAR}{ALT}=V1_1                    ;DA-II&IE-Free
MD_T_DA_{YEAR}{ALT}=V3_1                    ;DA-II&IE-Toll
MD_F_EDA_{YEAR}{ALT}=V9_1                   ;DA-EE-Free
MD_T_EDA_{YEAR}{ALT}=V13_1                  ;DA-EE-Toll

MD_VL_SR2_{YEAR}{ALT}=V2_1+V4_1+V10_1+V14_1 ;SR2-Free&Toll-II&IE+EE 
MD_F_SR2_{YEAR}{ALT}=V2_1                   ;SR2-II&IE-Free
MD_T_SR2_{YEAR}{ALT}=V4_1                   ;SR2-II&IE-Toll
MD_F_ESR2_{YEAR}{ALT}=V10_1                 ;SR2-EE-Free
MD_T_ESR2_{YEAR}{ALT}=V14_1                 ;SR2-EE-Toll

MD_VL_SR3_{YEAR}{ALT}=V5_1+V6_1+V11_1+V15_1 ;SR3-Free&Toll-II&IE+EE 
MD_F_SR3_{YEAR}{ALT}=V5_1                   ;SR3-II&IE-Free
MD_T_SR3_{YEAR}{ALT}=V6_1                   ;SR3-II&IE-Toll
MD_F_ESR3_{YEAR}{ALT}=V11_1                 ;SR3-EE-Free
MD_T_ESR3_{YEAR}{ALT}=V15_1                 ;SR3-EE-Toll

MD_VL_Trk_{YEAR}{ALT}=V7_1+V8_1+V12_1       ;Truck-II&IE+EE+Port
MD_VL_PrtTk_{YEAR}{ALT}=V12_1               ;Port-Truck

MD_VL_EXT_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V13_1+V14_1+V15_1 ;EXT-TRK + EE-Free&Toll(DA+SR2+SR3) -Note:Does not include ext-ext of Port Truck

MD_CGSPEED_{YEAR}{ALT}=CSPD_1
MD_VMT_{YEAR}{ALT}=VDT_1
MD_VHT_{YEAR}{ALT}=VHT_1

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (MD_CGSPEED_{YEAR}{ALT}>0)
   MD_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/MD_CGSPEED_{YEAR}{ALT}
 else 
   MD_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(MD_CGSPEED_{YEAR}{ALT}+0.01)
   MD_FlgCGSPDZero=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
;if ('{Year}'='05')
;   if (Li.1.Count>0)
;      VOLCNTRTO= V_1/LI.1.COUNT
;     else
;      VOLCNTRTO=0.0
;   endif 
;endif


if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  MD_VCcapRTO_{YEAR}{ALT}=(V_1*LI.1.CONFACMDP)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  MD_VCcapRTO_{YEAR}{ALT}=9999.0
endif



ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\HTNET00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00C.PRN" MSG='PM Period - Rename Loaded Netw Attributes & Minor Calc'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\FINAL_ASGN_PM.NET"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_PM_Period.NET",
 EXCLUDE=TIME_1 VC_1, CSPD_1 VDT_1 VHT_1,
          V_1 V1_1 V2_1 V3_1 V4_1 V5_1 V6_1 V7_1 V8_1 V9_1 V10_1 V11_1 V12_1 V13_1 V14_1 V15_1,
          VT_1 V1T_1 V2T_1 V3T_1 V4T_1 V5T_1 V6T_1 V7T_1 V8T_1 V9T_1 V10T_1 V11T_1 V12T_1 V13T_1 V14T_1 V15T_1
         
PM_VL_TOT_{YEAR}{ALT}=V_1                   ;Total

PM_VL_DA_{YEAR}{ALT}=V1_1+V3_1+V9_1+V13_1   ;DA-Free&Toll-II&IE+EE 
PM_F_DA_{YEAR}{ALT}=V1_1                    ;DA-II&IE-Free
PM_T_DA_{YEAR}{ALT}=V3_1                    ;DA-II&IE-Toll
PM_F_EDA_{YEAR}{ALT}=V9_1                   ;DA-EE-Free
PM_T_EDA_{YEAR}{ALT}=V13_1                  ;DA-EE-Toll

PM_VL_SR2_{YEAR}{ALT}=V2_1+V4_1+V10_1+V14_1 ;SR2-Free&Toll-II&IE+EE 
PM_F_SR2_{YEAR}{ALT}=V2_1                   ;SR2-II&IE-Free
PM_T_SR2_{YEAR}{ALT}=V4_1                   ;SR2-II&IE-Toll
PM_F_ESR2_{YEAR}{ALT}=V10_1                 ;SR2-EE-Free
PM_T_ESR2_{YEAR}{ALT}=V14_1                 ;SR2-EE-Toll

PM_VL_SR3_{YEAR}{ALT}=V5_1+V6_1+V11_1+V15_1 ;SR3-Free&Toll-II&IE+EE 
PM_F_SR3_{YEAR}{ALT}=V5_1                   ;SR3-II&IE-Free
PM_T_SR3_{YEAR}{ALT}=V6_1                   ;SR3-II&IE-Toll
PM_F_ESR3_{YEAR}{ALT}=V11_1                 ;SR3-EE-Free
PM_T_ESR3_{YEAR}{ALT}=V15_1                 ;SR3-EE-Toll

PM_VL_Trk_{YEAR}{ALT}=V7_1+V8_1+V12_1       ;Truck-II&IE+EE+Port
PM_VL_PrtTk_{YEAR}{ALT}=V12_1               ;Port-Truck

PM_VL_EXT_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V13_1+V14_1+V15_1 ;EXT-TRK + EE-Free&Toll(DA+SR2+SR3) -Note:Does not include ext-ext of Port Truck

PM_CGSPEED_{YEAR}{ALT}=CSPD_1
PM_VMT_{YEAR}{ALT}=VDT_1
PM_VHT_{YEAR}{ALT}=VHT_1

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (PM_CGSPEED_{YEAR}{ALT}>0)
   PM_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/PM_CGSPEED_{YEAR}{ALT}
 else 
   PM_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(PM_CGSPEED_{YEAR}{ALT}+0.01)
   PM_FlgCGSPDZero=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
;if ('{Year}'='05')
;   if (Li.1.Count>0)
;      VOLCNTRTO= V_1/LI.1.COUNT
;     else
;      VOLCNTRTO=0.0
;   endif 
;endif


if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  PM_VCcapRTO_{YEAR}{ALT}=(V_1*LI.1.CONFACPMP)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  PM_VCcapRTO_{YEAR}{ALT}=9999.0
endif



ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\HTNET00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00D.PRN" MSG='Night Period - Rename Loaded Netw Attributes & Minor Calc'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\FINAL_ASGN_NT.NET"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_NT_Period.NET",
 EXCLUDE=TIME_1 VC_1, CSPD_1 VDT_1 VHT_1,
          V_1 V1_1 V2_1 V3_1 V4_1 V5_1 V6_1 V7_1 V8_1 V9_1 V10_1 V11_1 V12_1 V13_1 V14_1 V15_1,
          VT_1 V1T_1 V2T_1 V3T_1 V4T_1 V5T_1 V6T_1 V7T_1 V8T_1 V9T_1 V10T_1 V11T_1 V12T_1 V13T_1 V14T_1 V15T_1
         
NT_VL_TOT_{YEAR}{ALT}=V_1                   ;Total

NT_VL_DA_{YEAR}{ALT}=V1_1+V3_1+V9_1+V13_1   ;DA-Free&Toll-II&IE+EE 
NT_F_DA_{YEAR}{ALT}=V1_1                    ;DA-II&IE-Free
NT_T_DA_{YEAR}{ALT}=V3_1                    ;DA-II&IE-Toll
NT_F_EDA_{YEAR}{ALT}=V9_1                   ;DA-EE-Free
NT_T_EDA_{YEAR}{ALT}=V13_1                  ;DA-EE-Toll

NT_VL_SR2_{YEAR}{ALT}=V2_1+V4_1+V10_1+V14_1 ;SR2-Free&Toll-II&IE+EE 
NT_F_SR2_{YEAR}{ALT}=V2_1                   ;SR2-II&IE-Free
NT_T_SR2_{YEAR}{ALT}=V4_1                   ;SR2-II&IE-Toll
NT_F_ESR2_{YEAR}{ALT}=V10_1                 ;SR2-EE-Free
NT_T_ESR2_{YEAR}{ALT}=V14_1                 ;SR2-EE-Toll

NT_VL_SR3_{YEAR}{ALT}=V5_1+V6_1+V11_1+V15_1 ;SR3-Free&Toll-II&IE+EE 
NT_F_SR3_{YEAR}{ALT}=V5_1                   ;SR3-II&IE-Free
NT_T_SR3_{YEAR}{ALT}=V6_1                   ;SR3-II&IE-Toll
NT_F_ESR3_{YEAR}{ALT}=V11_1                 ;SR3-EE-Free
NT_T_ESR3_{YEAR}{ALT}=V15_1                 ;SR3-EE-Toll

NT_VL_Trk_{YEAR}{ALT}=V7_1+V8_1+V12_1       ;Truck-II&IE+EE+Port
NT_VL_PrtTk_{YEAR}{ALT}=V12_1               ;Port-Truck

NT_VL_EXT_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V13_1+V14_1+V15_1 ;EXT-TRK + EE-Free&Toll(DA+SR2+SR3) -Note:Does not include ext-ext of Port Truck

NT_CGSPEED_{YEAR}{ALT}=CSPD_1
NT_VMT_{YEAR}{ALT}=VDT_1
NT_VHT_{YEAR}{ALT}=VHT_1

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (NT_CGSPEED_{YEAR}{ALT}>0)
   NT_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/NT_CGSPEED_{YEAR}{ALT}
 else 
   NT_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(NT_CGSPEED_{YEAR}{ALT}+0.01)
   NT_FlgCGSPDZero=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
;if ('{Year}'='05')
;   if (Li.1.Count>0)
;      VOLCNTRTO= V_1/LI.1.COUNT
;     else
;      VOLCNTRTO=0.0
;   endif 
;endif


if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  NT_VCcapRTO_{YEAR}{ALT}=(V_1*LI.1.CONFACNTP)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  NT_VCcapRTO_{YEAR}{ALT}=9999.0
endif



ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\HTNET00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00E.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_CombinedPeriods.NET"
FILEI LINKI[4] = "{SCENARIO_DIR}\output\LOADED_NT_Period.NET"
FILEI LINKI[3] = "{SCENARIO_DIR}\output\LOADED_PM_Period.NET"
FILEI LINKI[2] = "{SCENARIO_DIR}\output\LOADED_MD_Period.NET"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\LOADED_AM_Period.NET"

PROCESS  PHASE=INPUT
;Use this phase to modify data as it is read, such as recoding node numbers.


ENDPROCESS


PROCESS  PHASE=NODEMERGE  
; Use this phase to make computations and selections of any data on the NODEI files.


ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


;Directional Attributes:
AL_VL_TOT_{YEAR}{ALT}  =LI.1.AM_VL_TOT_{YEAR}{ALT}  +LI.2.MD_VL_TOT_{YEAR}{ALT}  +LI.3.PM_VL_TOT_{YEAR}{ALT}  +LI.4.NT_VL_TOT_{YEAR}{ALT}

AL_VL_DA_{YEAR}{ALT}   =LI.1.AM_VL_DA_{YEAR}{ALT}   +LI.2.MD_VL_DA_{YEAR}{ALT}   +LI.3.PM_VL_DA_{YEAR}{ALT}   +LI.4.NT_VL_DA_{YEAR}{ALT}
AL_F_DA_{YEAR}{ALT}  =LI.1.AM_F_DA_{YEAR}{ALT}  +LI.2.MD_F_DA_{YEAR}{ALT}  +LI.3.PM_F_DA_{YEAR}{ALT}  +LI.4.NT_F_DA_{YEAR}{ALT}
AL_T_DA_{YEAR}{ALT}  =LI.1.AM_T_DA_{YEAR}{ALT}  +LI.2.MD_T_DA_{YEAR}{ALT}  +LI.3.PM_T_DA_{YEAR}{ALT}  +LI.4.NT_T_DA_{YEAR}{ALT}
AL_F_EDA_{YEAR}{ALT}  =LI.1.AM_F_EDA_{YEAR}{ALT}  +LI.2.MD_F_EDA_{YEAR}{ALT}  +LI.3.PM_F_EDA_{YEAR}{ALT}  +LI.4.NT_F_EDA_{YEAR}{ALT}
AL_T_EDA_{YEAR}{ALT}  =LI.1.AM_T_EDA_{YEAR}{ALT}  +LI.2.MD_T_EDA_{YEAR}{ALT}  +LI.3.PM_T_EDA_{YEAR}{ALT}  +LI.4.NT_T_EDA_{YEAR}{ALT}


AL_VL_SR2_{YEAR}{ALT}  =LI.1.AM_VL_SR2_{YEAR}{ALT}  +LI.2.MD_VL_SR2_{YEAR}{ALT}  +LI.3.PM_VL_SR2_{YEAR}{ALT}  +LI.4.NT_VL_SR2_{YEAR}{ALT}
AL_F_SR2_{YEAR}{ALT} =LI.1.AM_F_SR2_{YEAR}{ALT} +LI.2.MD_F_SR2_{YEAR}{ALT} +LI.3.PM_F_SR2_{YEAR}{ALT} +LI.4.NT_F_SR2_{YEAR}{ALT}
AL_T_SR2_{YEAR}{ALT} =LI.1.AM_T_SR2_{YEAR}{ALT} +LI.2.MD_T_SR2_{YEAR}{ALT} +LI.3.PM_T_SR2_{YEAR}{ALT} +LI.4.NT_T_SR2_{YEAR}{ALT}
AL_F_ESR2_{YEAR}{ALT}  =LI.1.AM_F_ESR2_{YEAR}{ALT}  +LI.2.MD_F_ESR2_{YEAR}{ALT}  +LI.3.PM_F_ESR2_{YEAR}{ALT}  +LI.4.NT_F_ESR2_{YEAR}{ALT}
AL_T_ESR2_{YEAR}{ALT}  =LI.1.AM_T_ESR2_{YEAR}{ALT}  +LI.2.MD_T_ESR2_{YEAR}{ALT}  +LI.3.PM_T_ESR2_{YEAR}{ALT}  +LI.4.NT_T_ESR2_{YEAR}{ALT}

AL_VL_SR3_{YEAR}{ALT}  =LI.1.AM_VL_SR3_{YEAR}{ALT}  +LI.2.MD_VL_SR3_{YEAR}{ALT}  +LI.3.PM_VL_SR3_{YEAR}{ALT}  +LI.4.NT_VL_SR3_{YEAR}{ALT}
AL_F_SR3_{YEAR}{ALT} =LI.1.AM_F_SR3_{YEAR}{ALT} +LI.2.MD_F_SR3_{YEAR}{ALT} +LI.3.PM_F_SR3_{YEAR}{ALT} +LI.4.NT_F_SR3_{YEAR}{ALT}
AL_T_SR3_{YEAR}{ALT} =LI.1.AM_T_SR3_{YEAR}{ALT} +LI.2.MD_T_SR3_{YEAR}{ALT} +LI.3.PM_T_SR3_{YEAR}{ALT} +LI.4.NT_T_SR3_{YEAR}{ALT}
AL_F_ESR3_{YEAR}{ALT}  =LI.1.AM_F_ESR3_{YEAR}{ALT}  +LI.2.MD_F_ESR3_{YEAR}{ALT}  +LI.3.PM_F_ESR3_{YEAR}{ALT}  +LI.4.NT_F_ESR3_{YEAR}{ALT}
AL_T_ESR3_{YEAR}{ALT}  =LI.1.AM_T_ESR3_{YEAR}{ALT}  +LI.2.MD_T_ESR3_{YEAR}{ALT}  +LI.3.PM_T_ESR3_{YEAR}{ALT}  +LI.4.NT_T_ESR3_{YEAR}{ALT}

AL_VL_Trk_{YEAR}{ALT}  =LI.1.AM_VL_Trk_{YEAR}{ALT}  +LI.2.MD_VL_Trk_{YEAR}{ALT}  +LI.3.PM_VL_Trk_{YEAR}{ALT}  +LI.4.NT_VL_Trk_{YEAR}{ALT}
AL_VL_PrtTk_{YEAR}{ALT}=LI.1.AM_VL_PrtTk_{YEAR}{ALT}+LI.2.MD_VL_PrtTk_{YEAR}{ALT}+LI.3.PM_VL_PrtTk_{YEAR}{ALT}+LI.4.NT_VL_PrtTk_{YEAR}{ALT}

AL_VL_EXT_{YEAR}{ALT}  =LI.1.AM_VL_EXT_{YEAR}{ALT}  +LI.2.MD_VL_EXT_{YEAR}{ALT}  +LI.3.PM_VL_EXT_{YEAR}{ALT}  +LI.4.NT_VL_EXT_{YEAR}{ALT}

AL_VMT_{YEAR}{ALT}   =LI.1.AM_VMT_{YEAR}{ALT}   +LI.2.MD_VMT_{YEAR}{ALT}   +LI.3.PM_VMT_{YEAR}{ALT}   +LI.4.NT_VMT_{YEAR}{ALT}
AL_VHT_{YEAR}{ALT}   =LI.1.AM_VHT_{YEAR}{ALT}   +LI.2.MD_VHT_{YEAR}{ALT}   +LI.3.PM_VHT_{YEAR}{ALT}   +LI.4.NT_VHT_{YEAR}{ALT}

;Calulate All day Congested time and Speed based on summation of period VMT & VHT (SKS-10/12/2006):

if (AL_VMT_{YEAR}{ALT}>0)
  AL_CGTIME_{YEAR}{ALT}=60*(AL_VHT_{YEAR}{ALT}*LI.1.DISTANCEFT/5280)/AL_VMT_{YEAR}{ALT}           ;in minutes
 else
 
;   _FracAMVMT=LI.1.AM_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;   _FracMDVMT=LI.2.MD_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;   _FracPMVMT=LI.3.PM_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;   _FracNTVMT=LI.4.NT_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;  AL_CGTIME_{YEAR}{ALT}=((LI.1.AM_CGTIME_{YEAR}{ALT}*_FracAMVMT) + (LI.2.MD_CGTIME_{YEAR}{ALT}*_FracMDVMT)+
;                         (LI.3.PM_CGTIME_{YEAR}{ALT}*_FracPMVMT) + (LI.4.NT_CGTIME_{YEAR}{ALT}*_FracNTVMT))
  AL_CGTIME_{YEAR}{ALT}=((LI.1.AM_CGTIME_{YEAR}{ALT}*0.17) + (LI.2.MD_CGTIME_{YEAR}{ALT}*0.31)+
                         (LI.3.PM_CGTIME_{YEAR}{ALT}*0.25) + (LI.4.NT_CGTIME_{YEAR}{ALT}*0.27))+0.0001


endif

AL_CGSPEED_{YEAR}{ALT}=((LI.1.DISTANCEFT/5280)/AL_CGTIME_{YEAR}{ALT})*60


;sks -8/22/08 - For link with year 2005 traffic counts.
if ('{Year}'='05')
   if (Li.1.Count>0)
      AL_VOLCNTRTO= AL_VL_TOT_{YEAR}{ALT}/LI.1.COUNT
     else
      AL_VOLCNTRTO=0.0
   endif 
endif

;An Estimated All Day Volume/Capacity Ratio...
if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  AL_VCcapRTO_{YEAR}{ALT}=(AL_VL_TOT_{YEAR}{ALT}*LI.1.CONFAC)/(LI.1.CAPACITY*LI.1.NUM_LANES)  ;(An Esimated) Directional Volume/Capacity Ratio
                                                                                              ;CONFAC represnts 24-Hour Condition
 else
  AL_VCcapRTO_{YEAR}{ALT}=9999.0
endif


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS

ENDRUN


