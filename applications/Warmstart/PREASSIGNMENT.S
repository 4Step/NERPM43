; Script for program DISTRIBUTION in file "C:\NERPM43\APPLICATIONS\WARMSTART\PADST00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=DISTRIBUTION PRNFILE="{SCENARIO_DIR}\output\PREDISTRIB.PRN" MSG='pre-distribution'

FILEO MATO[5] = "{SCENARIO_DIR}\output\TripsRuralCounties.MAT",
MO=71-82,NAME=HBW_Rural,HBSH_Rural,HBSR_Rural,HBO_Rural,NHB_Rural,
               LTRK_Rural,MTRK_Rural,HTRK_Rural,SOIE_Rural,HOIE_Rural,LDIE_Rural,HDIE_Rural dec=12*s

FILEO MATO[4] = "{SCENARIO_DIR}\output\VehHoursRuralCounties.MAT",
 MO=51-62,NAME=HBW_Rural,HBSH_Rural,HBSR_Rural,HBO_Rural,NHB_Rural,
               LTRK_Rural,MTRK_Rural,HTRK_Rural,SOIE_Rural,HOIE_Rural,LDIE_Rural,HDIE_Rural dec=12*s

FILEO MATO[3] = "{SCENARIO_DIR}\output\VehHoursAllCounties.MAT",
 MO=31-42,NAME=HBW_All,HBSH_All,HBSR_All,HBO_All,NHB_All,
          LTRK_All,MTRK_All,HTRK_All,SOIE_All,HOIE_All,LDIE_All,HDIE_All dec=12*s

FILEI LOOKUPI[3] = "{CATALOG_DIR}\parameters\\FF_Rural.CSV"
FILEI MATI[1] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\SUBAREABAL.CSV"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\PANDA.DBF"

FILEO MATO[2] = "{SCENARIO_DIR}\output\VTRIP1.MAT",
 mo=6-12, name=LTRK,MTRK,HTRK,SOIE,HOIE,LDIE,HDIE, dec=7*s
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\FF.CSV"

FILEO MATO[1] = "{SCENARIO_DIR}\output\PTRIP1.MAT",
 MO=1-5,20,NAME=HBW,HBSH,HBSR,HBO,NHB,GMTIME dec=5*s

PAR MAXITERS={ATITER},MAXRMSE=2, ZONEMSG=100

    LOOKUP, LOOKUPI=1,
        INTERPOLATE=Y, NAME=FF,
        LOOKUP[1]=1,RESULT=2,
        LOOKUP[2]=1,RESULT=3,
        LOOKUP[3]=1,RESULT=4,
        LOOKUP[4]=1,RESULT=5,
        LOOKUP[5]=1,RESULT=6,
        LOOKUP[6]=1,RESULT=7,
        LOOKUP[7]=1,RESULT=8,
        LOOKUP[8]=1,RESULT=9,
        LOOKUP[9]=1,RESULT=10,
        LOOKUP[10]=1,RESULT=11,
        LOOKUP[11]=1,RESULT=12,
        LOOKUP[12]=1,RESULT=13

    LOOKUP, LOOKUPI=2,
        INTERPOLATE=N, NAME=ATRFAC,
        LOOKUP[1]=1,RESULT=3,
        LOOKUP[2]=1,RESULT=4,
        LOOKUP[3]=1,RESULT=5,
        LOOKUP[4]=1,RESULT=6,
        LOOKUP[5]=1,RESULT=7,
        LOOKUP[6]=1,RESULT=8,
        LOOKUP[7]=1,RESULT=9,
        LOOKUP[8]=1,RESULT=10,
        LOOKUP[9]=1,RESULT=11,
        LOOKUP[10]=1,RESULT=12,
        LOOKUP[11]=1,RESULT=13,
        LOOKUP[12]=1,RESULT=14

    LOOKUP, LOOKUPI=3,
        INTERPOLATE=Y, NAME=FFRural,
        LOOKUP[1]=1,RESULT=2,
        LOOKUP[2]=1,RESULT=3,
        LOOKUP[3]=1,RESULT=4,
        LOOKUP[4]=1,RESULT=5,
        LOOKUP[5]=1,RESULT=6,
        LOOKUP[6]=1,RESULT=7,
        LOOKUP[7]=1,RESULT=8,
        LOOKUP[8]=1,RESULT=9,
        LOOKUP[9]=1,RESULT=10,
        LOOKUP[10]=1,RESULT=11,
        LOOKUP[11]=1,RESULT=12,
        LOOKUP[12]=1,RESULT=13

;   ----- SETUP THE WORKING P'S AND A'S
;HBWKP,HBWKA,HBSHP,HBSHA,HBSRP,HBSRA,HBOTP,HBOTA,NHBSP,NHBSA,LTRKP,LTRKA,
;MTRKP,MTRKA,HTRKP,HTRKA,SOIEP,SOIEA,HOIEP,HOIEA,LDIEP,LDIEA,HDIEP,HDIEA

    SETPA P[1]=HBWKP  A[1]=HBWKA  *ATRFAC(1,I)  ;These factors are used for subarea balancing
    SETPA P[2]=HBSHP  A[2]=HBSHA  *ATRFAC(2,I)  ;and have been temporarily removed for
    SETPA P[3]=HBSRP  A[3]=HBSRA  *ATRFAC(3,I)  ;testing purposes.  Reintroduce these factors
    SETPA P[4]=HBOTP  A[4]=HBOTA  *ATRFAC(4,I)  ;if subarea balancing is still needed after
    SETPA P[5]=NHBSP  A[5]=NHBSA  *ATRFAC(5,I)  ;testing.
    SETPA P[6]=LTRKP  A[6]=LTRKA  *ATRFAC(6,I)
    SETPA P[7]=MTRKP  A[7]=MTRKA  *ATRFAC(7,I)
    SETPA P[8]=HTRKP  A[8]=HTRKA  *ATRFAC(8,I)
    SETPA P[9]=SOIEP  A[9]=SOIEA  *ATRFAC(9,I)
    SETPA P[10]=HOIEP A[10]=HOIEA *ATRFAC(10,I)
    SETPA P[11]=LDIEP A[11]=LDIEA *ATRFAC(11,I)
    SETPA P[12]=HDIEP A[12]=HDIEA *ATRFAC(12,I)

;   ----- DO 12 GRAVITY MODELS
;sks:    MW[20]=MI.1.TIME+MI.1.TERMINALTIME  
    MW[20]=MI.1.WtdTime+MI.1.TERMINALTIME      ; Include WtdTime in distribution, WtdTime includes toll time and cost


   MW[90]=MI.1.Distance ; Include also intrazonal distance to report trip length in miles


if (i=2401-2450 | i=2451-2549 | i=2554-2563 | i=2569-2575)             ;Baker & Putnam (Rural Co) Zones

    GRAVITY PURPOSE=1, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=2, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=3, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=4, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=5, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=6, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=7, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=8, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=9, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=10, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=11, LOS=MW[20], FFACTORS=FFRural
    GRAVITY PURPOSE=12, LOS=MW[20], FFACTORS=FFRural
else
    GRAVITY PURPOSE=1, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=2, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=3, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=4, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=5, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=6, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=7, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=8, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=9, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=10, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=11, LOS=MW[20], FFACTORS=FF
    GRAVITY PURPOSE=12, LOS=MW[20], FFACTORS=FF
endif

;All Counties (including Rural -Baker+Putnam- Counties) ...
;   ----- GENERATE FREQUENCY DISTRIBUTION REPORTS (Time in minutes)
FREQUENCY VALUEMW=1  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HBW TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=2  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HBSH TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=3  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HBSR TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=4  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HBO TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=5  BASEMW=20,  RANGE=1-100, TITLE='All Counties-NHB TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=6  BASEMW=20,  RANGE=1-100, TITLE='All Counties-LTRK TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=7  BASEMW=20,  RANGE=1-100, TITLE='All Counties-MTRK TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=8  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HTRK TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=9  BASEMW=20,  RANGE=1-100, TITLE='All Counties-SOV IE TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=10  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HOV IE TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=11  BASEMW=20,  RANGE=1-100, TITLE='All Counties-LD IE TRIP LENGTH FREQUENCY {descr}'
FREQUENCY VALUEMW=12  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HD IE TRIP LENGTH FREQUENCY {descr}'
;added by SKS (10-30-2008)
;TLFD wrt DISTANCE (DOES NOT include Terminal and toll equivalency DISTANCE, BUT INCLUDES intrazonal distance)
FREQUENCY VALUEMW=1  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HBW TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=2  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HBSH TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=3  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HBSR TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=4  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HBO TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=5  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-NHB TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=6  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-LTRK TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=7  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-MTRK TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=8  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HTRK TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=9  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-SOV IE TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=10  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HOV IE TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=11  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-LD IE TRAVEL DISTANCE FREQUENCY {descr}'
FREQUENCY VALUEMW=12  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HD IE TRAVEL DISTANCE FREQUENCY {descr}'


if (i=2401-2450 | i=2451-2549 | i=2554-2563 | i=2569-2575)             ;Baker & Putnam (Rural Co) Zones

   ;Rural (Baker & Putnam) Counties) ...
   ;   ----- GENERATE FREQUENCY DISTRIBUTION REPORTS (Time in minutes)
   FREQUENCY VALUEMW=1  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HBW TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=2  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HBSH TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=3  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HBSR TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=4  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HBO TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=5  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-NHB TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=6  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-LTRK TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=7  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-MTRK TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=8  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HTRK TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=9  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-SOV IE TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=10  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HOV IE TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=11  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-LD IE TRIP LENGTH FREQUENCY {descr}'
   FREQUENCY VALUEMW=12  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HD IE TRIP LENGTH FREQUENCY {descr}'
   ;TLFD wrt DISTANCE (DOES NOT include Terminal and toll equivalency DISTANCE, BUT INCLUDES intrazonal distance)
   FREQUENCY VALUEMW=1  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HBW TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=2  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HBSH TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=3  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HBSR TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=4  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HBO TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=5  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-NHB TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=6  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-LTRK TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=7  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-MTRK TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=8  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HTRK TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=9  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-SOV IE TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=10  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HOV IE TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=11  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-LD IE TRAVEL DISTANCE FREQUENCY {descr}'
   FREQUENCY VALUEMW=12  BASEMW=90,  RANGE=0-100-2, TITLE='Rural Counties-HD IE TRAVEL DISTANCE FREQUENCY {descr}'

endif



;IF (ITERATION=1)
;  PRINT FORM=9.0, LIST=I,ZI.1.HBWKP[I],
;        FILE = "C:\FSUTMS\DISTRICT2\NERPM\CUBE\IPFME.ROW"
;  PRINT FORM=9.0, LIST=I,ZI.1.HBWKA[I],
;        FILE = "C:\FSUTMS\DISTRICT2\NERPM\CUBE\IPFME.COL"
;  JLOOP
;      PRINT FORM=9.0, LIST=I,J,MW[2],
;        FILE = "C:\FSUTMS\DISTRICT2\NERPM\CUBE\IPFME.SED"
;  ENDJLOOP
;ENDIF

;Person/Vehicle Hours - All Counties
mw[31]=mw[1]*mw[20]/60
mw[32]=mw[2]*mw[20]/60
mw[33]=mw[3]*mw[20]/60
mw[34]=mw[4]*mw[20]/60
mw[35]=mw[5]*mw[20]/60
mw[36]=mw[6]*mw[20]/60
mw[37]=mw[7]*mw[20]/60
mw[38]=mw[8]*mw[20]/60
mw[39]=mw[9]*mw[20]/60
mw[40]=mw[10]*mw[20]/60
mw[41]=mw[11]*mw[20]/60
mw[42]=mw[12]*mw[20]/60

;Person/Vehicle Hours & Trips - Rural Counties
if (i=2401-2450 | i=2451-2549 | i=2554-2563 | i=2569-2575)             ;Baker & Putnam (Rural Co) Zones
   mw[51]=mw[1]*mw[20]/60
   mw[52]=mw[2]*mw[20]/60
   mw[53]=mw[3]*mw[20]/60
   mw[54]=mw[4]*mw[20]/60
   mw[55]=mw[5]*mw[20]/60
   mw[56]=mw[6]*mw[20]/60
   mw[57]=mw[7]*mw[20]/60
   mw[58]=mw[8]*mw[20]/60
   mw[59]=mw[9]*mw[20]/60
   mw[60]=mw[10]*mw[20]/60
   mw[61]=mw[11]*mw[20]/60
   mw[62]=mw[12]*mw[20]/60

  MW[71]=MW[1]
  MW[72]=MW[2]
  MW[73]=MW[3]
  MW[74]=MW[4]
  MW[75]=MW[5]
  MW[76]=MW[6]
  MW[77]=MW[7]
  MW[78]=MW[8]
  MW[79]=MW[9]
  MW[80]=MW[10]
  MW[81]=MW[11]
  MW[82]=MW[12]

endif

;   ----- GET A COMPARISON REPORT ON LAST ITERATION
;REPORT ACOMP=1-12 ITERATIONS=99
ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\WARMSTART\PAMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\PAMAT00A.PRN" MSG='Separate trips by purpose and auto ownership'
FILEI MATI[3] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\VTRIP1.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\input\warmstart\PTRIPS_MC2.MAT"
FILEO MATO[1] = "{Scenario_Dir}\Output\PKPRELOAD1.MAT",
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


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\WARMSTART\PAMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{Scenario_Dir}\output\PAMAT00B.PRN" MSG='Use pk-hour factors to get the peak hour trip table'
FILEI MATI[2] = "{Scenario_Dir}\output\PORT_TRK_24H_{Year}.MAT"
FILEI MATI[1] = "{Scenario_Dir}\Output\PKPRELOAD1.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PKPRELOAD.MAT",
 MO=1-8,NAME=SOV,CARPOOL,IEEITRK,EETRUCKS,EESOV,EEHOV,PRTTRK,TotAM2HR, DEC=8*S

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
prttrkfac  = 0.05431*2


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
MW[07]=MI.2.1*prttrkfac

;Total Trips
MW[8]=MW[1]+MW[2]+MW[3]+MW[4]+MW[5]+MW[6]+MW[7]


ENDRUN


; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\WARMSTART\PAHWY00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="{SCENARIO_DIR}\output\PAHWY00F.PRN" MSG='Time of day - peak hour assignment'
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED.NET"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO TURNVOLO[1] = "{SCENARIO_DIR}\output\turnvols.bin",
format=BIN
FILEI MATI[1] = "{SCENARIO_DIR}\output\PKPRELOAD.MAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PAHWY00B.PRN"
FILEI TURNPENI = "{Scenario_Dir}\input\tcards_{Year}{alt}.pen"
FILEO NETO = "{SCENARIO_DIR}\output\PKPreLoad_tem.NET"


PAR ZONEMSG=100 COMBINE=EQUI ENHANCE=2 MAXITERS={iter} RAAD=0.00000 AAD=0.000000 RMSE=0.000000 GAP=0.00025; RELATIVEGAP=0.001
;PAR ZONEMSG=100 COMBINE=EQUI MAXITERS={ITER} GAP=0.0005 RAAD=0.0000 AAD=0.00000 RMSE=0.000000
;PAR ZONEMSG=100 MAXITERS=7

TURNS N=40555,40265,40258,40241,40568

; look up deceleration rate based on approach speed
LOOKUP,
 INTERPOLATE=Y, LIST=Y, NAME=DECEL,
        LOOKUP[1]=1,RESULT=2,
R = '30 4',
    '70 6.2'

PROCESS PHASE=LINKREAD
  T0=li.TIME
;sks-Revised to 0.50 assuming more congestion in future years:  confacpk=0.582    ; using peak hour factor from HH survey - jeff
  confacpk=0.50
  LW.DISTANCE=LI.DISTANCEFT/5280
  LW.FFTIME=LI.TIME ; USE FOR PRELOAD PURPOSES (FFTIME)
  C=LI.CAPACITY*LI.NUM_LANES*LI.UROADFACTOR/confacpk

;Save 2-hour AM peak capacity
  CAPACITY_AMPK2H=C

 IF (li.FACILITY_TYPE=80-89) ADDTOGROUP=1 ; HOV FACILITIES
  IF (li.EECODE>0) ADDTOGROUP=2 ; EE PROHIBITED LINKS
;  IF (LI.{PATHGROUP}) ADDTOGROUP=7 ; DEFINE A SUBSET FOR PATHFILE
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

  PATHLOAD PATH=TIME, PENI=1, VOL[1]=MI.1.1, VOL[3]=MI.1.3, EXCLUDEGROUP=1,9                       ;IE&II- SOV(1) & TRK(3)      
  PATHLOAD PATH=TIME, PENI=1, VOL[2]=MI.1.2, EXCLUDEGROUP=9                                        ;IE&II - HOV(2)
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[4]=MI.1.4, VOL[5]=MI.1.5, VOL[7]=MI.1.7, EXCLUDEGROUP=1-2,9 ;EE -TRK(4) & SOV (5); JaxportTrk(7)
  PATHLOAD PATH=LW.FFTIME, PENI=1, VOL[6]=MI.1.6, EXCLUDEGROUP=2,9                                 ;EE - HOV(6)
 
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


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\WARMSTART\PANET00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\PANET00A.PRN" MSG='Adjust Extreme Congested Speed and Time of Peak Hour loaded network'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PKPreLoad_tem.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PKPreLoad.NET"

PROCESS PHASE=LINKMERGE

;===========================================================
;SKS-CAP Congested Speed to 2.5-75 mph and recalculate time_1 (congested time)
;Also if congested speed greater than initial speed (SPEED), then cap that to initial speed
;This changes will be required for unreasonable congested speeds for congested skims used in HBW final distribution;
;as well as to have proper transit connector speed. 

If (CSPD_1<2.5) CSPD_1=2.5
IF (CSPD_1>75.0) CSPD_1=75.0
if (!(facility_type=49,59,69))             ; exclude transit-only links
    IF (CSPD_1>SPEED) CSPD_1=SPEED
endif

time_1 = 60.0*DISTANCE/CSPD_1

;=======================================


ENDPROCESS

ENDRUN


; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\WARMSTART\PAHWY00F.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\PAHWY00A3.PRN" MSG='Develops Preload Skims'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI NETI = "{SCENARIO_DIR}\output\PKPreLoad.NET"
FILEI TURNPENI = "{SCENARIO_DIR}\input\tcards_{Year}{alt}.pen"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\TERMTIME.CSV"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT",
 MO=1-9,DEC=9*2,NAME=Toll,Distance,Time,WtdTime,HOVToll,HOVDistance,HOVTime,HOVWtdTime,TerminalTime

PAR ZONEMSG=100

; ARRAY TERMINAL TIMES INTO MEMORY
ARRAY ATYPE={ZONESA}
LOOKUP NAME=TERMTIME, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LOOKUPI=1
PROCESS PHASE=LINKREAD
  LW.TIME_1=ROUND(100*LI.TIME_1)/100
;sks - added toll time and cost to GM time
  LW.TIME=lw.time_1+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60

   LW.DISTANCE=LI.DISTANCEFT/5280 ; CONVERTS NETWORK DISTANCES (FEET) TO MILES FOR SKIM TABLES
   IF (LI.FACILITY_TYPE=80-89) ADDTOGROUP=1
   IF (LI.FACILITY_TYPE=49 | LI.FACILITY_TYPE=59 | LI.FACILITY_TYPE=69) ADDTOGROUP=9
   IF (A<={ZONESA})  ; FLAGS LAST ENCOUNTERED LINK FOR TERMINAL TIME CALCULATION LATER
        ATYPE[A]=LI.AREA_TYPE
        PRINT LIST=A,LI.AREA_TYPE
   ENDIF
ENDPROCESS

PROCESS PHASE=ILOOP
   PATHLOAD PATH=LW.TIME, PENI=1,                                ;LOV Skims 
      MW[1]=PATHTRACE(LI.CARTOLL), NOACCESS=999.99,dec=2,
      MW[2]=PATHTRACE(LW.DISTANCE), NOACCESS=999.99,dec=2,
      MW[3]=PATHTRACE(LW.TIME_1), NOACCESS=999.99,dec=3,         ;sks: use congested time (LW.TIME_1), it was Li.TIME
      MW[4]=PATHTRACE(LW.TIME), NOACCESS=999.99,dec=3,
      EXCLUDEGROUP=1,9
   PATHLOAD PATH=LW.TIME, PENI=1,                                ;HOV Skims
      MW[5]=PATHTRACE(LI.CARTOLL), NOACCESS=999.99,dec=2,
      MW[6]=PATHTRACE(LW.DISTANCE), NOACCESS=999.99,dec=2,
      MW[7]=PATHTRACE(LW.TIME_1), NOACCESS=999.99,dec=3,         ;sks: use congested time (LW.TIME_1), it was Li.TIME
      MW[8]=PATHTRACE(LW.TIME), NOACCESS=999.99,dec=3,
      EXCLUDEGROUP=9
;(precede this comment with block comment to disable) intrazonal array
deno={AVEZONE}*2.0
loop _ww=1,8
  mw[_ww][i]=lowest(_ww,{AVEZONE})/deno
endloop
; set intrazonal array to zero for cost
mw[1][i]=0
mw[5][i]=0
;(precede this comment with block comment to close disable) END DISABLE INTRAZONAL CALCULATIONS

;sks: following set of high numbers were missed in earlier skims
;set intrazonal travel times at externals to very high numbers
jloop
  if (j>={ExtZnStrt} & i=j)
    mw[3][i]=999999
    mw[4][i]=999999
    mw[7][i]=999999
    mw[8][i]=999999
 ; else
  endif
endjloop
;finish set intrazonal travel times at externals to very high numbers

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


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\WARMSTART\PNNET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\PNNET00A.PRN" MSG='Remove Transit -Only links from loaded network hor Highway Evaluation'
FILEI LINKI[1] = "{Scenario_Dir}\output\PKPreLoad.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PreAssignLOADED_HEVAL.NET"

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


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\WARMSTART\PNNET00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\PreAssignXtabsmry.PRN" MSG='Prepare for HEVAL for All Area'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PreAssignLOADED_HEVAL.NET"
FILEO PRINTO[2] = "{Scenario_Dir}\output\PreAssignPROFILE_NERPM4.TXT"
FILEO LINKO = "{Scenario_Dir}\output\PreAssignLinksCnt0.DBF",
   FORMAT=DBF,include=A,B,DISTANCE,ONE,ATYPE2,FTYPE2,
      LANES,TIME,PK2HRCAP,COUNT,SCRN,ZONE,USECODE,LOCATION,
      LANDUSE,CCODE,CGTIME,TOTAL_VOL,TOLL,TWOWAY

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

;if(LI.1.COUNTY<>6) delete       ;comment out for county specific evaluation & set county no (1=Nassau, 2=Duval,3=St Johns,
                                 ;                                                            4=Clay, 5=Baker, 6=Putnam)
;if(LI.1.FACILITY_TYPE=70-79,97-98) delete       ;comment out for RMSE without ramps                                                            4=Clay, 5=Baker, 6=Putnam)

;Delete dummy zone facility types (#29) since it will distort heval and/or crosstab stat with a speed of 1 MPH;
;Note: only valid 29 is (mayport bridge link (64273-64589 of DISTANCEFT=2010)
  IF(LI.1.Facility_Type=29) DELETE 



; DUMMY VARIABLES FOR HEVALDBF
ZONE        =1
USECODE     =1
LANDUSE     =1
CCODE       =1
DIRCODE     =1
;
   LOCATION=LI.1.COUNTY
   CGTIME=LI.1.TIME_1
   TOTAL_VOL=LI.1.V_1
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

;sks-Revised to 0.50 assuming more congestion in future years:  confacpk=0.582    ; using peak hour factor from HH survey - jeff
  confacpk=0.50

   TWOWAY=li.1.TWOWAY_{Year}{alt}
  

   PK2HRCAP=li.1.CAPACITY*LNS/CONFACPK    ; Pre-assignment  2-hour AMpeak capacity
                                          
   SCRN=sl
   cnty=LI.1.COUNTY

;void count for this 2-hour evaluation
  count=0

;
; *****************************
;
; initialize arrays and variables
;sks - for computing capacity of the network by FTG and ATG
CROSSTAB  VAR= _LANEMILES, form=14.2c, VAR= _CAPLNMILES, form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_CAPLNMILES/_LANEMILES, form=14.2


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
    


ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY
; a little loop to write out the Percent Root Mean Square Error

;----SKS (9/7/2008)---Write Profile for HEVAL-NERPM4-All Counties data 
; Preassignment Always run in Analysis mode.
;GTITLE=' - ALL SIX COUNTIES'

if ('{VALIDATE}' = 'NO')      ;Preassign HEVAL always in Analysis mode since no peak count
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\nYES",
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\nNO",
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}',"- PreAssignment HEVAL in Analysis Mode",                                                                      ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nYES",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nYES",
           PRINTO=2
endif

if ('{VALIDATE}' = 'YES')     ;Preassign HEVAL always in Analysis mode since no peak count
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\nYES",
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\nNO",
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}',"- PreAssignment HEVAL in Alalysis Mode",                                                                       ;GTITLE,
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
*copy /a {SCENARIO_DIR}\output\PreAssignPROFILE_NERPM4.TXT PROFILE.MAS
*copy /a {CATALOG_DIR}\parameters\HESCREEN.SYN HESCREEN.SYN
*copy /a {CATALOG_DIR}\parameters\HELABELS.SYN HELABELS.SYN
*copy /a {CATALOG_DIR}\parameters\HERATES.SYN HERATES.SYN
*copy /a {CATALOG_DIR}\parameters\DATABASE_PK2HR.CTL DATABASE.CTL
*copy /b "{SCENARIO_DIR}\output\PreAssignLinksCnt0.DBF" LnksCnt.DBF

*REM -- Clean the Cube Folder of HEVAL/RMSE outputs from any previous run (if any)...
*if exist HEVAL.OUT del HEVAL.OUT
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC.ASC del HRLDXY2.ASC

*REM -- Run HEVAL/RMSE Routines...
*{CATALOG_DIR}\User.prg\hevaldbf.exe >{SCENARIO_DIR}\output\hevaldbf.LOG

*REM -- Save HEVAL/RMSE outputs from Cube folder to user's output folder...
*if exist HEVAL.OUT copy /a heval.out {SCENARIO_DIR}\output\PreAssignheval-NERPM4.out
*if exist SCRNLINE.ASC copy /a SCRNLINE.ASC {SCENARIO_DIR}\output\PreAssignSCRNLINE-NERPM4.out
*if exist HRLDXY.ASC copy /a HRLDXY.ASC {SCENARIO_DIR}\output\PreAssignHRLDXY-NERPM4.ASC
*if exist HRLDXY2.ASC copy /a HRLDXY2.ASC {SCENARIO_DIR}\output\PreAssignHRLDXY2-NERPM4.ASC

*REM -- Delete HEVAL outputs from Cube folder...
*if exist HEVAL.OUT del heval.out
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC del HRLDXY2.ASC

*REM -- Clean Cube folder of HEVAL routine Inputs...
*if exist PROFILE.MAS del PROFILE.MAS
*if exist HESCREEN.SYN del HESCREEN.SYN
*if exist HELABELS.SYN del HELABELS.SYN
*if exist HERATES.SYN del HERATES.SYN
*if exist DATABASE.CTL del DATABASE.CTL
*if exist LnksCnt.DBF del LnksCnt.DBF

; End of PILOT Script

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"C:\NERPM43\APPLICATIONS\WARMSTART\PreAssignheval-NERPM4.out" "{Scenario_Dir}\output\PreAssignHEVAL.PRN" '
ENDRUN

