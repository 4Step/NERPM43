; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\PFMAT00B.PRN" MSG='Create PK-OP  EE Tables'
FILEI MATI[1] = "{SCENARIO_DIR}\INPUT\EETrips.dbf",
    PATTERN=IJ:V, FIELDS=ORZ,DSZ,TRIPS
FILEI LOOKUPI[1] = "{CATALOG_DIR}\Parameters\PeakFac.dbf"
FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\EETRIPS_{ALT}{Year}_PK_OP.MAT",
  MO=1-2, DEC=2*S  NAME=EE_PK,EE_OP
LOOKUP LOOKUPI=1,
       NAME=Peaking_Fac,
         LOOKUP[1]=PID, RESULT=HBW,
         LOOKUP[2]=PID, RESULT=HBU,
         LOOKUP[3]=PID, RESULT=HBSC,
         LOOKUP[4]=PID, RESULT=HBSH,
         LOOKUP[5]=PID, RESULT=HBSR,
         LOOKUP[6]=PID, RESULT=HBO,
         LOOKUP[7]=PID, RESULT=NHBW,
         LOOKUP[8]=PID, RESULT=NHBO,
       FAIL[3]=0
; example of use: v=Peaking_Fac(8,25)
; look for 25 in the PID field and returns the NHBO value

PARAMETERS ZONES={ZONESA} ZONEMSG=100

; Factor EE trips (Using NHBO peaking factors.  This will be updaeted when peaking faactors for EE trips are developed)
MW[1]=MI.1.1*Peaking_Fac(8,1)    ; Peak
MW[2]=MI.1.1*Peaking_Fac(8,2)    ; Off-Peak

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
