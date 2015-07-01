; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="D:\JTA RTS Model\APPLICATIONS\SCNET00A.PRN" MSG='Peak Transit Speeds'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PKPreLoad.NET"
FILEO NETO = "D:\JTA RTS Model\APPLICATIONS\SCNET00A.NET"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TRANSPD_091307_v9.DBF"

PROCESS PHASE=LINKMERGE

  if (time_1>0)
    _AUTOSPEED=60*(DISTANCE)/TIME_1
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
  spdratioM27 = 1.0

  LOOP _nn=1,_numberofcurves
    if ((FACILITY_TYPE >= LF[_nn]) & (FACILITY_TYPE <= HF[_nn]) & (AREA_TYPE >= LA[_nn]) & (AREA_TYPE <= HA[_nn]))
     if ((LM[_nn] >= 21) & (HM[_nn] <= 21)) spdratioM21 = SR[_nn]
     if ((LM[_nn] >= 22) & (HM[_nn] <= 22)) spdratioM22 = SR[_nn]
     if ((LM[_nn] >= 23) & (HM[_nn] <= 23)) spdratioM23 = SR[_nn]
     if ((LM[_nn] >= 24) & (HM[_nn] <= 26)) spdratioM24 = SR[_nn]
     if ((LM[_nn] >= 27) & (HM[_nn] <= 27)) spdratioM27 = SR[_nn]
    endif
  ENDLOOP

     ; APPLY DEFAULT CURVES
     IF (_AUTOSPEED>0)
       _TSPD21=spdratioM21*_AUTOSPEED  ; Bus Speeds
       _TSPD22=spdratioM22*_AUTOSPEED  ; BRT Speeds (assumed same as buses)
       _TSPD23=spdratioM23*_AUTOSPEED  ; Circulator Speeds (assumed same as buses)
       _TSPD24=spdratioM24*_AUTOSPEED  ; rail speeds
       _TSPD27=spdratioM27*_AUTOSPEED  ; Project mode

       M21TIMEPK=60*(DISTANCE)/_TSPD21
       M22TIMEPK=60*(DISTANCE)/_TSPD22
       M23TIMEPK=60*(DISTANCE)/_TSPD23
       M24TIMEPK=60*(DISTANCE)/_TSPD24
       M27TIMEPK=60*(DISTANCE)/_TSPD27
     ENDIF

     ; OVERRIDES BUS TIMES FOR BUS LINKS FROM NETWORK
     IF (TBSTIME>0)
        M21TIMEPK=TBSTIME
        M22TIMEPK=TBSTIME
        M23TIMEPK=TBSTIME
        M27TIMEPK=TBSTIME
     ENDIF

     ; GET THE FIXED GUIDEWAY TIMES 
     IF (TFGTIME>0)
        M21TIMEPK=999
        M22TIMEPK=999
        M27TIMEPK=999
     ENDIF

     IF (TFGTIME>0 & TFGMODE=23) M23TIMEPK=TFGTIME     ; skyway times
     IF (TFGTIME>0&TFGMODE=22) 
      M21TIMEPK=TFGTIME     ; Premium buses coded as a local bus mode
      M22TIMEPK=TFGTIME     ; BRT times
     ENDIF
     IF (TFGTIME>0&TFGMODE=11) 
      M21TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for local buses)
      M22TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for premium buses)
      M23TIMEPK=TFGTIME     ; Links with FT=59 (connectors to the station for skyway/trolley buses)
     ENDIF 


     ; ASSIGNS THINGS WITH MISSING VALUES A 999
     IF (M21TIMEPK=0) M21TIMEPK=999
     IF (M22TIMEPK=0) M22TIMEPK=999
     IF (M23TIMEPK=0) M23TIMEPK=999
     IF (M27TIMEPK=0) M27TIMEPK=999

; WALK CONTROLS
     WALKTIME=60*(DISTANCE)/{AVGWLKSPD}
     IF (FACILITY_TYPE=10-19,70-99)
        WALKTIME=999.99
     ENDIF
     IF (FACILITY_TYPE=59) ; escaltor link
        WALKTIME=1.0
     ENDIF

ENDPROCESS

ENDRUN
