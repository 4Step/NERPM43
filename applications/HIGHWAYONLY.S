; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\HOMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\HOMAT00A.PRN" MSG='Separate trips by purpose and auto ownership'
FILEI MATI[2] = "{SCENARIO_DIR}\output\VTRIP1.MAT"
FILEO MATO[1] = "C:\NERPM50\APPLICATIONS\HOMAT00A.MAT",
MO=1-15, NAME=AUTO1HBW,AUTO1HBNW,AUTO1NHB,AUTO1SOVIE,AUTO2HBW,AUTO2HBNW,AUTO2NHB,AUTO3HBW,AUTO3HBO,AUTO3NHB,EESO,IEHO,EEHO,IIIETK,EETK, DEC=15*S

zonemsg=100

MW[1]=MI.1.1
MW[2]=MI.1.5
MW[3]=MI.1.9
MW[4]=MI.2.4
MW[5]=MI.1.2
MW[6]=MI.1.6
MW[7]=MI.1.10
MW[8]=MI.1.3
MW[9]=MI.1.7
MW[10]=MI.1.11
MW[11]=MI.3.1
MW[12]=MI.2.5
MW[13]=MI.3.2
MW[14]=MI.2.1+MI.2.2+MI.2.3+MI.2.6+MI.2.7
MW[15]=MI.3.3+MI.3.4

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\HOMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\HOMAT00B.PRN" MSG='Apply Auto Occupancy Rate'
FILEI MATI[2] = "{SCENARIO_DIR}\output\PORT_TRK_24H_{Year}.MAT"
FILEI MATI[1] = "C:\NERPM50\APPLICATIONS\HOMAT00A.MAT"
FILEO MATO[1] = "C:\NERPM50\APPLICATIONS\HOMAT00B.MAT",
 MO=1-8,NAME=SOV,CARPOOL,IEEITRK,EETRUCKS,EESOV,EEHOV,PortTrk,24_Tot, DEC=8*d

PAR ZONEMSG=100

pahbwpkfac = 1;0.45299*10   ; 2000 HH survey
pahbnwpkfac= 1;0.25757*10   ; 2000 HH survey
panhbpkfac = 1;0.036640*10  ; 2000 HH survey
aphbwpkfac = 1;0.02367 *10  ; 2000 HH survey
aphbnwpkfac= 1;0.03536 *10  ; 2000 HH survey
apnhbpkfac = 1;0.036640*10  ; 2000 HH survey
iepkfac    = 1;0.1537  *10  ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
eepkfac    = 1;0.136   *10 ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
trkpkfac   = 1;0.20    *10 ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS



;SOV & SOVIE
MW[01]=(pahbwpkfac * MI.1.1 + aphbwpkfac * MI.1.1.T) * 0.5 +
       (pahbnwpkfac * MI.1.2 + aphbnwpkfac * MI.1.2.T) * 0.5 +
       (panhbpkfac * MI.1.3 + apnhbpkfac * MI.1.3.T) * 0.5 +
       (iepkfac * MI.1.4 + iepkfac * MI.1.4.T) * 0.5
;CARPOOL
MW[02]=(pahbwpkfac * MI.1.5 + aphbwpkfac * MI.1.5.T) * 0.5 /2 +
       (pahbnwpkfac * MI.1.6 + aphbnwpkfac * MI.1.6.T) * 0.5 /2 +
       (panhbpkfac * MI.1.7 + apnhbpkfac * MI.1.7.T) * 0.5 /2 +
       (pahbwpkfac * MI.1.8 + aphbwpkfac * MI.1.8.T) * 0.5 /{OC3VHBW} +
       (pahbnwpkfac * MI.1.9 + aphbnwpkfac * MI.1.9.T) * 0.5 /{OC3VHBNW} +
       (panhbpkfac * MI.1.10 + apnhbpkfac * MI.1.10.T) * 0.5 /{OC3VNHB} +
       (iepkfac * MI.1.12 + iepkfac * MI.1.12.T) * 0.5
;IE/EE TRUCK
MW[03]=(trkpkfac * MI.1.14 + trkpkfac * MI.1.14.T) * 0.5

;EETRUCKS
MW[04]=(trkpkfac * MI.1.15 + trkpkfac * MI.1.15.T) * 0.5
;EESOV
MW[05]=(eepkfac * MI.1.11 + eepkfac * MI.1.11.T) * 0.5
;EEHOV
MW[06]=(eepkfac * MI.1.13 + eepkfac * MI.1.13.T) * 0.5

;Jax Port Trucks
MW[07]=MI.2.1

;Total Trips
MW[8]=MW[1]+MW[2]+MW[3]+MW[4]+MW[5]+MW[6]+MW[7]


ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\HOMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\HOMAT00D.PRN" MSG='Highway Only Trip Table-Factoring and Adjustment'
FILEI MATI[4] = "{CATALOG_DIR}\\parameters\ORG_ALLVehicle_{alt}{year}.mat"
FILEI MATI[2] = "{CATALOG_DIR}\\parameters\HWYFACTOR_{alt}{year}.mat"
FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYONLYTTAB_{alt}{year}.mat",
MO=51-58 Name=SOVIEII,HOVIEII,TRKIEII,TRKEE,SOVEE,HOVEE,PortTrk, Total, dec=8*d
FILEI MATI[3] = "{CATALOG_DIR}\\parameters\HWYTTAB_{alt}{year}.mat"
FILEI MATI[1] = "C:\NERPM50\APPLICATIONS\HOMAT00B.MAT"


jloop
if (Mi.1.1=0); check if highway trip table is 0
  if (Mi.4.1=0); check if the original value is 0 to allow removing development
  MW[51]=mi.3.1; copy a value after mode choice step of highway trips to the highway only trip table
  else
  MW[51]=0; make it sensitive to have no trip scenario
  endif
else
  If (mi.2.1=0&mi.1.1>mi.4.1); if highway factor is 0 & new highway only trips are more than the  original
  MW[51]=mi.1.1*1; preserve the new demand 
  else
  MW[51]=mi.1.1*mi.2.1/10000 ; adjustment for transit trip
  endif
endif

if (Mi.1.2=0)
  if (Mi.4.2=0)
  MW[52]=mi.3.2
  else
  MW[52]=0
  endif
else
  If (mi.2.2=0&mi.1.2>mi.4.2)
  MW[52]=mi.1.2*1
  else
  MW[52]=mi.1.2*mi.2.2/10000
  endif
endif


if (mi.1.3=0)
  if (Mi.4.3=0)
  MW[53]=mi.3.3
  else
  MW[53]=0
  endif
else
  If (mi.2.3=0&mi.1.3>mi.4.3)
  MW[53]=mi.1.3*1
  else
  mw[53]=mi.1.3*mi.2.3/10000
  endif
endif

if (mi.1.4=0)
  if (Mi.4.4=0)
  MW[54]=mi.3.4
  else
  MW[54]=0
  endif
else 
  If (mi.2.4=0&mi.1.4>mi.4.4)
  MW[54]=mi.1.4*1
  else
  mw[54]=mi.1.4*mi.2.4/10000
  endif
endif

if (mi.1.5=0)
  if (Mi.4.5=0)
  MW[55]=mi.3.5
  else
  MW[55]=0
  endif
else
  If (mi.2.5=0&mi.1.5>mi.4.5)
  MW[55]=mi.1.5*1
  else
  mw[55]=mi.1.5*mi.2.5/10000
  endif
endif

if (mi.1.6=0)
  if (Mi.4.6=0)
  MW[56]=mi.3.6
  else
  MW[56]=0
  endif
else
   If (mi.2.6=0&mi.1.6>mi.4.6)
   MW[56]=mi.1.6*1
   else
   mw[56]=mi.1.6*mi.2.6/10000
   endif
endif


if (mi.1.7=0)
  if (Mi.4.7=0)
  MW[57]=mi.3.7
  else
  MW[57]=0
  endif
else
   If (mi.2.7=0&mi.1.7>mi.4.7)
   MW[57]=mi.1.7*1
   else
   mw[57]=mi.1.7*mi.2.7/10000
   endif
endif

MW[58]=mw[51]+mw[52]+mw[53]+mw[54]+mw[55]+mw[56]+mw[57]

endjloop
ENDRUN


; Script for program HIGHWAY in file "C:\NERPM50\APPLICATIONS\HOHWY00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\HOHWY00A.PRN" MSG='Highway Only Assignment'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO PATHO[1] = "{SCENARIO_DIR}\output\HIGHWAYPATH{ALT}{YEAR}.PTH"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HWYONLYTTAB_{alt}{year}.mat"
FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEO TURNVOLO[1] = "C:\NERPM50\APPLICATIONS\HOHWY00A.TRN"
FILEO PRINTO[1] = "C:\NERPM50\APPLICATIONS\HOHWY00B.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\HWYLOADED{alt}{year}.NET"


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


; Script for program NETWORK in file "C:\NERPM50\APPLICATIONS\HONET00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM50\APPLICATIONS\HONET00C.PRN" MSG='Rename Variables and Minor Calculations'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\HWYLOADED{alt}{year}.NET"
FILEO NETO = "{SCENARIO_DIR}\Output\HWYLOADED.NET",
EXCLUDE=    V_1    TIME_1,     VC_1,
    CSPD_1    VDT_1    VHT_1    V1_1    V2_1    V3_1    V4_1    V5_1    V6_1     V7_1,
    VT_1    V1T_1    V2T_1    V3T_1    V4T_1    V5T_1    V6T_1    V7T_1, 
    V8_1    V9_1    V10_1    V11_1    V12_1    V13_1    V14_1,
    V8T_1    V9T_1    V10T_1    V11T_1    V12T_1    V13T_1    V14T_1 

VOLTOT_HO_{YEAR}{ALT}=V_1                      ;Total
VOLSOV_HO_{YEAR}{ALT}=V1_1+V5_1                ;DA-II&IE+EE 
VOLHOV_HO_{YEAR}{ALT}=V2_1+V6_1                ;SR-II&IE+EE
VOLTRK_HO_{YEAR}{ALT}=V3_1+V4_1+V7_1           ;Truck-II&IE+EE+Port
VOLPTRK_HO_{YEAR}{ALT}=V7_1                    ;Port-Truck
VOLEXT_HO_{YEAR}{ALT}=V4_1+V5_1+V6_1           ;EXT-TRK+DA+SR (Does not include ext-ext of Port Truck) 


SEL_VTOT_HO_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V12_1+V13_1+V14_1   ;Selected Total
SEL_VSOV_HO_{YEAR}{ALT}=V8_1+V12_1                                ;Selected DA-II&IE+EE
SEL_VHOV_HO_{YEAR}{ALT}=V9_1+V13_1                                ;Selected SR-II&IE+EE
SEL_VTRK_HO_{YEAR}{ALT}=V10_1+V11_1+V14_1                         ;Selected Truck-II&IE+EE+Port
SEL_VOLPTRK_HO_{YEAR}{ALT}=V14_1                                  ;Selected Port-Truck
SEL_VOLEXT_HO_{YEAR}{ALT}=V11_1+V12_1+V13_1                       ;EXT-TRK+DA+SR (Does not include ext-ext of Port Truck) 

CGSPEED_HO_{YEAR}{ALT}=CSPD_1
VMT_HO_{YEAR}{ALT}=VDT_1
VHT_HO_{YEAR}{ALT}=VHT_1

;CGTIME{YEAR}{ALT}=60*DISTANCE/CGSPEED{YEAR}{ALT}

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (CGSPEED_HO_{YEAR}{ALT}>0)
   CGTIME_HO_{YEAR}{ALT}=60*(DISTANCEFT/5280)/CGSPEED_HO_{YEAR}{ALT}
 else 
   CGTIME_HO_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(CGSPEED_HO_{YEAR}{ALT}+0.01)
   FlgCGSPDZero_HO=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
if ('{Year}'='05')
   if (Li.1.Count>0)
      VOLCNTRTO_HO= V_1/LI.1.COUNT
     else
      VOLCNTRTO_HO=0.0
   endif 
endif

if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  VOLCAPRTO_HO=(V_1*LI.1.CONFAC)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  VOLCAPRTO_HO=9999.0
endif



ENDRUN


; Script for program NETWORK in file "C:\NERPM50\applications\HHNET00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\OUTPUT\ANNET00B.PRN" MSG='Remove Transit -Only links from loaded network hor Highway Evaluation'
FILEI LINKI[1] = "{SCENARIO_DIR}\Output\HWYLOADED.NET"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_HO_HEVAL.NET"

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

 
;Delete transit-Only non-highway links from loaded network
  IF(LI.1.Facility_Type=49,59,69) DELETE 

    

ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY


ENDPHASE



ENDRUN


; Script for program NETWORK in file "C:\NERPM50\applications\HHNET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\XTABSmryFinal_HO.PRN" MSG='Prepare for HEVAL for All Area'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\LOADED_HO_HEVAL.NET"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\HO_PROFILE_NERPM4.TXT"
FILEO LINKO = "{SCENARIO_DIR}\output\HO_LinksCnt0.DBF",
   FORMAT=DBF,include=A,B,DISTANCE,ONE,ATYPE2,FTYPE2,
      LANES,TIME,DAILYCAP,COUNT,SCRN,ZONE,USECODE,LOCATION,
      LANDUSE,CCODE,CGTIME,TOTAL_VOL,TOLL,TWOWAY
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\RMSE_HO.PRN"

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

;if(LI.1.COUNTY<>6) delete       ;comment out for county specific evaluation & set county no (1=Nassau, 2=Duval,3=St Johns,
                                 ;                                                            4=Clay, 5=Baker, 6=Putnam)
;if(LI.1.FACILITY_TYPE=70-79,97-98) delete       ;comment out for RMSE without ramps                                                            4=Clay, 5=Baker, 6=Putnam)

;Delete dummy zone facility types (#29) since it will distort heval and/or crosstab stat with a speed of 1 MPH;
;NOTE: Without this, the "analysis" mode HEVAL output will be skewed, since it did not recognize the filtered facility
;      type of 29.
;Note: only valid 29 is mayport bridge link (64273-64589 of DISTANCEFT=2010)
  IF(LI.1.Facility_Type=29) DELETE 


; DUMMY VARIABLES FOR HEVALDBF
ZONE        =1
USECODE     =1
LANDUSE     =1
CCODE       =1
DIRCODE     =1
;
   LOCATION=LI.1.COUNTY
   CGTIME=LI.1.CGTIME_HO_{Year}{alt}
   TOTAL_VOL=LI.1.VOLTOT_HO_{Year}{alt}
   ft=LI.1.FACILITY_TYPE
   FACILITY=LI.1.FACILITY_TYPE
   at=LI.1.AREA_TYPE
   LNS=LI.1.NUM_LANES
   ftg=INT(LI.1.FACILITY_TYPE/10)
   atg=INT(LI.1.AREA_TYPE/10)
   sl=LI.1.SCREENLINE


;sks-Fill crosstab variables
   if (!(ft=50-59))
     _caplnmiles=li.1.CAPACITY*li.1.DISTANCE*LI.1.NUM_LANES
     _orgtimehr=li.1.time/60
     _cgtimehr=cgtime/60
     _distmile=li.1.distance
     _lanemiles=lns*distance
     _orgspd=_distmile/_orgtimehr
     _links=1

    else
     _caplnmiles=0.0
     _orgtimehr=0.0
     _cgtimehr=0.0
     _distmile=0.0
     _lanemiles=0.0
     _orgspd=0.0
     _links=1
   endif 



;
;   ANODE=li.1.A
;   BNODE=li.1.B
   ONE=DIRCODE
   ATYPE2=at
   FTYPE2=ft
   LANES=LNS
;   USE=USECODE
;   CONSTRUCT=CCODE
;   CONG_TIME=CGTIME
;   MODELVOL=TOTAL_VOL
;   COST=li.1.TOLL
   TWOWAY=li.1.TWOWAY_{Year}{alt}
   DAILYCAP=li.1.CAPACITY*LNS/CONFAC
   SCRN=sl
   cnty=LI.1.COUNTY

; *SKS-6/28/2008****************************
if ('{ANALYSIS}' = 'YES')
   count=0            ;Important: this will turn-off RMSE, VOL/CONT by FT and AT
                      ;           for "analysis"="YES" mode 
  else
   count=COUNT
endif

;   count   = COUNT    ;selected real counts, not repeated
/*
  if (DIR==1 & FTYPE1<>1); Both sides of freeways get the entire volume in the database
     PSAWDT00=AADT002W/MOCF
  else
     PSAWDT00= 0.5 * AADT002W/MOCF
  endif
*/
   _aK     = COUNT ;All COUNTS
;
; *****************************
;
; initialize arrays and variables
   ARRAY _err=13, _cns=13, _cnt=13, _RGP=13, _vols=13, _volbyft=100, _cntbyft=100
   ARRAY _volbyat=100, _cntbyat=100, _lnkbyft=100, _lnkbyat=100
   ARRAY _volbyftg=100, _volbyatg=100, _cntbyftg=100, _cntbyatg=100
   ARRAY _lnkbyftg=100, _lnkbyatg=100
   ARRAY _volbyLNS=100, _cntbyLNS=100, _lnkbyLNS=100
   ARRAY _volbysl=100, _cntbysl=100, _lnkbysl=100
   ARRAY _volbycnty=100, _cntbycnty=100, _lnkbycnty=100

   _group=(0.0*FACILITY_TYPE)
   _RGP[1]=1, _RGP[2]=5000, _RGP[3]=10000, _RGP[4]=20000, _RGP[5]=30000, _RGP[6]=40000, _RGP[7]=50000,
   _RGP[8]=60000, _RGP[9]=70000, _RGP[10]=80000, _RGP[11]=90000, _RGP[12]=100000, _RGP[13]=500000
   IF (A=1)
     LOOP _iter=1,13
           _err[_iter]=0,_cnt[_iter]=0,_cns[_iter]=0,_vols[_iter]=0
     ENDLOOP
     LOOP _iter=1,99
           _volbyft[_iter]=0, _cntbyft[_iter]=0, _lnkbyft[_iter]=0
           _volbyat[_iter]=0, _cntbyat[_iter]=0, _lnkbyat[_iter]=0
           _volbyftg[_iter]=0, _cntbyftg[_iter]=0, _lnkbyftg[_iter]=0
           _volbyatg[_iter]=0, _cntbyatg[_iter]=0, _lnkbyatg[_iter]=0
           _volbyLNS[_iter]=0, _cntbyLNS[_iter]=0, _lnkbyLNS[_iter]=0
           _volbysl[_iter]=0, _cntbysl[_iter]=0, _lnkbysl[_iter]=0
           _volbycnty[_iter]=0, _cntbycnty[_iter]=0, _lnkbycnty[_iter]=0
     ENDLOOP
   ENDIF
;   FNAME='ROADNAME'
; establish some English sounding variables for the output network
 ;  links=1
 ;  lanemiles=lns*distance
; calculate and compartmentalize
   IF (_aK>0) VOLCNT=TOTAL_VOL/_aK, _TVOL=TOTAL_VOL, NETDIFF=TOTAL_VOL-_aK, ABSDIFF=ABS(NETDIFF), ERRORSQ=NETDIFF^2, PCTDIFF=100*NETDIFF/_aK _group=1
 
;   IF(_aK>0) VOLCNT=TOTAL_VOL/_aK, NETDIFF=TOTAL_VOL-_aK, ABSDIFF=ABS(NETDIFF), ERRORSQ=NETDIFF^2, PCTDIFF=100*NETDIFF/_aK _group=1, _TVOL=TOTAL_VOL
   IF (_aK>5000) _group=2
   IF (_aK>10000) _group=3
   IF (_aK>20000) _group=4
   IF (_aK>30000) _group=5
   IF (_aK>40000) _group=6
   IF (_aK>50000) _group=7
   IF (_aK>60000) _group=8
   IF (_aK>70000) _group=9
   IF (_aK>80000) _group=10
   IF (_aK>90000) _group=11
   IF (_aK>100000) _group=12
   IF (_aK>0) 
   _ERR[_group]=ERRORSQ+_ERR[_group], _CNS[_group]=_aK+_CNS[_group], _CNT[_group]=_CNT[_group]+1, _VOLS[_group]=_TVOL+_VOLS[_group]
   _ERR[13]=ERRORSQ+_ERR[13], _CNS[13]=_aK+_CNS[13], _CNT[13]=_CNT[13]+1, _VOLS[13]=_TVOL+_VOLS[13]
   ENDIF

IF (_aK>0)  
   _volbyft[ft]=_volbyft[ft]+TOTAL_VOL
   _cntbyft[ft]=_cntbyft[ft]+_aK
   _lnkbyft[ft]=_lnkbyft[ft]+1
   _volbyat[at]=_volbyat[at]+TOTAL_VOL
   _cntbyat[at]=_cntbyat[at]+_aK
   _lnkbyat[at]=_lnkbyat[at]+1
   _volbyft[100]=_volbyft[100]+TOTAL_VOL
   _cntbyft[100]=_cntbyft[100]+_aK
   _lnkbyft[100]=_lnkbyft[100]+1
   _volbyat[100]=_volbyat[100]+TOTAL_VOL
   _cntbyat[100]=_cntbyat[100]+_aK

   _lnkbyat[100]=_lnkbyat[100]+1
   _volbyftg[ftg]=_volbyftg[ftg]+TOTAL_VOL
   _cntbyftg[ftg]=_cntbyftg[ftg]+_aK
   _lnkbyftg[ftg]=_lnkbyftg[ftg]+1
   _volbyatg[atg]=_volbyatg[atg]+TOTAL_VOL
   _cntbyatg[atg]=_cntbyatg[atg]+_aK
   _lnkbyatg[atg]=_lnkbyatg[atg]+1
   _volbyftg[100]=_volbyftg[100]+TOTAL_VOL
   _cntbyftg[100]=_cntbyftg[100]+_aK
   _lnkbyftg[100]=_lnkbyftg[100]+1
   _volbyatg[100]=_volbyatg[100]+TOTAL_VOL
   _cntbyatg[100]=_cntbyatg[100]+_aK
   _lnkbyatg[100]=_lnkbyatg[100]+1
   _volbyLNS[LNS]=_volbyLNS[LNS]+TOTAL_VOL
   _cntbyLNS[LNS]=_cntbyLNS[LNS]+_aK
   _lnkbyLNS[LNS]=_lnkbyLNS[LNS]+1
   _volbysl[sl]=_volbysl[sl]+TOTAL_VOL
   _cntbysl[sl]=_cntbysl[sl]+_aK
   _lnkbysl[sl]=_lnkbysl[sl]+1
   _volbyLNS[100]=_volbyLNS[100]+TOTAL_VOL
   _cntbyLNS[100]=_cntbyLNS[100]+_aK
   _lnkbyLNS[100]=_lnkbyLNS[100]+1
   _volbysl[100]=_volbysl[100]+TOTAL_VOL
   _cntbysl[100]=_cntbysl[100]+_aK
   _lnkbysl[100]=_lnkbysl[100]+1
   _volbycnty[cnty]=_volbycnty[cnty]+TOTAL_VOL
   _cntbycnty[cnty]=_cntbycnty[cnty]+_aK
   _lnkbycnty[cnty]=_lnkbycnty[cnty]+1
   _volbycnty[100]=_volbycnty[100]+TOTAL_VOL
   _cntbycnty[100]=_cntbycnty[100]+_aK
   _lnkbycnty[100]=_lnkbycnty[100]+1

endif
CROSSTAB  VAR= _LINKS _LANEMILES, form=12.0c,
    row=FT, range=10-99-10,
    col=LNS, range=1-5-1,6-9
IF (_aK>0)
CROSSTAB  VAR= TOTAL_VOL,_aK, form=12.0c,
    row=FT, range=10-99-10,
    col=AT, range=10-59-10
ENDIF
CROSSTAB  VAR= _LINKS _LANEMILES, form=12.0c,
    row=FTG, range=1-9-1,
    col=LNS, range=1-5-1,6-9
IF (_aK>0)
CROSSTAB  VAR= TOTAL_VOL,_aK, form=12.0c,
    row=FTG, range=1-9-1,
    col=ATG, range=1-5-1
ENDIF

;sks - for computing capacity of the network by FTG and ATG
CROSSTAB  VAR= _LANEMILES, form=14.2c, VAR= _CAPLNMILES, form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_CAPLNMILES/_LANEMILES, form=14.2


;CROSSTAB  VAR= _CAPLNMILES, form=14.2c,
;    row=FTG, range=1-9-1,1-9,
;    col=ATG, range=1-5-1,1-5


;sks - for computing original Speed the network by FTG and ATG
CROSSTAB  VAR=_distmile form=14.2c, VAR=_orgtimehr form=14.2c, VAR=_orgspd form=14.2c,VAR=_links form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_distmile/_orgtimehr, form=14.2,
    comp=_orgspd/_links, form=14.2

;CROSSTAB  VAR= orgtimehr, form=14.2c,
;    row=FTG, range=1-9-1,1-9,
;    col=ATG, range=1-5-1,1-5


;sks - for computing Congested Speed the network by FTG and ATG
CROSSTAB  VAR=_distmile form=14.2c, VAR=_cgtimehr form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_distmile/_cgtimehr, form=14.2
    

;if (count=0) delete

ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY
; a little loop to write out the Percent Root Mean Square Error
LOOP _iter=1,12 

;  set allowable limit ranges
   if (_iter=1) _limit='45 - 55'
   if (_iter=2) _limit='35 - 45'
   if (_iter=3) _limit='27 - 35'
   if (_iter=4) _limit='24 - 27'
   if (_iter=5) _limit='22 - 24'
   if (_iter=6) _limit='20 - 22'
   if (_iter=7) _limit='18 - 20'
   if (_iter=8) _limit='17 - 18'
   if (_iter=9) _limit='16 - 17'
   if (_iter=10) _limit='15 - 16'
   if (_iter=11) _limit='14 - 15'
   if (_iter=12) _limit='LT 14  '
 
  if (_iter=1) print list="*********************************** ROOT MEAN SQUARE ERROR SUMMARY BY VOLUME GROUP ***********************************", printo=1
  if (_cnt[_iter]>0) print,        
 list="%RMSE Vol Grp ",_iter(2.0c)," ",_RGP[_iter](7.0c),"-",_RGP[_iter+1](7.0c),": ",sqrt(_err[_iter]/(_cnt[_iter]-1))/(_cns[_iter]/_cnt[_iter])*100(7.3),"%",
 " Allow_RMSE = ", _limit,"%",
 " VOL=",_vols[_iter](11.0c),
 " CNT=",_cns[_iter](11.0c),
 " VOL/CNT=",(_vols[_iter]/_cns[_iter])(5.2c),
 " N=",_cnt[_iter](5.0CL), PRINTO=1
ENDLOOP
_iter=13

;  set allowable limit ranges
 if (_iter=13) _limit='32 - 39'

 list="%RMSE Vol Grp ",_iter(2.0c)," ",_RGP[1](7.0c),"-",_RGP[_iter](7.0c),": ",sqrt(_err[_iter]/(_cnt[_iter]-1))/(_cns[_iter]/_cnt[_iter])*100(7.3),"%",
 " Allow_RMSE = ", _limit,"%",
 " VOL=",_vols[_iter](11.0c),
 " CNT=",_cns[_iter](11.0c),
 " VOL/CNT=",(_vols[_iter]/_cns[_iter])(5.2c),
 " N=",_cnt[_iter](5.0CL), PRINTO=1

; one for Vol/Cnt by FT 
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ********************** VOLUME AND COUNT SUMMARY BY FACILITY TYPE **********************", PRINTO=1
if (_cntbyft[_iter]>0) print,
 list="Facility Type Summary for FT=",_iter(3.0c),
 " VOL=",_volbyft[_iter](11.0c),
 " CNT=",_cntbyft[_iter](11.0c),
 " VOL/CNT=",(_volbyft[_iter]/_cntbyft[_iter])(5.2c),
 "   N=",_lnkbyft[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by AT
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY AREA TYPE ************************", PRINTO=1
if (_cntbyat[_iter]>0) print,
 list="    Area Type Summary for AT=",_iter(3.0c),
 " VOL=",_volbyat[_iter](11.0c),

 " CNT=",_cntbyat[_iter](11.0c),
 " VOL/CNT=",(_volbyat[_iter]/_cntbyat[_iter])(5.2c),
 "   N=",_lnkbyat[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by FTG 
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ********************** VOLUME AND COUNT SUMMARY BY FACILITY TYPE GROUP*****************", PRINTO=1
if (_cntbyftg[_iter]>0) print,
 list="Facility Type Summary for FTG=",_iter(3.0c),
 " VOL=",_volbyftg[_iter](11.0c),
 " CNT=",_cntbyftg[_iter](11.0c),
 " VOL/CNT=",(_volbyftg[_iter]/_cntbyftg[_iter])(5.2c),
 "   N=",_lnkbyftg[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by ATG
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY AREA TYPE GROUP*******************", PRINTO=1
if (_cntbyatg[_iter]>0) print,
 list="    Area Type Summary for ATG=",_iter(3.0c),
 " VOL=",_volbyatg[_iter](11.0c),

 " CNT=",_cntbyatg[_iter](11.0c),
 " VOL/CNT=",(_volbyatg[_iter]/_cntbyatg[_iter])(5.2c),
 "   N=",_lnkbyatg[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by LNS 
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ********************** VOLUME AND COUNT SUMMARY BY LANES PER DIRECTION*****************", PRINTO=1
if (_cntbyLNS[_iter]>0) print,
 list="Facility Type Summary for LNS=",_iter(3.0c),
 " VOL=",_volbyLNS[_iter](11.0c),
 " CNT=",_cntbyLNS[_iter](11.0c),
 " VOL/CNT=",(_volbyLNS[_iter]/_cntbyLNS[_iter])(5.2c),
 "   N=",_lnkbyLNS[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by SL
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ******************** VOLUME AND COUNT SUMMARY BY SCREENLINE & CUTLINE *******************", PRINTO=1
if (_cntbysl[_iter]>0) print,
 list="    ScrCut Line Summary for SL=",_iter(3.0c),
 " VOL=",_volbysl[_iter](11.0c),
 " CNT=",_cntbysl[_iter](11.0c),
 " VOL/CNT=",(_volbysl[_iter]/_cntbysl[_iter])(5.2c),
 "   N=",_lnkbysl[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by County
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY COUNTY *****************************", PRINTO=1
if (_cntbycnty[_iter]>0) print,
 list="    County-wide Smry for Cnty = ",_iter(3.0c),
 " VOL=",_volbycnty[_iter](11.0c),
 " CNT=",_cntbycnty[_iter](11.0c),
 " VOL/CNT=",(_volbycnty[_iter]/_cntbycnty[_iter])(5.2c),
 "   N=",_lnkbycnty[_iter](5.0c), PRINTO=1
ENDLOOP

;----SKS (7/28/2008)---Write Profile for HEVAL-NERPM3-All Counties data
;GTITLE=' - ALL SIX COUNTIES'

if ('{VALIDATE}' = 'YES')           ;Validate Mode
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\nNO",
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\n",'{VALIDATE}',
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}',                                                                      ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nYES",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nYES",
           PRINTO=2
endif

if ('{ANALYSIS}' = 'YES')           ;Analysis Mode
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\n",'{ANALYSIS}',
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\nNO",
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}',                                                                       ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nYES",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nYES",
           PRINTO=2
endif


ENDPHASE



ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*REM -- Copy required Input files of HEVAL/RMSE routines to Cube Folder...
*copy /a {SCENARIO_DIR}\output\HO_PROFILE_NERPM4.TXT PROFILE.MAS
*copy /a {CATALOG_DIR}\parameters\HESCREEN.SYN HESCREEN.SYN
*copy /a {CATALOG_DIR}\parameters\HELABELS.SYN HELABELS.SYN
*copy /a {CATALOG_DIR}\parameters\HERATES.SYN HERATES.SYN
*copy /a {CATALOG_DIR}\parameters\DATABASE.CTL DATABASE.CTL
*copy /b "{SCENARIO_DIR}\output\HO_LinksCnt0.DBF" LnksCnt.DBF

*REM -- Clean the Cube Folder of HEVAL/RMSE outputs from any previous run (if any)...
*if exist HEVAL.OUT del HEVAL.OUT
*if exist RMSE.OUT del RMSE.OUT
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC.ASC del HRLDXY2.ASC

*REM -- Run HEVAL/RMSE Routines...
*{CATALOG_DIR}\User.prg\hevaldbf.exe >{SCENARIO_DIR}\output\hevaldbf.LOG
if ('{ANALYSIS}'='YES') GOTO HOSKPN4
*{CATALOG_DIR}\User.prg\rmsedbf.exe >{SCENARIO_DIR}\output\rmsedbf.LOG
:HOSKPN4

*REM -- Save HEVAL/RMSE outputs from Cube folder to user's output folder...
*if exist HEVAL.OUT copy /a heval.out {SCENARIO_DIR}\output\heval_HO-NERPM4.out
*if exist RMSE.OUT copy /a rmse.out {SCENARIO_DIR}\output\rmse_HO-NERPM4.out
*if exist SCRNLINE.ASC copy /a SCRNLINE.ASC {SCENARIO_DIR}\output\SCRNLINE_HO-NERPM4.out

*REM -- Delete HEVAL/RMSE outputs from Cube folder...
*if exist HEVAL.OUT del heval.out
*if exist RMSE.OUT del rmse.out
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC del HRLDXY2.ASC

*REM -- Clean Cube folder of HEVAL/RMSE routines' Inputs...
*if exist PROFILE.MAS del PROFILE.MAS
*if exist HESCREEN.SYN del HESCREEN.SYN
*if exist HELABELS.SYN del HELABELS.SYN
*if exist HERATES.SYN del HERATES.SYN
*if exist DATABASE.CTL del DATABASE.CTL
*if exist LnksCnt.DBF del LnksCnt.DBF

; End of PILOT Script

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\output\heval_HO-NERPM4.out" "{SCENARIO_DIR}\output\HEVAL_HO.PRN" '
ENDRUN

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\output\rmse_HO-NERPM4.out" "{SCENARIO_DIR}\output\RMSEDBF_HO.PRN" '
ENDRUN

