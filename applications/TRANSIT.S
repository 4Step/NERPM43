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
     IF (TFGTIME>0 & TFGMODE=26) M26TIMEPK=TFGTIME     ; CR Times

     
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
     
     IF (TFGTIME>0 & TFGMODE=23) M23TIMEOP=TFGTIME     ; skyway times
      
     IF (TFGTIME>0 & TFGMODE=26) M26TIMEOP=TFGTIME     ; CR times
     
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


; Script for program NETWORK in file "C:\NERPM43\applications\ACNET00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\ACNET01G.PRN" MSG='Peak add PNR Lot data to Station Node'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"
FILEI NODEI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{Year}.DAT",
var=STANUM,N,STAZ,MAXD,SPACE,STACOST_AM,STACOST_MD,STAW_PNR,STAW_KNR,TSTYPE,STA_NAME(C)
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD_PT_TEMP.NET"

ENDRUN


; Script for program NETWORK in file "C:\NERPM43\applications\ACNET00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\ACNET01H.PRN" MSG='Off-Peak add PNR Lot data to Station Node'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEI NODEI[2] = "{SCENARIO_DIR}\OUTPUT\STATDATA_{alt}{Year}.DAT" ,
var=STANUM,N,STAZ,MAXD,SPACE,STACOST_AM,STACOST_MD,STAW_PNR,STAW_KNR,TSTYPE,STA_NAME(C)
FILEO NETO = "{SCENARIO_DIR}\output\UNLOADED_PT_TEMP.NET"

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\applications\CNPTR00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\CNPTR00A.PRN" MSG='Peak period connectors'
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PT_AUTOCON_PK.OUT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG2PK_{Year}{alt}.PRN"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\PNRCOMRAIL.FAC"
FILEI MATI[1] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT"

; Inputs for walk connectors
FILEI NETI = "{SCENARIO_DIR}\output\PRELOAD_PT_TEMP.NET"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkCOMRAIL.FAC"

; Output files
FILEO NETO = "{SCENARIO_DIR}\output\NTLEGSPK.NET"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\NTLEGPK_{alt}{year}.DBF"
FILEO LINEO = "{SCENARIO_DIR}\output\TROUTE_MOD.LIN"
FILEO NTLEGO = "{SCENARIO_DIR}\output\NTLEGPK_{YEAR}{ALT}.NTL"
FILEO REPORTO = "{SCENARIO_DIR}\output\NTLEGPK.RPT"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE=5280, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEPK,
           TRANTIME[22]=LI.M22TIMEPK,
           TRANTIME[23]=LI.M23TIMEPK,
           TRANTIME[24]=LI.M24TIMEPK,
           TRANTIME[25]=LI.M25TIMEPK,
           TRANTIME[26]=LI.M26TIMEPK
REPORT LINES=T

PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEPK
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
 LW.ADJDISTANCE=LI.ADJDISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 1 - WALK ACCESS/EGRESS
  GENERATE, COST=(LW.ADJDISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),
            NTLEGMODE=1,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,FROMNODE=1-{ZONESI},TONODE={NODEMIN}-99999
     
  ; 11 - Fixed-guideway to bus (transfer connectors)
  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LI.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,INCLUDELINK=(LI.FACILITY_TYPE=59),
            NTLEGMODE=11,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,DIRECTLINK=2,ONEWAY=F,FROMNODE={NODEMIN}-99999,TONODE={NODEMIN}-99999
  
            ; 11 - station to nearby stop (transfer connectors)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATXFER_TMP.DAT"

  ; 12 - CBD sidewalks
   READ, FILE = "{SCENARIO_DIR}\OUTPUT\CBDXFER.DAT"

            
 ; Add AUTOCON outputs
 list='\nGenerate Zone Access/Egress Legs'
    GENERATE, 
       PNR=T,
       KNR=T,
       PERIOD=1,
       
       PNRMODE=2,
       KNRMODE=3,
       INTERNALZONES=1-2494,
       
       CBDZONE=730,
       ORIGINTERMTIME=2.0,
       DEFDRIVETIME=20.0,
       CHECKRELEVANCE=1,
       CHECKBACKTRACK=1,
       MAXBACKDIST=4.0,
       MAXBACKFACTOR=0.30,
       DISTANCEFACTOR=5280,
       ;EAH testing distance
       ;DISTANCEFACTOR=528,
       
       ; Trn Modes = 21,22,23,24,25,26
       PREMIUMMODE  =0,0,0,1,1,1,  
       MODEPRIORITY =7,7,7,2,2,1,

       VOT=6,3,
       OVTRATIO=2,2,
       AATRATIO=1.5,1.5,
       AUTOCCPNR=1.2,
       AUTOCCKNR=1.2,
       AOC=9.5,
       INFLTRANSITFARE=0.9487,
       INFLAOC=1,
       INFLPARKINGCOST=1.1976,
       MAXCHECK = 10,
       MAXCONN = 5,
       
       CONNREPORT=1,
       GENREPORT=2,
       TIMEMAT=MI.1.4*100,
       DISTMAT=MI.1.2*100,
       AUTOMATCH=T     ; T=original logic, F=Enhanced logic

     GENERATE, 
       KNR=T,
       PERIOD=1,
       
       PNRMODE=2,
       KNRMODE=3,
       INTERNALZONES=1-2494,
       
       CBDZONE=730,
       ORIGINTERMTIME=2.0,
       DEFDRIVETIME=20.0,
       CHECKRELEVANCE=1,
       CHECKBACKTRACK=1,
       MAXBACKDIST=4.0,
       MAXBACKFACTOR=0.30,
       DISTANCEFACTOR=5280,
       ;EAH testing distance
       ;DISTANCEFACTOR=528,
       
       ; Trn Modes = 21,22,23,24,25,26
       PREMIUMMODE  =0,0,0,1,1,1,  
       MODEPRIORITY =7,7,7,2,2,1,

       VOT=6,3,
       OVTRATIO=2,2,
       AATRATIO=1.5,1.5,
       AUTOCCPNR=1.2,
       AUTOCCKNR=1.2,
       AOC=9.5,
       INFLTRANSITFARE=0.9487,
       INFLAOC=1,
       INFLPARKINGCOST=1.1976,
       MAXCHECK = 10,
       MAXCONN = 5,
       
       CONNREPORT=1,
       GENREPORT=2,
       TIMEMAT=MI.1.4*100,
       DISTMAT=MI.1.2*100,
       AUTOMATCH=F     ; T=original logic, F=Enhanced logic

  ENDPROCESS
ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\APPLICATIONS\CNPTR00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="C:\NERPM43\APPLICATIONS\CNPTR00E.PRN" MSG='OffPeak period connectors'
FILEO PRINTO[2] = "{Scenario_Dir}\output\PT_AUTOCON_PK.OUT"
FILEO PRINTO[1] = "{Scenario_Dir}\output\NTLEG2OP_{Year}{alt}.PRN"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\PNRCOMRAIL.FAC"
FILEI MATI[1] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"

; Inputs for walk connectors
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED_PT_TEMP.NET"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkCOMRAIL.FAC"

; Output files
FILEO NETO = "{Scenario_Dir}\output\NTLEGSOP.NET"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\NTLEGOP_{alt}{year}.DBF"
FILEO LINEO = "{Scenario_Dir}\output\TROUTE_MOD.LIN"
FILEO NTLEGO = "{SCENARIO_DIR}\output\NTLEGOP_{YEAR}{ALT}.NTL"
FILEO REPORTO = "{SCENARIO_DIR}\output\NTLEGOP.RPT"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE=5280, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEOP,
           TRANTIME[22]=LI.M22TIMEOP,
           TRANTIME[23]=LI.M23TIMEOP,
           TRANTIME[24]=LI.M24TIMEOP,
           TRANTIME[25]=LI.M25TIMEOP,
           TRANTIME[26]=LI.M26TIMEOP
REPORT LINES=T

PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEOP
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
 LW.ADJDISTANCE=LI.ADJDISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 1 - WALK ACCESS/EGRESS
  GENERATE, COST=(LW.ADJDISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),
            NTLEGMODE=1,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,FROMNODE=1-{ZONESI},TONODE={NODEMIN}-99999

  ; 11 - Fixed-guideway to bus
  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LI.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,INCLUDELINK=(LI.FACILITY_TYPE=59),
            NTLEGMODE=11,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,DIRECTLINK=2,ONEWAY=F,FROMNODE={NODEMIN}-99999,TONODE={NODEMIN}-99999
  ;11 - station to nearby stop (transfer connectors)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATXFER_TMP.DAT"

  ; 12 - CBD sidewalks
   READ, FILE = "{SCENARIO_DIR}\OUTPUT\CBDXFER.DAT"

 ; Add AUTOCON outputs
 list='\nGenerate Zone Access/Egress Legs'
    GENERATE, 
       PNR=T,
       KNR=T,
       PERIOD=1,
       
       PNRMODE=2,
       KNRMODE=3,
       INTERNALZONES=1-2494,
       
       CBDZONE=730,
       ORIGINTERMTIME=2.0,
       DEFDRIVETIME=20.0,
       CHECKRELEVANCE=1,
       CHECKBACKTRACK=1,
       MAXBACKDIST=4.0,
       MAXBACKFACTOR=0.30,
       DISTANCEFACTOR=5280,
       ;EAH testing distance
       ;DISTANCEFACTOR=5,
       
       ; Trn Modes = 21,22,23,24,25,26
       PREMIUMMODE  =0,0,0,1,1,1,  
       MODEPRIORITY=7,7,7,2,2,1,

       
       VOT=6,3,
       OVTRATIO=2,2,
       AATRATIO=1.5,1.5,
       AUTOCCPNR=1.2,
       AUTOCCKNR=1.2,
       AOC=9.5,
       INFLTRANSITFARE=0.9487,
       INFLAOC=1,
       INFLPARKINGCOST=1.1976,
       MAXCHECK = 10,
       MAXCONN = 5,
       
       CONNREPORT=1,
       GENREPORT=2,
       TIMEMAT=MI.1.4,
       DISTMAT=MI.1.2,
       AUTOMATCH=T      ; T=original logic, F=Enhanced logic
 
  
   GENERATE, 
       KNR=T,
       PERIOD=1,
       
       PNRMODE=2,
       KNRMODE=3,
       INTERNALZONES=1-2494,
       
       CBDZONE=730,
       ORIGINTERMTIME=2.0,
       DEFDRIVETIME=20.0,
       CHECKRELEVANCE=1,
       CHECKBACKTRACK=1,
       MAXBACKDIST=4.0,
       MAXBACKFACTOR=0.30,
       DISTANCEFACTOR=5280,
       ;EAH testing distance
       ;DISTANCEFACTOR=5,
       
       ; Trn Modes = 21,22,23,24,25,26
       PREMIUMMODE  =0,0,0,1,1,1,  
       MODEPRIORITY=7,7,7,2,2,1,

       
       VOT=6,3,
       OVTRATIO=2,2,
       AATRATIO=1.5,1.5,
       AUTOCCPNR=1.2,
       AUTOCCKNR=1.2,
       AOC=9.5,
       INFLTRANSITFARE=0.9487,
       INFLAOC=1,
       INFLPARKINGCOST=1.1976,
       MAXCHECK = 10,
       MAXCONN = 5,
       
       CONNREPORT=1,
       GENREPORT=2,
       TIMEMAT=MI.1.4*100,
       DISTMAT=MI.1.2*100,
       AUTOMATCH=F      ; T=original logic, F=Enhanced logic

  ENDPROCESS
ENDRUN


; Script for program MATRIX in file "C:\NERPM43\applications\CNMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00A1.PRN" MSG='Peak walk, pnr, knr connectors'
FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI RECI = "{SCENARIO_DIR}\output\NTLEGPK_{YEAR}{ALT}.NTL"

FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG3PK_{alt}{year}.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\NTLEG2PK_{alt}{year}.NTL"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1PK_TEM.NTL"
FILEO PRINTO[4] = "{Scenario_Dir}\output\NTLEG11PK_{alt}{year}.NTL"
FILEO PRINTO[5] = "{Scenario_Dir}\output\NTLEG12PK_{alt}{year}.NTL"

; print all removed NTLEGS
s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))


; ############# check for error in time field #################
if (time > 999)
 time=999
 print list='*****Error in the time field, Time exceeds 999 min *****', zonei(5.0),'-',zonej(5.0),mode(3.0)
endif
;##############################################################

; LOOKUP for coefficient file
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=2
ovtfactor =COEFF(1,3)/COEFF(1,1)      ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)      ; drive access to transit time factor

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  PRINT LIST=";;<<PT>>;;", PRINTO=2
  PRINT LIST=";;<<PT>>;;", PRINTO=3
  _ctr = _ctr + 1
endif

if (mode=1) PRINT FORM=L, LIST="NT LEG=",zonei,"-",zonej," MODE=",mode," COST=",time(6.2L)," DIST=",dist(6.2L)," ",s23,PRINTO=1
if (mode=2) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=2
if (mode=3) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=3
if (mode=11) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=4
if (mode=12) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=5

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\applications\CNMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B.PRN" MSG='OffPeak walk, pnr, knr connectors'

FILEI RECI = "{SCENARIO_DIR}\output\NTLEGOP_{YEAR}{ALT}.NTL"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG3OP_{alt}{year}.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\NTLEG2OP_{alt}{year}.NTL"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1OP_TEM.NTL"

FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEO PRINTO[5] = "{Scenario_Dir}\output\NTLEG12OP_{alt}{year}.NTL"
FILEO PRINTO[4] = "{Scenario_Dir}\output\NTLEG11OP_{alt}{year}.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))

; ############# check for error in time field #################
if (time > 999)
 time=999
 print list='*****Error in the time field, Time exceeds 999 min *****', zonei(5.0),'-',zonej(5.0),mode(3.0)
endif
;##############################################################

; LOOKUP for coefficient file
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=2
ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  PRINT LIST=";;<<PT>>;;", PRINTO=2
  PRINT LIST=";;<<PT>>;;", PRINTO=3
  _ctr = _ctr + 1
endif

if (mode=1) PRINT FORM=L, LIST="NT LEG=",zonei,"-",zonej," MODE=",mode," COST=",time(6.2L)," DIST=",dist(6.2L)," ",s23,PRINTO=1
if (mode=2) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=2
if (mode=3) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=3
if (mode=11) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=4
if (mode=12) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=5

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00A.PRN" MSG='Connector Information for Peak'
FILEO RECO[1] = "{SCENARIO_DIR}\output\PKZONECONN_TEM.DBF",
FIELDS =zonea,conn_ctr,mindist,mincost,cenflag
;FIELDS =zonea(5.0),conn_ctr(3.0),mindist(5.2),mincost(5.2),cenflag(1.0)

FILEI RECI = "{SCENARIO_DIR}\output\NTLEG1PK_TEM.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))

; Get information (# connectors,mindist,centroid stop(?)) about walk access connectors

if (mode==1 && zonei<{ZONESA})     ; mode = walk & Anode less the Number of Zones
 if (_ctrwalk==1)
   zonea=zonei
   conn_ctr=conn_ctr+1
   mindist=dist
   mincost=time
   if (s7==0) cenflag=1            ; Check for stop at centroid Connector
 endif

 if (_ctrwalk >1 && zonei==zonea)
   conn_ctr=conn_ctr+1            ; Number of walk access connectors for a zone
   if (s7==0) cenflag=1
   if (dist<mindist)
       mindist=dist               ; Minimum length of the connector
       mincost=time
   endif
 endif

 if (_ctrwalk>1 && zonei<>zonea)
   WRITE RECO=1                   ; Output # connectors, min.length & Stop flag for centroid connectors
   zonea=zonei
   conn_ctr=1
   mindist=dist
   mincost=time
   cenflag=0
  if (s7==0) cenflag=1
 endif
  _ctrwalk=_ctrwalk + 1
endif

if (i==0)
 WRITE RECO=1                     ; output the information for the last centroid connector
endif

if (i==1 && _ctrwalk==0)
  _ctrwalk=_ctrwalk + 1
endif

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00C.PRN" MSG='Revise Peak Walk Access Connectors'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG1PK_DEL.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWPK_TEM.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1PK_{alt}{year}.NTL"
FILEI RECI = "{SCENARIO_DIR}\OUTPUT\NTLEG1PK_TEM.NTL"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\pcwalk_{year}{alt}.dat"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\PKZONECONN_TEM.DBF"

avgwalkc=({AVGWALK}/{AVGWLKSPD})*60   ;average walk time (minutes)

if (_ctr>0)
 s1=strpos('NT',reci)
 s2=strpos('LEG',reci)
 s3=strpos('MODE',reci)
 s4=strpos('COST',reci)
 s5=strpos('DIST',reci)
 s6=strpos('ONEWAY',reci)
 s7=strpos('XN',reci)

 ; get the origin and destination zone
 s8=(s3-s2)
 leg1=substr(reci,s2,s8)
 s9=strpos('=',leg1)
 s10=strpos('-',leg1)
 s11=(s9+1)
 s12=(s10-1)
 s13=(s10+1)
 zonei=val(substr(leg1,s11,s12))
 zonej=val(substr(leg1,s13,strlen(leg1)))

 if (tempzone <> zonei )
  new_zone=1
 elseif (tempzone == zonei)
  new_zone=0
 endif

 ; get the mode number
 s14=(s4-s3)
 mode1=substr(reci,s3,s14)
 s15=strpos('=',mode1)
 s16=(s15+1)
 mode=val(substr(mode1,s16,strlen(mode1)))

 ; get the time on the connector (cost field in the NT leg file)
 s17=(s5-s4)
 time1=substr(reci,s4,s17)
 s18=strpos('=',time1)
 s19=(s18+1)
 time=val(substr(time1,s19,strlen(time1)))

 ; get the distance
 s20=(s6-s5)
 dist1=substr(reci,s5,s20)
 s21=strpos('=',dist1)
 s22=(s21+1)
 dist=val(substr(dist1,s22,strlen(dist1)))

 ; get the rest of the string
 s23=substr(reci,s6,strlen(reci))
 s24=strpos('=',s23)
 s25=substr(reci,s6,s24+1)

 if (zonei<{ZONESA})
  zone = zonei                  ; Check if Anode is the zone number
 elseif (zonei>{ZONESA})
  zone=zonej
 endif

 ;Lookup for pcwalk file
 LOOKUP LOOKUPI=1, NAME=PCWALK, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        pkprod=PCWALK(1,zone)
        pkattr=PCWALK(2,zone)
        opprod=PCWALK(3,zone)              ; Lookup for PCW information
        opattr=PCWALK(4,zone)

 ;Lookup for connectors
 LOOKUP LOOKUPI=2, NAME=GETCONNECTORS, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        conn=GETCONNECTORS(1,zone)
        mindist=GETCONNECTORS(2,zone)    ; Lookup for centroid connector information
        mincost=GETCONNECTORS(3,zone)
        cenflag=GETCONNECTORS(4,zone)

 ; Assigning Rule values (rules refer to the rule numbers used in the REWALK documentation)
 if (cenflag=0 && pkprod<95) rule = 2                                ; No Transit Stop at centroid connector and PCW<95%
 if (cenflag=0 && pkprod>=95 && mindist<{AVGWALK}) rule = 3          ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK
 if (cenflag=0 && pkprod>=95 && mindist>={AVGWALK}) rule = 4         ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK
 if (cenflag=1 && pkprod=100) rule = 5                               ; Transit Stop at centroid connector & PCW =100%
 if (cenflag=1 && pkprod>={MINPCW} && pkprod<100) rule = 6           ; Transit Stop at centroid connector & MinPCW<=PCW<100%
 if (cenflag=1 && pkprod<{MINPCW}) rule = 7                          ; Transit Stop at centroid connector & PCW<MinPCW

 ;Rules 3,5: No changes to walk access connectors & PCW
 if (rule=3,5)
   PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
   if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
    tempzone=zonei
   endif
 endif

 ;Rules 2,4,7: Delete walk access connectors and reset PCW =0
 if(rule=2,4,7)
   pkprod=0
   pkattr=0
   PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s23,PRINTO=3
   if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
    tempzone=zonei
   endif
 endif

 ;Rule 6: No changes to PCW, adjust walk access connector dist & times
 if (rule=6)
  if (mindist>{AVGWALK})
   dist_delta =(mindist - {AVGWALK})       ;if minimum connector length > AVGWALK
   time_delta =(mincost-avgwalkc)          ;set minimum distance & time to avgwalk & avgwalkc
   dist=(dist-dist_delta)                  ;and adjust the rest of the connectors by the same delta's
   time=(time-time_delta)
  endif
   PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
  if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
   tempzone=zonei
  endif
 endif

endif

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  tempzone=0
endif

_ctr = _ctr + 1

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00B.PRN" MSG='Connector Information for Off-Peak'
FILEO RECO[1] = "{SCENARIO_DIR}\output\OPZONECONN_TEM.DBF",
FIELDS =zonea,conn_ctr,mindist,mincost,cenflag

;FIELDS =zonea(5.0),conn_ctr(3.0),mindist(5.2),mincost(5.2),cenflag(1.0)
FILEI RECI = "{SCENARIO_DIR}\output\NTLEG1OP_TEM.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))

; Get information (# connectors,mindist,centroid stop(?)) about walk access connectors

if (mode==1 && zonei<{ZONESA})        ; mode = walk & Anode less the Number of Zones
 if (_ctrwalk==1)
   zonea=zonei
   conn_ctr=conn_ctr+1
   mindist=dist
   mincost=time
   if (s7==0) cenflag=1                        ; Check for stop at centroid Connector
 endif

 if (_ctrwalk >1 && zonei==zonea)
   conn_ctr=conn_ctr+1         ; Number of walk access connectors for a zone
   if (s7==0) cenflag=1
   if (dist<mindist)
       mindist=dist               ; Minimum length of the connector
       mincost=time
   endif
 endif

 if (_ctrwalk>1 && zonei<>zonea)
   WRITE RECO=1                   ; Output # connectors, min.length & Stop flag for centroid connectors
   zonea=zonei
   conn_ctr=1
   mindist=dist
   mincost=time
   cenflag=0
  if (s7==0) cenflag=1
 endif
  _ctrwalk=_ctrwalk + 1
endif

if (i==0)
 WRITE RECO=1                 ; output the information for the last centroid connector
endif

if (i==1 && _ctrwalk==0)
  _ctrwalk=_ctrwalk + 1
endif

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00E.PRN" MSG='Revise Off Peak Walk Access Connectors'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG1OP_DEL.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWOP_TEM.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1OP_{alt}{year}.NTL"
FILEI RECI = "{SCENARIO_DIR}\OUTPUT\NTLEG1OP_TEM.NTL"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\pcwalk_{year}{alt}.dat"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\OPZONECONN_TEM.DBF"

avgwalkc=({AVGWALK}/{AVGWLKSPD})*60

if (_ctr>0)
 s1=strpos('NT',reci)
 s2=strpos('LEG',reci)
 s3=strpos('MODE',reci)
 s4=strpos('COST',reci)
 s5=strpos('DIST',reci)
 s6=strpos('ONEWAY',reci)
 s7=strpos('XN',reci)

 ; get the origin and destination zone
 s8=(s3-s2)
 leg1=substr(reci,s2,s8)
 s9=strpos('=',leg1)
 s10=strpos('-',leg1)
 s11=(s9+1)
 s12=(s10-1)
 s13=(s10+1)
 zonei=val(substr(leg1,s11,s12))
 zonej=val(substr(leg1,s13,strlen(leg1)))

 if (tempzone <> zonei )
  new_zone=1
 elseif (tempzone == zonei)
 new_zone=0
 endif

 ; get the mode number
 s14=(s4-s3)
 mode1=substr(reci,s3,s14)
 s15=strpos('=',mode1)
 s16=(s15+1)
 mode=val(substr(mode1,s16,strlen(mode1)))

 ; get the time on the connector (cost field in the NT leg file)
 s17=(s5-s4)
 time1=substr(reci,s4,s17)
 s18=strpos('=',time1)
 s19=(s18+1)
 time=val(substr(time1,s19,strlen(time1)))

 ; get the distance
 s20=(s6-s5)
 dist1=substr(reci,s5,s20)
 s21=strpos('=',dist1)
 s22=(s21+1)
 dist=val(substr(dist1,s22,strlen(dist1)))

 ; get the rest of the string
 s23=substr(reci,s6,strlen(reci))
 s24=strpos('=',s23)
 s25=substr(reci,s6,s24+1)

 if (zonei<{ZONESA})
  zone = zonei                  ; Check if Anode is the zone number
 elseif (zonei>{ZONESA})
  zone=zonej
 endif

 ;Lookup for pcwalk file
 LOOKUP LOOKUPI=1, NAME=PCWALK, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        pkprod=PCWALK(1,zone)
        pkattr=PCWALK(2,zone)
        opprod=PCWALK(3,zone)              ; Lookup for PCW information
        opattr=PCWALK(4,zone)

 ;Lookup for connectors
 LOOKUP LOOKUPI=2, NAME=GETCONNECTORS, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        conn=GETCONNECTORS(1,zone)
        mindist=GETCONNECTORS(2,zone)    ; Lookup for centroid connector information
        mincost=GETCONNECTORS(3,zone)
        cenflag=GETCONNECTORS(4,zone)

 ; Assigning Rule values (rules refer to the rule numbers used in the REWALK documentation)
 if (cenflag=0 && opprod<95) rule = 2                                ; No Transit Stop at centroid connector and PCW<95%
 if (cenflag=0 && opprod>=95 && mindist<{AVGWALK}) rule = 3           ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK
 if (cenflag=0 && opprod>=95 && mindist>={AVGWALK}) rule = 4          ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK
 if (cenflag=1 && opprod=100) rule = 5                               ; Transit Stop at centroid connector & PCW =100%
 if (cenflag=1 && opprod>={MINPCW} && opprod<100) rule = 6           ; Transit Stop at centroid connector & MinPCW<=PCW<100%
 if (cenflag=1 && opprod<{MINPCW}) rule = 7                          ; Transit Stop at centroid connector & PCW<MinPCW

 ;Rules 3,5: No changes to walk access connectors & PCW
 if (rule=3,5)
  PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
  if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
    tempzone=zonei
  endif
 endif

 ;Rules 2,4,7: Delete walk access connectors and reset PCW =0
 if(rule=2,4,7)
  opprod=0
  opattr=0
  PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s23,PRINTO=3
  if (zonei<{ZONESA} && new_zone=1)
   PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
   tempzone=zonei
  endif
 endif

 ;Rule 6: No changes to PCW, adjust walk access connector dist & times
 if (rule=6)
  if (mindist>{AVGWALK})
   dist_delta =(mindist - {AVGWALK})        ;if minimum connector length > AVGWALK
   time_delta =(mincost-avgwalkc)         ;set minimum distance & time to avgwalk & avgwalkc
   dist=(dist-dist_delta)                 ;and adjust the rest of the connectors by the same delta's
   time=(time-time_delta)
  endif
  PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
  if (zonei<{ZONESA} && new_zone=1)
   PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
   tempzone=zonei
  endif
 endif

endif

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  tempzone=0
endif

_ctr = _ctr + 1

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00J.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00F.PRN" MSG='Revise PCWALK'
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWCHANGE_TEM.DAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\input\PCWALK_{Year}{Alt}.DAT",
  z=#1,pkprod=#2,pkattr=#3,opprod=#4,opattr=#5
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PCWALK_{alt}{year}.DAT"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\PCWOP_TEM.DAT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\PCWPK_TEM.DAT"

zones={ZONESA}    ; Number of zones

;Peak period temp pcwalk file
LOOKUP LOOKUPI=1, NAME=PKPCWALK, LOOKUP[1]=1, RESULT=1,LOOKUP[2]=1, RESULT=2,LOOKUP[3]=1, RESULT=3,LOOKUP[4]=1, RESULT=6,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0
        pk_chkzone=PKPCWALK(1,z)         ; Check for existience of zone in peak walk access connectors file(centroid connector) 
        pk_rule=PKPCWALK(4,z,1)
;Off-Peak period temp pcwalk file
LOOKUP LOOKUPI=2, NAME=OPPCWALK, LOOKUP[1]=1, RESULT=1,LOOKUP[2]=1, RESULT=4,LOOKUP[3]=1, RESULT=5,LOOKUP[4]=1, RESULT=6,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0
        op_chkzone=OPPCWALK(1,z)        ; Check for existience of zone in off peak walk access connectors file(centroid connector)
        op_rule=OPPCWALK(4,z,1)
;;Peak period modifications
if (pk_chkzone>0)
  zone =z
  pkp=PKPCWALK(2,z)
  pka=PKPCWALK(3,z)                    ; revised peak PCW's 
  elseif (pk_chkzone==0)
  zone =z
  pkp=0
  pka=0
endif

;;Off-peak period modifications
if (op_chkzone>0)
  zone =z
  opp=OPPCWALK(2,z)
  opa=OPPCWALK(3,z)                   ;revised off peak PCW's 
elseif (op_chkzone==0)
  zone =z
  opp=0
  opa=0
endif

PRINT LIST= zone(5.0),pkp(6.0),pka(6.0),opp(6.0),opa(6.0), PRINTO=1   ; Output PCW with PCW's updated for peak & off peak 

;;Output zones whose PCW were revised
if (_ctr=0) 
  PRINT  LIST =';Percent Walk updated for the zones below based on the following rules:\n\n',
              ';Rule 1 : No Walk Access Connectors to the Zone(PCW=0)\n',
              ';Rule 2 : No Transit Stop at centroid connector and PCW<95% (PCW=0)\n',
              ';Rule 3 : No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK (No Change in PCW)\n',
              ';Rule 4 : No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK (PCW=0)\n',
              ';Rule 5 : Transit Stop at centroid connector & PCW =100% (No Change in PCW)\n',
              ';Rule 6 : Transit Stop at centroid connector & MinPCW<=PCW<100% (No Change in PCW)\n',
              ';Rule 7 : Transit Stop at centroid connector & PCW<MinPCW (PCW=0)\n',PRINTO=2
  PRINT LIST = 'ZONE   ','REVISED_PK_PROD  ','ORIGINAL_PK_PROD  ','PK_RULE  ','REVISED_OP_PROD  ','ORIGINAL_OP_PROD  ','OP_RULE',PRINTO=2
endif

if ( ((pk_rule=1,2,4,7) && pkprod>0) || ((op_rule=1,2,4,7) && opprod>0) ) PRINT LIST = zone(5.0),'         ',pkp(6.0),
  '            ',pkprod(6.0),'       ',pk_rule(3.0),'          ',opp(6.0),'            ',opprod(6.0),'       ',op_rule(3.0),PRINTO=2
    

_ctr=_ctr+1 

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B1.PRN" MSG='Modify TROUTE file to remove DELAY (for AUTOCON program)'
FILEI RECI = "{SCENARIO_DIR}\output\TROUTE_MOD.LIN",
MAXSCAN=120
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\troute_modified.lin"

PAR MAXSTRING=200

;what follows is a modified version of the original script to be able to run autocon using Voyager 5.1 or above
;this modified version was provided by CITILABS Heejoo Ham on March 30, 2011 to PBS&J (an Atkins Company)
;further modified by Atkins to temporarily delete the headway[2] variable so that autocon can run

linestr=reci

pos_delay=strpos('DELAY=',linestr)                        ; check position of "DELAY="
pos_delay_c=strpos('DELAY_C=',linestr)                    ; check position of "DELAY_C="
pos_n=strpos('N=',linestr)                                ; check position of "N="
pos_head=strpos('HEADWAY[2]=',linestr)                    ; check position of "HEADWAY[2]="
linestrlen=strlen(linestr)                                ; length of current record string

pos_linename=strpos('LINE ',linestr)                      ; check position of "LINE NAME"
if (pos_linename>0)
   _curline=1                                             ; flag for beginning current transit line record
endif

if (pos_delay>0 || pos_delay_c>0 || pos_n>0 || pos_head>0)
   rev_linestr=linestr                                    ; revised line string record
   
   if (pos_head>0)
      loop _ii=1,500
         pos_a=strpos('HEADWAY[2]=',rev_linestr)
         if (pos_a>0)
            rev_linestr=deletestr(rev_linestr,pos_a,13)    ; delete "HEADWAY[2]=##"
         else
            break
         endif
      endloop
   endif


   if (pos_delay>0)
      loop _ii=1,500
         pos_a=strpos('DELAY=',rev_linestr)
         if (pos_a>0)
            rev_linestr=deletestr(rev_linestr,pos_a,7)    ; delete "DELAY=#"
         else
            break
         endif
      endloop
   endif
   if (pos_delay_c>0)
      loop _ii=1,500
         pos_b=strpos('DELAY_C=',rev_linestr)
         if (pos_b>0)
            rev_linestr=deletestr(rev_linestr,pos_b,9)    ; delete "DELAY_C=#"
         else
            break
         endif
      endloop
   endif
   if (pos_n>0)
      pos_loc=1
      loop _ii=1,500
         pos_c=strposex('N=',rev_linestr,pos_loc)
         if (pos_c>0 & _curline=1)                        ; skip for the first keyword with "N="
            pos_loc=pos_c+2                               ; replace the first column position after "N="
            _curline=0
            continue
         elseif (pos_c>0 & _curline=0)                    ; remove all "N=" if it is not the first one
            rev_linestr=deletestr(rev_linestr,pos_c,2)
         else
            break
         endif
      endloop
   endif
   print list=rev_linestr,printo=1                        ; write the modified current record
   rev_linestr=''
else                                                      ; if the current line record doesn't
   print list=linestr,printo=1                            ; include any designated keywords
endif


;==========================================================================================================
;What follows is the original script that worked fine with Voyager 5.0, but NOT with VOYAGER 5.1 and above

/*
linestr=reci

; ############## Check for 'DELAY' keyword in the line file
pos_delay=strpos('DELAY=',linestr)
linestrlen=strlen(linestr)
pos_delay_c=strpos('DELAY_C=',linestr)

if (pos_delay_c > 0) goto skip

if (deleten==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline=strpos('N=',linestr)
  s91=substr(linestr,1,pos_n_nextline)
  s92=substr(linestr,pos_n_nextline+2,linestrlen)
  print list='       ',s92,printo=1
  deleten=0
  goto skip
endif

if (deleten1==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline1=strpos('N=',linestr)
  s93=substr(linestr,1,pos_n_nextline1)
  s94=substr(linestr,pos_n_nextline1+2,linestrlen)
  print list='       ',s94,printo=1
  deleten1=0
  goto skip2
endif

if ((pos_delay > 0) & (deleten==0))
; print list=linestr,printo=1
 s1=substr(linestr,1,pos_delay-1)   ;yes
 s2=substr(linestr,pos_delay+6,linestrlen)
; print list='*',s2,'*',printo=1
 pos_n=strpos('N=',s2)
 if (pos_n=0)  ; 'N=' is on the next line
  deleten=1
  s3=' ,'
 else
  deleten=0
  s3=substr(s2,pos_n+2,strlen(s2))
 endif
 print list=s1,s3,printo=1
 s1=' '
 s2=' '
 s3=' '
else
 deleten=0
 print list=linestr,printo=1
endif

:skip

; ############### Also check for 'DELAY_C' keyword

if ((pos_delay_c > 0) & (deleten1==0))
; print list=linestr,printo=1
 s11=substr(linestr,1,pos_delay_c-1)
 s21=substr(linestr,pos_delay_c+8,linestrlen)
; print list='*',s21,'*',printo=1
 pos_n=strpos('N=',s21)
 if (pos_n=0)  ; 'N=' is on the next line
  deleten1=1
  s31=' ,'
 else
  deleten1=0
  s31=substr(s21,pos_n+2,strlen(s21))
 endif
 print list=s11,s31,printo=1
 s11=' '
 s21=' '
 s31=' '
else
 deleten1=0
; print list=linestr,printo=1
endif

:skip2
*/
;====================================================================================================
;end of the original script for Voyager 5.0

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\applications\CNPTR00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\CNPTR00C.PRN" MSG='All walk skim'
FILEI NETI = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"
FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{Year}.RTE"
FILEO MATO[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{Year}.MAT",
 MO=1,DEC=2,NAME=ALLWALK
FILEO REPORTO = "{SCENARIO_DIR}\output\CNPTR00B.RPT"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkCOMRAIL.FAC"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE=5280, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEPK,
           TRANTIME[22]=LI.M22TIMEPK,
           TRANTIME[23]=LI.M23TIMEPK,
           TRANTIME[24]=LI.M24TIMEPK

REPORT LINES=T
PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEPK
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 4 - ALL-WALKS
  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*7,LIST=N,EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),
            NTLEGMODE=4,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,FROMNODE=1-{ZONESI},TONODE=1-{ZONESI}

ENDPROCESS


PROCESS PHASE=SKIMIJ
 IF (TIMEA(0,4) > 0)
  MW[1]=TIMEA(0,4)     ; all walk time
 ELSE
  MW[1]=9999.99
 ENDIF
ENDPROCESS

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; DistributeMULTISTEP ProcessID="NERPM4Dist", ProcessNum=1
; End of PILOT Script

LOOP PER = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
IF (PER == 1)
    Period='PK'
    HWYNET = 'PRELOAD_PT'
ELSEIF (PER == 2)
    Period='OP'
    HWYNET = 'UNLOADED_PT'
ENDIF

; End of PILOT Script

  LOOP ACCESS = 1, 3, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


IF (ACCESS == 1)
    ACCESS_NAME='Walk'
ELSEIF (ACCESS == 2)
    ACCESS_NAME='PNR'
ELSEIF (ACCESS == 3)
    ACCESS_NAME='KNR'
ENDIF
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\APPLICATIONS\TNPTR00W.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\TNPTR00A11_@period@_@access_NAME@.PRN" MSG='Peak transit paths and skims'
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG1@Period@_{alt}{year}.NTL"
FILEO REPORTO = "{SCENARIO_DIR}\output\TNPTR00B_@period@_@access_NAME@.PRN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\trnskim_@period@_@access_NAME@.rpt"

 ; OUTPUT files
FILEO NTLEGO = "{SCENARIO_DIR}\output\@PERIOD@NTL.NTL"
FILEO NETO = "{SCENARIO_DIR}\output\Transit@PERIOD@_@access_name@.NET"

FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_SKYWAY_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-15,DEC=15*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_LOCAL_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-15,DEC=15*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[3] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_EXPRESS_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-15,DEC=15*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[4] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_BRTLRT_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-15,DEC=15*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[5] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_COMRAIL_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-15,DEC=15*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime

FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_SKYWAY_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[2] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_LOCAL_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[3] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_EXPRESS_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[4] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_BRTLRT_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[5] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_COMRAIL_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}

 ; Input files
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\@ACCESS_NAME@SKYWAY.FAC"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\@ACCESS_NAME@LOCAL.FAC"
FILEI FACTORI[3] = "{SCENARIO_DIR}\output\@ACCESS_NAME@EXPRESS.FAC"
FILEI FACTORI[4] = "{SCENARIO_DIR}\output\@ACCESS_NAME@BRTLRT.FAC"
FILEI FACTORI[5] = "{SCENARIO_DIR}\output\@ACCESS_NAME@COMRAIL.FAC"
FILEI NTLEGI[2] = "{SCENARIO_DIR}\output\NTLEG2@Period@_{alt}{year}.NTL"
FILEI NTLEGI[3] = "{SCENARIO_DIR}\output\NTLEG3@Period@_{alt}{year}.NTL"
FILEI NTLEGI[4] = "{SCENARIO_DIR}\output\NTLEG11@Period@_{alt}{year}.NTL"
FILEI NTLEGI[5] = "{SCENARIO_DIR}\output\NTLEG12@Period@_{alt}{year}.NTL"
FILEI NETI = "{SCENARIO_DIR}\output\@HWYNET@_Temp.NET"

zonemsg=50

; OVERALL PARAMETERS OF RUNPARAMETERS USERCLASSES=1-5,FARE=N, MAPSCALE=5280, HDWAYPERIOD=@PER@,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIME@PERIOD@,
           TRANTIME[22]=LI.M22TIME@PERIOD@,
           TRANTIME[23]=LI.M23TIME@PERIOD@,
           TRANTIME[24]=LI.M24TIME@PERIOD@,
           TRANTIME[25]=LI.M25TIME@PERIOD@,
           TRANTIME[26]=LI.M26TIME@PERIOD@

;REPORT LINES=T
;REREPORT LINES=T,TRNLEGS3=T

PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIME@PERIOD@
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP
    ; 1- Generate walk-access links
     GENERATE READNTLEGI=1
    ; 2- Generate PNR-access links
     GENERATE READNTLEGI=2
    ; 3- Generate KNR-access links
     GENERATE READNTLEGI=3
    ; 11- Generate fixed-guideway to bus links
     GENERATE READNTLEGI=4
    ; 12- Generate transfer links
     GENERATE READNTLEGI=5
ENDPROCESS

PROCESS PHASE=SKIMIJ
  ; SKYWAY 
  IF (USERCLASS==1)
      IF (TIMEA(0,23) > 0)                                     ; If Skyway path exists
       MW[1]=TIMEA(0,1)                                        ; Walk time
       MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; Commuter Rail time
       MW[9]=TIMEA(0,27)                                       ; Project mode time
       MW[10]=0
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
      ELSE
       MW[1]=0
       MW[2]=0
       MW[3]=0
       MW[4]=0
       MW[5]=0
       MW[6]=0
       MW[7]=0
       MW[8]=0
       MW[9]=0
       MW[10]=0
       MW[11]=0
       MW[12]=0
       MW[13]=0
       MW[14]=0
       MW[15]=0
      ENDIF
  
  ; LOCAL BUS path
   ELSEIF (USERCLASS=2)  
     IF (TIMEA(0,21) > 0)                                    ; If local bus path exists
       MW[1]=TIMEA(0,1)                                        ; Walk time
       MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; Commuter Rail time
       MW[9]=TIMEA(0,27)                                       ; Project mode time       
       MW[10]=0
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
      ELSE
       MW[1]=0
       MW[2]=0
       MW[3]=0
       MW[4]=0
       MW[5]=0
       MW[6]=0
       MW[7]=0
       MW[8]=0
       MW[9]=0
       MW[10]=0
       MW[11]=0
       MW[12]=0
       MW[13]=0
       MW[14]=0
       MW[15]=0
      ENDIF
       
  ; EXPRESS BUS path
   ELSEIF (USERCLASS=3)  
     IF (TIMEA(0,22) > 0)                                    ; If express bus path exists
       MW[1]=TIMEA(0,1)                                        ; Walk time
       MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; Commuter Rail time
       MW[9]=TIMEA(0,27)                                      ; Project mode time
       MW[10]=0
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
      ELSE
       MW[1]=0
       MW[2]=0
       MW[3]=0
       MW[4]=0
       MW[5]=0
       MW[6]=0
       MW[7]=0
       MW[8]=0
       MW[9]=0
       MW[10]=0
       MW[11]=0
       MW[12]=0
       MW[13]=0
       MW[14]=0
       MW[15]=0
      ENDIF
     
  ; BRTLRT  path
   ELSEIF (USERCLASS=4)  
     IF (TIMEA(0,24) > 0)                       ; If BRT or LRT bus path exists
     ; IF ((TIMEA(0,24)+TIMEA(0,25)) > 0)                       ; If BRT or LRT bus path exists
       MW[1]=TIMEA(0,1)                                        ; Walk time
       MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; Commuter Rail time
       MW[9]=0
       ;       MW[9]=TIMEA(0,27)                                       ; Project mode time
       MW[10]=0
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
      ELSE
       MW[1]=0
       MW[2]=0
       MW[3]=0
       MW[4]=0
       MW[5]=0
       MW[6]=0
       MW[7]=0
       MW[8]=0
       MW[9]=0
       MW[10]=0
       MW[11]=0
       MW[12]=0
       MW[13]=0
       MW[14]=0
       MW[15]=0
      ENDIF   
      
  ; Commuter Rail path
   ELSEIF (USERCLASS=5)  ; 2.5 miles minimum bus ride on KNR paths - from OD survey
     IF (TIMEA(0,26) > 0)                                    ; If Commuter rail path exists
       MW[1]=TIMEA(0,1)                                        ; Walk time
       MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; Commuter Rail time
       MW[9]=TIMEA(0,27)                                       ; Project mode time
       MW[10]=0
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
      ELSE
       MW[1]=0
       MW[2]=0
       MW[3]=0
       MW[4]=0
       MW[5]=0
       MW[6]=0
       MW[7]=0
       MW[8]=0
       MW[9]=0
       MW[10]=0
       MW[11]=0
       MW[12]=0
       MW[13]=0
       MW[14]=0
       MW[15]=0
      ENDIF
   
 ENDIF

ENDPROCESS

ENDRUN


  ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
; End of PILOT Script

ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; EndDistributeMULTISTEP



; End of PILOT Script

LOOP per = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

    IF (per ==1)
     todToken = 'PK'
     hwySkim = 'PRELSKIMS.MAT'
    ElseIF(per ==2)
     todToken = 'OP'
     hwySkim = 'FHSKIMS.MAT'
    EndIF
   
    
    
; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TRMAT00A.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\createDriveToSkywaySkims.PRN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\DriveToSkyway.dat"
FILEO MATO[2] = "{SCENARIO_DIR}\output\@todToken@_DRV_SKYWAY_ZONES.MAT",
MO=11,Name= PNRZONE
FILEO MATO[1] = "{SCENARIO_DIR}\output\@todToken@_DRV_SKYWAY.MAT",
MO=1-10,Name= Toll,Distance,WtTime,WlkTime,SkyTime,Xfers,IWait,Xwait,Fare,TotalTime
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM_@todToken@_SKYWAY_Walk_{Alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@hwySkim@"
    
    ; zones = 2578
    
    ; Loop by pnr lots and get the least time pnr location
    Array pnr=6, pathTime=6, skyTime=6
    pnr[1]=766, pnr[2]=767, pnr[3]=726, pnr[4]=677, pnr[5]=665, pnr[6]=739
    
    ; Loop by JZONES and get least cost path
    JLOOP
      ; Initialize variables for each JZone
      pathTime[1]=9999, pathTime[2]=9999, pathTime[3]=9999, pathTime[4]=9999, pathTime[5]=9999, pathTime[6]=9999
      skyTime[1]=0, skyTime[2]=0, skyTime[3]=0, skyTime[4]=0, skyTime[5]=0, skyTime[6]=0
      ; leastTime  = 9999
      chosenPnr = 0
      
        ; Get the origin-to-pnr and pnr-to-destination travel time
        skyTime[1] = MATVAL(2,4,pnr[1],J,0)
        skyTime[2] = MATVAL(2,4,pnr[2],J,0)
        skyTime[3] = MATVAL(2,4,pnr[3],J,0)
        skyTime[4] = MATVAL(2,4,pnr[4],J,0)
        skyTime[5] = MATVAL(2,4,pnr[5],J,0)
        skyTime[6] = MATVAL(2,4,pnr[6],J,0)
        
        ; pathtime = drive-to-pnr hwy time + trn walk time + skyway IVTT
        IF (skyTime[1] > 0) 
            pathTime[1] = MATVAL(1,3,I,pnr[1],0) + MATVAL(2,1,pnr[1],J,0) + MATVAL(2,4,pnr[1],J,0)
        ENDIF
        IF (skyTime[2] > 0) 
           pathTime[2] = MATVAL(1,3,I,pnr[2],0) + MATVAL(2,1,pnr[2],J,0) + MATVAL(2,4,pnr[2],J,0)
        ENDIF
        IF (skyTime[3] > 0) 
           pathTime[3] = MATVAL(1,3,I,pnr[3],0) + MATVAL(2,1,pnr[3],J,0) + MATVAL(2,4,pnr[3],J,0)
        ENDIF
        IF (skyTime[4] > 0) 
           pathTime[4] = MATVAL(1,3,I,pnr[4],0) + MATVAL(2,1,pnr[4],J,0) + MATVAL(2,4,pnr[4],J,0)
        ENDIF
        IF (skyTime[5] > 0) 
           pathTime[5] = MATVAL(1,3,I,pnr[5],0) + MATVAL(2,1,pnr[5],J,0) + MATVAL(2,4,pnr[5],J,0)
        ENDIF
        IF (skyTime[6] > 0) 
           pathTime[6] = MATVAL(1,3,I,pnr[6],0) + MATVAL(2,1,pnr[6],J,0) + MATVAL(2,4,pnr[6],J,0)
        ENDIF
        
        ; Compute total time if there is a walk to skyway path from that pnr station
        leastTime = min(pathTime[1],pathTime[2],pathTime[3],pathTime[4],pathTime[5],pathTime[6])
        
        ; Record the lowest cost pnr lot
        IF (leastTime == pathTime[1]) chosenPnr = 1
        IF (leastTime == pathTime[2]) chosenPnr = 2
        IF (leastTime == pathTime[3]) chosenPnr = 3
        IF (leastTime == pathTime[4]) chosenPnr = 4
        IF (leastTime == pathTime[5]) chosenPnr = 5
        IF (leastTime == pathTime[6]) chosenPnr = 6
        
        ; Fillin the least cost path values in the matrix
        IF (chosenPnr >0 & leastTime > 0 & leastTime != 9999)
          MW[1] = MATVAL(1,1,I,pnr[chosenPnr],0)   ; Toll cost
          MW[2] = MATVAL(1,2,I,pnr[chosenPnr],0)   ; Distance (hwy only, we don't have distance in trn skim)            
          MW[3] = MATVAL(1,4,I,pnr[chosenPnr],0)   ; Weighted Hwy Time
          MW[4] = MATVAL(2,1,pnr[chosenPnr],J,0)   ; Walk Time
          MW[5] = MATVAL(2,4,pnr[chosenPnr],J,0)   ; Skyway Time
          MW[6] = MATVAL(2,11,pnr[chosenPnr],J,0)  ; Number of xfers
          MW[7] = MATVAL(2,12,pnr[chosenPnr],J,0)  ; Inital waitime
          MW[8] = MATVAL(2,13,pnr[chosenPnr],J,0)  ; Xfer waitime
          MW[9] = MATVAL(2,14,pnr[chosenPnr],J,0)  ; Fare
          MW[10] = leastTime                       ; Time (drive+ walk+ skyway) 
          MW[11] = pnr[chosenPnr]                  ; Get the Choosen PNR lot(zone)
        ENDIF
    
      
      ; Trace for selected I-J pair (I= 1, J = 767)
      IF (I== 1 & J == 1) print form =15.4,list=  'I'(6),'J'(6),'Lot'(4),'pnr'(4),'PT1'(12),'PT2'(12),'PT3'(12),'PT4'(12),'PT5'(12),'PT6'(12), FILE = "C:\NERPM43\APPLICATIONS\DRIVETOSKYWAY.DAT"
      IF (I== 767 & J == 688) print form =15.4,list= I(6), J(6), chosenPnr(4), pnr[chosenPnr](4), 
                                                   pathTime[1](12.4), pathTime[2](12.4), pathTime[3](12.4), 
                                                   pathTime[4](12.4), pathTime[5](12.4), pathTime[6](12.4), 
 FILE = "C:\NERPM43\APPLICATIONS\DRIVETOSKYWAY.DAT"
    
    ENDJLOOP
    
ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; End of PILOT Script

ENDLOOP

