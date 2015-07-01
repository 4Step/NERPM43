; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43\APPLICATIONS\NTHWY00A.PRN" MSG='Build Skims and Terminal Time Matrix'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI LOOKUPI[1] = "{Scenario_Dir}\input\TERMTIME.CSV"
FILEI TURNPENI = "{Scenario_Dir}\input\tcards_{Year}{alt}.pen"
FILEO MATO[1] = "{Scenario_Dir}\output\FHSKIMS.MAT",
 MO=1-9 NAME=Toll,Distance,Time,WtdTime,HOVToll,HOVDistance,HOVTime,HOVWtdTime,TerminalTime
FILEI NETI = "{Scenario_Dir}\output\UNLOADED.NET"

PAR ZONEMSG=100

; ARRAY TERMINAL TIMES INTO MEMORY
ARRAY ATYPE={ZONESA}
LOOKUP, NAME=TERMTIME, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LOOKUPI=1
PROCESS PHASE=LINKREAD
   lw.distance=li.distanceft/5280; CONVERTS DISTANCES FROM NETWORK (FEET) TO MILES FOR SKIMS
   IF (LI.FACILITY_TYPE=80-89) ADDTOGROUP=1
   IF (LI.FACILITY_TYPE=49 | LI.FACILITY_TYPE=59 | LI.FACILITY_TYPE=69) ADDTOGROUP=9   ; AK-these are transit only links/fixed guideways
   IF (A<={ZONESA})  ; FLAGS LAST ENCOUNTERED LINK FOR TERMINAL TIME CALCULATION LATER
        ATYPE[A]=LI.AREA_TYPE
        PRINT LIST=A,LI.AREA_TYPE
   ENDIF
   LW.TIME=li.time+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60
ENDPROCESS

PROCESS PHASE=ILOOP
   PATHLOAD PATH=LW.TIME, PENI=1,                                 ;LOV Skims - Sks (use Path LW.TIME) - earlier was on LI.TIME
      MW[1]=PATHTRACE(LI.CARTOLL), NOACCESS=999.99,dec=2,
      MW[2]=PATHTRACE(LW.DISTANCE), NOACCESS=999.99,dec=2,
      MW[3]=PATHTRACE(LI.TIME), NOACCESS=999.99,dec=3,
      MW[4]=PATHTRACE(LW.TIME), NOACCESS=999.99,dec=3,
      EXCLUDEGROUP=1,9

   PATHLOAD PATH=LW.TIME, PENI=1,                                ;HOV Skims - Sks (use Path LW.TIME) - earlier was on LI.TIME
      MW[5]=PATHTRACE(LI.CARTOLL), NOACCESS=999.99,dec=2,
      MW[6]=PATHTRACE(LW.DISTANCE), NOACCESS=999.99,dec=2,
      MW[7]=PATHTRACE(LI.TIME), NOACCESS=999.99,dec=3,
      MW[8]=PATHTRACE(LW.TIME), NOACCESS=999.99,dec=3,
      EXCLUDEGROUP=9
; intrazonal array
;(precede this comment with block comment to disable) DISABLE THE INTRAZONAL TO MIMIC TRANPLAN VALIDATION RESULTS
deno={AVEZONE}*2.0
loop _ww=1,8
  mw[_ww][i]=lowest(_ww,{AVEZONE})/deno
endloop
; set intrazonal array to zero for cost
mw[1][i]=0
mw[5][i]=0

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
