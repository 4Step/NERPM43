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
