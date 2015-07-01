; PILOT Script


DistributeMultiStep ProcessID="TMUDemoDist", ProcessNum=1
; End of PILOT Script

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\OUTPUT\PRELSKIMS.MAT" "{SCENARIO_DIR}\OUTPUT\MMLOO_PKSKIM.MAT" '
ENDRUN

RUN PGM="C:\Program Files (x86)\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\OUTPUT\PRELSKIMS.MAT" "{SCENARIO_DIR}\OUTPUT\MMLOO_OPSKIM.MAT" '
ENDRUN

; PILOT Script

EndDistributeMultiStep

DistributeMultiStep ProcessID="TMUDemoDist", ProcessNum=2
; End of PILOT Script

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

EndDistributeMultiStep

Wait4Files Files=TMUDemoDist1.script.end, TMUDemoDist2.script.end, PrintFiles=SAVE
; End of PILOT Script

LOOP PURPOSE = 6, 12, 1

; PILOT Script

IF (PURPOSE=1) ; HBW PK
PURP='HBW'
PERIOD='PK'
PURPNO=1
MARKETS=5
isHBW=' '
noHBW=';'
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 1 of 16 HBW PK", printo=0

ELSEIF (PURPOSE=2) ; NHBW PK 
PURP='NHBW'
PERIOD='PK'
PURPNO=2
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number = 2 of 16 NHBW PK", printo=0

ELSEIF (PURPOSE=3) ; HBSH PK 
PURP='HBSH'
PERIOD='PK'
PURPNO=3
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 3 of 16 HBSH PK", printo=0

ELSEIF (PURPOSE=4) ; HBSR PK  
PURP='HBSR'
PERIOD='PK'
PURPNO=4
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 4 of 16 HBSR PK", printo=0

ELSEIF (PURPOSE=5) ; HBO PK 
PURP='HBO'
PERIOD='PK'
PURPNO=5
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 5 of 16 HBO PK", printo=0

ELSEIF (PURPOSE=6) ; NHB PK
PURP='NHBO'
PERIOD='PK'
PURPNO=6
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number = 6 of 16 NHBO PK", printo=0

ELSEIF (PURPOSE=7) ; HBW OP 
PURP='HBW'
PERIOD='OP'
PURPNO=7
MARKETS=5
isHBW=' '
noHBW=';'
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 7 of 16 HBW OP", printo=0

ELSEIF (PURPOSE=8) ; NHBW OP 
PURP='NHBW'
PERIOD='OP'
PURPNO=8
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number = 8 of 16 NHBW OP", printo=0

ELSEIF (PURPOSE=9) ; HBSH OP  
PURP='HBSH'
PERIOD='OP'
PURPNO=9
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 9 of 16 HBSH OP", printo=0

ELSEIF (PURPOSE=10) ; HBSR OP  
PURP='HBSR'
PERIOD='OP'
PURPNO=10
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number =10 of 16 HBSR OP", printo=0

ELSEIF (PURPOSE=11) ; HBO OP  
PURP='HBO'
PERIOD='OP'
PURPNO=11
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number =11 of 16 HBO OP", printo=0

ELSEIF (PURPOSE=12) ; NHB OP
PURP='NHBO'
PERIOD='OP'
PURPNO=12
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number =12 of 16 NHBO OP", printo=0

ENDIF
; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DCMODEL\TDMAT00O.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\OUTPUT\tripDist.PRN" MSG='Apply Destination Choice Model'
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\OUTPUT\PANDA_{ALT}{Year}_@PERIOD@.DBF"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\PARAMETERS\DESTCHOICE_PARAMETERS.DBF"
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCLS_{ALT}{Year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\OUTPUT\MMLOO_@PERIOD@SKIM.MAT"

FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_PERTRIPS_{ALT}{Year}.MAT",
  MO=131-136, DEC=6*S, NAME=PTRIPS1,PTRIPS2,PTRIPS3,PTRIPS4,PTRIPS5,TOTAL
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\DESTCHOICE_DEBUG.TXT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\DESTCHOICE_SUMMARY.TXT"
FILEO PRINTO[3] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_Zonal_Trips.csv"


ZONES = {zonesa}

ARRAY TYPE=D CDIST1=7, CDIST2=7 CDIST3=7, CIZ=7
ARRAY TYPE=D PRODS=7,ZONES
ARRAY TYPE=D ATTS=7,ZONES
ARRAY TYPE=D DENOM=7


; READ IN MODEL PARAMETERS

LOOKUP, NAME=COEFF, LOOKUP[1]=NVAR, RESULT=@PURP@@PERIOD@, INTERPOLATE=N, LIST=Y, LOOKUPI=1
;LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=HBWPK, INTERPOLATE=N, LIST=Y, LOOKUPI=1

DISTCAP = COEFF(1,1)
CLSUM   = COEFF(1,2)
ADJCAP = COEFF(1,3)                  ; adjustment cap
ADJDIST = COEFF(1,16)
ADJDISTSQ = COEFF(1,26)
ADJDISTCUB = COEFF(1,36)

LOOP _mm = 1,@MARKETS@

CDIST1[_mm] = COEFF(1,10+_mm)
CDIST2[_mm] = COEFF(1,20+_mm)
CDIST3[_mm] = COEFF(1,30+_mm)
CIZ[_mm]    = COEFF(1,40+_mm)

ENDLOOP

; Report coefficient values to summary file and debug file;

IF (I == 1)
    
; Debug destination choice

    IF ({DebugDC}>0)
    
  print list='DESTINTION CHOICE TRACE @PURP@-@PERIOD@','\n\n',printo=1
  print list='-- @DATE.RUNDATE@     ',printo=1
  print list='-- @TIME.RUNTIME@     ','\n\n',printo=1
  print list='Transit Modeling Update DEMO \n\nSelected Interchange for Tracing:    ',{SelOrigin}(4.0),'-',{SelDest}(4.0),'\n\n',printo=1
  print list='PURPOSE -                   @PURP@  ',printo=1
  print list='SKIMS/PERIOD                @PERIOD@',printo=1
   
  print list='\n\nCOEFFICIENTS                ',printo=1
  print list='    Mode choice logsum LSUM     ',CLSUM(8.4),printo=1
  print list='    Distance cap DISTCAP        ',DISTCAP(8.4),printo=1
   
  LOOP _m=1,@MARKETS@
  print list='\n\n    Linear Distance CDIST(',_m(1),')    ',CDIST1[_m](8.4),printo=1
  print list='    Squared Distance CDIST2(',_m(1),')  ',CDIST2[_m](8.4),printo=1
  print list='    Cubed Distance CDIST3(',_m(1),')    ',CDIST3[_m](8.4),printo=1
  print list='    Intrazonal indicator CIZ(',_m(1),') ',CIZ[_m](8.4),printo=1
  ENDLOOP
   
  ENDIF

; Summary report file

  print list='DESTINTION CHOICE TRACE @PURP@-@PERIOD@','\n\n',printo=2
  print list='-- @DATE.RUNDATE@     ',printo=2
  print list='-- @TIME.RUNTIME@     ','\n\n',printo=2
  print list='Transit Modeling Update DEMO \n\nSelected Interchange for Tracing:    ',{SelOrigin}(4.0),'-',{SelDest}(4.0),'\n\n',printo=2
  print list='PURPOSE -                   @PURP@  ',printo=2
  print list='SKIMS/PERIOD                @PERIOD@',printo=2
   
  print list='\n\nCOEFFICIENTS                ',printo=2
  print list='    Mode choice logsum LSUM     ',CLSUM(8.4),printo=2
  print list='    Distance cap DISTCAP        ',DISTCAP(8.4),printo=2
  print list='    Adjusted cap DISTCAP        ',ADJCAP(8.4),printo=2
   
  LOOP _m=1,@MARKETS@
  print list='\n\n    Linear Distance CDIST(',_m(1),')    ',CDIST1[_m](8.4),printo=2
  print list='    Squared Distance CDIST2(',_m(1),')  ',CDIST2[_m](8.4),printo=2
  print list='    Cubed Distance CDIST3(',_m(1),')    ',CDIST3[_m](8.4),printo=2
  print list='    Intrazonal indicator CIZ(',_m(1),') ',CIZ[_m](8.4),printo=2
  ENDLOOP

ENDIF  ; end reporting


; READ IN PRODUCTIONS AND ATTRACTIONS

@noNHB@ LOOKUP, NAME=TPROD, 
@noNHB@  LOOKUP[1]=TAZ, RESULT=@PURP@P1, 
@noNHB@  LOOKUP[2]=TAZ, RESULT=@PURP@P2, 
@noNHB@  LOOKUP[3]=TAZ, RESULT=@PURP@P3, 
@noNHB@  LOOKUP[4]=TAZ, RESULT=@PURP@P4, 
@noNHB@  LOOKUP[5]=TAZ, RESULT=@PURP@P5,
@noNHB@  INTERPOLATE=N, LIST=Y, LOOKUPI=2

@isNHB@ LOOKUP, NAME=TPROD, 
@isNHB@  LOOKUP[1]=TAZ, RESULT=@PURP@P, 
@isNHB@  INTERPOLATE=N, LIST=Y, LOOKUPI=2

@isHBW@ LOOKUP, NAME=HBWATTS, 
@isHBW@  LOOKUP[1]=TAZ, RESULT=HBWA1, 
@isHBW@  LOOKUP[2]=TAZ, RESULT=HBWA2, 
@isHBW@  LOOKUP[3]=TAZ, RESULT=HBWA3, 
@isHBW@  LOOKUP[4]=TAZ, RESULT=HBWA4, 
@isHBW@  LOOKUP[5]=TAZ, RESULT=HBWA5, 
@isHBW@  INTERPOLATE=N, LIST=Y, LOOKUPI=2

@noHBW@ LOOKUP, NAME=TATTS, 
@noHBW@  LOOKUP[1]=TAZ, RESULT=@PURP@A, 
@noHBW@  INTERPOLATE=N, LIST=Y, LOOKUPI=2

IF(I == 1)

LOOP ZN = 1, ZONES

; Productions

IF(@MARKETS@ == 1) 
   PRODS[1][ZN] = TPROD(1,ZN)
ELSEIF(@MARKETS@ == 4)
   PRODS[1][ZN] = TPROD(1,ZN)
   PRODS[2][ZN] = TPROD(2,ZN)
   PRODS[3][ZN] = TPROD(3,ZN)
   PRODS[4][ZN] = TPROD(4,ZN)
ELSE
   PRODS[1][ZN] = TPROD(1,ZN)
   PRODS[2][ZN] = TPROD(2,ZN)
   PRODS[3][ZN] = TPROD(3,ZN)
   PRODS[4][ZN] = TPROD(4,ZN)
   PRODS[5][ZN] = TPROD(5,ZN)
ENDIF

; Attractions

@isHBW@   ATTS[1][ZN] = HBWATTS(1,ZN)
@isHBW@   ATTS[2][ZN] = HBWATTS(2,ZN)
@isHBW@   ATTS[3][ZN] = HBWATTS(3,ZN)
@isHBW@   ATTS[4][ZN] = HBWATTS(4,ZN)
@isHBW@   ATTS[5][ZN] = HBWATTS(5,ZN)

@noHBW@   ATTS[1][ZN] = TATTS(1,ZN)
@noHBW@   ATTS[2][ZN] = ATTS[1][ZN]              ; HBNW attractions are not stratified by hhld market
@noHBW@   ATTS[3][ZN] = ATTS[1][ZN]
@noHBW@   ATTS[4][ZN] = ATTS[1][ZN]
@noHBW@   ATTS[5][ZN] = ATTS[1][ZN]

ENDLOOP

ENDIF      ; finish reading Ps and As

; READ IN LEVEL OF SERVICE MATRICES

; Mode choice logsums


@noNHB@  MW[1] = MI.1.1 
@noNHB@  MW[2] = MI.1.2
@noNHB@  MW[3] = MI.1.3
@noNHB@  MW[4] = MI.1.4
@noNHB@  MW[5] = MI.1.5  

@isNHB@  MW[1] = MI.1.1 
@isNHB@  MW[2] = MI.1.1
@isNHB@  MW[3] = MI.1.1
@isNHB@  MW[4] = MI.1.1
@isNHB@  MW[5] = MI.1.1


  
; Distance

 MW[11] = MI.2.2                          ; SOV distance
 MW[12] = MIN(MW[11], DISTCAP)            ; Capped distance
 MW[13] = MIN(MW[11], ADJCAP)             ; adjusted capped distance
 
 
; COMPUTE DESTINATION CHOICE PROBABILITIES


LOOP _m = 1, @MARKETS@

  JLOOP

 INTRAZN = 0
 IF(J == I) INTRAZN = 1

  ; utility
  IF(ATTS[_m][J] > 0.0)
 
   MW[100+_m] = CLSUM * MW[_m] + 
        CDIST1[_m] * MW[12] + CDIST2[_m] * POW(MW[12],2) + CDIST3[_m] * POW(MW[12],3) + 
             CIZ[_m] * INTRAZN + LN(ATTS[_m][J])+ ADJDIST * MW[13] + ADJDISTSQ * POW(MW[13],2) + ADJDISTCUB * POW(MW[13],3)
             
   MW[500+_m] = ADJDIST * MW[13] + ADJDISTSQ * POW(MW[13],2) + ADJDISTCUB * POW(MW[13],3)
   
   MW[110 + _m] = EXP(MW[100+_m])
  
  ELSE
   MW[100+_m] = 0.0
   MW[110 + _m] = 0.0
  ENDIF

 ENDJLOOP
  
  ; destination choice probabilities
  
  DENOM[_m] = ROWSUM(110+_m)
 
  IF(DENOM[_m] > 0)
    MW[120+_m] = MW[110+_m]/DENOM[_m]
  ELSE
    MW[120+_m] = 0.0
  ENDIF

  ; person trips
  
  MW[130+_m] = PRODS[_m][I] * MW[120+_m]
  MW[136]=MW[131]+ MW[132]+ MW[133]+ MW[134]+ MW[135]
  
   ; Now some debugging
  
  IF({DebugDC} > 0 && I == {SelOrigin})
  
  
   PRINT LIST = '\n\nDESTINATION CHOICE UTILITY CALCULATIONS', PRINTO=1
   PRINT LIST = '\n\nSELECT ZONE = ',I(5), PRINTO=1
   PRINT LIST = 'HOUSEHOLD MARKET = ', _m(2), PRINTO=1
   PRINT LIST = 'PERSON TRIPS =     ', PRODS[_m][I](10.3), PRINTO=1
   PRINT LIST = '\n\n  JZONE   MCLS      DIST    CAPDIST    ADJDIST    ATTS      UTIL     ADDUTIL    PROB     TRIPS', PRINTO=1
  JLOOP
  PRINT LIST = J(5), MW[_m](10.4), MW[11](10.2), MW[12](10.2), MW[13](10.2), ATTS[_m][J](10.3), MW[100+_m](12.4), MW[500+_m](12.4), MW[120+_m](12.4), MW[130+_m](10.4), PRINTO=1 
  ENDJLOOP

  ENDIF
ENDLOOP  ; end household market loop

 ; print interzonal trips to csv file

LOOP pTAZ=1,{zonesa}


IF (I==pTAZ)

  JLOOP
   IF (I==1 && J==1) PRINT CSV=T LIST='ProdTAZ','AttrTAZ','Trips','DISTANCE',PRINTO=3
   PRINT CSV=T LIST=I(5),J(5),MW[136](10.6),MW[11](10.6),PRINTO=3
  ENDJLOOP
  
ENDIF

ENDLOOP
; REPORT

ENDRUN


; PILOT Script
; End of PILOT Script

ENDLOOP

