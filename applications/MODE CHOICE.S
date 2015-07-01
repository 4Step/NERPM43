; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


*echo Date: %date% >"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Time: %time% >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo NERPM Model Run - {DESCR}>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Input Directory {SCENARIO_DIR}\input >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo ======================================================================================>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

*del "{SCENARIO_DIR}\output\ModeDebug.TXT"
*del "{SCENARIO_DIR}\output\ModeSum.TXT"
*del "{SCENARIO_DIR}\output\CalibSum.TXT"
*del "{SCENARIO_DIR}\output\modeshares.csv"
*del "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV"
*del "{SCENARIO_DIR}\output\CBDSHARES.CSV"
; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00R.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='store time and date'
FILEI RECI = "{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

zones={ZONESA}

s1=strpos('Date:',reci)
s2=strpos('Time:',reci)

; get the date and time
if (s1 > 0)
 rundate=substr(reci,s1,80)
 log prefix=date var=rundate
endif
if (s2 > 0) 
 runtime=substr(reci,s2,80)
 log prefix=time var=runtime
endif

ENDRUN


RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{CATALOG_DIR}\parameters\MC_CONSTANTS.DBF" "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF" '
ENDRUN

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF" "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF" '
ENDRUN

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00Q.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00A3.PRN" MSG='Preparation for mode choice model'
FILEI ZDATI[3] = "{SCENARIO_DIR}\output\ZONESAT.DAT",
Z=1-10,A1=11-20
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\TERMTIME.CSV"
FILEI ZDATI[2] = "{SCENARIO_DIR}\output\PCWALK_{alt}{year}.DAT",
Z=1-5,A1=6-11,A2=12-17,A3=18-23,A4=24-29
FILEI ZDATI[1] = "{SCENARIO_DIR}\input\ZDATA_{year}{alt}.DBF"
FILEO RECO[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF",
   FIELDS= TAZ,DESCR,SFDU,SFSEAS,SFVAC,SFPOP,SF0CAR,SF1CAR,SF2CAR,SF3CAR,MFDU,MFSEAS,
           MFVAC,MFPOP,MF0CAR,MF1CAR,MF2CAR,MF3CAR,HMUNITS,HMPCTOCC,HMPOP,EMPMFG,EMPIND,EMPCOM,EMPSVC,EMPTOT,SCHENR,STPKCST,LTPKCST,
           PCWPRDPK,PCWATTPK,PCWPRDOP,PCWATTOP,AREA_TYPE,CBD_DUMMY,EXU_DUMMY,TERMTIME,PERCAUTO0,PERCAUTO1,PERCAUTO2,PERCAUTO3,PERCAUTO4,LONGPARK

PAR ZONES={ZONESI} ZONEMSG=100


LOOKUP, NAME=TERM, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LOOKUPI=1, FAIL=0

RO.TAZ=ZI.1.TAZ
RO.DESCR=ZI.1.DESCRIPTIO
RO.SFDU=ZI.1.SFDU
RO.SFSEAS=ZI.1.SFSEAS
RO.SFVAC=ZI.1.SFVAC
RO.SFPOP=ZI.1.SFPOP 
RO.SF0CAR=ZI.1.SF0CAR
RO.SF1CAR=ZI.1.SF1CAR
RO.SF2CAR=ZI.1.SF2CAR
RO.SF3CAR=ZI.1.SF3CAR
RO.MFDU=ZI.1.MFDU
RO.MFSEAS=ZI.1.MFSEAS
RO.MFVAC=ZI.1.MFVAC
RO.MFPOP=ZI.1.MFPOP
RO.MF0CAR=ZI.1.MF0CAR
RO.MF1CAR=ZI.1.MF1CAR
RO.MF2CAR=ZI.1.MF2CAR
RO.MF3CAR=ZI.1.MF3CAR
RO.HMUNITS=ZI.1.HMUNITS
RO.HMPCTOCC=ZI.1.HMPCTOCC
RO.HMPOP=ZI.1.HMPOP
RO.EMPMFG=ZI.1.EMPMFG
RO.EMPIND=ZI.1.EMPIND
RO.EMPCOM=ZI.1.EMPCOM
RO.EMPSVC=ZI.1.EMPSVC
RO.EMPTOT=ZI.1.EMPTOT
RO.SCHENR=ZI.1.SCHENR
RO.STPKCST=ZI.1.STPKCST
RO.LTPKCST=ZI.1.LTPKCST

RO.PCWPRDPK=ZI.2.A1   ; percent walk at production end for peak period
RO.PCWATTPK=ZI.2.A2
RO.PCWPRDOP=ZI.2.A3
RO.PCWATTOP=ZI.2.A4

RO.AREA_TYPE=ZI.3.A1
RO.TERMTIME=TERM(1,ZI.3.A1)

RO.LONGPARK= 1 ; Needs to be updated with zonal parking (Add some dummy for MC during MC setup)

CBD_DUMMY=0
EXU_DUMMY=0
; define CBD zones for mode chocie
if (ZI.3.A1>10 & ZI.3.A1<20) CBD_DUMMY=1
; define EXURBAN zones for mode choice
if (ZI.3.A1>40 & ZI.3.A1<50) EXU_DUMMY=1


; Percent 0car, 1 car and 2+car percentages 
_pop1car = (ZI.1.SFPOP * ZI.1.SF1CAR * 0.01) + (ZI.1.MFPOP * ZI.1.MF1CAR * 0.01)
_pop2car = (ZI.1.SFPOP * (ZI.1.SF2CAR + ZI.1.SF3CAR) * 0.01) + (ZI.1.MFPOP * (ZI.1.MF2CAR + ZI.1.MF3CAR) * 0.01) 
_pop0car = (ZI.1.SFPOP + ZI.1.MFPOP - _pop1car - _pop2car)

if (_pop0car < -0.01) print list=" ************** Error in calculating 2 car population. *********", I(5.0),_pop0car(10.2),_pop1car(10.2),_pop2car(10.2)

_poptot = _pop0car + _pop1car + _pop2car


if (_poptot > 0) then
 PERCAUTO0 = _pop0car/_poptot
 PERCAUTO1 = _pop1car/_poptot
 PERCAUTO2 = _pop2car/_poptot
else
 PERCAUTO0 = 1.00  ; set 100% to the 0 car
 PERCAUTO1 = 0
 PERCAUTO2 = 0
endif

; This is added only for the MC to run, these shares need to be replaced with autosufficiencies
 PERCAUTO3 = PERCAUTO1/2
 PERCAUTO4 = PERCAUTO2/2
 PERCAUTO1 =  PERCAUTO1/2
 PERCAUTO2 = PERCAUTO2/2

WRITE RECO=1

ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\MCMAT00X.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00A2.PRN" MSG='Calculate HOV time savings (to be used in mode choice model)'
FILEI MATI[2] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT",
 MO=21-22,DEC=2*2,NAME=HOVsaveOP,HOVsavePK

PAR ZONEMSG=100

FILLMW MW[1] =MI.1.4,8   ; note that time2 is used here (time2 contains both time and time-equivalent of toll)
FILLMW MW[11]=MI.2.4,8

MW[21]=MW[1] - MW[2]   ; hov time savings during off-peak hours
MW[22]=MW[11] - MW[12] ; hov time savings during peak hours

JLOOP
; if (MW[21] > 0) MW[21]=0.0   ; if less than HOVMIN zero out the savings
; if (MW[22] > 0) MW[22]=0.0
 if (MW[21] < {HOVMIN}) MW[21]=0.0   ; if less than HOVMIN zero out the savings
 if (MW[22] < {HOVMIN}) MW[22]=0.0
ENDJLOOP
ENDRUN


LOOP AMLoop_1 = 1, 1, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


*del "{SCENARIO_DIR}\output\MODESHARES.CSV"
*del "{SCENARIO_DIR}\output\CBDSHARES.CSV"
; End of PILOT Script

  LOOP PURPOSE = 1, 3, 1

; PILOT Script

IF (PURPOSE=1) ; HBW PK purpose
PERIOD='PK'
PURP='HBW'
PURPNO=2
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS1'
OCC3={oc3vhbw}
RUNDATE='@DATE.RUNDATE@'
RUNTIME=@TIME.RUNTIME@
PRK='LONGPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 1 of 16 HBW PK", printo=0

ELSEIF (PURPOSE=2) ; NHBW PK purpose
PERIOD= 'PK'
PURP='NHBW'
PURPNO=4
SHRNO=2
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 2 of 16 HBNW PK", printo=0

ELSEIF (PURPOSE=3) ; HBSH PK purpose 
PERIOD='PK'
PURP='HBSH'
PURPNO=3
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 3 of 16 HBSH PK", printo=0

ELSEIF (PURPOSE=4) ; HBSR PK purpose 
PERIOD='PK'
PURP='HBSR'
PURPNO=3
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 4 of 16 HBSR PK", printo=0

ELSEIF (PURPOSE=5) ; HBO PK purpose 
PERIOD='PK'
PURP='HBO'
PURPNO=3
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 5 of 16 HBO PK", printo=0

ELSEIF (PURPOSE=6) ; NHBO PK purpose
PERIOD= 'PK'
PURP='NHBO'
PURPNO=4
SHRNO=3
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number = 6 of 16 NHBO PK", printo=0

ELSEIF (PURPOSE=7) ; HBW OP purpose
PERIOD='OP'
PURP='HBW'
PURPNO=2
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS1'
OCC3={oc3vhbw}
RUNDATE='@DATE.RUNDATE@'
RUNTIME=@TIME.RUNTIME@
PRK='LONGPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 7 of 16 HBW OP", printo=0

ELSEIF (PURPOSE=8) ; NHBW OP purpose
PERIOD= 'OP'
PURP='NHBW'
PURPNO=4
SHRNO=2
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number = 8 of 16 NHBW OP", printo=0

ELSEIF (PURPOSE=9) ; HBSH OP purpose 
PERIOD='OP'
PURP='HBSH'
PURPNO=3
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 9 of 16 HBSH OP", printo=0

ELSEIF (PURPOSE=10) ; HBSR OP purpose 
PERIOD='OP'
PURP='HBSR'
PURPNO=3
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number =10 of 16 HBSR OP", printo=0

ELSEIF (PURPOSE=11) ; HBO OP purpose 
PERIOD='OP'
PURP='HBO'
PURPNO=3
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=5
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient High Income   '
Mkt4_Name='Car Suficient Low Income      '
Mkt5_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number =11 of 16 HBO OP", printo=0

ELSEIF (PURPOSE=12) ; NHBO OP purpose
PERIOD= 'OP'
PURP='NHBO'
PURPNO=4
SHRNO=3
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number =12 of 16 NHBO OP", printo=0

; HBCU and HBSC
ELSEIF (PURPOSE=13) ; HBCU PK purpose 
PERIOD='PK'
PURP='HBCU'
PURPNO=2
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number =13 of 16 HBCU PK", printo=0

ELSEIF (PURPOSE=14) ; HBSC PK purpose 
PERIOD='PK'
PURP='HBSC'
PURPNO=3
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number =14 of 16 HBSC PK", printo=0

ELSEIF (PURPOSE=15) ; HBCU OP purpose 
PERIOD='OP'
PURP='HBCU'
PURPNO=2
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number =15 of 16 HBCU OP", printo=0

ELSEIF (PURPOSE=16) ; HBSC OP purpose 
PERIOD='OP'
PURP='HBSC'
PURPNO=3
SKIMFILE='FHSKIMS'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number =16 of 16 HBSC OP", printo=0

ENDIF

; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00O.S"
/*
  Mode Choice Model
  Purpose and Market Definitions:

  Num  Purpose  Segment  ||  Seg     AutoSufficiency
   1   HBW        5      ||   1      Zero Auto
   2   HBO        5      ||   2      A<W Low Inc
   3   HBS        5      ||   3      A<W High Inc
   4   HBSR       5      ||   4      A>=W Low Inc
   5   SCH        1      ||   5      A>=W High Inc
   6   HBCU       1      ||
   7   NHBW       1      ||
   8   NHBO       1      ||

   ; Market stratification for all trip purposes except student trips is based on Car Sufficiency.

*/

; PURPNO = 1

RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00D.PRN"   MSG='Utilities and XCHOICE'

    ; Multi-core processing
    ; DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F

/*
    ; Mode choice output files
      FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_0CAR.MAT",
      MO=701-712,DEC=12*s,NAME=DACW0CAR,SR2CW0CAR,SR3CW0CAR,WBCW0CAR,WPCW0CAR,PBCW0CAR,PPCW0CAR,KBCW0CAR,KPCW0CAR,CKBCW0CAR,CKPCW0CAR,FRGPNRCW0CAR
      FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_1CAR.MAT",
      MO=713-724,DEC=12*s,NAME=DACW1CAR,SR2CW1CAR,SR3CW1CAR,WBCW1CAR,WPCW1CAR,PBCW1CAR,PPCW1CAR,KBCW1CAR,KPCW1CAR,CKBCW1CAR,CKPCW1CAR,FRGPNRCW1CAR
      FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_2CAR.MAT",
      MO=725-736,DEC=12*s,NAME=DACW2CAR,SR2CW2CAR,SR3CW2CAR,WBCW2CAR,WPCW2CAR,PBCW2CAR,PPCW2CAR,KBCW2CAR,KPCW2CAR,CKBCW2CAR,CKPCW2CAR,FRGPNRCW2CAR
      FILEO MATO[4] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_0CAR.MAT",
      MO=737-748,DEC=12*s,NAME=DAMD0CAR,SR2MD0CAR,SR3MD0CAR,WBMD0CAR,WPMD0CAR,PBMD0CAR,PPMD0CAR,KBMD0CAR,KPMD0CAR,CKBMD0CAR,CKPMD0CAR,FRGPNRMD0CAR
      FILEO MATO[5] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_1CAR.MAT",
      MO=749-760,DEC=12*s,NAME=DAMD1CAR,SR2MD1CAR,SR3MD1CAR,WBMD1CAR,WPMD1CAR,PBMD1CAR,PPMD1CAR,KBMD1CAR,KPMD1CAR,CKBMD1CAR,CKPMD1CAR,FRGPNRMD1CAR
      FILEO MATO[6] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_2CAR.MAT",
      MO=761-772,DEC=12*s,NAME=DAMD2CAR,SR2MD2CAR,SR3MD2CAR,WBMD2CAR,WPMD2CAR,PBMD2CAR,PPMD2CAR,KBMD2CAR,KPMD2CAR,CKBMD2CAR,CKPMD2CAR,FRGPNRMD2CAR
      FILEO MATO[7] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_0CAR.MAT",
      MO=773-784,DEC=12*s,NAME=DANT0CAR,SR2NT0CAR,SR3NT0CAR,WBNT0CAR,WPNT0CAR,PBNT0CAR,PPNT0CAR,KBNT0CAR,KPNT0CAR,CKBNT0CAR,CKPNT0CAR,FRGPNRNT0CAR
      FILEO MATO[8] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_1CAR.MAT",
      MO=785-796,DEC=12*s,NAME=DANT1CAR,SR2NT1CAR,SR3NT1CAR,WBNT1CAR,WPNT1CAR,PBNT1CAR,PPNT1CAR,KBNT1CAR,KPNT1CAR,CKBNT1CAR,CKPNT1CAR,FRGPNRNT1CAR
      FILEO MATO[9] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_2CAR.MAT",
      MO=797-808,DEC=12*s,NAME=DANT2CAR,SR2NT2CAR,SR3NT2CAR,WBNT2CAR,WPNT2CAR,PBNT2CAR,PPNT2CAR,KBNT2CAR,KPNT2CAR,CKBNT2CAR,CKPNT2CAR,FRGPNRNT2CAR
      FILEO MATO[10] = "{SCENARIO_DIR}\output\@PURP@Trip.MAT",
      MO=601-612,621-632,641-652,251-254,261-269,DEC=49*S
      FILEO MATO[11] = "{SCENARIO_DIR}\output\expautoutil_tmp.mat",
      MO=56-58,36-38,DEC=6*D,NAME=EXPA_0CAR,EXPA_1CAR,EXPA_2CAR,SPLITCMP_0CAR,SPLITCMP_1CAR,SPLITCMP_2CAR
      FILEO MATO[12] = "{SCENARIO_DIR}\output\farexfer_tmp.mat",
      MO=211-228,DEC=18*2,NAME=farewb,farewp,farepb,farepp,farekb,farekp,fareckb,fareckp,farefp,xferwb,xferwp,xferpb,xferpp,xferkb,xferkp,xferckb,xferckp,xferfp

*/               
   
    ; Composite Logsums by Market
    FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCLS_{ALT}{Year}.MAT",
        MO=340-344,DEC=5*S,
            NAME=LSUM_M1,LSUM_M2,LSUM_M3,LSUM_M4,LSUM_M5
            
    FILEO MATO[2] = "{SCENARIO_DIR}\output\expautoutil_tmp_@PERIOD@.mat",
        MO=350-354,330-334,DEC=10*S,NAME=EXPA_M1,EXPA_M2,EXPA_M3,EXPA_M4,EXPA_M5,
           SPLITCMP_M1,SPLITCMP_M2,SPLITCMP_M3,SPLITCMP_M4,SPLITCMP_M5
    
    FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB1.MAT",
        MO=701-718,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
    FILEO MATO[4] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB2.MAT",
        MO=721-738,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
    FILEO MATO[5] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB3.MAT",
        MO=741-758,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
    FILEO MATO[6] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB4.MAT",
        MO=761-778,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
    FILEO MATO[7] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB5.MAT",
        MO=781-798,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
     

    ; Print outputs
    FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebug.TXT",append=t
    FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSum.TXT", append=t

    ; Zone and station data
    FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
    FILEI ZDATI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"

    ; Modechoice coefficients and alternative specific constants
    FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"
    FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"

    ; Highway Skim Tables
    ; Tables 1-4 for SOV: 1-Toll, 2-Distance, 3-Time, 4-Weighted Time
    ; Tables 5-8 for HOV: 5-Toll, 6-Distance, 7-Time, 8-Weighted Time
    ; Table 9 is terminal time

    ; Transit Skim Tables
    ; Tables 1-6: 1-WalkTime, 2-AutoTime, 3-XferTime, 4-BusTime, 5-PRJBusTime, 6-CircTime
    ; Tables 7-10: 7-RailTime, 8-CommuterRailTime, 9-OtherModeTime, 10-ProjectModeTime
    ; Tables 11-15: 11-NumXfers, 12-InitialWaitTime, 13-XferWaitTime, 14-Fare, 15-Total time

    ; Transit skim (1: Walk to Skyway)
    FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@1_{Alt}{year}.MAT"

    ; Transit skim (2: Walk to Local Bus)
    FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@2_{Alt}{year}.MAT"

    ; Transit skim (3: Walk to Express Bus)
    FILEI MATI[3] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@3_{Alt}{year}.MAT"

    ; Transit skim (4: Walk to BRT-LRT)
    FILEI MATI[4] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@4_{Alt}{year}.MAT"

    ; Transit skim (5: Walk to Commuter Rail)
    FILEI MATI[5] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@5_{Alt}{year}.MAT"

    ; Transit skim (6: Drive to Local Bus)
    ; FILEI MATI[6] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@6_{Alt}{year}.MAT"

    ; Transit skim (6: PNR to Express Bus)
    FILEI MATI[6] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@6_{Alt}{year}.MAT"

    ; Transit skim (7: PNR to BRT-LRT Bus)
    FILEI MATI[7] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@7_{Alt}{year}.MAT"

    ; Transit skim (8: PNR to Commuter Rail)
    FILEI MATI[8] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@8_{Alt}{year}.MAT"

    ; Transit skim (9: KNR to Express Bus)
    FILEI MATI[9] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@6_{Alt}{year}.MAT"

    ; Transit skim (10: KNR to BRT-LRT Bus)
    FILEI MATI[10] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@7_{Alt}{year}.MAT"

    ; Transit skim (11: KNR to Commuter Rail)
    FILEI MATI[11] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@8_{Alt}{year}.MAT"

    ; Highway skim (All Drive)
    FILEI MATI[13] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"

    ; Highway skim (Drive to Skyway) // Need to repalce with sky
    FILEI MATI[14] = "{SCENARIO_DIR}\output\PRELSKIMS_SKY_{year}{Alt}.MAT"

    ; Non-Motorized skim (All Walk)
    ; FILEI MATI[15] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"

    ; Non-Motorized skim (All Bike)
    ; FILEI MATI[16] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"

    ; HOV time savings
    ; Table 1 - HOV time savings for peak period
    ; Table 2 - HOV time savings for off-peak period
    FILEI MATI[17] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT"

    ; Station to station table
    ; 1-4 tables - PKStationTAZ_pnrb, PKParkCost_pnrb, termtimpnr, termtimknr,
    ; 5-8 tables - OPStationTAZ_pnrb, OPParkCost_pnrb, termtimpnr, termtimknr
    FILEI MATI[18] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"

    ; Select link matrices??
    FILEI MATI[19] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT"

    ; Person trips
    FILEI MATI[20] = "{SCENARIO_DIR}\output\PTRIPSMC.MAT"


    ; Progress Bar update for evey 100 zones
    zonemsg=100

    ; Declare arrays to hold alternative specific constants
    ARRAY PARK={ZONESA}
    ARRAY TYPE=F K_AUT=5, K_SR=5, K_SR3=5, K_TRN=5, K_TDRV=5, K_TKNR=5, K_NMOT=5, K_BIKE=5
    ARRAY TYPE=C30 MARKET_NAME=5

    ; Read alternative specific Constants
    LOOKUP, NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, , LIST=Y, LOOKUPI=1

    ; Read mode choice coefficients
    LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=2

    ; Read coefficients and constants
    IF (i=FirstZone)
      ; Index _m identifies the market segment, as follows:
      ; All HB purposes except shcool, university and NNHB
      ; -------------------------------------------------------
      ;    _m = 1      zero-car households
      ;    _m = 2      low income, car insufficient hhlds
      ;    _m = 3      high income, car sufficient hhlds
      ;    _m = 4      low income, car sufficient hhlds
      ;    _m = 5      high income, car sufficient hhlds

      ; Household market stratified constants
      LOOP _m=1,5
         K_AUT[_m]  = CONSTANTS(1,(_m-1)*10+1)            ; auto
         K_SR[_m]   = CONSTANTS(1,(_m-1)*10+2)            ; shared-ride 2 & 3+
         K_SR3[_m]  = CONSTANTS(1,(_m-1)*10+3)            ; shared ride 3+
         K_TRN[_m]  = CONSTANTS(1,(_m-1)*10+4)            ; transit
         K_TDRV[_m] = CONSTANTS(1,(_m-1)*10+5)            ; drive to transit
         K_TKNR[_m] = CONSTANTS(1,(_m-1)*10+6)            ; knr to transit
         K_NMOT[_m] = CONSTANTS(1,(_m-1)*10+7)            ; non-motorized (walk & bike)
         K_BIKE[_m] = CONSTANTS(1,(_m-1)*10+8)            ; bike
      ENDLOOP

      ; MARKETS=@MARKETS@
      MARKET_NAME[1] = '@Mkt1_Name@'
      MARKET_NAME[2] = '@Mkt2_Name@'
      MARKET_NAME[3] = '@Mkt3_Name@'
      MARKET_NAME[4] = '@Mkt4_Name@'
      MARKET_NAME[5] = '@Mkt5_Name@'

      ; Mode-specific constants -- same for all hhld markets
      K_SKY = CONSTANTS(1,51)                        ; Skyway
      K_EXP = CONSTANTS(1,52)                        ; express bus
      K_BRT = CONSTANTS(1,53)                        ; brt
      K_UR  = CONSTANTS(1,54)                        ; urban rail
      K_CR  = CONSTANTS(1,55)                        ; commuter rail

      ; Nesting coefficients
      NC_1        = COEFF(1,10)                      ; Level 1 - auto, trn, non-mot
      NC_2        = COEFF(1,11)                      ; Level 2 - transit access mode choice
      NCP = NC_1 * NC_2                              ; Product of nesting coefficients

      ; Level of Service Coefficients
      COEFF_IVTT   = COEFF(1,1)                      ; In-vehicle travel time coefficient
      COEFF_OVT    = COEFF(1,3)                      ; Out-of-vehicle travel time coefficient
      COEFF_AAT    = COEFF(1,5)                      ; Access coefficient?
      COEFF_XFER   = COEFF(1,6)                      ; transfer
      COEFF_DCBD   = COEFF(1,7)                      ;
      COEFF_DEXUP  = COEFF(1,8)                      ;
      COEFF_DEXUA  = COEFF(1,9)                      ;

      COEFF_DCBD_WALK = COEFF(1,15)                  ;
      COEFF_DCBD_PNR  = COEFF(1,16)                  ;
      COEFF_DCBD_KNR  = COEFF(1,17)                  ;

      ; Cost Coefficients
      ARRAY TYPE=F COEFF_COST=7
      COEFF_COST[1]  = COEFF(1,21)
      COEFF_COST[2]  = COEFF(1,22)
      COEFF_COST[3]  = COEFF(1,23)
      COEFF_COST[4]  = COEFF(1,24)
      COEFF_COST[5]  = COEFF(1,25)
      COEFF_COST[6]  = COEFF(1,26)
      COEFF_COST[7]  = COEFF(1,27)

    ENDIF

    ; Highway skims
    FILLMW MW[1]=MI.13.1,2,3,4,5,6,7,8 ;,9     ; highway skims
    FILLMW MW[241]=MI.14.1,2,3,4,5,6,7,8 ;,9   ; drive toskyway best path
    FILLMW MW[11]=MI.17.HOVsave@PERIOD@        ; HOVsavePK for peak period and HOVsaveOP for off-peak period
    FILLMW MW[291]=MI.18.@STATION_TABLE@       ; 8 tables - PKStationTAZ_pnrb,PKParkCost_pnrb,termtimpnr,termtimknr,OPStationTAZ_pnrb,OPParkCost_pnrb,termtimpnr,termtimknr

    ; Transit (walk) skims
    FILLMW MW[21]=MI.1.1(15)                   ; walk to skyway
    FILLMW MW[41]=MI.2.1(15)                   ; walk to loc bus
    FILLMW MW[61]=MI.3.1(15)                   ; walk to exp bus
    FILLMW MW[81]=MI.4.1(15)                   ; walk to brt lrt
    FILLMW MW[101]=MI.5.1(15)                  ; walk to com rail

    ; Transit (PNR) skims
    FILLMW MW[121]=MI.6.1(15)                  ; pnr to exp bus
    FILLMW MW[141]=MI.7.1(15)                  ; pnr to brt lrt
    FILLMW MW[161]=MI.8.1(15)                  ; pnr to com rail

    ; Transit (KNR) skims
    FILLMW MW[181]=MI.6.1(15)                  ; knr to exp bus
    FILLMW MW[201]=MI.7.1(15)                  ; knr to brt lrt
    FILLMW MW[221]=MI.8.1(15)                  ; knr to com rail

    ; Walk and Bike
    ; distance portion that is 1 mile or less
    MW[12] = MIN(MW[2],1)

    ; Distance portion that is longer than 1 mile
    JLOOP
      IF (MW[2][J] > 1)
          MW[13] = MW[2][J] - 1
      ELSE
          MW[13] = 0
      ENDIF
    ENDJLOOP

    ; Person trips
    MW[251] = MI.20.1

    ;  Write out coefficients for debug and regular runs
    IF (I=1)  ; Write mode choice summary file                                                                                                
      ; DEBUG MODE CHOICE                                                                                                                   
      IF ({DebugMC}>0) 
         ; split this into two sections (1) DEBUG and (2) Regular 
         READ FILE = "WriteReport.S"
      ENDIF
    ENDIF
    
    ; ************************** PROCESS PERSON TRIPS INTO MARKETS ************************************
    ; Divide person trip table into different markets
      MW[252]=MW[251] * ZI.1.PERCAUTO0[I]                                                                   ; Zero car HHs
      MW[253]=MW[251] * ZI.1.PERCAUTO1[I]                                                                   ; Auto Insufficient Low Income HHs
      MW[254]=MW[251] * ZI.1.PERCAUTO3[I]                                                                   ; Auto Insufficient High Income HHs
      MW[255]=MW[251] * ZI.1.PERCAUTO4[I]                                                                   ; Auto Sufficient Low Income HHs
      MW[256]=(MW[251] - MW[252] - MW[253] - MW[254] - MW[255])                                             ; Auto Sufficient High Income HHs

      ; Overwrite the above if there is only one market
      IF (@MARKETS@=1)
         MW[252]=MW[251]
         MW[253]=0
         MW[254]=0
         MW[255]=0
         MW[256]=0
      ENDIF

      ; Zero car transit sub-markets (can walk, must drive and no access)
      MW[261] = MW[252] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
      MW[262] = MW[252] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
      MW[263] = MW[252] - MW[261] - MW[262]                                                                 ; No Access

      ; Auto Insufficient Low Income transit sub-markets (can walk, must drive and no access)
      MW[264] = MW[253] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
      MW[265] = MW[253] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
      MW[266] = MW[253] - MW[264] - MW[265]                                                                 ; No Access

      ; Auto Insufficient Low Income transit sub-markets (can walk, must drive and no access)
      MW[267] = MW[254] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
      MW[268] = MW[254] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
      MW[269] = MW[254] - MW[267] - MW[268]                                                                 ; No Access

      ; Auto Sufficient Low Income transit sub-markets (can walk, must drive and no access)
      MW[270] = MW[255] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
      MW[271] = MW[255] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
      MW[272] = MW[255] - MW[270] - MW[271]                                                                 ; No Access

      ; Auto Sufficient Low Income transit sub-markets (can walk, must drive and no access)
      MW[273] = MW[256] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
      MW[274] = MW[256] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
      MW[275] = MW[256] - MW[273] - MW[274]                                                                 ; No Access


    ; *******************************************  WALK ACCESS MARKETS  ************************************************
    ; ******************************************************************************************************************

    ; Loop by access modes
    LOOP ACC=1,3

        ; ************************** COMMON UTILITY CALCULATIONS ************************************
        ; Computes utility that is common across all household market segments

        ; DRIVE ALONE UTILITY:
              MW[301]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[1] * {CTOLL} * 60))) +               ; IVTT
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; SHARED RIDE PERSONS/SHARE RIDE - ONE PASSENGER UTILITY:
              MW[302]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[8] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) -               ; IVTT
                       COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP


        ; SHARED RIDE - 2+ PASSENGER UTILITY:
              MW[303]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[8] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) -               ; IVTT
                       COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; DRIVE TO SKYWAY UTILITY:
              MW[304]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[241] - ({InflationToll} * (MW[245] * {CTOLL} * 60))) -           ; IVTT
                       COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP

        ; WALK ACCESS - SKYWAY UTILITY:
              MW[305]=(COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time (skyway has no xfer time)
                       COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[24] + MW[25] + MW[26] + MW[27] + MW[28]) +                       ; IVTT
                       COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
                       K_SKY +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - LOCAL BUS UTILITY:
              MW[306]=(COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
                       COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[48]) +                       ; IVTT
                       COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - EXPRESS BUS UTILITY:
              MW[307]=(COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
                       COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[68]) +                       ; IVTT
                       COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
                       K_EXP +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - BRT-LRT UTILITY:
              MW[308]=(COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
                       COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[88])+                        ; IVTT
                       COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
                       K_BRT +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - COMMUTER RAIL UTILITY:
              MW[309]=(COEFF_OVT * (MW[101] + MW[103]) +                                                 ; Walk & transfer time
                       COEFF_OVT * (MW[112] + MW[113]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[104] + MW[105] + MW[106] + MW[107] + MW[108]) +                  ; IVTT
                       COEFF_XFER * (MW[111]) +                                                          ; Number of transfers
                       K_CR +                                                                            ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; PNR ACCESS - EXPRESS BUS UTILITY:
              MW[310]=(COEFF_OVT * (MW[121] + MW[123]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[132] + MW[133]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[122]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[124] + MW[125] + MW[126] + MW[127] + MW[128]) +                  ; IVTT
                       COEFF_XFER * (MW[131]) +                                                          ; Number of transfers
                       K_EXP +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; PNR ACCESS - BRT-LRT UTILITY:
              MW[311]=(COEFF_OVT * (MW[141] + MW[143]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[152] + MW[153]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[142]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[144] + MW[145] + MW[146] + MW[147] + MW[148]) +                  ; IVTT
                       COEFF_XFER * (MW[151]) +                                                          ; Number of transfers
                       K_BRT +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; PNR ACCESS - COMMUTER RAIL UTILITY:
              MW[312]=(COEFF_OVT * (MW[161] + MW[163]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[172] + MW[173]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[162]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[164] + MW[165] + MW[166] + MW[167] + MW[168]) +                  ; IVTT
                       COEFF_XFER * (MW[171]) +                                                          ; Number of transfers
                       K_CR +                                                                            ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; KNR ACCESS - LOCAL BUS UTILITY (WALK SKIM with drive access time:
              MW[313]=(COEFF_OVT * ((MW[41]/10) + MW[43]) +                                              ; Drive time = Walk time/10, assuming drive speed of 30 MPH and Walk speed of 3 MPH (limitations on not having separate access & egress links) & transfer time
                       COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[48]) +                       ; IVTT
                       COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; KNR ACCESS - EXPRESS BUS UTILITY:
              MW[314]=(COEFF_OVT * (MW[181] + MW[183]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[192] + MW[193]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[182]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[184] + MW[185] + MW[186] + MW[187] + MW[188]) +                  ; IVTT
                       COEFF_XFER * (MW[191]) +                                                          ; Number of transfers
                       K_EXP +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; KNR ACCESS - BRT-LRT UTILITY:
              MW[315]=(COEFF_OVT * (MW[201] + MW[203]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[212] + MW[213]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[202]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[204] + MW[205] + MW[206] + MW[207] + MW[208]) +                  ; IVTT
                       COEFF_XFER * (MW[211]) +                                                          ; Number of transfers
                       K_BRT +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; KNR ACCESS - COMMUTER RAIL UTILITY:
              MW[316]=(COEFF_OVT * (MW[221] + MW[223]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[232] + MW[233]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[222]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[224] + MW[225] + MW[226] + MW[227] + MW[228]) +                  ; IVTT
                       COEFF_XFER * (MW[231]) +                                                          ; Number of transfers
                       K_CR +                                                                            ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; WALK MODE ELEMENTS OF UTILITY ARE:
             MW[317]=(COEFF_IVTT * 2 * (60/3) * MW[12] +                                                 ; walking time if less than 1 mile
                      COEFF_IVTT * 3 * (60/3) * MW[13]) / NCP                                            ; walking time if more than 1 mile

        ;BIKE MODE ELEMENTS OF UTILITY ARE
             MW[318]=(COEFF_IVTT * 2 * (60/10) * MW[12] +                                                ; biking time if less than 1 mile
                      COEFF_IVTT * 3 * (60/10) * MW[13]) / NCP                                           ; biking time if more than 1 mile

        ;************************** END COMMON UTILITY CALCULATIONS ************************************

        ;**********************  ADD HOUSEHOLD MARKET SPECIFIC TERMS **********************************
        ;                              Cost utility and constants
        LOOP _m=1,@MARKETS@

           ; Drive alone
           MW[401+20*(_m-1)] = MW[301] + (0                +                                                    ; Constant(s)
                                   COEFF_COST[_m] * {InflationToll} * MW[1]        +                            ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +     ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +     ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost
           ; Shared Ride 2-person
           MW[402+20*(_m-1)] = MW[302] + (K_SR[_m]       +                                                      ; Constant(s)
                                   COEFF_COST[_m] * ({InflationToll} * MW[5] / 2.0) +                           ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 2.0) +     ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 1.0) +     ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost (not shared among occupants)

           ; Shared Ride 3+ person
           MW[403+20*(_m-1)] = MW[303] + (K_SR[_m] + K_SR3[_m] +                                                ; Constant(s)
                                   COEFF_COST[_m] * ({InflationToll} * MW[5] / @OCC3@) +                        ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 2.0) +  ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 1.0) +  ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost (not shared among occupants)
           ; Drive to Skyway
           MW[404+20*(_m-1)] = MW[304] + (0                +                                                    ; Constant(s)
                                   COEFF_COST[_m] * {InflationToll} * MW[1]        +                            ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +     ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +     ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost
                                   
           ; Walk to Skyway
           MW[405+20*(_m-1)] = MW[305] + (K_TRN[_m]      +                                                      ; Constant(s)
                                  COEFF_COST[_m] * {InflationFare} * (MW[34]) ) / NCP                           ; Transit fare

           ; Walk to Local Bus
           MW[406+20*(_m-1)] = MW[306] + (K_TRN[_m]      +                                                      ; Constant(s)
                                  COEFF_COST[_m] * {InflationFare} * (MW[54]) ) / NCP                           ; Transit fare

           ; Walk to Express Bus
           MW[407+20*(_m-1)] = MW[307] + (K_TRN[_m] + K_EXP  +                                                  ; Constant(s)
                                 COEFF_COST[_m] * {InflationFare} * (MW[74]) ) / NCP                            ; Transit fare

           ; Walk to BRT-LRT
           MW[408+20*(_m-1)] = MW[308] + (K_TRN[_m] + K_EXP  +                                                  ; Constant(s)
                                 COEFF_COST[_m] * {InflationFare} * (MW[94]) ) / NCP                            ; Transit fare

           ; Walk to Commuter Rail
           MW[409+20*(_m-1)] = MW[309] + (K_TRN[_m] + K_EXP  +                                                  ; Constant(s)
                                 COEFF_COST[_m] * {InflationFare} * (MW[114]) ) / NCP                           ; Transit fare

           ; PNR to Express Bus
           MW[410+20*(_m-1)] = MW[310] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@         COEFF_COST[_m] * ((({InflationFare}*MW[291])/{OCCPNRAccess})/2.0) +                  ; add in other half of NHB PNR parking cost
                                  COEFF_COST[_m] * {InflationFare} * (MW[134])  ) / NCP                         ; Transit fare

           ; PNR to BRT-LRT Bus
           MW[411+20*(_m-1)] = MW[311] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[154]) ) / NCP                         ; Transit fare

           ; PNR to Commuter Rail
           MW[412+20*(_m-1)] = MW[312] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[174]) ) / NCP                         ; Transit fare

           ; KNR to Local Bus
           MW[413+20*(_m-1)] = MW[313] + (K_TRN[_m] + K_TDRV[_m] + K_TKNR[_m] +                                 ; Constant(s)
                                  COEFF_COST[_m] * {InflationFare} * (MW[34]) ) / NCP                           ; Transit fare

           ; KNR to Express Bus
           MW[414+20*(_m-1)] = MW[314] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@         COEFF_COST[_m] * ((({InflationFare}*MW[291])/{OCCPNRAccess})/2.0) +                  ; add in other half of NHB PNR parking cost
                                  COEFF_COST[_m] * {InflationFare} * (MW[134])  ) / NCP                         ; Transit fare

           ; KNR to BRT-LRT Bus
           MW[415+20*(_m-1)] = MW[315] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[154]) ) / NCP                         ; Transit fare

           ; KNR to Commuter Rail
           MW[416+20*(_m-1)] = MW[316] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[174]) ) / NCP                         ; Transit fare
           ; Walk
           MW[417+20*(_m-1)] = MW[317] + (K_NMOT[_m])/NCP                                                       ; Constant(s)

           ; Bike
           MW[418+20*(_m-1)] = MW[318] + (K_NMOT[_m] + K_BIKE[_m])/NCP                                          ; Constant(s)

        ENDLOOP

        ;***************************    MODE AVAILABILITY CHECKS    ************************************
        ;  Drive alone and PNR to transit not available to zero car households
        IF (@Mkt1_0car@=1)
          MW[401] = -9999.99
          MW[404] = -9999.99
          MW[410] = -9999.99
          MW[411] = -9999.99
          MW[412] = -9999.99
        ENDIF

        LOOP _m=1,@MARKETS@
          JLOOP
             ; Transit not available if no line-haul in-vehicle time on the transit path
             ; Walk to skyway
             IF (MW[24] == 0)  MW[405+20*(_m-1)]=-9999.99

             ; Walk to local bus
             IF (MW[44] == 0)  MW[406+20*(_m-1)]=-9999.99

             ; Walk to express bus
             IF (MW[64] == 0)  MW[407+20*(_m-1)]=-9999.99

             ; Walk to BRT-LRT bus
             IF (MW[84] == 0)  MW[408+20*(_m-1)]=-9999.99

             ; Walk to Commuter Rail
             IF (MW[104] == 0)  MW[409+20*(_m-1)]=-9999.99

             ; PNR to express bus
             IF (MW[124] == 0)  MW[410+20*(_m-1)]=-9999.99

             ; PNR to BRT-LRT
             IF (MW[144] == 0)  MW[411+20*(_m-1)]=-9999.99

             ; PNR to Commuter rail
             IF (MW[164] == 0) MW[412+20*(_m-1)]=-9999.99

             ; KNR to express bus
             IF (MW[184] == 0)  MW[413+20*(_m-1)]=-9999.99

             ; KNR to BRT-LRT
             IF (MW[204] == 0)  MW[414+20*(_m-1)]=-9999.99

             ; KNR to Commuter rail
             IF (MW[224] == 0) MW[415+20*(_m-1)]=-9999.99

             ; If walk access distance less than minimum, no walk access to transit
             IF (MW[2] < {MinDistWalkAcc})
                 MW[405+20*(_m-1)]=-9999.99
                 MW[406+20*(_m-1)]=-9999.99
                 MW[407+20*(_m-1)]=-9999.99
                 MW[408+20*(_m-1)]=-9999.99
                 MW[409+20*(_m-1)]=-9999.99
             ENDIF

             ; If drive access distance less than minimum, no drive access to transit
             IF (MW[2] < {MinDistAutoAcc})
                MW[410+20*(_m-1)]=-9999.99
                MW[411+20*(_m-1)]=-9999.99
                MW[412+20*(_m-1)]=-9999.99
             ENDIF

             ; Walk to transit not available for the MD or NT access markets;
             IF(ACC==2 || ACC==3)
                MW[405+20*(_m-1)]=-9999.99
                MW[406+20*(_m-1)]=-9999.99
                MW[407+20*(_m-1)]=-9999.99
                MW[408+20*(_m-1)]=-9999.99
                MW[409+20*(_m-1)]=-9999.99
             ENDIF

             ; Transit not available for NT access markets;
             IF(ACC==3)
               MW[410+20*(_m-1)]=-9999.99
               MW[411+20*(_m-1)]=-9999.99
               MW[412+20*(_m-1)]=-9999.99
               MW[413+20*(_m-1)]=-9999.99
               MW[414+20*(_m-1)]=-9999.99
               MW[415+20*(_m-1)]=-9999.99
               MW[416+20*(_m-1)]=-9999.99
             ENDIF
          ENDJLOOP
       ENDLOOP    ; end market segment loop to set mode availability

       ; Write out the utilities
       JLOOP                                                                                                                                         
         if (ACC=1-3)                                                                                                                                  
           IF (ACC==1) then                                                                                                                            
              ACC_NAME='CAN WALK TO TRANSIT'                                                                                                           
           ELSEIF (ACC==2)                                                                                                                             
              ACC_NAME='MUST DRIVE TO TRANSIT'                                                                                                         
           ELSEIF (ACC==3)                                                                                                                             
              ACC_NAME='NO TRANSIT'                                                                                                                    
           ENDIF                                                                                                                                       
                                                                                                                                                       
           IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))    
              READ FILE = "WriteCompositeUtility.S"
          ENDIF
        ENDIF  
      ENDJLOOP 

       ; ############################# XCHOICE SETUP ###################################
       ; Use DEMAND=1 to generate probabilities.
       ; 0-Car Households
             _DMD=260+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,
             DEMAND=_DMD,
             ODEMANDMW=601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=321,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=331,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       IF(@MARKETS@==1) GOTO next
       ; Car-insufficient, Low Income Households
             _DMD=263+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,
             DEMAND=_DMD,
             ODEMANDMW=621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=322,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=332,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       ; Car-insufficient, High Income Households
             _DMD=266+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,
             DEMAND=_DMD,
             ODEMANDMW=641,642,643,644,645,646,647,648,649,650,651, 652,653,654,655,656,657,658,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=323,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=333,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       ; Car-sufficient, Low Income Households
             _DMD=269+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,
             DEMAND=_DMD,
             ODEMANDMW=661,662,663,664,665,666,667,668,668,670,671,672,673,674,675,676,677,678,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=324,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=334,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       ; Car-sufficient, High Income Households
             _DMD=271+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,
             DEMAND=_DMD,
             ODEMANDMW=681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=325,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=335,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       :next
       
       ; Aggregate trips for all access markets
       LOOP _m=1,@MARKETS@              ; For each auto sufficiency market
           LOOP _c=1,18                 ; 17 choices
               _n=700+_c+(_m-1)*20      ; 701 to 717: Zero auto market trips, 721 - 737 is auto insufficient low inc...
               _d=600+_c + (_m-1)*20    
               MW[_n]=MW[_d]            ; MW[_n] --> MW(701 to 797)
           ENDLOOP
       ENDLOOP

       ; Exponentiated composite utilities
         LOOP _m=1,@MARKETS@
           MW[350+_m]=exp(NC_2 * MW[330+_m])   ; exponentiated auto utility -- for user benefits
         ENDLOOP

       ; Store probabilities for each transit access category
       ;  IF (ACC == 1)
       ;      LOOP _m=1,@MARKETS@
       ;          LOOP _c=1,11
       ;              _n=320+_c+(_m-1)*11
       ;              _d=600+_c + (_m-1)*20
       ;              MW[_n]=MW[_d]         ; MW[_n] --> MW(321 to 397)
       ;          ENDLOOP
       ;      ENDLOOP
       ;  ELSEIF (ACC == 2)
       ;      LOOP _m=1,@MARKETS@
       ;          LOOP _c=1,11
       ;;             _n=320+_c+(_m-1)*11
       ;              _n=740+_c+(_m-1)*11
       ;              _d=600+_c + (_m-1)*20
       ;              MW[_n]=MW[_d]         ; MW[_n] --> MW(741 to 817)
       ;          ENDLOOP
       ;      ENDLOOP
       ;  ENDIF


        ; Calculate access market shares
        ARRAY TYPE=F ACCShare=ZONES,ZONES,3
        JLOOP

          IF (ACC==1)
              ACCShare[I][J][ACC] = (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)         ; Can Walk
          ELSEIF (ACC==2)
              ACCShare[I][J][ACC] = (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)   ; Must Drive
          ELSEIF (ACC==3)
              ACCShare[I][J][ACC] = 1 - ACCShare[I][J][1] - ACCShare[I][J][2]                                 ; No Transit
          ENDIF

        ENDJLOOP

        ; Calculate logit average of the mode choice logsums (composite utilities) across access markets
        LOOP _m=1,@MARKETS@

         JLOOP
           MW[340+_m] = MW[340+_m] + EXP(MW[320+_m]) * ACCShare[I][J][ACC]
           IF(ACC==3) MW[340+_m] = LN(MW[340+_m])
         ENDJLOOP

        ENDLOOP
       ; ############################################ END XCHOICE #################################


        ; Now some debuging

          LOOP _m=1,@MARKETS@

           _cnt=(_m-1)*20
           M1=601+_cnt, M2=602+_cnt, M3=603+_cnt, M4=604+_cnt, M5=605+_cnt, M6=606+_cnt,
           M7=607+_cnt, M8=608+_cnt, M9=609+_cnt, M10=610+_cnt, M11=611+_cnt


           IF ({DebugMC}>0)
            JLOOP
             if ((I={SelOrigin}) && (J={SelDest}))




       ; ##################### XCHOICE RESULTS###############################

              print list='\n\n-------------------------------------------------------------',printo=1
              print list='\nCUBE UTILITY BASED XCHOICE MODEL\n',printo=1
              print list='\nMARKET:                                     ',MARKET_NAME[_m],printo=1
           print list='Access market (1=CW | 2=MD | 3= NT):         ',ACC(2.0),printo=1
              print list='Access market share:                         ',ACCShare[I][J][ACC](6.4),printo=1

         IF ((MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J])>0)
              xcshrda  = MW[M1][J]
              xcshrhov2= MW[M2][J]
              xcshrhov3= MW[M3][J]
              xcshrwkb = MW[M4][J]
              xcshrwkp = MW[M5][J]
              xcshrpnrb= MW[M6][J]
              xcshrpnrp= MW[M7][J]
              xcshrknrb= MW[M8][J]
              xcshrknrp= MW[M9][J]
              xcshrnmw = MW[M10][J]
              xcshrnmb = MW[M11][J]

              xcshrtot=xcshrda+xcshrhov2+xcshrhov3+xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrnmw+xcshrnmb
              print list='\n\nSHARE BY MODE:',printo=1
              print list='\n    Mode:                           Share',printo=1
              print list='    Drive Alone                  ',xcshrda(7.4),printo=1
              print list='    HOV2                         ',xcshrhov2(7.4),printo=1
              print list='    HOV3                         ',xcshrhov3(7.4),printo=1
              print list='    Walk Bus                     ',xcshrwkb(7.4),printo=1
              print list='    Walk Prj                     ',xcshrwkp(7.4),printo=1
              print list='    PNR Bus                      ',xcshrpnrb(7.4),printo=1
              print list='    PNR Prj                      ',xcshrpnrp(7.4),printo=1
              print list='    KNR Bus                      ',xcshrknrb(7.4),printo=1
              print list='    KNR Prj                      ',xcshrknrp(7.4),printo=1
              print list='    Walk                         ',xcshrnmw(7.4),printo=1
              print list='    Bike                         ',xcshrnmb(7.4),printo=1

              print list='\n\n\nOutput shares by XCHOICE:                      ', printo=1
              print list='   Top Nest:                                         ', printo=1
              print list='        Auto Share               ',(xcshrda+xcshrhov2+xcshrhov3)(7.4), printo=1
              print list='        Transit Share            ',(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp)(7.4), printo=1
              print list='        Non-Motorized Share      ',(xcshrnmw+xcshrnmb)(7.4), printo=1
              print list='\n\n   Auto Nest:                                    ', printo=1
              print list='        Drive Alone Share        ',(xcshrda/(xcshrda+xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='        Shared Ride Share        ',((xcshrhov2+xcshrhov3)/(xcshrda+xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='\n\n   Shared Ride Nest:                             ', printo=1
              print list='        HOV2 Share               ',(xcshrhov2/(xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='        HOV3 Share               ',(xcshrhov3/(xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='\n\n   Transit Nest:                                 ', printo=1
              print list='        Walk Transit Share       ',((xcshrwkb+xcshrwkp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='        PNR Transit Share        ',((xcshrpnrb+xcshrpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='        KNR Transit Share        ',((xcshrknrb+xcshrpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='\n\n   Walk Nest:                                 ', printo=1
              print list='        Walk Bus Share           ',(xcshrwkb/(xcshrwkb+xcshrwkp))(7.4), printo=1
              print list='        Walk Prj Share           ',(xcshrwkp/(xcshrwkb+xcshrwkp))(7.4), printo=1
              print list='\n\n   PNR Nest:                                 ', printo=1
              print list='        PNR Bus Share            ',(xcshrpnrb/(xcshrpnrb+xcshrpnrp))(7.4), printo=1
              print list='        PNR Prj Share            ',(xcshrpnrp/(xcshrpnrb+xcshrpnrp))(7.4), printo=1
              print list='\n\n   KNR Nest:                                 ', printo=1
              print list='        KNR Bus Share            ',(xcshrknrb/(xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='        KNR Prj Share            ',(xcshrknrp/(xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='\n\n   Non-Motorized Nest:                                 ', printo=1
              print list='        Walk Share               ',((xcshrnmw)/(xcshrnmw+xcshrnmb))(7.4), printo=1
              print list='        Bike Share               ',((xcshrnmb)/(xcshrnmw+xcshrnmb))(7.4), printo=1

              print list='\n\n\nTotal composite utilities by XCHOICE:          ', MW[100+_m][J](7.4),printo=1
              print list='Auto composite utilities by XCHOICE:           ', MW[110+_m][J](7.4),printo=1
            IF (ACC==3)
              print list='Averaged composite utility:                    ', MW[290+_m][J](7.4),printo=1
           ENDIF
              print list='\n\n',printo=1

              IF (_m=@MARKETS@)
               print list='\n\n\n','END TRACE @PURP@-@PERIOD@','\n',printo=1
               print list='========================================================================================',printo=1
              ENDIF

             ELSE
              print list='No demand (input trips) from this access type and market segment............... ',printo=1
              print list='\n\n',printo=1

             ENDIF

             ENDIF
            ENDJLOOP
           ENDIF

          ENDLOOP ; end market loop created for reporting purposes

       ; ###############################################################################


    ENDLOOP      ; end access loop
    ; ******************************************************************************************************************

ENDRUN

; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\MCMAT00Y.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00A.PRN" MSG='Mode Choice Reporting'
;DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F ;Does not work in matrix with arrays in matrix step
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4 ; Does not work in matrix with arrays in matrix step

FILEI MATI[13] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_0CAR.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_1CAR.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_2CAR.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_0CAR.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_1CAR.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_2CAR.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_0CAR.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_1CAR.MAT"
FILEI MATI[9] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_2CAR.MAT"
FILEI MATI[10] = "{SCENARIO_DIR}\output\@PURP@Trip.MAT"
FILEI MATI[11] = "{SCENARIO_DIR}\output\expautoutil_tmp.mat"
FILEI MATI[12] = "{SCENARIO_DIR}\output\farexfer_tmp.mat"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"

FILEO PRINTO[4] = "{SCENARIO_DIR}\output\CBDSHARES.CSV",
append=t
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\MODESHARES.CSV",
append=t
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSum.TXT",
append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebug.TXT",
append=t
FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@UTIL_{alt}{year}.MAT",
MO=401-407,421-427,441-447, DEC=21*D,
NAME=PerTrip1,AutoTrnTrip1,AutoPrice1,WalkFrac1,WalkShare1,DriveFrac1,DriveShare1,
     PerTrip2,AutoTrnTrip2,AutoPrice2,WalkFrac2,WalkShare2,DriveFrac2,DriveShare2,
     PerTrip3,AutoTrnTrip3,AutoPrice3,WalkFrac3,WalkShare3,DriveFrac3,DriveShare3
FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@_{alt}{year}.MAT",
MO=501-512,DEC=12*s,NAME=DA,SR2,SR3,WALKBUS,WALKPRJ,PNRBUS,PNRPRJ,KNRBUS,KNRPRJ,CBDKNRBUS,CBDKNRPRJ,FRGPNR

zonemsg=100

FILLMW MW[1]  =MI.1.1,2,3,4,5,6,7,8,9,10,11,12     ; can walk 0 car
FILLMW MW[21] =MI.2.1,2,3,4,5,6,7,8,9,10,11,12     ; can walk 1 car
FILLMW MW[41] =MI.3.1,2,3,4,5,6,7,8,9,10,11,12     ; can walk 2 car
FILLMW MW[61] =MI.4.1,2,3,4,5,6,7,8,9,10,11,12     ; must drive 0 car
FILLMW MW[81] =MI.5.1,2,3,4,5,6,7,8,9,10,11,12     ; must drive 1 car
FILLMW MW[101]=MI.6.1,2,3,4,5,6,7,8,9,10,11,12     ; must drive 2 car
FILLMW MW[121]=MI.7.1,2,3,4,5,6,7,8,9,10,11,12     ; no transit 0 car
FILLMW MW[141]=MI.8.1,2,3,4,5,6,7,8,9,10,11,12     ; no transit 1 car
FILLMW MW[161]=MI.9.1,2,3,4,5,6,7,8,9,10,11,12     ; no transit 2 car
FILLMW MW[201]=MI.10.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36   ; 0 car, 1 car, 2 car households
FILLMW MW[251]=MI.11.1,2,3
FILLMW MW[261]=MI.12.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18   ; fare and xfer matrix for the nine paths
FILLMW MW[281]=MI.13.@STATION_TABLE@         ; 2 tables - knr zone for knr-bus path and knr-prj paths

array _tripsDA=3, _tripsHOV2=3, _tripsHOV3=3, _tripsWalkbus=3, _tripsWalkprj=3, _tripsPNRbus=3,
      _tripsPNRprj=3, _tripsKNRbus=3, _tripsKNRprj=3, _tripsFrgPNR=3, _tripsFrgKNR=3, _tripsCBDKNRBus=3, _tripsCBDKNRPrj=3, _SUMtrips=3,
      CBDA=4,TOTACC=4

if (i=FirstZone)
  loop xx=1,3
    _tripsDA[xx]=0
    _tripsHOV2[xx]=0
    _tripsHOV3[xx]=0
    _tripsWalkBus[xx]=0
    _tripsWalkPrj[xx]=0
    _tripsPNRBus[xx]=0
    _tripsPNRPrj[xx]=0
    _tripsKNRBus[xx]=0
    _tripsKNRPrj[xx]=0
    _tripsCBDKNRBus[xx]=0
    _tripsCBDKNRPrj[xx]=0
    _tripsFrgPNR[xx]=0
    _SUMtrips[xx]=0
  endloop
endif

 ; Total person trips for each market segment
 COMP total = ROWADD(301,201,202,203,204,205,206,207,208,209,210,211,212)    ; Person trips Market Segment 1
 COMP total = ROWADD(302,213,214,215,216,217,218,219,220,221,222,223,224)    ; Person trips Market Segment 2
 COMP total = ROWADD(303,225,226,227,228,229,230,231,232,233,234,235,236)    ; Person trips Market Segment 3

 ; Person trip for assignment
 COMP total = ROWADD(501,1,21,41,61,81,101,121,141,161)              ; DA Person trips
 COMP total = ROWADD(502,2,22,42,62,82,102,122,142,162)              ; HOV2 Person trips
 COMP total = ROWADD(503,3,23,43,63,83,103,123,143,163)              ; HOV3 Person trips
 COMP total = ROWADD(504,4,24,44,64,84,104,124,144,164)              ; walk-bus Person trips
 COMP total = ROWADD(505,5,25,45,65,85,105,125,145,165)              ; walk-prj Person trips
 COMP total = ROWADD(506,6,26,46,66,86,106,126,146,166)              ; pnr-bus Person trips
 COMP total = ROWADD(507,7,27,47,67,87,107,127,147,167)              ; pnr-prj Person trips
 COMP total = ROWADD(508,8,28,48,68,88,108,128,148,168)              ; knr-bus Person trips
 COMP total = ROWADD(509,9,29,49,69,89,109,129,149,169)              ; knr-prj Person trips
 COMP total = ROWADD(510,10,30,50,70,90,110,130,150,170)             ; cbdknr-prj Person trips
 COMP total = ROWADD(511,11,31,51,71,91,111,131,151,171)             ; cbdknr-prj Person trips
 COMP total = ROWADD(512,12,32,52,72,92,112,132,152,172)             ; fringe pnr Person trips

; ********************************* BEGIN USER BENEFIT AND MODE CHOICE SUMMARY ********************************************
LOOP MARKET=1,3                    ; SUMMIT is done for each market segment separately

 if (MARKET=1) MARKET_NAME='Zero Car HHs       '
 if (MARKET=2) MARKET_NAME='One Car HHs        '
 if (MARKET=3) MARKET_NAME='Two+ Car HHs       '

 _idx1 = (200 + 12*(MARKET-1))
 _idx2 = 20*(MARKET-1)

 JLOOP
  _tripsDA[MARKET] = _tripsDA[MARKET] + MW[_idx1+1]
  _tripsHOV2[MARKET] = _tripsHOV2[MARKET] + MW[_idx1+2]
  _tripsHOV3[MARKET] = _tripsHOV3[MARKET] + MW[_idx1+3]
  _tripsWalkBus[MARKET] = _tripsWalkBus[MARKET] + MW[_idx1+4]
  _tripsWalkPrj[MARKET] = _tripsWalkPrj[MARKET] + MW[_idx1+5]
  _tripsPNRBus[MARKET] = _tripsPNRBus[MARKET] + MW[_idx1+6]
  _tripsPNRPrj[MARKET] = _tripsPNRPrj[MARKET] + MW[_idx1+7]
  _tripsKNRBus[MARKET] = _tripsKNRBus[MARKET] + MW[_idx1+8]
  _tripsKNRPrj[MARKET] = _tripsKNRPrj[MARKET] + MW[_idx1+9]
  _tripsCBDKNRBus[MARKET] = _tripsCBDKNRBus[MARKET] + MW[_idx1+10]
  _tripsCBDKNRPrj[MARKET] = _tripsCBDKNRPrj[MARKET] + MW[_idx1+11]
  _tripsFrgPNR[MARKET] = _tripsFrgPNR[MARKET] + MW[_idx1+12]

  ; For reporting access categories
  _cw1 = _cw1 + MW[_idx2+1]     ;da
  _cw2 = _cw2 + MW[_idx2+2]     ;hov2
  _cw3 = _cw3 + MW[_idx2+3]     ;hov3
  _cw4 = _cw1 + _cw2 + _cw3                          ;auto
  _cw5 = _cw5 + MW[_idx2+4]
  _cw6 = _cw6 + MW[_idx2+5]
  _cw7 = _cw7 + MW[_idx2+6]
  _cw8 = _cw8 + MW[_idx2+7]
  _cw9 = _cw9 + MW[_idx2+8]
  _cw10= _cw10+ MW[_idx2+9]
  _cw11= _cw11+ MW[_idx2+10]
  _cw12= _cw12+ MW[_idx2+11]
  _cw13= _cw5 + _cw6 + _cw7 + _cw8 + _cw9 + _cw10 + _cw11 + _cw12    ;transit
  _cw14= _cw14+ MW[_idx2+12]             ; fringe
  _cw15= _cw4+ _cw13 + _cw14                         ;total
  _md1 = _md1 + MW[_idx2+61]
  _md2 = _md2 + MW[_idx2+62]
  _md3 = _md3 + MW[_idx2+63]
  _md4 = _md1 + _md2 + _md3
  _md5 = _md5 + MW[_idx2+64]
  _md6 = _md6 + MW[_idx2+65]
  _md7 = _md7 + MW[_idx2+66]
  _md8 = _md8 + MW[_idx2+67]
  _md9 = _md9 + MW[_idx2+68]
  _md10= _md10+ MW[_idx2+69]
  _md11= _md11+ MW[_idx2+70]
  _md12= _md12+ MW[_idx2+71]
  _md13= _md5 + _md6 + _md7 + _md8 + _md9 + _md10 + _md11 + _md12
  _md14= _md14+ MW[_idx2+72]
  _md15= _md4+ _md13 + _md14
  _na1 = _na1 + MW[_idx2+121]
  _na2 = _na2 + MW[_idx2+122]
  _na3 = _na3 + MW[_idx2+123]
  _na4 = _na1 + _na2 + _na3
  _na5 = _na5 + MW[_idx2+124]
  _na6 = _na6 + MW[_idx2+125]
  _na7 = _na7 + MW[_idx2+126]
  _na8 = _na8 + MW[_idx2+127]
  _na9 = _na9 + MW[_idx2+128]
  _na10= _na10+ MW[_idx2+129]
  _na11= _na11+ MW[_idx2+130]
  _na12= _na12+ MW[_idx2+131]
  _na13= _na5 + _na6 + _na7 + _na8 + _na9 + _na10 + _na11 + _na12
  _na14= _na14+ MW[_idx2+132]
  _na15= _na4 + _na13 + _na14
  _totacc1 = _cw1 + _md1 + _na1
  _totacc2 = _cw2 + _md2 + _na2
  _totacc3 = _cw3 + _md3 + _na3
  _totacc4 = _cw4 + _md4 + _na4    ;total auto
  _totacc5 = _cw5 + _md5 + _na5      ;wb
  _totacc6 = _cw6 + _md6 + _na6      ;wp
  _totacc7 = _cw7 + _md7 + _na7      ;pb
  _totacc8 = _cw8 + _md8 + _na8      ;pp
  _totacc9 = _cw9 + _md9 + _na9      ;kb
  _totacc10 = _cw10 + _md10 + _na10  ;kp
  _totacc11 = _cw11 + _md11 + _na11  ;ckb
  _totacc12 = _cw12 + _md12 + _na12  ;ckp
  _totacc13 = _cw13 + _md13 + _na13    ;total transit
  _totacc14 = _cw14 + _md14 + _na14    ;fringe
  _totacc15 = _cw15 + _md15 + _na15    ;total trip

  ; For reporting prods/attrs
  if (ZI.1.CBD_DUMMY[i]==1)
    _cbdp1 = _cbdp1 + MW[_idx1+1]
    _cbdp2 = _cbdp2 + MW[_idx1+2]
    _cbdp3 = _cbdp3 + MW[_idx1+3]
    _cbdp4 = _cbdp1 + _cbdp2 + _cbdp3
    _cbdp5 = _cbdp5 + MW[_idx1+4]
    _cbdp6 = _cbdp6 + MW[_idx1+5]
    _cbdp7 = _cbdp7 + MW[_idx1+6]
    _cbdp8 = _cbdp8 + MW[_idx1+7]
    _cbdp9 = _cbdp9 + MW[_idx1+8]
    _cbdp10= _cbdp10+ MW[_idx1+9]
    _cbdp11= _cbdp11+ MW[_idx1+10]
    _cbdp12= _cbdp12+ MW[_idx1+11]
    _cbdp13= _cbdp5 + _cbdp6 + _cbdp7 + _cbdp8 + _cbdp9 + _cbdp10 + _cbdp11
    _cbdp14= _cbdp14+ MW[_idx1+12]
    _cbdp15= _cbdp4 + _cbdp13 + _cbdp14
  elseif (ZI.1.EXU_DUMMY[i]==1)
    _exup1 = _exup1 + MW[_idx1+1]
    _exup2 = _exup2 + MW[_idx1+2]
    _exup3 = _exup3 + MW[_idx1+3]
    _exup4 = _exup1 + _exup2 + _exup3
    _exup5 = _exup5 + MW[_idx1+4]
    _exup6 = _exup6 + MW[_idx1+5]
    _exup7 = _exup7 + MW[_idx1+6]
    _exup8 = _exup8 + MW[_idx1+7]
    _exup9 = _exup9 + MW[_idx1+8]
    _exup10= _exup10+ MW[_idx1+9]
    _exup11= _exup11+ MW[_idx1+10]
    _exup12= _exup12+ MW[_idx1+11]
    _exup13= _exup5 + _exup6 + _exup7 + _exup8 + _exup9 + _exup10 + _exup11
    _exup14= _exup14+ MW[_idx1+12]
    _exup15= _exup4 + _exup13 + _exup14
  else
    _othp1 = _othp1 + MW[_idx1+1]
    _othp2 = _othp2 + MW[_idx1+2]
    _othp3 = _othp3 + MW[_idx1+3]
    _othp4 = _othp1 + _othp2 + _othp3
    _othp5 = _othp5 + MW[_idx1+4]
    _othp6 = _othp6 + MW[_idx1+5]
    _othp7 = _othp7 + MW[_idx1+6]
    _othp8 = _othp8 + MW[_idx1+7]
    _othp9 = _othp9 + MW[_idx1+8]
    _othp10= _othp10+ MW[_idx1+9]
    _othp11= _othp11+ MW[_idx1+10]
    _othp12= _othp12+ MW[_idx1+11]
    _othp13= _othp5 + _othp6 + _othp7 + _othp8 + _othp9 + _othp10 + _othp11
    _othp14= _othp14+ MW[_idx1+12]
    _othp15= _othp4 + _othp13 + _othp14
  endif
  if (ZI.1.CBD_DUMMY[j]==1)
    _cbda1 = _cbda1 + MW[_idx1+1]
    _cbda2 = _cbda2 + MW[_idx1+2]
    _cbda3 = _cbda3 + MW[_idx1+3]
    _cbda4 = _cbda1 + _cbda2 + _cbda3
    _cbda5 = _cbda5 + MW[_idx1+4]
    _cbda6 = _cbda6 + MW[_idx1+5]
    _cbda7 = _cbda7 + MW[_idx1+6]
    _cbda8 = _cbda8 + MW[_idx1+7]
    _cbda9 = _cbda9 + MW[_idx1+8]
    _cbda10= _cbda10+ MW[_idx1+9]
    _cbda11= _cbda11+ MW[_idx1+10]
    _cbda12= _cbda12+ MW[_idx1+11]
    _cbda13= _cbda5 + _cbda6 + _cbda7 + _cbda8 + _cbda9 + _cbda10 + _cbda11
    _cbda14= _cbda14+ MW[_idx1+12]
    _cbda15= _cbda4 + _cbda13 + _cbda14
  elseif (ZI.1.EXU_DUMMY[j]==1)
    _exua1 = _exua1 + MW[_idx1+1]
    _exua2 = _exua2 + MW[_idx1+2]
    _exua3 = _exua3 + MW[_idx1+3]
    _exua4 = _exua1 + _exua2 + _exua3
    _exua5 = _exua5 + MW[_idx1+4]
    _exua6 = _exua6 + MW[_idx1+5]
    _exua7 = _exua7 + MW[_idx1+6]
    _exua8 = _exua8 + MW[_idx1+7]
    _exua9 = _exua9 + MW[_idx1+8]
    _exua10= _exua10+ MW[_idx1+9]
    _exua11= _exua11+ MW[_idx1+10]
    _exua12= _exua12+ MW[_idx1+11]
    _exua13= _exua5 + _exua6 + _exua7 + _exua8 + _exua9
    _exua14= _exua14+ MW[_idx1+12]
    _exua15= _exua4 + _exua13 + _exua14
  else
    _otha1 = _otha1 + MW[_idx1+1]
    _otha2 = _otha2 + MW[_idx1+2]
    _otha3 = _otha3 + MW[_idx1+3]
    _otha4 = _otha1 + _otha2 + _otha3
    _otha5 = _otha5 + MW[_idx1+4]
    _otha6 = _otha6 + MW[_idx1+5]
    _otha7 = _otha7 + MW[_idx1+6]
    _otha8 = _otha8 + MW[_idx1+7]
    _otha9 = _otha9 + MW[_idx1+8]
    _otha10= _otha10+ MW[_idx1+9]
    _otha11= _otha11+ MW[_idx1+10]
    _otha12= _otha12+ MW[_idx1+11]
    _otha13= _otha5 + _otha6 + _otha7 + _otha8 + _otha9 + _otha10 + _otha11
    _otha14= _otha14+ MW[_idx1+12]
    _otha15= _otha4 + _otha13 + _otha14
  endif
/*
  ; For reporting fare revenue
  _frev1 = _frev1 + ((MI.11.FareWB * MW[_idx1+4]) / 100.0)
  _frev2 = _frev2 + ((MI.11.FareWP * MW[_idx1+5]) / 100.0)
  _frev3 = _frev3 + ((MI.11.FareAB * MW[_idx1+6]) / 100.0)
  _frev4 = _frev4 + ((MI.11.FareAP * MW[_idx1+7]) / 100.0)
  _frev5 = _frev5 + ((MI.11.FareAB * MW[_idx1+8]) / 100.0)
  _frev6 = _frev6 + ((MI.11.FareAP * MW[_idx1+9]) / 100.0)
  _frev7 = _frev1 + _frev2 + _frev3 + _frev4 + _frev5 + _frev6
  _avef1 = 0
  if (_totacc5>0) _avef1 = _frev1 / _totacc5
    _avef2 = 0
  if (_totacc6>0) _avef2 = _frev2 / _totacc6
    _avef3 = 0
  if (_totacc7>0) _avef3 = _frev3 / _totacc7
    _avef4 = 0
  if (_totacc8>0) _avef4 = _frev4 / _totacc8
    _avef5 = 0
  if (_totacc9>0) _avef5 = _frev5 / _totacc9
    _avef6 = 0
  if (_totacc10>0) _avef6 = _frev6 / _totacc10
    _avef7 = 0
  if (_totacc11>0) _avef7 = _frev7 / _totacc11
*/
 if (MARKET=3)
  ; For reporting transfers
  if (MW[270]==0)                          ;walk bus
    _xfer0_1 = _xfer0_1 + MW[504]
  elseif (MW[270]==1)
    _xfer1_1 = _xfer1_1 + MW[504]
  elseif (MW[270]==2)
    _xfer2_1 = _xfer2_1 + MW[504]
  else
    _xfer3_1 = _xfer3_1+ MW[504]
  endif
  if (MW[271]==0)                          ;walk prj
    _xfer0_2 = _xfer0_2 + MW[505]
  elseif (MW[271]==1)
    _xfer1_2 = _xfer1_2 + MW[505]
  elseif (MW[271]==2)
    _xfer2_2 = _xfer2_2 + MW[505]
  else
    _xfer3_2 = _xfer3_2 + MW[505]
  endif
  if (MW[272]==0)                          ;pnr bus
    _xfer0_3 = _xfer0_3 + MW[506]
  elseif (MW[272]==1)
    _xfer1_3 = _xfer1_3 + MW[506]
  elseif (MW[272]==2)
    _xfer2_3 = _xfer2_3 + MW[506]
  else
    _xfer3_3 = _xfer3_3 + MW[506]
  endif
  if (MW[273]==0)                          ;pnr prj
    _xfer0_4 = _xfer0_4 + MW[507]
  elseif (MW[273]==1)
    _xfer1_4 = _xfer1_4 + MW[507]
  elseif (MW[273]==2)
    _xfer2_4 = _xfer2_4 + MW[507]
  else
    _xfer3_4 = _xfer3_4 + MW[507]
  endif
  if (MW[274]==0)                          ;knr bus
    _xfer0_5 = _xfer0_5 + MW[508]
  elseif (MW[274]==1)
    _xfer1_5 = _xfer1_5 + MW[508]
  elseif (MW[274]==2)
    _xfer2_5 = _xfer2_5 + MW[508]
  else
    _xfer3_5 = _xfer3_5 + MW[508]
  endif
  if (MW[275]==0)                          ;knr prj
    _xfer0_6 = _xfer0_6 + MW[509]
  elseif (MW[275]==1)
    _xfer1_6 = _xfer1_6 + MW[509]
  elseif (MW[275]==2)
    _xfer2_6 = _xfer2_6 + MW[509]
  else
    _xfer3_6 = _xfer3_6 + MW[509]
  endif
  if (MW[276]==0)                          ;cbdknr bus
    _xfer0_7 = _xfer0_7 + MW[510]
  elseif (MW[276]==1)
    _xfer1_7 = _xfer1_7 + MW[510]
  elseif (MW[276]==2)
    _xfer2_7 = _xfer2_7 + MW[510]
  else
    _xfer3_7 = _xfer3_7 + MW[510]
  endif
  if (MW[277]==0)                          ;cbdknr prj
    _xfer0_8 = _xfer0_8 + MW[511]
  elseif (MW[277]==1)
    _xfer1_8 = _xfer1_8 + MW[511]
  elseif (MW[277]==2)
    _xfer2_8 = _xfer2_8 + MW[511]
  else
    _xfer3_8 = _xfer3_8 + MW[511]
  endif
  if (MW[278]==0)                          ;frg pnr
    _xfer0_9 = _xfer0_9 + MW[512]
  elseif (MW[278]==1)
    _xfer1_9 = _xfer1_9 + MW[512]
  elseif (MW[278]==2)
    _xfer2_9 = _xfer2_9 + MW[512]
  else
    _xfer3_9 = _xfer3_9 + MW[512]
  endif

  _xfer0_10 = _xfer0_1 + _xfer0_2 + _xfer0_3 + _xfer0_4 + _xfer0_5 + _xfer0_6 + _xfer0_7 + _xfer0_8 + _xfer0_9
  _xfer1_10 = _xfer1_1 + _xfer1_2 + _xfer1_3 + _xfer1_4 + _xfer1_5 + _xfer1_6 + _xfer1_7 + _xfer1_8 + _xfer1_9
  _xfer2_10 = _xfer2_1 + _xfer2_2 + _xfer2_3 + _xfer2_4 + _xfer2_5 + _xfer2_6 + _xfer2_7 + _xfer2_8 + _xfer2_9
  _xfer3_10 = _xfer3_1 + _xfer3_2 + _xfer3_3 + _xfer3_4 + _xfer3_5 + _xfer3_6 + _xfer3_7 + _xfer3_8 + _xfer3_9

 endif

  ; User benefit calculations are done for each market segment
  ; Determine can walk & must drive percentages for matrix for Summit for each market segment (1 for auto0, 2 for auto1 and 3 for auto2)
  ; person trips
  IF ({RunUB}==1)

  T1=401+_idx2, T2=402+_idx2, T3=403+_idx2, T4=404+_idx2, T5=405+_idx2, T6=406+_idx2, T7=407+_idx2

  if (MW[300+MARKET]>0)
    MW[T1] = MW[300+MARKET]                                                                     ; person trips in market segment
    MW[T2] = MW[T1]                                                                             ; motorized trips in market segment
    MW[T3] = MW[250+MARKET]                                                                     ; expotentied auto utility
    MW[601] = MW[1+_idx2] + MW[2+_idx2] + MW[3+_idx2] + MW[4+_idx2] + MW[5+_idx2] +
              MW[6+_idx2] + MW[7+_idx2] + MW[8+_idx2] + MW[9+_idx2] + MW[10+_idx2]+
              MW[11+_idx2]+ MW[12+_idx2]                                                        ; total trips that can walk in MS
    MW[602] = MW[4+_idx2] + MW[5+_idx2] + MW[6+_idx2] + MW[7+_idx2] + MW[8+_idx2] +
              MW[9+_idx2] + MW[10+_idx2]+ MW[11+_idx2]                                          ; transit trips that can walk in MS
    MW[T4] = MW[601] / MW[T1]
    if (MW[601]>0)
        MW[T5] = MW[602] / MW[601]
    else
        MW[T5] = 0.00                                                                           ; transit share of trips that can walk
    endif

    MW[603] = MW[61+_idx2] + MW[62+_idx2] + MW[63+_idx2] + MW[64+_idx2] + MW[65+_idx2] +
              MW[66+_idx2] + MW[67+_idx2] + MW[68+_idx2] + MW[69+_idx2] + MW[70+_idx2] + MW[71+_idx2] + MW[72+_idx2]   ; total trips that must drive in MS
    MW[604] = MW[64+_idx2] + MW[65+_idx2] + MW[66+_idx2] + MW[67+_idx2] + MW[68+_idx2] +
              MW[69+_idx2] + MW[70+_idx2] + MW[71+_idx2]                                        ; transit trips that must drive in MS
    MW[T6] = MW[603] / MW[T1]                                                                   ; fraction of person trips that must drive
    if (MW[603]>0)
        MW[T7] = MW[604] / MW[603]                                                              ; transit share of trips that must drive
    else
        MW[T7] = 0.00
    endif
  else
    MW[T1] = 0.00
    MW[T2] = 0.00
    MW[T3] = 0.00
    MW[T4] = 0.00
    MW[T5] = 0.00
    MW[T6] = 0.00
    MW[T7] = 0.00
  endif

  if (I={SelOrigin} && J={SelDest})
    print list="*UB Rec* ",i(5.0),j(5.0),MARKET(5.0),mw[T1](10.1),mw[T2](10.1),mw[T3](10.7),mw[T4](10.5),mw[T5](10.5),mw[T6](10.5),mw[T7](10.5)
  endif

  ENDIF

  ; MODE CHOICE SUMMARY
  IF (i=_zones & j=_zones)

   _SUMtrips[MARKET] = _tripsDA[MARKET] + _tripsHOV2[MARKET] + _tripsHOV3[MARKET] +
                       _tripsWalkBus[MARKET] + _tripsWalkPrj[MARKET] +
                       _tripsPNRBus[MARKET] + _tripsPNRPrj[MARKET] +
                       _tripsKNRBus[MARKET] + _tripsKNRPrj[MARKET] + _tripsCBDKNRBus[MARKET] + _tripsCBDKNRPrj[MARKET] + _tripsFrgPNR[MARKET]
   ; Total trips by purpose
   if (_SUMtrips[MARKET]=0) _SUMtrips[MARKET]=1

   if (MARKET==1)
     PRINT FORM=8.OC, LIST='\f\n\n@PURP@ - @PERIOD@ MODE XCHOICE RESULTS',
     '\n**************************************************************',
     '\n','                 ','     Total','     Drive','       One','      Two+','     Total','      Walk','      Walk','       PNR','       PNR','       KNR','       KNR','    CBDKNR','    CBDKNR','     Total','    Fringe',
     '\n','MARKET SEGMENT   ','    Person','     Alone','       Pax','       Pax','      Auto','       Bus','   Project','       Bus','   Project','       Bus','   Project','       Bus','   Project','   Transit','       PNR',
     '\n','--------------   ','   -------','    ------','    ------','    ------','    ------','    ------','   -------','    ------','   -------','    ------','   -------','    ------','   -------','   -------','    ------',PRINTO=2
   endif

   _aocp = _aocp + (_tripsDA[MARKET]+_tripsHOV2[MARKET]+_tripsHOV3[MARKET])
   _aocv = _aocv + (_tripsDA[MARKET]+_tripsHOV2[MARKET]/2.0+_tripsHOV3[MARKET]/@OCC3@)

   _trntemp = (_tripsWalkBus[MARKET]+_tripsWalkPrj[MARKET]+_tripsPNRBus[MARKET]+_tripsPNRPrj[MARKET]+_tripsKNRBus[MARKET]+_tripsKNRPrj[MARKET]+_tripsCBDKNRBus[MARKET]+_tripsCBDKNRPrj[MARKET])
   _frgtemp = (_tripsFrgPNR[MARKET]+_tripsFrgKNR[MARKET])
   PRINT LIST='\n',MARKET_NAME(17),_SUMtrips[MARKET](10.1),
                   _tripsDA[MARKET](10.1),_tripsHOV2[MARKET](10.1),_tripsHOV3[MARKET](10.1),_tripsDA[MARKET]+_tripsHOV2[MARKET]+_tripsHOV3[MARKET](10.1),
                   _tripsWalkBus[MARKET](10.1),_tripsWalkPrj[MARKET](10.1),
                   _tripsPNRBus[MARKET](10.1),_tripsPNRPrj[MARKET](10.1),
                   _tripsKNRBus[MARKET](10.1),_tripsKNRPrj[MARKET](10.1),_tripsCBDKNRBus[MARKET](10.1),_tripsCBDKNRPrj[MARKET](10.1),_trntemp(10.1),
                   _tripsFrgPNR[MARKET](10.1),PRINTO=2

   if (MARKET==3)
     PRINT LIST =  '\n\n',
                   'TOTAL            ',_totacc15(10.1),_totacc1(10.1),_totacc2(10.1),_totacc3(10.1),_totacc4(10.1),_totacc5(10.1),_totacc6(10.1),
                   _totacc7(10.1),_totacc8(10.1),_totacc9(10.1),_totacc10(10.1),_totacc11(10.1),_totacc12(10.1),_totacc13(10.1),_totacc14(10.1),
                   '\n\n',
                   'Can Walk         ',_cw15(10.1),_cw1(10.1),_cw2(10.1),_cw3(10.1),_cw4(10.1),_cw5(10.1),_cw6(10.1),
                   _cw7(10.1),_cw8(10.1),_cw9(10.1),_cw10(10.1),_cw11(10.1),_cw12(10.1),_cw13(10.1),_cw14(10.1),'\n',
                   'Must Drive       ',_md15(10.1),_md1(10.1),_md2(10.1),_md3(10.1),_md4(10.1),_md5(10.1),_md6(10.1),
                   _md7(10.1),_md8(10.1),_md9(10.1),_md10(10.1),_md11(10.1),_md12(10.1),_md13(10.1),_md14(10.1),'\n',
                   'No Access        ',_na15(10.1),_na1(10.1),_na2(10.1),_na3(10.1),_na4(10.1),_na5(10.1),_na6(10.1),
                   _na7(10.1),_na8(10.1),_na9(10.1),_na10(10.1),_na11(10.1),_na12(10.1),_na13(10.1),_na14(10.1),'\n\n',
                   'TOTAL            ',_totacc15(10.1),_totacc1(10.1),_totacc2(10.1),_totacc3(10.1),_totacc4(10.1),_totacc5(10.1),_totacc6(10.1),
                   _totacc7(10.1),_totacc8(10.1),_totacc9(10.1),_totacc10(10.1),_totacc11(10.1),_totacc12(10.1),_totacc13(10.1),_totacc14(10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Productions:     ','\n',
                   'CBD              ',_cbdp15(10.1),_cbdp1(10.1),_cbdp2(10.1),_cbdp3(10.1),_cbdp4(10.1),_cbdp5(10.1),_cbdp6(10.1),
                   _cbdp7(10.1),_cbdp8(10.1),_cbdp9(10.1),_cbdp10(10.1),_cbdp11(10.1),_cbdp12(10.1),_cbdp13(10.1),_cbdp14(10.1),'\n',
                   'Exurban          ',_exup15(10.1),_exup1(10.1),_exup2(10.1),_exup3(10.1),_exup4(10.1),_exup5(10.1),_exup6(10.1),
                   _exup7(10.1),_exup8(10.1),_exup9(10.1),_exup10(10.1),_exup11(10.1),_exup12(10.1),_exup13(10.1),_exup14(10.1),'\n',
                   'Other            ',_othp15(10.1),_othp1(10.1),_othp2(10.1),_othp3(10.1),_othp4(10.1),_othp5(10.1),_othp6(10.1),
                   _othp7(10.1),_othp8(10.1),_othp9(10.1),_othp10(10.1),_othp11(10.1),_othp12(10.1),_othp13(10.1),_othp14(10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Attractions:     ','\n',
                   'CBD              ',_cbda15(10.1),_cbda1(10.1),_cbda2(10.1),_cbda3(10.1),_cbda4(10.1),_cbda5(10.1),_cbda6(10.1),
                   _cbda7(10.1),_cbda8(10.1),_cbda9(10.1),_cbda10(10.1),_cbda11(10.1),_cbda12(10.1),_cbda13(10.1),_cbda14(10.1),'\n',
                   'Exurban          ',_exua15(10.1),_exua1(10.1),_exua2(10.1),_exua3(10.1),_exua4(10.1),_exua5(10.1),_exua6(10.1),
                   _exua7(10.1),_exua8(10.1),_exua9(10.1),_exua10(10.1),_exua11(10.1),_exua12(10.1),_exua13(10.1),_exua14(10.1),'\n',
                   'Other            ',_otha15(10.1),_otha1(10.1),_otha2(10.1),_otha3(10.1),_otha4(10.1),_otha5(10.1),_otha6(10.1),
                   _otha7(10.1),_otha8(10.1),_otha9(10.1),_otha10(10.1),_otha11(10.1),_otha12(10.1),_otha13(10.1),_otha14(10.1),PRINTO=2

     CBDA[1] = CBDA[1] + _cbda5
     CBDA[2] = CBDA[2] + _cbda7
     CBDA[3] = CBDA[3] + _cbda9
     CBDA[4] = CBDA[4] + _cbda11
     TOTACC[1] = TOTACC[1] + _totacc5
     TOTACC[2] = TOTACC[2] + _totacc7
     TOTACC[3] = TOTACC[3] + _totacc9
     TOTACC[4] = TOTACC[4] + _totacc11

/*
     PRINT LIST =  '\n\n',
                   'Fare Revenue ($) '," "(50),_frev1(10.2),_frev2(10.2),_frev3(10.2),_frev4(10.2),_frev5(10.2),
                                               _frev6(10.2),_frev7(10.2)," "(10),'\n',
                   'Average Fare ($) '," "(50),_avef1(10.2),_avef2(10.2),_avef3(10.2),_avef4(10.2),_avef5(10.2),
                                               _avef6(10.2),_avef7(10.2)," "(10),PRINTO=2
*/
     PRINT LIST =  '\n\n',
                   'Transfers:       ','\n',
                   'NONE             '," "(50),_xfer0_1(10.1),_xfer0_2(10.1),_xfer0_3(10.1),_xfer0_4(10.1),_xfer0_5(10.1),
                                               _xfer0_6(10.1),_xfer0_7(10.1),_xfer0_8(10.1),_xfer0_9(10.1),_xfer0_10(10.1),'\n',
                   'ONE              '," "(50),_xfer1_1(10.1),_xfer1_2(10.1),_xfer1_3(10.1),_xfer1_4(10.1),_xfer1_5(10.1),
                                               _xfer1_6(10.1),_xfer1_7(10.1),_xfer1_8(10.1),_xfer1_9(10.1),_xfer1_10(10.1),'\n',
                   'TWO              '," "(50),_xfer2_1(10.1),_xfer2_2(10.1),_xfer2_3(10.1),_xfer2_4(10.1),_xfer2_5(10.1),
                                               _xfer2_6(10.1),_xfer2_7(10.1),_xfer2_8(10.1),_xfer2_9(10.1),_xfer2_10(10.1),'\n',
                   'THREE +          '," "(50),_xfer3_1(10.1),_xfer3_2(10.1),_xfer3_3(10.1),_xfer3_4(10.1),_xfer3_5(10.1),
                                               _xfer3_6(10.1),_xfer3_7(10.1),_xfer3_8(10.1),_xfer3_9(10.1),_xfer3_10(10.1),PRINTO=2

     PRINT LIST =  '\n\n',
                   'Average Auto Occupancy      =',_aocp/_aocv(8.3),
                   '\n\n**************************************************************',PRINTO=2
   endif

   ; OUTPUT MODEL SHARES TO A CSV FILE FOR CALIBRATION

    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+1),@PURPOSE@,MARKET,_tripsDA[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+2),@PURPOSE@,MARKET,_tripsHOV2[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+3),@PURPOSE@,MARKET,_tripsHOV3[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+4),@PURPOSE@,MARKET,_tripsWalkBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+5),@PURPOSE@,MARKET,_tripsWalkPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+6),@PURPOSE@,MARKET,_tripsPNRBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+7),@PURPOSE@,MARKET,_tripsPNRPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+8),@PURPOSE@,MARKET,_tripsKNRBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+9),@PURPOSE@,MARKET,_tripsKNRPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+10),@PURPOSE@,MARKET,_tripsCBDKNRBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+11),@PURPOSE@,MARKET,_tripsCBDKNRPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+12),@PURPOSE@,MARKET,_tripsFrgPNR[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3

  ENDIF

 ENDJLOOP


ENDLOOP

IF (I == _ZONES)
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+1),(@PURPNO@-1),(cbda[1]/totacc[1])(10.6), printo=4
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+2),(@PURPNO@-1),(cbda[2]/totacc[2])(10.6), printo=4
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+3),(@PURPNO@-1),(cbda[3]/totacc[3])(10.6), printo=4
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+4),(@PURPNO@-1),(cbda[4]/totacc[4])(10.6), printo=4
ENDIF
; ********************************* END USER BENEFIT AND MODE CHOICE SUMMARY ********************************************

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

if ({RunUB}==1)

; End of PILOT Script

; Script for program TPP2UB in file "C:\NERPM50\applications\MCTUB00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=TPP2UB PRNFILE="{SCENARIO_DIR}\output\MCMAT00F.PRN" MSG='Convert TPP matrices to Summit UB file'
FILEI VARI = "{SCENARIO_DIR}\output\@PURP@HEAD.VAR"
FILEI MATI = "{SCENARIO_DIR}\output\@PURP@UTIL_{alt}{year}.MAT"
FILEO MATO = "{SCENARIO_DIR}\output\@PURP@UTIL.UB"


ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


else
endif          ; RunUB flag
; End of PILOT Script

  ENDLOOP

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00V.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00C.PRN"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\CBDSHARES.CSV"
FILEO RECO[2] = "{SCENARIO_DIR}\output\CBDSHARES.DBF",
FORM=10.6,FIELDS=N2,HBW1,HBNW1,NHB1
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MODESHARES.CSV"
FILEO RECO[1] = "{SCENARIO_DIR}\output\MODESHARES.DBF",
FORM=10.6,FIELDS=N1,HBW,HBNW,NHB

zones=1
array Pshr=108, Pcbdshr=12

; LOOKUP for previuos run shares
LOOKUP NAME=SHARES, LOOKUP[1]=1, RESULT=4,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=1
LOOKUP NAME=CBDSHARES, LOOKUP[1]=1, RESULT=3,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=2

LOOP _ww=1,108
; records 1 through 11 are for 11 choices for HBW purpose and 0 car households, next 11 is for HBW purpose and 1 car household....
 Pshr[_ww] = SHARES(1,_ww)
ENDLOOP

LOOP _ww=1,12
; 4 cbd targets (for walk, pnr, knr cbdknr) and 3 purposes
 Pcbdshr[_ww] = CBDSHARES(1,_ww)
ENDLOOP

; print REVISED modal constants
LOOP _ww=1,36
 _idx=_idx+1
 RO.N1=_ww
 RO.HBW=Pshr[_idx]
 RO.HBNW=Pshr[_idx+36]
 RO.NHB=Pshr[_idx+72]
 WRITE RECO=1
ENDLOOP

LOOP _xx=1,4
 RO.N2=_xx
 RO.HBW1=Pcbdshr[_xx]
 RO.HBNW1=Pcbdshr[_xx+4]
 RO.NHB1=Pcbdshr[_xx+8]
 WRITE RECO=2
ENDLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

;*del {SCENARIO_DIR}\output\@PURP@UTIL_CW_0CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_CW_1CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_CW_2CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_MD_0CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_MD_1CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_MD_2CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_NT_0CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_NT_1CAR.MAT
;*del {SCENARIO_DIR}\output\@PURP@UTIL_NT_2CAR.MAT

if ({MC_Calib}>0)
; End of PILOT Script

  LOOP PURPOSE = 1, 3, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


IF (PURPOSE=1) ; HBW purpose
 PERIOD='PK'
 PURP='HBW'
 PURPNO=2
*del "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV"
*del "{SCENARIO_DIR}\output\NEW_TRNCOEFF.CSV"
ELSEIF (PURPOSE=2) ; HBO purpose
 PERIOD='OP'
 PURP='HBNW'
 PURPNO=3
ELSEIF (PURPOSE=3) ; NHB purpose
 PERIOD='OP'
 PURP='NHB'
 PURPNO=4
ENDIF

; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00U.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00A1.PRN" MSG='Calibration'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NEW_TRNCOEFF.CSV",
append=t
FILEI LOOKUPI[5] = "{SCENARIO_DIR}\output\CBDSHARES.DBF"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\CalibSum.TXT",
append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV",
append=t
FILEI LOOKUPI[4] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\MODESHARES.DBF"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\MC_TARGETS.DBF"

zones=1
numchoice=12

 ; LOOKUP for Coefficients
 LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=4
 ; Transit Coefficients
  COEFF_IVTT   = COEFF(1,1)
  COEFF_OVT    = COEFF(1,3)
  COEFF_COST   = COEFF(1,4)
  COEFF_AAT    = COEFF(1,5)
  COEFF_XFER   = COEFF(1,6)
  COEFF_DCBD   = COEFF(1,7)
  COEFF_DEXUP  = COEFF(1,8)
  COEFF_DEXUA  = COEFF(1,9)
  NC_TRNAC     = COEFF(1,10)
  NC_TRN       = COEFF(1,11)
  NC_AUTO      = COEFF(1,12)
  NC_AUTOSR    = COEFF(1,13)
  NC_FRINGE    = COEFF(1,14)
  COEFF_DCBD_WALK   = COEFF(1,15)
  COEFF_DCBD_PNR    = COEFF(1,16)
  COEFF_DCBD_KNR    = COEFF(1,17)
  COEFF_DCBD_CBDKNR = COEFF(1,18)

 ; Nesting Coefficients
  NC_DriveAlone = NC_AUTO
  NC_FringePark = NC_FRINGE
  NC_SharedRide = NC_AUTO * NC_AUTOSR
  NC_Wlk = NC_TRN * NC_TRNAC
  NC_PNR = NC_TRN * NC_TRNAC
  NC_KNR = NC_TRN * NC_TRNAC

 LOOP MARKET=1,3  ; 0 car, 1 car, 2+ car household

  ; LOOKUP for previuos run shares
  _idx=numchoice*(MARKET-1)
  LOOKUP NAME=SHARES, LOOKUP[1]=1, RESULT=@PURPNO@,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=3
  Eda=SHARES(1,_idx+1)         ; 1 - drive alone Previous share
  Ehov2=SHARES(1,_idx+2)       ; 2 - HOV2 Previous share
  Ehov3=SHARES(1,_idx+3)       ; 3 - HOV3+ Previous share
  Ewalkbus=SHARES(1,_idx+4)    ; 4 - Walk to bus Previous share
  Ewalkprj=SHARES(1,_idx+5)    ; 5 - Walk to prj Previous share
  Epnrbus=SHARES(1,_idx+6)     ; 6 - PNR to bus Previous share
  Epnrprj=SHARES(1,_idx+7)     ; 7 - PNR to prj Previous share
  Eknrbus=SHARES(1,_idx+8)     ; 8 - KNR to bus Previous share
  Eknrprj=SHARES(1,_idx+9)     ; 9 - KNR to prj Previous share
  Ecbdknrbus=SHARES(1,_idx+10)     ; 10 - KNR to bus Previous share
  Ecbdknrprj=SHARES(1,_idx+11)     ; 11 - KNR to prj Previous share
  EFringe=SHARES(1,_idx+12)    ;12 - Fringe PNR to circulator
  Eshr  = Ehov2 + Ehov3
  Eauto = Eda + Eshr
  Efrg  = EFringe
  Ewalk = Ewalkbus + Ewalkprj
  Epnr  = Epnrbus + Epnrprj
  Eknr  = Eknrbus + Eknrprj
  Ecbdknr = Ecbdknrbus + Ecbdknrprj
  Etran = Ewalk + Epnr + Eknr + Ecbdknr

  ; LOOKUP for previuos run shares of CBD targets
  _idx=numchoice*(MARKET-1)
  LOOKUP NAME=CBDSHARES, LOOKUP[1]=1, RESULT=@PURPNO@,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=5
  Ecbdwalk=CBDSHARES(1,1)
  Ecbdpnr =CBDSHARES(1,2)
  Ecbdknr2 =CBDSHARES(1,3)
  Ecbdcbdknr=CBDSHARES(1,4)

  ; LOOKUP for constants
  LOOKUP NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=2
  Kda=CONSTANTS(1,_idx+1)         ; 1 - drive alone
  Khov2=CONSTANTS(1,_idx+2)       ; 2 - HOV2
  Khov3=CONSTANTS(1,_idx+3)       ; 3 - HOV3+
  Kwalkbus=CONSTANTS(1,_idx+4)    ; 4 - Walk to bus
  Kwalkprj=CONSTANTS(1,_idx+5)    ; 5 - Walk to prj
  Kpnrbus=CONSTANTS(1,_idx+6)     ; 6 - PNR to bus
  Kpnrprj=CONSTANTS(1,_idx+7)     ; 7 - KNR to prj
  Kknrbus=CONSTANTS(1,_idx+8)     ; 8 - PNR to bus
  Kknrprj=CONSTANTS(1,_idx+9)     ; 9 - KNR to prj
  Kcbdknrbus=CONSTANTS(1,_idx+10)     ; 10 - PNR to bus
  Kcbdknrprj=CONSTANTS(1,_idx+11)     ; 11 - KNR to prj
  Kfrgpnr=CONSTANTS(1,_idx+12)    ;12 - Fringe PNR

  ; LOOKUP for targets
  LOOKUP NAME=TARG, LOOKUP[1]=1, RESULT=@PURPNO@, FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=1
  Oda=TARG(1,_idx+1)              ; 1- drive alone target
  Ohov2=TARG(1,_idx+2)            ; 2- hov2 target
  Ohov3=TARG(1,_idx+3)            ; 3- hov3 target
  Owalkbus=TARG(1,_idx+4)         ; 4- walk to bus target
  Owalkprj=TARG(1,_idx+5)         ; 5- walk to prj target
  Opnrbus=TARG(1,_idx+6)          ; 6- PNR to bus target
  Opnrprj=TARG(1,_idx+7)          ; 7- PNR to prj target
  Oknrbus=TARG(1,_idx+8)          ; 8- KNR to bus target
  Oknrprj=TARG(1,_idx+9)          ; 9- KNR to prj target
  Ocbdknrbus=TARG(1,_idx+10)          ; 10- KNR to bus target
  Ocbdknrprj=TARG(1,_idx+11)          ; 11- KNR to prj target
  OFringe=TARG(1,_idx+12)         ;12- Fringe PNR target
; targets for CBD trips
  Ocbdwalk=TARG(1,37)
  Ocbdpnr=TARG(1,38)
  Ocbdknr2=TARG(1,39)
  Ocbdcbdknr=TARG(1,40)

  Oshr  = Ohov2 + Ohov3
  Oauto = Oda + Oshr
  Ofrg  = OFringe
  Owalk = Owalkbus + Owalkprj
  Opnr  = Opnrbus + Opnrprj
  Oknr  = Oknrbus + Oknrprj
  Ocbdknr  = Ocbdknrbus + Ocbdknrprj
  Otran = Owalk + Opnr + Oknr + Ocbdknr

;**************************************************************************************************
; MODE CHOICE CALIBRATION
;**************************************************************************************************
; following symbols used in this script
; E-previous share, K-previuos constant, O-target, L-logsum, R-revised constant

  D=+1.0    ; Dampening factor
  tiny=0.0000000000001

  ; Compute deltas
  dDA = 0
  dH2 = 0
  dH3 = 0
  dWB = 0
  dWP = 0
  dPB = 0
  dPP = 0
  dKB = 0
  dKP = 0
  dCKB = 0
  dCKP = 0
  dFP = 0
  dcbdwalk=0
  dcbdpnr=0
  dcbdknr=0
  dcbdcbdknr=0

_dummy=0.000001
  if (Eda>_dummy)      dDA = LN(Eda / (Oda+tiny)) * NC_Auto
  if (Ehov2>_dummy)    dH2 = LN(Ehov2 / (Ohov2+tiny)) * NC_Auto * NC_AutoSR
  if (Ehov3>_dummy)    dH3 = LN(Ehov3 / (Ohov3+tiny)) * NC_Auto * NC_AutoSR
  if (Ewalkbus>_dummy) dWB = LN(Ewalkbus / (Owalkbus+tiny)) * NC_Trn * NC_TrnAC
  if (Ewalkprj>_dummy)
    dWP = LN(Ewalkprj / (Owalkprj+tiny)) * NC_Trn * NC_TrnAC

  else
    dWP = dWB
  endif
  if (Epnrbus>_dummy)  dPB = LN(Epnrbus  / (Opnrbus+tiny))  * NC_Trn * NC_TrnAC
  if (Epnrprj>_dummy)
    dPP = LN(Epnrprj  / (Opnrprj+tiny))  * NC_Trn * NC_TrnAC
  else
    dPP = dPB
  endif
  if (Eknrbus>_dummy)  dKB = LN(Eknrbus  / (Oknrbus+tiny))  * NC_Trn * NC_TrnAC
  if (Eknrprj>_dummy)
   dKP = LN(Eknrprj  / (Oknrprj+tiny))  * NC_Trn * NC_TrnAC
  else
   dKP = dKB
  endif
  if (Ecbdknrbus>_dummy)  dCKB = LN(Ecbdknrbus  / (Ocbdknrbus+tiny))  * NC_Trn * NC_TrnAC
  if (Ecbdknrprj>_dummy)
   dCKP = LN(Ecbdknrprj  / (Ocbdknrprj+tiny))  * NC_Trn * NC_TrnAC
  else
   dCKP = dCKB
  endif
  if (Efrg>_dummy)     dFP = LN(Efrg / (Ofrg+tiny)) * NC_Fringe

  if (Ecbdwalk>_dummy)    dcbdwalk = LN(Ecbdwalk / (Ocbdwalk+tiny)) * NC_Trn * NC_TrnAC
  if (Ecbdpnr>_dummy)     dcbdpnr = LN(Ecbdpnr / (Ocbdpnr+tiny)) * NC_Trn * NC_TrnAC
  if (Ecbdknr2>_dummy)     dcbdknr = LN(Ecbdknr2 / (Ocbdknr2+tiny)) * NC_Trn * NC_TrnAC
  if (Ecbdcbdknr>_dummy)  dcbdcbdknr = LN(Ecbdcbdknr / (Ocbdcbdknr+tiny)) * NC_Trn * NC_TrnAC

  ; Revise constants
  Rda      = Kda
  Rhov2    = Khov2    + (dDA - dH2)
  Rhov3    = Khov3    + (dDA - dH3)
  Rwalkbus = Kwalkbus + (dDA - dWB)
  Rwalkprj = Kwalkprj + (dDA - dWP)
  if (MARKET==1 & ('@PURP@'<> 'NHB'))
    Rpnrbus  = Kpnrbus
    Rpnrprj  = Kpnrprj
  else
    Rpnrbus  = Kpnrbus  + (dDA - dPB)
    Rpnrprj  = Kpnrprj  + (dDA - dPP)
  endif
  Rknrbus  = Kknrbus  + (dDA - dKB)
  Rknrprj  = Kknrprj  + (dDA - dKP)
  Rcbdknrbus  = Kcbdknrbus  + (dDA - dCKB)
  Rcbdknrprj  = Kcbdknrprj  + (dDA - dCKP)
  Rfrg     = Kfrgpnr  + (dDA - dFP)

  Rcbdwalk     = COEFF_DCBD_WALK + (dDA - dcbdwalk)
  Rcbdpnr      = COEFF_DCBD_PNR + (dDA - dcbdpnr)
  Rcbdknr      = COEFF_DCBD_KNR + (dDA - dcbdknr)
  Rcbdcbdknr   = COEFF_DCBD_CBDKNR + (dDA - dcbdcbdknr)

  if (Oda<_dummy)        Rda=-999.99
  if (Ohov2<_dummy)      Rhov2=-999.99
  if (Ohov3<_dummy)      Rhov3=-999.99
  if (Owalkbus<_dummy)   Rwalkbus=-999.99
                         Rwalkprj=Rwalkbus
  if (Opnrbus<_dummy)    Rpnrbus=-999.99
                         Rpnrprj=Rpnrbus
  if (Oknrbus<_dummy)    Rknrbus=-999.99
                         Rknrprj=Rknrbus
  if (Ocbdknrbus<_dummy) Rcbdknrbus=-999.99
                         Rcbdknrprj=Rcbdknrbus
  if (OFringe<_dummy)    Rfrg=-999.99

  if (Ocbdwalk<_dummy)   Rcbdwalk   =-999.99
  if (Ocbdpnr<_dummy)    Rcbdpnr    =-999.99
  if (Ocbdknr2<_dummy)    Rcbdknr    =-999.99
  if (Ocbdcbdknr<_dummy) Rcbdcbdknr =-999.99

  ; print calibration summary
  if (market==1) print list='\n\n\nIteration ',@AMLoop_1@(2.0),printo=2
  if (market==1) _lab='Zero Car HHs'
  if (market==2) _lab='One Car HHs '
  if (market==3) _lab='Two+ Car HHs'
  print list='\n\n','@PURP@, ',_lab(12),'\n',printo=2
  print list='Category            ','   TargShare'(12),'    EstShare'(12),'   PrevConst'(12),'      Adjust'(12),'    RevConst'(12),printo=2
  print list='--------            ','   ---------'(12),'    --------'(12),'   ---------'(12),'      ------'(12),'    --------'(12),printo=2
  print list='Drive Alone         ',Oda(12.6)      ,Eda(12.6)     ,Kda(12.6)     ,(dDA-dDA)(12.6),Rda(12.6)     ,printo=2
  print list='One Pax             ',Ohov2(12.6)    ,Ehov2(12.6)   ,Khov2(12.6)   ,(dDA-dH2)(12.6),Rhov2(12.6)   ,printo=2
  print list='Two+ Pax            ',Ohov3(12.6)    ,Ehov3(12.6)   ,Khov3(12.6)   ,(dDA-dH3)(12.6),Rhov3(12.6)   ,printo=2
  print list='Walk-Bus            ',Owalkbus(12.6) ,Ewalkbus(12.6),Kwalkbus(12.6),(dDA-dWB)(12.6),Rwalkbus(12.6),printo=2
  print list='Walk-Project        ',Owalkprj(12.6) ,Ewalkprj(12.6),Kwalkprj(12.6),(dDA-dWP)(12.6),Rwalkprj(12.6),printo=2
  print list='PNR-Bus             ',Opnrbus(12.6)  ,Epnrbus(12.6) ,Kpnrbus(12.6) ,(dDA-dPB)(12.6),Rpnrbus(12.6) ,printo=2
  print list='PNR-Project         ',Opnrprj(12.6)  ,Epnrprj(12.6) ,Kpnrprj(12.6) ,(dDA-dPP)(12.6),Rpnrprj(12.6) ,printo=2
  print list='KNR-Bus             ',Oknrbus(12.6)  ,Eknrbus(12.6) ,Kknrbus(12.6) ,(dDA-dKB)(12.6),Rknrbus(12.6) ,printo=2
  print list='KNR-Project         ',Oknrprj(12.6)  ,Eknrprj(12.6) ,Kknrprj(12.6) ,(dDA-dKP)(12.6),Rknrprj(12.6) ,printo=2
  print list='CBDKNR-Bus          ',Ocbdknrbus(12.6)  ,Ecbdknrbus(12.6) ,Kcbdknrbus(12.6) ,(dDA-dCKB)(12.6),Rcbdknrbus(12.6) ,printo=2
  print list='CBDKNR-Project      ',Ocbdknrprj(12.6)  ,Ecbdknrprj(12.6) ,Kcbdknrprj(12.6) ,(dDA-dCKP)(12.6),Rcbdknrprj(12.6) ,printo=2
  print list='Fringe PNR          ',Ofrg(12.6)     ,Efrg(12.6)     ,Kfrgpnr(12.6),(dDA-dFP)(12.6),Rfrg(12.6)     ,printo=2
  print list='Shared Ride         ',Oshr(12.6)     ,Eshr(12.6)    ,printo=2
  print list='Auto                ',Oauto(12.6)    ,Eauto(12.6)   ,printo=2
  print list='Walk                ',Owalk(12.6)    ,Ewalk(12.6)   ,' '(12),       printo=2
  print list='PNR                 ',Opnr(12.6)     ,Epnr(12.6)    ,' '(12),       printo=2
  print list='KNR                 ',Oknr(12.6)     ,Eknr(12.6)    ,' '(12),       printo=2
  print list='CBDKNR              ',Ocbdknr(12.6)  ,Ecbdknr(12.6) ,' '(12),       printo=2
  print list='Transit             ',Otran(12.6)    ,Etran(12.6)   ,' '(12),       printo=2

  ; print REVISED modal constants
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+1),Rda(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+2),Rhov2(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+3),Rhov3(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+4),Rwalkbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+5),Rwalkprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+6),Rpnrbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+7),Rpnrprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+8),Rknrbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+9),Rknrprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+10),Rcbdknrbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+11),Rcbdknrprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+12),Rfrg(12.6),PRINTO=1

ENDLOOP

  ; print REVISED modal coefficients (only CBD attraction-related ones)
  print list='CBD Attraction Coefficients',printo=2
  print list='CBD Attr Walk       ',Ocbdwalk(12.6) ,Ecbdwalk(12.6),COEFF_DCBD_WALK(12.6),(dDA-dcbdwalk)(12.6),Rcbdwalk(12.6),printo=2
  print list='CBD Attr PNR        ',OcbdPNR(12.6) ,EcbdPNR(12.6),COEFF_DCBD_PNR(12.6),(dDA-dcbdPNR)(12.6),RcbdPNR(12.6),printo=2
  print list='CBD Attr KNR        ',OcbdKNR2(12.6) ,EcbdKNR2(12.6),COEFF_DCBD_KNR(12.6),(dDA-dcbdKNR)(12.6),RcbdKNR(12.6),printo=2
  print list='CBD Attr CBD-KNR    ',OcbdcbdKNR(12.6) ,EcbdcbdKNR(12.6),COEFF_DCBD_CBDKNR(12.6),(dDA-dcbdcbdKNR)(12.6),RcbdcbdKNR(12.6),printo=2
  PRINT CSV=T, LIST=1+(18*(@PURPNO@-2)),  COEFF_IVTT(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=2+(18*(@PURPNO@-2)),  COEFF_IVTT(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=3+(18*(@PURPNO@-2)),  COEFF_OVT(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=4+(18*(@PURPNO@-2)),  COEFF_COST(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=5+(18*(@PURPNO@-2)),  COEFF_AAT(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=6+(18*(@PURPNO@-2)),  COEFF_XFER(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=7+(18*(@PURPNO@-2)),  COEFF_DCBD(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=8+(18*(@PURPNO@-2)),  COEFF_DEXUP(10.5) ,PRINTO=3
  PRINT CSV=T, LIST=9+(18*(@PURPNO@-2)),  COEFF_DEXUA(10.5) ,PRINTO=3
  PRINT CSV=T, LIST=10+(18*(@PURPNO@-2)), NC_TRNAC(10.5)    ,PRINTO=3
  PRINT CSV=T, LIST=11+(18*(@PURPNO@-2)), NC_TRN(10.5)      ,PRINTO=3
  PRINT CSV=T, LIST=12+(18*(@PURPNO@-2)), NC_AUTO(10.5)     ,PRINTO=3
  PRINT CSV=T, LIST=13+(18*(@PURPNO@-2)), NC_AUTOSR(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=14+(18*(@PURPNO@-2)), NC_FRINGE(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=15+(18*(@PURPNO@-2)), Rcbdwalk(10.5 )   ,PRINTO=3
  PRINT CSV=T, LIST=16+(18*(@PURPNO@-2)), Rcbdpnr(10.5)     ,PRINTO=3
  PRINT CSV=T, LIST=17+(18*(@PURPNO@-2)), Rcbdknr(10.5)     ,PRINTO=3
  PRINT CSV=T, LIST=18+(18*(@PURPNO@-2)), Rcbdcbdknr(10.5)  ,PRINTO=3
ENDRUN


  ENDLOOP

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00W.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00I.PRN"
FILEO RECO[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF",
FORM=10.6,FIELDS=N1,HBW,HBNW,NHB
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\NEW_TRNCOEFF.CSV"
FILEO RECO[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF",
FORM=10.6,FIELDS=N1,HBW,HBNW,NHB
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV"

zones=1
array Nconst=108, Ncoeff=54

; LOOKUP for previuos run shares
LOOKUP NAME=NewConst, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=1
LOOKUP NAME=Ncoef, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=2

LOOP _ww=1,108
; records 1 through 9 are for 9 choices for HBW purpose and 0 car households, next 9 is for HBW purpose and 1 car household....
 Nconst[_ww] = NewConst(1,_ww)
 LIST=_ww,Nconst[_ww]
ENDLOOP

LOOP _ww=1,54
 Ncoeff[_ww] = Ncoef(1,_ww)
 LIST=_ww,Ncoef[_ww]
ENDLOOP

; print REVISED modal constants
LOOP _ww=1,36
 _idx=_ww
 RO.N1=_ww
 RO.HBW=Nconst[_idx]
 RO.HBNW=Nconst[_idx+36]
 RO.NHB=Nconst[_idx+72]
 WRITE RECO=1
ENDLOOP

LOOP _ww=1,18
  RO.N1 = _ww
  RO.HBW  = Ncoeff[_ww]
  RO.HBNW = Ncoeff[_ww+18]
  RO.NHB  = Ncoeff[_ww+36]
  WRITE RECO=2
ENDLOOP

ENDRUN


RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\output\MC_CONSTANTS.DBF" "{CATALOG_DIR}\parameters\MC_CONSTANTS.DBF" '
ENDRUN

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF" "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF" '
ENDRUN

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


else ; end mode choice calibration
endif
; End of PILOT Script

ENDLOOP

; Script for program MATRIX in file "C:\NERPM50\applications\MCMAT00T.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00G.PRN" MSG='add auto-access trips to the highway table'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI MATI[4] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\AutoAcc_Hwy.MAT",
 MO=141-142, NAME=AutoAcc_SOV, AutoAcc_HOV2, DEC=2*s

FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT"

PAR ZONEMSG=100

;; in this model, KNR is assumed to be taking place at every stop
;; most of the KNR trips are not accounted for because the station data file does not contain list of all KNR stations
;; the print file gives details of the KNR trips that are not included in the auto trip table
;; however, PNR trips, fringe trips and CBDKNR trips are fully accounted for in the following script

FILLMW MW[1] =MI.1.1,2,3,4,5,6,7,8,9,10,11,12
FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12
FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12
FILLMW MW[71]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14           ; only statzone tables are needed - PK auto-bus, PK auto-prj, OP auto-bus, OP auto-prj

MW[101] = MW[6]                                                      ; peak period pnr-access vehicle trips for pnr-bus path
MW[102] = MW[7]                                                      ; peak period pnr-access vehicle trips for pnr-Prj path
MW[103] = MW[8]                                                      ; peak period knr-access vehicle trips for knr-bus path
MW[104] = MW[9]                                                      ; peak period knr-access vehicle trips for knr-Prj path
MW[105] = MW[10]                                                      ; peak period cbdknr-access vehicle trips for cbdknr-Prj path
MW[106] = MW[11]                                                      ; peak period cbdknr-access vehicle trips for cbdknr-Prj path
MW[107] = MW[12]                                                      ; peak period fringe-access vehicle trips for fringe path

MW[108] = (MW[26] + MW[46])                                          ; off-peak period pnr-access vehicle trips for pnr-bus path
MW[109] = (MW[27] + MW[47])                                          ; off-peak period pnr-access vehicle trips for pnr-prj path
MW[110] = (MW[28] + MW[48])                                          ; off-peak period knr-access vehicle trips for knr-bus path
MW[111] = (MW[29] + MW[49])                                          ; off-peak period knr-access vehicle trips for knr-prj path
MW[112] = (MW[30] + MW[50])                                          ; off-peak period cbdknr-access vehicle trips for cbdknr-prj path
MW[113] = (MW[31] + MW[51])                                          ; off-peak period cbdknr-access vehicle trips for cbdknr-prj path
MW[114] = (MW[32] + MW[52])                                          ; off-peak period fringe-access vehicle trips for fringe-prj path

JLOOP
 if (MW[101] > 0) ; PK period pnr-bus trips
  _parkingzone=MW[71][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
   MW[121][_parkingzone] = MW[121][_parkingzone] + MW[101]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 1 ',MW[101](20.10),'*************'
  endif
 endif

 if (MW[102] > 0) ; PK period pnr-prj trips
  _parkingzone=MW[75][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[122][_parkingzone] = MW[122][_parkingzone] + MW[102][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 2 ',MW[102](20.10),'*************'
  endif
 endif

 if (MW[103] > 0) ; PK period knr-bus trips
  _parkingzone=MW[72][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[123][_parkingzone] = MW[123][_parkingzone] + MW[103][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 3 ',MW[103](20.10),'*************'
  endif
 endif

 if (MW[104] > 0) ; PK period knr-prj trips
  _parkingzone=MW[76][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[124][_parkingzone] = MW[124][_parkingzone] + MW[104][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 4 ',MW[104](20.10),'*************'
  endif
 endif

 if (MW[105] > 0) ; PK period cbdknr-bus trips
  _parkingzone=MW[73][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[125][_parkingzone] = MW[125][_parkingzone] + MW[105][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 5 ',MW[105](20.10),'*************'
  endif
 endif

 if (MW[106] > 0) ; PK period cbdknr-prj trips
  _parkingzone=MW[77][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[126][_parkingzone] = MW[126][_parkingzone] + MW[106][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 6 ',MW[106](20.10),'*************'
  endif
 endif

 if (MW[107] > 0) ; PK period fringe trips
  _parkingzone=MW[74][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[127][_parkingzone] = MW[127][_parkingzone] + MW[107][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 7 ',MW[107](20.10),'*************'
  endif
 endif

 if (MW[108] > 0) ; OP period pnr-bus trips
  _parkingzone=MW[78][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
   MW[128][_parkingzone] = MW[128][_parkingzone] + MW[108]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 8 ',MW[108](20.10),'*************'
  endif
 endif

 if (MW[109] > 0) ; OP period pnr-prj trips
  _parkingzone=MW[82][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[129][_parkingzone] = MW[129][_parkingzone] + MW[109][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),' 9 ',MW[109](20.10),'*************'
  endif
 endif

 if (MW[110] > 0) ; OP period knr-bus trips
  _parkingzone=MW[79][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[130][_parkingzone] = MW[130][_parkingzone] + MW[110][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'10 ',MW[110](20.10),'*************'
  endif
 endif

 if (MW[111] > 0) ; OP period knr-prj trips
  _parkingzone=MW[83][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[131][_parkingzone] = MW[131][_parkingzone] + MW[111][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'11 ',MW[111](20.10),'*************'
  endif
 endif

 if (MW[112] > 0) ; OP period cbdknr-bus trips
  _parkingzone=MW[80][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[132][_parkingzone] = MW[132][_parkingzone] + MW[112][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'12 ',MW[112](20.10),'*************'
  endif
 endif

 if (MW[113] > 0) ; OP period cbdknr-prj trips
  _parkingzone=MW[84][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[133][_parkingzone] = MW[133][_parkingzone] + MW[113][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'13 ',MW[113](20.10),'*************'
  endif
 endif

 if (MW[114] > 0) ; OP period cbdknr-prj trips
  _parkingzone=MW[81][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[134][_parkingzone] = MW[134][_parkingzone] + MW[114][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'14 ',MW[114](20.10),'*************'
  endif
 endif

ENDJLOOP

;combine PK and OP trips to daily trips
MW[141] = (MW[121] + MW[122] + MW[127] + MW[128] + MW[129] + MW[134])/{OCCPNRAccess}   ; PNR auto access trips will be added to the SOV table
MW[142] = (MW[123] + MW[124] + MW[125] + MW[126] + MW[130] + MW[131] + MW[132] + MW[133])/{OCCKNRAccess}   ; KNR auto access trips will be added to the HOV2 table

ENDRUN


