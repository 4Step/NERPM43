; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\PAHWY00A1.PRN" MSG='Build Skims and Terminal Time Matrix - FFSKIM based on the modified network: used in the transit model'
DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4
FILEI LOOKUPI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\TERMTIME.CSV"
FILEI TURNPENI = "C:\NERPM43\APPLICATIONS\WARMSTART\tcards_{Year}{alt}.pen"
FILEO MATO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\FHSKIMS1.MAT",
 MO=1-9,DEC=9*2, NAME=Toll,Distance,Time,WtdTime,HOVToll,HOVDistance,HOVTime,HOVWtdTime,TerminalTime

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
   PATHLOAD PATH=LI.TIME, PENI=1,
      MW[1]=PATHTRACE(LI.CARTOLL), NOACCESS=0,
      MW[2]=PATHTRACE(LW.DISTANCE), NOACCESS=0,
      MW[3]=PATHTRACE(LI.TIME), NOACCESS=0,
      MW[4]=PATHTRACE(LW.TIME), NOACCESS=0,
      EXCLUDEGROUP=1,9
   PATHLOAD PATH=LI.TIME, PENI=1,
      MW[5]=PATHTRACE(LI.CARTOLL), NOACCESS=0,
      MW[6]=PATHTRACE(LW.DISTANCE), NOACCESS=0,
      MW[7]=PATHTRACE(LI.TIME), NOACCESS=0,
      MW[8]=PATHTRACE(LW.TIME), NOACCESS=0,
      EXCLUDEGROUP=9
; intrazonal array
;(precede this comment with block comment to disable) DISABLE THE INTRAZONAL TO MIMIC TRANPLAN VALIDATION RESULTS
deno={AVEZONE}*2
loop _ww=1,8
  mw[_ww][i]=lowest(_ww,{AVEZONE})/deno
endloop
; set intrazonal array to zero for cost
mw[1][i]=0
mw[5][i]=0

;set intrazonal travel times at externals to very high numbers
jloop
;A Big mistake---  if (j>=1620 & i=j)
  if (j>={ExtZnStrt} & i=j)
    mw[3][i]=999999
    mw[4][i]=999999
    mw[7][i]=999999
    mw[8][i]=999999
  else
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
