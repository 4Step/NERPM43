; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\Output\@PURP@@PERIOD@_Apply_MC.PRN" MSG='Apply MC probabilities to NHBW & NHBO person trips'
FILEO RECO[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCRPT_TMP.DBF",
  FIELDS=MARKET(1.0),ACCESS(1.0),DA(10.0),SR2(10.0),SR3(10.0),WLKLOC(10.0),WLKPRJ(10.0),
  PNRLOC(10.0),PRNPRJ(10.0),KNRLOC(10.0),KNRPRJ(10.0),WALK(10.0),BIKE(10.0),TOTAL(10.0)
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCRPT.TXT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCDEBUG.TXT"
FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@_@PERIOD@_{ALT}{Year}.MAT",
  MO=202,212,222,232,242,252,262,272,282,292,302,
  NAME=DA,SR2,SR3,WLKLOC,WLKPRJ,PNRLOC,PRNPRJ,KNRLOC,KNRPRJ,WALK,BIKE,
  DEC=11*S
FILEI MATI[9] = "{SCENARIO_DIR}\OUTPUT\MMLOO_@PERIOD@SKIM.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCPRB1.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_PERTRIPS_{ALT}{Year}.MAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\OUTPUT\TAZDATA_{ALT}{Year}.DBF"

PAR ZONEMSG=10

ARRAY TYPE=D TRIPS=8,3,12


; READ IN PERSON TRIP TABLES
; for NHB trip purposes
FILLMW MW[1] = MI.1.1


; COMPUTE THE SHARE OF EACH TRANSIT ACCESS MARKET
MW[11] = 1.0 * (ZI.1.PCWPRD@PERIOD@[I]/100) * (ZI.1.PCWATT@PERIOD@[J]/100)           ; Can Walk trips
MW[12] = 1.0 * (1 - (ZI.1.PCWPRD@PERIOD@[I]/100)) * (ZI.1.PCWATT@PERIOD@[J]/100)     ; Must Drive trips
MW[13] = 1.0 - MW[11] - MW[12]                                                       ; No Transit trips


; TO APPLY THE MODE CHOICE PROBABILITIES TO THE PERSON TRIPS, WE NEED TO APPLY THE PROBS.
; FOR EACH MARKET SEGMENT, TRANSIT ACCESS AND MODE TO THE APPROPRIATE FRACTION OF OD TRIPS,
; THEN ACCUMULATE TRIPS BY MARKET SEGMENT, TRANSIT ACCESS AND MODE AND OUTPUT TOTAL TRIPS BY MODE

; FIRST THE HOUSEHOLD SEGMENT LOOP

;IF(I == 20) EXIT                    ; temp, for debugging

LOOP _m = 1, @MARKETS@

; READ IN MODE CHOICE PROBABILITIES FOR EACH HOUSEHOLD MARKET
;     Tables 1-11:   CW
;     Tables 12-22:  MD
;     Tables 23-33:  NT

IF(_m == 1)  FILLMW MW[101]=MI.2.1(33)


; THEN LOOP OVER TRANSIT WALK ACCESS MARKETS

 LOOP _acc=1,3

  MW[10] = MW[_acc+10]                                  ; set the transit walk market shares

 
;  THEN LOOP OVER THE MODES
;  DA,SR2,SR3,WALKBUS,WALKPRJ,PNRBUS,PNRPRJ,KNRBUS,KNRPRJ,WALK,BIKE 

  LOOP _mode=1,11

   ; mc probability matrix index for this mode, access, hhld mkt
    _mcprbtab = 100 + _mode + (_acc - 1)*11

    ;  Compute trips X probs as:  prb(mode,acc,hhld) * accShare * perTrips(hhld)
  ;  Then keep total trips by mode and hhld mkt for each OD

      MW[200+_m+(_mode-1)*10] = MW[200+_m+(_mode-1)*10] + (MW[_mcprbtab] * MW[10] * MW[_m])  
    
  ;  Total for all hhld mkts
      MW[200+@MARKETS@+1+(_mode-1)*10] = MW[200+@MARKETS@+1+(_mode-1)*10] + (MW[_mcprbtab] * MW[10] * MW[_m])

  ; Accumumate Trips in Array By Mode, Transit Access and Household Market Segment  
   MW[400]                         = (MW[_mcprbtab] * MW[10] * MW[_m])
   TRIPS[_m][_acc][_mode]          = TRIPS[_m][_acc][_mode]          + ROWSUM(400)
   TRIPS[@MARKETS@+1][_acc][_mode] = TRIPS[@MARKETS@+1][_acc][_mode] + ROWSUM(400)
   TRIPS[@MARKETS@+1][_acc][12]    = TRIPS[@MARKETS@+1][_acc][12]    + ROWSUM(400)
   TRIPS[_m][_acc][12]             = TRIPS[_m][_acc][12]             + ROWSUM(400)
   
   
IF (I==ZONES)
  
 IF ((_m = 1) & (_acc=1) & (_mode=1))  

   PRINT LIST='MODE CHOICE SUMMARY','\n', PRINTO=2
   PRINT LIST='DATE:  @DATE.RUNDATE@     ', PRINTO=2
   PRINT LIST='TIME:  @TIME.RUNTIME@     ','\n\n', PRINTO=2
   PRINT LIST='                             HOUSEHOLD MARKETS                                      TRANSIT ACCESS  ',PRINTO=2
   PRINT LIST='-----------------------------------------------------------------------------      ---------------- ',PRINTO=2
   PRINT LIST='   All HB purposes except HBCU and HBSC      HBCU and HBSC      NHBW and NHBO        All Purposes   ',PRINTO=2
   PRINT LIST='-----------------------------------------------------------------------------      ---------------- ',PRINTO=2
   PRINT LIST=' 1) Zero-car households                     1) 1-Person hhld    1) All hhlds         1) Can-Walk    ',PRINTO=2
   PRINT LIST=' 2) Low income, car insufficient hhlds      2) 2-Person hhld                         2) Must-Drive  ',PRINTO=2
   PRINT LIST=' 3) Medium income, car insufficient hhlds   3) 3-Person hhld                         3) No-Transit  ',PRINTO=2
   PRINT LIST=' 4) High income, car insufficient hhlds     4) 4-Person+ hhld                                       ',PRINTO=2
   PRINT LIST=' 5) Low income, car sufficient hhlds                                                                ',PRINTO=2
   PRINT LIST=' 6) Medium income, car sufficient hhlds                                                             ',PRINTO=2
   PRINT LIST=' 7) High income, car sufficient hhlds                                                               ',PRINTO=2
   PRINT LIST='-----------------------------------------------------------------------------      ---------------- ',PRINTO=2

   PRINT LIST='     ','\n\n', PRINTO=2
   PRINT LIST='PURPOSE:  @PURP@ @PERIOD@  ', PRINTO=2
   PRINT LIST='\n\nTOTAL TRIPS BY MODE AND HOUSEHOLD MARKET', PRINTO=2
   PRINT LIST='---------------------------------------------------------------------------------------------------------------------------------------', PRINTO=2
   PRINT LIST='MARKET  TRN-ACC    DA       SR2      SR3+      WLKLOC    WLKPRJ    PNRLOC   PNRPRJ   KNRLOC    KNRPRJ      WALK      BIKE     TOTAL', PRINTO=2
   PRINT LIST='---------------------------------------------------------------------------------------------------------------------------------------', PRINTO=2
   ENDIF
   
   IF (_mode=11)
   
   ; WRITE OUT TRIPS BY MODE, TRANSIT ACCESS AND HOUSEHOLD MARKET SEGMENT
   IF (_acc=1) 
   PRINT LIST = _m(1.0),_acc(10.0),
                TRIPS[_m][_acc][1](10.0),TRIPS[_m][_acc][2](10.0),TRIPS[_m][_acc][3](10.0),
                TRIPS[_m][_acc][4](10.0),TRIPS[_m][_acc][5](10.0),TRIPS[_m][_acc][6](10.0),
                TRIPS[_m][_acc][7](10.0),TRIPS[_m][_acc][8](10.0),TRIPS[_m][_acc][9](10.0),
                TRIPS[_m][_acc][10](10.0),TRIPS[_m][_acc][11](10.0),TRIPS[_m][_acc][12](10.0), PRINTO=2
   ENDIF ; (_acc=1)
   
   IF (_acc=2) 
   PRINT LIST = _m(1.0),_acc(10.0),
                TRIPS[_m][_acc][1](10.0),TRIPS[_m][_acc][2](10.0),TRIPS[_m][_acc][3](10.0),
                TRIPS[_m][_acc][4](10.0),TRIPS[_m][_acc][5](10.0),TRIPS[_m][_acc][6](10.0),
                TRIPS[_m][_acc][7](10.0),TRIPS[_m][_acc][8](10.0),TRIPS[_m][_acc][9](10.0),
                TRIPS[_m][_acc][10](10.0),TRIPS[_m][_acc][11](10.0),TRIPS[_m][_acc][12](10.0), PRINTO=2
   ENDIF ; (_acc=2)
   
   IF (_acc=3) 
   PRINT LIST = _m(1.0),_acc(10.0),
                TRIPS[_m][_acc][1](10.0),TRIPS[_m][_acc][2](10.0),TRIPS[_m][_acc][3](10.0),
                TRIPS[_m][_acc][4](10.0),TRIPS[_m][_acc][5](10.0),TRIPS[_m][_acc][6](10.0),
                TRIPS[_m][_acc][7](10.0),TRIPS[_m][_acc][8](10.0),TRIPS[_m][_acc][9](10.0),
                TRIPS[_m][_acc][10](10.0),TRIPS[_m][_acc][11](10.0),TRIPS[_m][_acc][12](10.0), PRINTO=2
   ENDIF  ; (_acc=3)
   
   ENDIF   ;(_mode=11)
                 
   ENDIF  ;(I=LASTZONE) 
  
   
  ; Now debugging
  
  IF({DebugMC} > 0 && I =={SelOrigin})

    PRINT LIST = "TRIP CALCULATIONS DEBUG REPORT", PRINTO=1
   JLOOP
    PRINT LIST = "IZONE=", I(5),"  JZONE=",J(5), "  MKT=",_m(1),"  PERTRIPS=", MW[_m](10.4),
                 "  ACCMKT=", _acc(1), "  ACCSHARE=", MW[10](5.2), 
                 "  MODE=", _mode(2),"  PRB=", MW[_mcprbtab](10.4), PRINTO=1
   ENDJLOOP

  ENDIF
  
  ENDLOOP   ; end mode loop
  
 ENDLOOP  ; end transit access loop

ENDLOOP  ; end hhld market loop


; MC REPORT

IF(I==ZONES)

LOOP _m = 1, @MARKETS@  
  LOOP _acc=1,3
    TOT_DA     = TOT_DA     + TRIPS[_m][_acc][1]
    TOT_SR2    = TOT_SR2    + TRIPS[_m][_acc][2]
    TOT_SR3    = TOT_SR3    + TRIPS[_m][_acc][3]
    TOT_WLKLOC = TOT_WLKLOC + TRIPS[_m][_acc][4]
    TOT_WLKPRJ = TOT_WLKPRJ + TRIPS[_m][_acc][5]
    TOT_PNRLOC = TOT_PNRLOC + TRIPS[_m][_acc][6]
    TOT_PNRPRJ = TOT_PNRPRJ + TRIPS[_m][_acc][7]
    TOT_KNRLOC = TOT_KNRLOC + TRIPS[_m][_acc][8]
    TOT_KNRPRJ = TOT_KNRPRJ + TRIPS[_m][_acc][9]
    TOT_WALK   = TOT_WALK   + TRIPS[_m][_acc][10]
    TOT_BIKE   = TOT_BIKE   + TRIPS[_m][_acc][11]
    TOT_ALL    = TOT_ALL    + TRIPS[_m][_acc][12]
    
    RO.MARKET = _m
    RO.ACCESS = _acc
    RO.DA     = TRIPS[_m][_acc][1]
    RO.SR2    = TRIPS[_m][_acc][2]
    RO.SR3    = TRIPS[_m][_acc][3]
    RO.WLKLOC = TRIPS[_m][_acc][4]
    RO.WLKPRJ = TRIPS[_m][_acc][5]
    RO.PNRLOC = TRIPS[_m][_acc][6]
    RO.PRNPRJ = TRIPS[_m][_acc][7]
    RO.KNRLOC = TRIPS[_m][_acc][8]
    RO.KNRPRJ = TRIPS[_m][_acc][9]
    RO.WALK   = TRIPS[_m][_acc][10]
    RO.BIKE   = TRIPS[_m][_acc][11]
    RO.TOTAL  = TRIPS[_m][_acc][12]    
    WRITE RECO=1 
  ENDLOOP
ENDLOOP 

PRINT LIST='-----------------------------------------------------------------------------------------------------------------------------------', PRINTO=2
PRINT LIST = 'TOTAL','     -',TOT_DA(10.0),TOT_SR2(10.0),TOT_SR3(10.0),TOT_WLKLOC(10.0),
             TOT_WLKPRJ(10.0),TOT_PNRLOC(10.0),TOT_PNRPRJ(10.0),TOT_KNRLOC(10.0),
             TOT_KNRPRJ(10.0),TOT_WALK(10.0),TOT_BIKE(10.0),TOT_ALL(10.0), PRINTO=2
PRINT LIST='-----------------------------------------------------------------------------------------------------------------------------------', PRINTO=2                               



ENDIF


; Drive Alone and Shared-Ride Trip Length Frequency Reports
MW[501]=MW[202]
MW[502]=MW[212]+MW[222]
MW[520]=MI.9.STIME+MI.9.STERMINALTIME
MW[521]=MI.9.HTIME+MI.9.STERMINALTIME

FREQUENCY BASEMW=520,VALUEMW=501,RANGE=1-100,TITLE='@PURP@ @PERIOD@ DA Trip Length Frequency {descr}'
FREQUENCY BASEMW=521,VALUEMW=502,RANGE=1-100,TITLE='@PURP@ @PERIOD@ SR Trip Length Frequency {descr}'

ENDRUN
