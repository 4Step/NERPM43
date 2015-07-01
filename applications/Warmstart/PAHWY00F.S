; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\WARMSTART\PAHWY00A3.PRN" MSG='Develops Preload Skims'
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
