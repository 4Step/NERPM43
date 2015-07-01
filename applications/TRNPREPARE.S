; PILOT Script
FILEO PRINTO[1] = "TRANSIT.MAS"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; Create TRANSIT.MAS file
copy,
 FILE = "C:\NERPM43\APPLICATIONS\TRANSIT.MAS"

DESCRIPTION                  {DESCR}
ZONESA                       {ZONESA}

; AutoCon-Related Files
; Input
StatDataFile                 {SCENARIO_DIR}\output\STATDATA_{ALT}{YEAR}.DAT
XtraAutoFileAM               {SCENARIO_DIR}\input\XTRAAUTO_{YEAR}{ALT}.DAT
XtraAutoFileMD               {SCENARIO_DIR}\input\XTRAAUTO_{YEAR}{ALT}.DAT
AutoDelFileAM                {SCENARIO_DIR}\input\AUTDELPK_{YEAR}{ALT}.DAT
AUTODELFILEMD                {SCENARIO_DIR}\input\AUTDELOP_{YEAR}{ALT}.DAT
NodesFile                    {SCENARIO_DIR}\output\XY_{ALT}{YEAR}.DAT
TransitLineFile              {SCENARIO_DIR}\output\troute_modified.lin
RHSKIMS                      {SCENARIO_DIR}\output\RHSKIMS1.{ALT}{YEAR}
FHSKIMS                      {SCENARIO_DIR}\output\FHSKIMS1.{ALT}{YEAR}
; Output
AUTOCONRPT                   {SCENARIO_DIR}\output\AUTOCON.OUT
PNRAUTOAM                    {SCENARIO_DIR}\output\NTLEG2PK_{ALT}{YEAR}.NTL
PNRAUTOMD                    {SCENARIO_DIR}\output\NTLEG2OP_{ALT}{YEAR}.NTL
KNRAUTOAM                    {SCENARIO_DIR}\output\NTLEG2PK_KNR{ALT}{YEAR}.NTL
KNRAUTOMD                    {SCENARIO_DIR}\output\NTLEG2OP_KNR{ALT}{YEAR}.NTL
; AutoCon Parameters
AUTOCONVERSION               2
ZONESI                       {ZONESI}
CBDZONE                      {CBDZONE}
TERM                         2.00
DEF                          2.00
NOPT                         1
BACK                         1
BACKD                        4.0
BACKPC                       0.30
UNITS                        5280
MAXMODE                      27
MODENUM (not used)            21 22 23 24 25 26 27
PREMIUMFLAG                    0  1  0  1  1  1  1
MODEPRIORITY                   7  5  7  2  1  4  3
VOTAM                         6.00
VOTMD                         3.00
OVTRATIOAM                    2.00
OVTRATIOMD                    2.00
AATRATIOAM                    1.50
AATRATIOMD                    1.50
AUTOCCPNR                    {OCCPNRAccess}
AUTOCCKNR                    {OCCPNRAccess}
AOC                          {hwyopcost}
InflTransitFare              {InflationFare}
InflAOC                      {InflationAOC}
InflParkingCost              {InflationParkCost}
AUTODATAM                    {SCENARIO_DIR}\output\NTLDA2PK_{ALT}{YEAR}.TIM
AUTODATMD                    {SCENARIO_DIR}\output\NTLDA2OP_{ALT}{YEAR}.TIM
ACONLISTAM                   {SCENARIO_DIR}\output\NTLEG2PK_{ALT}{YEAR}.PRN
ACONLISTMD                   {SCENARIO_DIR}\output\NTLEG2OP_{ALT}{YEAR}.PRN


endcopy

; End of PILOT Script

LOOP ACCESS = 1, 3, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

IF (ACCESS == 1)
    ACCESS_NAME='Walk'
    DELACCMODE='2,3,4,5,6'
    DELEGRMODE='2,3,4,5,6'
    MAXIMUMXFER=2
    RECOSTMAX2=250.0
ELSEIF (ACCESS == 2)
    ACCESS_NAME='PNR'
    DELACCMODE='1,3,4,5,6'
    DELEGRMODE='2,3,4,5,6'
    MAXIMUMXFER=2
    RECOSTMAX2=250.0
ELSEIF (ACCESS == 3)
    ACCESS_NAME='KNR'
    DELACCMODE='1,2,4,5,6'
    DELEGRMODE='2,3,4,5,6'
    MAXIMUMXFER=2
    RECOSTMAX2=250.0
ENDIF

; End of PILOT Script

  LOOP MODE = 1, 5, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; Mode hierarchy
; Skyway <- Local Bus <- Express Bus <- BRT/LRT <- Com Rail
; 
; 21 LOCAL BUS
; 22 EXPRESS
; 23 SKYWAY & TROLLEY
; 24 BRT
; 25 LRT
; 26 COMMUTER RAIL

IF (MODE==1) ; Lowest level in the nest
  MODE_NAME='SKYWAY'
  ALLOWEXCLUDEMODES = ' '
  DELETEMODE='21,22,24,25,26'
  PREFLB=1.00
  PREFEB=1.00
  PREFSKY=1.00
  PREFBRT=1.00
  PREFLRT=1.00
  PREFCRL=1.00
  BRDpen23=2.0
  TRANSFERPEN1='XFERCONST=10.00, from=21-200, to=21-200'
ELSEIF (MODE==2)
  MODE_NAME='LOCAL'
  ALLOWEXCLUDEMODES = ' '
  DELETEMODE='22,24,25,26'
  PREFLB=1.00
  PREFEB=1.00
  PREFSKY=1.30
  PREFBRT=1.00
  PREFLRT=1.00
  PREFCRL=1.00
  BRDpen23=2.0
  TRANSFERPEN1='XFERCONST=10.00, from=21-200, to=21-200'
ELSEIF (MODE==3)
  MODE_NAME='EXPRESS'
  ALLOWEXCLUDEMODES = ' '
  DELETEMODE='24,25,26'
  PREFLB=1.30
  PREFEB=1.00
  PREFSKY=1.30
  PREFBRT=1.00
  PREFLRT=1.00
  PREFCRL=1.00
  BRDpen23=2.0
  TRANSFERPEN1='XFERCONST=10.00, from=21-200, to=21-200'
ELSEIF (MODE==4)
  MODE_NAME='BRTLRT'
  DELETEMODE='26'
  PREFLB=1.30
  PREFEB=1.30
  PREFSKY=1.30
  PREFBRT=1.00
  PREFLRT=1.00
  PREFCRL=1.00
  BRDpen23=2.0
  TRANSFERPEN1='XFERCONST=10.00, from=21-200, to=21-200'
ELSEIF (MODE==5)
  MODE_NAME='COMRAIL'
  ALLOWEXCLUDEMODES = ';'
  DELETEMODE= ' '
  PREFLB=1.30
  PREFEB=1.30
  PREFSKY=1.30
  PREFBRT=1.30
  PREFLRT=1.30
  PREFCRL=1.00
  BRDpen23=2.0
  TRANSFERPEN1='XFERCONST=10.00, from=21-200, to=21-200'
ENDIF

; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\applications\TPMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\FACTORS.PRN" MSG='create FACTORS file'
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\@Access_Name@@Mode_Name@.FAC"

ZONES=1

; LOOKUP for coefficient file
LOOKUP NAME=COEFF, LOOKUP[1]=1, RESULT=2,
FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=1

ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

comment=';'

IF (I=1)
  PRINT FORM=5.0,
    list="",comment, "PT Factors File for ********",'@ACCESS_NAME@'," Access - ",'@MODE_NAME@'," ********",
         "\n",comment, "NERPM - December 2006, AECOM Consult",
         "\n\n",comment, "Global Settings",
         "\n BESTPATHONLY=T",
         "\n FREQBYMODE=T",
         "\n RECOSTMAX=",@RECOSTMAX2@(6.2),
         "\n MAXFERS=",@MAXIMUMXFER@(1.0),
         "\n SERVICEMODEL=FREQUENCY",
         
         ; Don't write delete modes for Commuter Rail 
         @ALLOWEXCLUDEMODES@ "\n\n",comment, "Available Transit Modes",
         @ALLOWEXCLUDEMODES@"\n DELMODE = ",'@DELETEMODE@',
         
         "\n\n",comment, "Access & Egress Modes",
         "\n DELACCESSMODE = ",'@DELACCMODE@',
         "\n DELEGRESSMODE = ",'@DELEGRMODE@',

         "\n\n",comment, "Fare & Wait Times",
         "\n FARESYSTEM=1, OPERATOR=1",
         "\n FARESYSTEM=2, OPERATOR=2",
         "\n FARESYSTEM=3, OPERATOR=3",
         "\n FARESYSTEM=4, OPERATOR=4",
         "\n FARESYSTEM=5, OPERATOR=5",
         "\n FARESYSTEM=6, OPERATOR=6",
         "\n FARESYSTEM=7, OPERATOR=7",
         "\n FARESYSTEM=8, OPERATOR=8",
         "\n IWAITCURVE=1,  NODES={NODEMIN}-99999",
         "\n XWAITCURVE=1,  NODES={NODEMIN}-99999",
         "\n WAITFACTOR=",ovtfactor(5.2)," NODES={NODEMIN}-99999",

         "\n\n",comment, "Run Factors",
         "\n RUNFACTOR[1]   =",ovtfactor(5.2),
         "\n RUNFACTOR[2]   = 1.00",
         "\n RUNFACTOR[3]   = 1.00",
         "\n RUNFACTOR[4]   =",ovtfactor(5.2),
         "\n RUNFACTOR[5]   = 1.00",
         "\n RUNFACTOR[6]   = 1.00",
         "\n RUNFACTOR[11]  =",ovtfactor(5.2),
         "\n RUNFACTOR[12]  =",ovtfactor(5.2),
         "\n RUNFACTOR[21]  = ",@PREFLB@(4.2),
         "\n RUNFACTOR[22]  = ",@PREFEB@(4.2),
         "\n RUNFACTOR[23]  = ",@PREFSKY@(4.2),
         "\n RUNFACTOR[24]  = ",@PREFBRT@(4.2),
         "\n RUNFACTOR[25]  = ",@PREFLRT@(4.2),
         "\n RUNFACTOR[26]  = ",@PREFCRL@(4.2),

         "\n\n",comment, "Boarding & Transfer Penalties",
         "\n BRDPEN[21]  = 2.0",
         "\n BRDPEN[22]  = 2.0",
         "\n BRDPEN[23]  = ",@BRDpen23@(3.1),
         "\n BRDPEN[24]  = 2.0",
         "\n BRDPEN[25]  = 2.0",
         "\n BRDPEN[26]  = 2.0",
         "\n BRDPEN[27]  = 2.0",
         "\n XFERPEN=0.00, from=21-200, to=21-200",
         "\n XFERFACTOR=1.00, from=21-200, to=21-200",
         "\n ",'@TRANSFERPEN1@',

         "\n  ",PRINTO=1
ENDIF


ENDRUN


  ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; End of PILOT Script

ENDLOOP

; Script for program NETWORK in file "C:\NERPM43\applications\TPNET00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\TPNET00F.PRN" MSG='Peak Transit Speeds'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PKPreLoad.NET"
FILEI LOOKUPI[1] = "{Catalog_Dir}\parameters\TRANSPD.DBF"
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"

PROCESS PHASE=NODEMERGE
    if (N>80008 & N<80100) STOPGRP=1
ENDPROCESS

PROCESS PHASE=LINKMERGE

  if (time_1>0)
    _AUTOSPEED=60*(DISTANCE)/TIME_1
  else
    _AUTOSPEED=15
  ENDIF

;===========================================================
;SKS-CAP AutoSpeed to 2.5-75 mph and recalculate time_1 (congested time)
;Addressed in Step 4 of Preassignment

;If (_AUTOSPEED<2.5) _AUTOSPEED=2.5
;IF (_AUTOSPEED>75.0) _AUTOSPEED=75
;time_1 = 60.0*DISTANCE/_AUTOSPEED
;CSPD_1=_AUTOSPEED
;=======================================

  LOOKUP name=curve,
     lookup[1]=CURVE_NO, result=LOW_MODE,
     lookup[2]=CURVE_NO, result=HIGH_MODE,
     lookup[3]=CURVE_NO, result=LOW_FT,
     lookup[4]=CURVE_NO, result=HIGH_FT,
     lookup[5]=CURVE_NO, result=LOW_AT,
     lookup[6]=CURVE_NO, result=HIGH_AT,
     lookup[7]=CURVE_NO, result=PKSPDRATIO,
     interpolate=n, fail=0,0,0, list=y, lookupi=1

array LM=500, HM=500, LF=500, HF=500, LA=500, HA=500, SR=500

  LOOP _nn=1,500                                    ; assuming there are no more than 500 curves
   LM[_nn]=CURVE(1,_nn)
   HM[_nn]=CURVE(2,_nn)
   LF[_nn]=CURVE(3,_nn)
   HF[_nn]=CURVE(4,_nn)
   LA[_nn]=CURVE(5,_nn)
   HA[_nn]=CURVE(6,_nn)
   SR[_nn]=CURVE(7,_nn)
   if (LM[_nn] > 0) _numberofcurves=_nn
   if (LM[_nn] <= 0) BREAK
  ENDLOOP

  spdratioM21 = 1.0  ; initialize
  spdratioM22 = 1.0
  spdratioM23 = 1.0
  spdratioM24 = 1.0
  spdratioM25 = 1.0
  spdratioM26 = 1.0
 ; spdratioM27 = 1.0

  LOOP _nn=1,_numberofcurves
    if ((FACILITY_TYPE >= LF[_nn]) & (FACILITY_TYPE <= HF[_nn]) & (AREA_TYPE >= LA[_nn]) & (AREA_TYPE <= HA[_nn]))
     if ((LM[_nn] >= 21) & (HM[_nn] <= 21)) spdratioM21 = SR[_nn]
     if ((LM[_nn] >= 22) & (HM[_nn] <= 22)) spdratioM22 = SR[_nn]
     if ((LM[_nn] >= 23) & (HM[_nn] <= 23)) spdratioM23 = SR[_nn]
     if ((LM[_nn] >= 24) & (HM[_nn] <= 24)) spdratioM24 = SR[_nn]
     if ((LM[_nn] >= 25) & (HM[_nn] <= 25)) spdratioM25 = SR[_nn]
     if ((LM[_nn] >= 26) & (HM[_nn] <= 26)) spdratioM26 = SR[_nn]
    endif
  ENDLOOP

     ; APPLY DEFAULT CURVES
     IF (_AUTOSPEED>0)
       _TSPD21=spdratioM21*_AUTOSPEED  ; Bus Speeds
       _TSPD22=spdratioM22*_AUTOSPEED  ; Express Bus (assumed same as buses)
       _TSPD23=spdratioM23*_AUTOSPEED  ; Skyway Speeds (assumed same as buses)
       _TSPD24=spdratioM24*_AUTOSPEED  ; BRT speeds
       _TSPD25=spdratioM25*_AUTOSPEED  ; LRT speeds
       _TSPD26=spdratioM26*_AUTOSPEED  ; Commuter rail speeds

       M21TIMEPK=60*(DISTANCE)/_TSPD21
       M22TIMEPK=60*(DISTANCE)/_TSPD22
       M23TIMEPK=60*(DISTANCE)/_TSPD23
       M24TIMEPK=60*(DISTANCE)/_TSPD24
       M25TIMEPK=60*(DISTANCE)/_TSPD25
       M26TIMEPK=60*(DISTANCE)/_TSPD26
     ENDIF

     ; OVERRIDES BUS TIMES FOR BUS LINKS FROM NETWORK
     IF (TBSTIME>0)
        M21TIMEPK=TBSTIME
        M22TIMEPK=TBSTIME
        M23TIMEPK=TBSTIME
        M24TIMEPK=TBSTIME
        M25TIMEPK=TBSTIME 
        M26TIMEPK=TBSTIME
     ENDIF

     ; GET THE FIXED GUIDEWAY TIMES
     IF (TFGTIME>0)
        M23TIMEPK=999  ;
        M25TIMEPK=999
        M26TIMEPK=999
     ENDIF

     IF (TFGTIME>0 & TFGMODE=23) M23TIMEPK=TFGTIME     ; skyway times
     IF (TFGTIME>0&TFGMODE=22)
      M22TIMEPK=TFGTIME     ; Premium buses coded as a local bus mode
      M24TIMEPK=TFGTIME     ; BRT times
     ENDIF
     IF (TFGTIME>0&TFGMODE=11)
      M21TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for local buses)
      M22TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for express buses)
      M23TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for Skuway)
      M24TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for BRT)
      M25TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for LRT) 
      M26TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for com rail) 
     ENDIF

     ; ASSIGNS THINGS WITH MISSING VALUES A 999
     IF (M21TIMEPK=0) M21TIMEPK=999
     IF (M22TIMEPK=0) M22TIMEPK=999
     IF (M23TIMEPK=0) M23TIMEPK=999
     IF (M24TIMEPK=0) M24TIMEPK=999
     IF (M25TIMEPK=0) M25TIMEPK=999
     IF (M26TIMEPK=0) M26TIMEPK=999
    if (facility_type=69 & A>80008) BRTLINKTIME=TFGTIME

; ################## Set centroid connectors to maximum length for walk-transit paths
  if (LI.1.A <= {ZONESA} | LI.1.B <= {ZONESA})
    if (LI.1.DISTANCE > 0.40)
      ADJDISTANCE=0.40
    else
      ADJDISTANCE=LI.1.DISTANCE
    endif
  else
    ADJDISTANCE=LI.1.DISTANCE
  endif
; #######################
; WALK CONTROLS
     WALKTIME=60*(ADJDISTANCE)/{AVGWLKSPD}
     IF (FACILITY_TYPE=10-19,69,70-99)
        WALKTIME=999.99
     ENDIF
     IF (FACILITY_TYPE=59) ; escaltor link
        DISTANCE=0.1
        ADJDISTANCE=0.1
        WALKTIME=1.0
     ENDIF

ENDPROCESS

ENDRUN


; Script for program NETWORK in file "C:\NERPM43\applications\TPNET00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\TPNET00G.PRN" MSG='Off-peak Transit Speeds'
FILEI LOOKUPI[1] = "{Catalog_Dir}\parameters\TRANSPD.DBF"
FILEI LINKI[1] = "{Scenario_Dir}\output\UNLOADED.NET"
FILEO NETO = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"

PROCESS PHASE=NODEMERGE
    if (N>80008 & N<80100) STOPGRP=1
ENDPROCESS

PROCESS PHASE=LINKMERGE

  if (time>0)
    _AUTOSPEED=60*(DISTANCE)/TIME
  else
    _AUTOSPEED=15
  ENDIF

  LOOKUP name=curve,
     lookup[1]=CURVE_NO, result=LOW_MODE,
     lookup[2]=CURVE_NO, result=HIGH_MODE,
     lookup[3]=CURVE_NO, result=LOW_FT,
     lookup[4]=CURVE_NO, result=HIGH_FT,
     lookup[5]=CURVE_NO, result=LOW_AT,
     lookup[6]=CURVE_NO, result=HIGH_AT,
     lookup[7]=CURVE_NO, result=OPSPDRATIO,
     interpolate=n, fail=0,0,0, list=y, lookupi=1

array LM=500, HM=500, LF=500, HF=500, LA=500, HA=500, SR=500

  LOOP _nn=1,500                                    ; assuming there are no more than 500 curves
   LM[_nn]=CURVE(1,_nn)
   HM[_nn]=CURVE(2,_nn)
   LF[_nn]=CURVE(3,_nn)
   HF[_nn]=CURVE(4,_nn)
   LA[_nn]=CURVE(5,_nn)
   HA[_nn]=CURVE(6,_nn)
   SR[_nn]=CURVE(7,_nn)
   if (LM[_nn] > 0) _numberofcurves=_nn
   if (LM[_nn] <= 0) BREAK
  ENDLOOP

  spdratioM21 = 1.0  ; initialize
  spdratioM22 = 1.0
  spdratioM23 = 1.0
  spdratioM24 = 1.0
  spdratioM25 = 1.0
  spdratioM26 = 1.0
 ; spdratioM27 = 1.0

  LOOP _nn=1,_numberofcurves
    if ((FACILITY_TYPE >= LF[_nn]) & (FACILITY_TYPE <= HF[_nn]) & (AREA_TYPE >= LA[_nn]) & (AREA_TYPE <= HA[_nn]))
     if ((LM[_nn] >= 21) & (HM[_nn] <= 21)) spdratioM21 = SR[_nn]
     if ((LM[_nn] >= 22) & (HM[_nn] <= 22)) spdratioM22 = SR[_nn]
     if ((LM[_nn] >= 23) & (HM[_nn] <= 23)) spdratioM23 = SR[_nn]
     if ((LM[_nn] >= 24) & (HM[_nn] <= 24)) spdratioM24 = SR[_nn]
     if ((LM[_nn] >= 25) & (HM[_nn] <= 25)) spdratioM25 = SR[_nn]
     if ((LM[_nn] >= 26) & (HM[_nn] <= 26)) spdratioM26 = SR[_nn]
    endif
  ENDLOOP
; APPLY DEFAULT CURVES
     IF (_AUTOSPEED>0)
       _TSPD21=spdratioM21*_AUTOSPEED  ; Bus Speeds
       _TSPD22=spdratioM22*_AUTOSPEED  ; Express Bus (assumed same as buses)
       _TSPD23=spdratioM23*_AUTOSPEED  ; Skyway Speeds (assumed same as buses)
       _TSPD24=spdratioM24*_AUTOSPEED  ; BRT speeds
       _TSPD25=spdratioM25*_AUTOSPEED  ; LRT speeds
       _TSPD26=spdratioM26*_AUTOSPEED  ; Commuter rail speeds

       M21TIMEOP=60*(DISTANCE)/_TSPD21
       M22TIMEOP=60*(DISTANCE)/_TSPD22
       M23TIMEOP=60*(DISTANCE)/_TSPD23
       M24TIMEOP=60*(DISTANCE)/_TSPD24
       M25TIMEOP=60*(DISTANCE)/_TSPD25
       M26TIMEOP=60*(DISTANCE)/_TSPD26
     ENDIF


     ; OVERRIDES BUS TIMES FOR BUS LINKS FROM NETWORK
     IF (TBSTIME>0)
        M21TIMEOP=TBSTIME
        M22TIMEOP=TBSTIME
        M23TIMEOP=TBSTIME
        M24TIMEOP=TBSTIME
        M25TIMEOP=TBSTIME 
        M26TIMEOP=TBSTIME
     ENDIF

     ; GET THE FIXED GUIDEWAY TIMES
     IF (TFGTIME>0)
        M23TIMEOP=999  ;
        M25TIMEOP=999
        M26TIMEOP=999
     ENDIF
     
     IF (TFGTIME>0 & TFGMODE=23) M23TIMEPK=TFGTIME     ; skyway times
     IF (TFGTIME>0&TFGMODE=22)
      M22TIMEOP=TFGTIME     ; Premium buses coded as a local bus mode
      M24TIMEOP=TFGTIME     ; BRT times
     ENDIF
     IF (TFGTIME>0&TFGMODE=11)
      M21TIMEOP=TFGTIME     ; Links with FT=59 (connectors to the station for local buses)
      M22TIMEOP=TFGTIME     ; Links with FT=59 (connectors to the station for express buses)
      M23TIMEOP=TFGTIME     ; Links with FT=59 (connectors to the station for Skuway)
      M24TIMEOP=TFGTIME     ; Links with FT=59 (connectors to the station for BRT)
      M25TIMEOP=TFGTIME     ; Links with FT=59 (connectors to the station for LRT) 
      M26TIMEOP=TFGTIME     ; Links with FT=59 (connectors to the station for com rail) 
     ENDIF

     ; ASSIGNS THINGS WITH MISSING VALUES A 999
     IF (M21TIMEOP=0) M21TIMEOP=999
     IF (M22TIMEOP=0) M22TIMEOP=999
     IF (M23TIMEOP=0) M23TIMEOP=999
     IF (M24TIMEOP=0) M24TIMEOP=999
     IF (M25TIMEOP=0) M25TIMEOP=999
     IF (M26TIMEOP=0) M26TIMEOP=999
    if (facility_type=69 & A>80008) BRTLINKTIME=TFGTIME

; ################## Set centroid connectors to maximum length for walk-transit paths
  if (LI.1.A <= {ZONESA} | LI.1.B <= {ZONESA})
    if (LI.1.DISTANCE > 0.40)
      ADJDISTANCE=0.40
    else
      ADJDISTANCE=LI.1.DISTANCE
    endif
  else
    ADJDISTANCE=LI.1.DISTANCE
  endif
; #######################
; WALK CONTROLS
     WALKTIME=60*(ADJDISTANCE)/{AVGWLKSPD}
     IF (FACILITY_TYPE=10-19,69,70-99)
        WALKTIME=999.99
     ENDIF
     IF (FACILITY_TYPE=59) ; escaltor link
        DISTANCE=0.1
        ADJDISTANCE=0.1
        WALKTIME=1.0
     ENDIF

ENDPROCESS

ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\TPNET00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\TPNET00A.PRN" MSG='Create STATDATA file using PNR information'
FILEI LINKI[1] = "{Scenario_Dir}\output\PKPreLoad.NET"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\FringePNROP.TXT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\FringePNRPK.TXT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\STATDATA_{ALT}{YEAR}.DAT"


ARRAY PNR=9999,RNG=9999,ZON=9999,PRK=9999,CSTAM=9999,CSTMD=9999,PNRT=9999,KNRT=9999,TYPE=9999

PROCESS  PHASE=NODEMERGE
; put nodes, x and y coordinates into memory for lookup nearest TAZ question
lookup lookupi=1,name=netcoord, lookup[1]=1, result=2, lookup[2]=1, result=3, fail=0

if (N=1) _CNT=1
if (N=1) _CNT1=1

if (TSTYPE_{year}{alt} > 0)
 workstat=N
 workstatx=netcoord(1,workstat,0)
 workstaty=netcoord(2,workstat,0)
 mindist=999.99
 loop _ww=1,{ZONESI}
   zx=netcoord(1,_ww,0)
   zy=netcoord(2,_ww,0)
   if (_ww!=workstat) dist=sqrt((workstatx-zx)^2+(workstaty-zy)^2)/5280
   if (dist<mindist) mindist=dist, nearestzone=_ww
 endloop

 PNR[_CNT]=N
 RNG[_CNT]=TSRANGE_{year}{alt}
 ZON[_CNT]=nearestzone
 PRK[_CNT]=TSPARKSPACE_{year}{alt}
 CSTAM[_CNT]=TSCOSTAM_{year}{alt}
 CSTMD[_CNT]=TSCOSTMD_{year}{alt}
 PNRT[_CNT]=2.0
 KNRT[_CNT]=0.5
 TYPE[_CNT]=TSTYPE_{year}{alt}
; get all the informal PNRs first (locations obtained from the on-board survey)
  if (TSTYPE_{year}{alt}=3,4,5,6) ; informal PNRs (locations obtained from on-board survey) stations
   autocontype=1
   if (TSTYPE_{year}{alt}=4) autocontype=4
   print list=_CNT1(4.0),PNR[_CNT](6.0),ZON[_CNT](6.0),RNG[_CNT](6.1),PRK[_CNT](6.0),CSTAM[_CNT](6.0),CSTMD[_CNT](6.0),
                                    PNRT[_CNT](6.1),KNRT[_CNT](6.1),autocontype(3.0)," Informal PNR/KNR", printo=1
   _CNT1=_CNT1+1
  endif

 _CNT=_CNT+1
endif

ENDPROCESS

PROCESS PHASE=LINKMERGE

 LOOP _ww=1,_CNT
  if ((LI.1.A = PNR[_ww]) & (LI.1.A >0) & (LI.1.FACILITY_TYPE=59))  ; formal PNR
   print list=_CNT1(4.0),li.1.B(6.0),ZON[_ww](6.0),RNG[_ww](6.1),PRK[_ww](6.0),CSTAM[_ww](6.0),CSTMD[_ww](6.0),
                                    LI.1.PNRTERMTIME(6.1),LI.1.KNRTERMTIME(6.1),TYPE[_ww](3.0)," PNR Station", li.1.A(6.0), printo=1
   _CNT1=_CNT1+1
  endif
; GENERATE statement for Fringe PNRs
  IF ((LI.1.A = PNR[_ww]) & (LI.1.B >80000) & (LI.1.FACILITY_TYPE=59) & (TYPE[_ww]=2))
    PRINT FORM=5.0,list="\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(li.time_1+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60),MINCOST=200*6,MAXCOST=200*20,LIST=N,",
    "\n  NTLEGMODE=5,MAXNTLEGS=200*1,DIRECTION=1,ONEWAY=T,EXCLUDELINK=(LI.COUNTY=1,3,4,5,6),",
    "\n  FROMNODE=1-{ZONESA}, TONODE=",LI.1.B,printo=2                                 ;peak period

    PRINT FORM=5.0,list="\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(li.time+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60),MINCOST=200*6,MAXCOST=200*20,LIST=N,",
    "\n  NTLEGMODE=5,MAXNTLEGS=200*1,DIRECTION=1,ONEWAY=T,EXCLUDELINK=(LI.COUNTY=1,3,4,5,6),",
    "\n  FROMNODE=1-{ZONESA}, TONODE=",LI.1.B,printo=3                                 ;off-peak period
  ENDIF

  if (LI.1.B=PNR[_ww])
   PRKCSTAM=CSTAM[_ww]
   PRKCSTMD=CSTMD[_ww]
   PNRTerminalTime=PNRT[_ww]
   KNRTerminalTime=KNRT[_ww]
  endif
 ENDLOOP

ENDPROCESS

ENDRUN


; Script for program NETWORK in file "C:\NERPM43\applications\TPNET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\GenPrep.PRN"
FILEI LINKI[1] = "{Scenario_Dir}\output\PKPreLoad.NET"
FILEO PRINTO[7] = "{SCENARIO_DIR}\output\FringeKNRBusOP.TXT"
FILEO PRINTO[6] = "{SCENARIO_DIR}\output\FringeKNRBusPK.TXT"
FILEO PRINTO[5] = "{SCENARIO_DIR}\output\STATXFER_TMP.DAT"
FILEO PRINTO[4] = "{SCENARIO_DIR}\output\STATCON_TMP.DAT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ZONESAT.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\CBDXFER.DAT"

ARRAY CBDNODETMP=99999, CBDNODE=99999, BRTSTATIONS=500

PROCESS PHASE=NODEMERGE
 IF (N=1)
   _CNT=1
 ; GENERATE CBD sidewalks
       PRINT FORM=5.0, list="; CBD sidewalk (0.6 mile) from CBD nodes to all other nodes",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=N,",
         "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
         "\n  FROMNODE=",printo=1
  ; 6 - FRINGE PARK ACCESS TO BUS - peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME_1,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=6
  ; 7 - FRINGE PARK ACCESS TO BUS - off-peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=7
 ENDIF

ENDPROCESS

PHASE=LINKMERGE

; Store BRT nodes for SELECTLINK analysis
    if ( (FACILITY_TYPE=69) && (LI.1.A >= {FirstBRTStationNode}) && (LI.1.B >= {FirstBRTStationNode}) && (LI.1.A < LI.1.B) )   ; pick up the BRT Links (does not include the Skyway Links)
     if (_idx=0)
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
       _idx=_idx+2
     else
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
      _idx=_idx+2
     endif
    endif
; store CBD nodes
    _LNKCNT=_LNKCNT+1
    if ( (LI.1.A <> _lastnode) && (LI.1.A > {ZONESA}) )
     if (LI.1.AREA_TYPE>10 && LI.1.AREA_TYPE<20)                    ;list only CBD nodes
;        PRINT FORM=5.0, list= LI.1.A(6.0),",", printo=1
       CBDNODETMP[_LNKCNT]=LI.1.A
     endif
    endif

; list zones with area types (replaces CBDZONES.SYN and EXURBS.SYN files)
   if ( (LI.1.A <> _lastnode) && (LI.1.A <= {ZONESA}) )
     if (LI.1.A > 0) PRINT list=LI.1.A(10.0), LI.1.AREA_TYPE(10.0), printo=2
   endif

    _lastnode = LI.1.A
ENDPHASE

; Issue - Voyager does not allow to have more than 1000 nodes in one FROMNODE list
; assuming that there are no more than 10,000 nodes in the CBD region
; not sure whether the script below will work for more than 10,000 nodes in the CBD region
; summary phase for printing out the GENERATE statement with a list of CBD nodes for CBD sidewalks
PHASE=SUMMARY
    _A=1
    _B=1
    LOOP _N=1,99999
     if (CBDNODETMP[_N]>0)
      CBDNODE[_A]=CBDNODETMP[_N]
      _A=_A+1
     endif

    ENDLOOP

    LOOP _K=1,9999
      _M=(_K-1)*10
      if (CBDNODE[_M+1]>0 & CBDNODE[_M+10]>0)
       _B=_B+1
       if (_B<=50)

        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=1
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=6
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=7
       endif

       if (_B=50)
         PRINT FORM=5.0, list= "TONODE={NODEMIN}-99999", printo=1
         PRINT FORM=5.0, list= "NTLEGMODE=6", printo=6
         PRINT FORM=5.0, list= "NTLEGMODE=6", printo=7
         PRINT FORM=5.0, list="GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=N,",
           "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
           "\n  FROMNODE=",printo=1

  ; 6 - FRINGE PARK ACCESS TO BUS - peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME_1,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=6

 ; 7 - FRINGE PARK ACCESS TO BUS - off-peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=7
       endif

       if (_B>50)
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=1
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=6
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=7
       endif
      endif


      if (CBDNODE[_M+10]<=0)
       LOOP _C=1,10
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",printo=1
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",printo=6
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",printo=7
       ENDLOOP
      endif

    ENDLOOP

    PRINT FORM=5.0, list= "TONODE={NODEMIN}-99999", printo=1
    PRINT FORM=5.0, list= "NTLEGMODE=6", printo=6
    PRINT FORM=5.0, list= "NTLEGMODE=6", printo=7

;; BRT stations - walk connectors and transfer connectors
   SORT ARRAY=BRTSTATIONS

    loop _ff=1,500
; 3 mile walk connector to/from stations
     if ({isFutureYearAlternative}=1 & _ff=1); & BRTSTATIONS[_ff]>0)
        PRINT FORM=5.0,list="\n\n ; 3 mile walk connector from station to/from all zones",
          "\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*3.0,LIST=N,",
          "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
          "\n  FROMNODE=",printo=4
     endif
     if ({isFutureYearAlternative}=1 & _ff>1 & BRTSTATIONS[_ff]>0 & BRTSTATIONS[_ff]<>_prevstation) print list=BRTSTATIONS[_ff](9.0),",",printo=4
; station-nearby stop transfer connectors - maxntlegs=20 (99 too much for jax - huge impact on running times)
     if ({isFutureYearAlternative}=1 & _ff=1)
        PRINT FORM=5.0,list=";0.6 mile transfer connectors from all BRT stations to nearby stops",
          "\n\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*0.6,LIST=N,",
          "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),MAXNTLEGS=200*20,DIRECTION=3,ONEWAY=F,",
          "\n  FROMNODE=",printo=5
     endif
     if ({isFutureYearAlternative}=1 & _ff>1 & BRTSTATIONS[_ff]>0 & BRTSTATIONS[_ff]<>_prevstation) print list=BRTSTATIONS[_ff](9.0),",",printo=5
     _prevstation=BRTSTATIONS[_ff]

    endloop

    if ({isFutureYearAlternative}=1)
     print list="    TONODE=1-{ZONESA}, NTLEGMODE=1",printo=4
     print list="    TONODE={NODEMIN}-99999, NTLEGMODE=11",printo=5
    endif

ENDPHASE


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\applications\TPMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TPMAT00B.PRN" MSG='Create STATDATA DBF file'
FILEO RECO[1] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF",
   FORM=10.0, FIELDS=TAZ,STNODE,STNUM, FORM=10.2, FIELDS=STMAXD,STPKSP,STPKCS1,STPKCS2,STWALKPR,STWALKKR,FORM=5.0, FIELDS=TSTYPE, CFORM=30, FIELDS=STNAME
FILEI RECI = "{SCENARIO_DIR}\output\STATDATA_{ALT}{YEAR}.DAT",
 SORT=TAZ,
   STATION=1-4, STATNODE=5-10, TAZ=11-16, DRV=17-22, SPACES=23-28,
   A1=29-34, A2=35-40, B1=41-46, B2=47-52, C1=54-55, NAME(C)=56-85

RO.TAZ=RI.TAZ
RO.STNODE=RI.STATNODE
RO.STNUM=RI.STATION
RO.STMAXD=RI.DRV
RO.STPKSP=RI.SPACES
RO.STPKCS1=RI.A1
RO.STPKCS2=RI.A2
RO.STWALKPR=RI.B1
RO.STWALKKR=RI.B2
RO.TSTYPE=RI.C1
RO.STNAME=RI.NAME

WRITE RECO=1


ENDRUN


