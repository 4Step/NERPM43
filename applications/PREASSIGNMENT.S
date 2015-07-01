; Script for program MATRIX in file "D:\NERPM4\APPLICATIONS\PAMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\PAMAT00A.PRN" MSG='Separate trips by purpose and auto ownership'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PTRIPS_MC2.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\VTRIP1.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PKPRELOAD1.MAT",
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


; Script for program MATRIX in file "D:\NERPM4\APPLICATIONS\PAMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\PAMAT00B.PRN" MSG='Use pk-hour factors to get the peak hour trip table'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PKPRELOAD1.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PKPRELOAD.MAT",
 MO=1-6,NAME=IEEITRK,SOV,CARPOOL,EETRUCKS,EESOV,EEHOV, DEC=6*S

PAR ZONEMSG=100

pahbwpkfac = 0.45299   ; 2000 HH survey
pahbnwpkfac= 0.25757   ; 2000 HH survey
panhbpkfac = 0.036640  ; 2000 HH survey
aphbwpkfac = 0.02367   ; 2000 HH survey
aphbnwpkfac= 0.03536   ; 2000 HH survey
apnhbpkfac = 0.036640  ; 2000 HH survey
iepkfac    = 0.1537    ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
eepkfac    = 0.136     ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
trkpkfac   = 0.20      ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS

;IE/EE TRUCK
MW[01]=(trkpkfac * MI.1.14 + trkpkfac * MI.1.14.T) * 0.5
;SOV & SOVIE
MW[02]=(pahbwpkfac * MI.1.1 + aphbwpkfac * MI.1.1.T) * 0.5 +
       (pahbnwpkfac * MI.1.2 + aphbnwpkfac * MI.1.2.T) * 0.5 +
       (panhbpkfac * MI.1.3 + apnhbpkfac * MI.1.3.T) * 0.5 +
       (iepkfac * MI.1.4 + iepkfac * MI.1.4.T) * 0.5
;CARPOOL
MW[03]=(pahbwpkfac * MI.1.5 + aphbwpkfac * MI.1.5.T) * 0.5 /2 +
       (pahbnwpkfac * MI.1.6 + aphbnwpkfac * MI.1.6.T) * 0.5 /2 +
       (panhbpkfac * MI.1.7 + apnhbpkfac * MI.1.7.T) * 0.5 /2 +
       (pahbwpkfac * MI.1.8 + aphbwpkfac * MI.1.8.T) * 0.5 /{OC3VHBW} +
       (pahbnwpkfac * MI.1.9 + aphbnwpkfac * MI.1.9.T) * 0.5 /{OC3VHBNW} +
       (panhbpkfac * MI.1.10 + apnhbpkfac * MI.1.10.T) * 0.5 /{OC3VNHB} +
       (iepkfac * MI.1.12 + iepkfac * MI.1.12.T) * 0.5
;EETRUCKS
MW[04]=(trkpkfac * MI.1.15 + trkpkfac * MI.1.15.T) * 0.5
;EESOV
MW[05]=(eepkfac * MI.1.11 + eepkfac * MI.1.11.T) * 0.5
;EEHOV
MW[06]=(eepkfac * MI.1.13 + eepkfac * MI.1.13.T) * 0.5

ENDRUN


; Script for program HIGHWAY in file "D:\NERPM4\APPLICATIONS\PAHWY00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\PAHWY00F.PRN" MSG='Time of day - peak hour assignment'
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4
FILEO TURNVOLO = "{SCENARIO_DIR}\output\turnvols.bin",
format=BIN
FILEI MATI[1] = "{SCENARIO_DIR}\output\PKPRELOAD.MAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PAHWY00B.PRN"
FILEI TURNPENI = "{CATALOG_DIR}\parameters\tcards_pk.pen"
FILEO NETO = "{SCENARIO_DIR}\output\PKPreLoad.NET"

TURNS N=40555,40265,40258,40241,40568

PAR ZONEMSG=100 MAXITERS={ITER} GAP=0.0000005 RAAD=0.0000 AAD=0.00000 RMSE=0.000000

; look up deceleration rate based on approach speed
LOOKUP,
 INTERPOLATE=Y, LIST=Y, NAME=DECEL,
        LOOKUP[1]=1,RESULT=2,
R = '30 4',
    '70 6.2'

PROCESS PHASE=LINKREAD
  T0=li.TIME
  confacpk=0.582    ; using peak hour factor from HH survey - jeff
  LW.DISTANCE=LI.DISTANCEFT/5280
  LW.FFTIME=LI.TIME ; USE FOR PRELOAD PURPOSES (FFTIME)
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/confacpk
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
;  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5,  EXCLUDEGROUP=1-2,9
;  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=2,9
  PATHLOAD PATH=TIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5,  EXCLUDEGROUP=1,9
  PATHLOAD PATH=TIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=9
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


; Script for program HIGHWAY in file "D:\NERPM4\APPLICATIONS\PAHWY00F.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\PAHWY00A3.PRN" MSG='Develops Preload Skims'
DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4
FILEI NETI = "{SCENARIO_DIR}\output\PKPreLoad.NET"
FILEI TURNPENI = "{CATALOG_DIR}\parameters\tcards_pk.pen"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\TERMTIME.CSV"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT",
 MO=1-9,DEC=9*2,NAME=Toll,Distance,Time,WtdTime,HOVToll,HOVDistance,HOVTime,HOVWtdTime,TerminalTime

PAR ZONEMSG=100

; ARRAY TERMINAL TIMES INTO MEMORY
ARRAY ATYPE={ZONESA}
LOOKUP NAME=TERMTIME, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LOOKUPI=1
PROCESS PHASE=LINKREAD
   LW.TIME=ROUND(100*LI.TIME_1)/100
   LW.DISTANCE=LI.DISTANCEFT/5280 ; CONVERTS NETWORK DISTANCES (FEET) TO MILES FOR SKIM TABLES
   IF (LI.FACILITY_TYPE=80-89) ADDTOGROUP=1
   IF (LI.FACILITY_TYPE=49 | LI.FACILITY_TYPE=59 | LI.FACILITY_TYPE=69) ADDTOGROUP=9
   IF (A<={ZONESA})  ; FLAGS LAST ENCOUNTERED LINK FOR TERMINAL TIME CALCULATION LATER
        ATYPE[A]=LI.AREA_TYPE
        PRINT LIST=A,LI.AREA_TYPE
   ENDIF
ENDPROCESS

PROCESS PHASE=ILOOP
   PATHLOAD PATH=LW.TIME, PENI=1,
      MW[1]=PATHTRACE(LI.CARTOLL), NOACCESS=0,
      MW[2]=PATHTRACE(LW.DISTANCE), NOACCESS=0,
      MW[3]=PATHTRACE(LI.TIME), NOACCESS=0,
      MW[4]=PATHTRACE(LW.TIME), NOACCESS=0,
      EXCLUDEGROUP=1,9
   PATHLOAD PATH=LW.TIME, PENI=1,
      MW[5]=PATHTRACE(LI.CARTOLL), NOACCESS=0,
      MW[6]=PATHTRACE(LW.DISTANCE), NOACCESS=0,
      MW[7]=PATHTRACE(LI.TIME), NOACCESS=0,
      MW[8]=PATHTRACE(LW.TIME), NOACCESS=0,
      EXCLUDEGROUP=9
;(precede this comment with block comment to disable) intrazonal array
deno={AVEZONE}*2
loop _ww=1,8
  mw[_ww][i]=lowest(_ww,{AVEZONE})/deno
endloop
; set intrazonal array to zero for cost
mw[1][i]=0
mw[5][i]=0
;(precede this comment with block comment to close disable) END DISABLE INTRAZONAL CALCULATIONS

; BUILD TERMINAL TIME MATRIX
JLOOP
    ATYPEI=ATYPE[I]
    ATYPEJ=ATYPE[J]
    TERMTI=TERMTIME(1,ATYPEI)
    TERMTJ=TERMTIME(1,ATYPEJ)
    MW[9]=TERMTI+TERMTJ
ENDJLOOP

ENDPROCESS



ENDRUN


; Script for program DISTRIBUTION in file "D:\NERPM4\APPLICATIONS\PADST00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=DISTRIBUTION PRNFILE="{SCENARIO_DIR}\output\FINAL DTB.PRN" MSG='Perform a Final HBW Distribution'
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\SUBAREABAL.CSV"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\FF.CSV"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\PANDA.DBF"
FILEI MATI[1] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\CGHBW.MAT",
 MO=1,NAME=HBW, dec=1*s

PAR MAXITERS={ATITER},MAXRMSE=2, ZONEMSG=100

    LOOKUP, LOOKUPI=1,
        INTERPOLATE=Y, NAME=FF,
        LOOKUP[1]=1,RESULT=2

    LOOKUP, LOOKUPI=2,
        INTERPOLATE=N, NAME=ATRFAC,
        LOOKUP[1]=1,RESULT=3

;   ----- SETUP THE WORKING P AND A

    SETPA P[1]=HBWKP  A[1]=HBWKA*ATRFAC(1,I)  ;Subarea balancing factor removed for testing.

;   ----- GET THE LOS MATRIX INTO WORK MATRIX 20
    MW[20] = MI.1.TIME+MI.1.TERMINALTIME
;   ----- DO 12 GRAVITY MODELS
    GRAVITY PURPOSE=1, LOS=MW[20], FFACTORS=FF
    MW[31]=MW[1]*MW[20]/60
;   ----- GENERATE FREQUENCY DISTRIBUTION REPORTS
FREQUENCY VALUEMW=1  BASEMW=20,  RANGE=1-100, TITLE='HBW CG TRIP LENGTH FREQUENCY {descr}'
;   ----- GET A COMPARISON REPORT ON LAST ITERATION
REPORT ACOMP=1 ITERATIONS=99
ENDRUN


; Script for program MATRIX in file "D:\NERPM4\applications\PAMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\PAMAT00A.PRN" MSG='Converts Preload Skims to TRANPLAN format'
FILEI MATI[2] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"
FILEO MATO[4] = "{SCENARIO_DIR}\output\HFSKIMS1.{alt}{year}",
 mo=15-18, name=COST,DISTANCE,TIME,TIME2, FORMAT=TRANPLAN
FILEO MATO[3] = "{SCENARIO_DIR}\output\FHSKIMS1.{alt}{year}",
 mo=11-14, name=COST,DISTANCE,TIME,TIME2, FORMAT=TRANPLAN
FILEO MATO[2] = "{SCENARIO_DIR}\output\HRSKIMS1.{ALT}{YEAR}",
 MO=5-8, NAME=COST,DISTANCE,TIME1,TIME2, FORMAT=TRANPLAN
FILEO MATO[1] = "{SCENARIO_DIR}\output\RHSKIMS1.{ALT}{YEAR}",
 MO=1-4, NAME=COST,DISTANCE,TIME1,TIME2, FORMAT=TRANPLAN
FILEI MATI[1] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT"
PAR ZONEMSG=100
MW[1]=mi.1.1*100
MW[2]=mi.1.2*100
MW[3]=mi.1.3*100
MW[4]=mi.1.4*100
MW[5]=mi.1.5*100
MW[6]=mi.1.6*100
MW[7]=mi.1.7*100
MW[8]=mi.1.8*100

MW[11]=mi.2.1*100
MW[12]=mi.2.2*100
MW[13]=mi.2.3*100
MW[14]=mi.2.4*100
MW[15]=mi.2.5*100
MW[16]=mi.2.6*100
MW[17]=mi.2.7*100
MW[18]=mi.2.8*100

ENDRUN


