; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=DISTRIBUTION PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\FINAL DTB.PRN" MSG='Perform a Final HBW Distribution'
FILEO MATO[2] = "C:\NERPM43\APPLICATIONS\WARMSTART\CGHBWPrsnHoursAndTrips.MAT",
  MO=31,1,51,71, NAME=HBW_All_PrsnHrs,HBW_All_Trps,HBW_Rural_PrsnHrs,HBW_Rural_Trps, dec=4*S
FILEI LOOKUPI[3] = "C:\NERPM43\APPLICATIONS\WARMSTART\FF_Rural.CSV"
FILEI LOOKUPI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\FF.CSV"
FILEI MATI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\PRELSKIMS.MAT"
FILEO MATO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\CGHBW.MAT",
 MO=1,NAME=HBW, dec=1*s

PAR MAXITERS={ATITER},MAXRMSE=2, ZONEMSG=100

    LOOKUP, LOOKUPI=1,
        INTERPOLATE=Y, NAME=FF,
        LOOKUP[1]=1,RESULT=2

    LOOKUP, LOOKUPI=2,
        INTERPOLATE=N, NAME=ATRFAC,
        LOOKUP[1]=1,RESULT=3

    LOOKUP, LOOKUPI=3,
        INTERPOLATE=Y, NAME=FFRural,
        LOOKUP[1]=1,RESULT=2

;   ----- SETUP THE WORKING P AND A
    SETPA P[1]=HBWKP  A[1]=HBWKA*ATRFAC(1,I)  ;Subarea balancing factor removed for testing.

;   ----- GET THE LOS MATRIX INTO WORK MATRIX 20
;sks:    MW[20] = MI.1.TIME+MI.1.TERMINALTIME
   MW[20] = MI.1.TIME+MI.1.TERMINALTIME      ;Include WtdTime in distribution, WtdTime includes toll time and cost
   MW[90]=MI.1.Distance ; Include also intrazonal distance to report trip length in miles

;   ----- DO GRAVITY MODELS
if (i=2401-2450 | i=2451-2549 | i=2554-2563 | i=2569-2575)             ;Baker & Putnam (Rural Co) Zones
    GRAVITY PURPOSE=1, LOS=MW[20], FFACTORS=FFRural
 else
    GRAVITY PURPOSE=1, LOS=MW[20], FFACTORS=FF
endif



;All Counties (including Rural -Baker+Putnam- Counties) ...
;   ----- GENERATE FREQUENCY DISTRIBUTION REPORTS Time in minutes)
FREQUENCY VALUEMW=1  BASEMW=20,  RANGE=1-100, TITLE='All Counties-HBW CG TRIP LENGTH FREQUENCY {descr}'
;   ----- GET A COMPARISON REPORT ON LAST ITERATION
REPORT ACOMP=1 ITERATIONS=99
;TLFD wrt DISTANCE (DOES NOT include Terminal and toll equivalency DISTANCE, BUT INCLUDES intrazonal distance)
FREQUENCY VALUEMW=1  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HBW TRAVEL DISTANCE FREQUENCY {descr}'


if (i=2401-2450 | i=2451-2549 | i=2554-2563 | i=2569-2575)             ;Baker & Putnam (Rural Co) Zones
   ;Rural (Baker & Putnam) Counties) ...
   ;   ----- GENERATE FREQUENCY DISTRIBUTION REPORTS (Time in minutes)
   FREQUENCY VALUEMW=1  BASEMW=20,  RANGE=1-100, TITLE='Rural Counties-HBW CG TRIP LENGTH FREQUENCY {descr}'
   ;TLFD wrt DISTANCE (DOES NOT include Terminal and toll equivalency DISTANCE, BUT INCLUDES intrazonal distance)
   FREQUENCY VALUEMW=1  BASEMW=90,  RANGE=0-100-2, TITLE='All Counties-HBW TRAVEL DISTANCE FREQUENCY {descr}'
endif


;Person/Vehicle Hours - All Counties
    MW[31]=MW[1]*MW[20]/60

;Person/Vehicle Hours & Trips - Rural Counties
if (i=2401-2450 | i=2451-2549 | i=2554-2563 | i=2569-2575)             ;Baker & Putnam (Rural Co) Zones
   mw[51]=mw[1]*mw[20]/60
   MW[71]=MW[1]
endif


ENDRUN
