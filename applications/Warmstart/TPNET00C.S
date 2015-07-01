
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{CATALOG_DIR}\APPLICATIONS\TPNET00C.PRN" MSG='Transit speed for PK'
FILEI LINKI[1] = "C:\NERPM43\applications\Warmstart\PreAssign_AM.NET"
FILEI LOOKUPI[1] = "C:\NERPM43\applications\Warmstart\TRANSPD.DBF"
FILEO NETO = "{SCENARIO_DIR}\output\HWYLOAD2_AM_{Alt}{Year}.NET"

PROCESS PHASE=LINKMERGE

  ;If auto travel time is not present or is zero, a default value of 15 mph is used.
  IF (TIME>0)
    _AUTOSPEED=60*DISTANCE/TIME
  ELSE
    _AUTOSPEED=15
  ENDIF

;**************************************************************
;BEGIN POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************

;************************************************************************************************
;* DEFAULT TRANSIT SPEEDS SET EQUAL TO AUTO SPEEDS. APPLY APPROPRIATE TRANSIT SPEED CURVES HERE.*
;************************************************************************************************

lookup name=curve,
     lookup[1]=CURVE_NO, result=LOW_MODE,
     lookup[2]=CURVE_NO, result=HIGH_MODE,
     lookup[3]=CURVE_NO, result=LOW_FT,
     lookup[4]=CURVE_NO, result=HIGH_FT,
     lookup[5]=CURVE_NO, result=LOW_AT,
     lookup[6]=CURVE_NO, result=HIGH_AT,
     lookup[7]=CURVE_NO, result=PKSPDRATIO,
     interpolate=n,fail=0,0,0,list=y,lookupi=1
array lm=500,hm=500,lf=500,hf=500,la=500,ha=500,sr=500

loop _nn=1,500
   LM[_nn]=CURVE(1,_nn)
   HM[_nn]=CURVE(2,_nn)
   LF[_nn]=CURVE(3,_nn)
   HF[_nn]=CURVE(4,_nn)
   LA[_nn]=CURVE(5,_nn)
   HA[_nn]=CURVE(6,_nn)
   SR[_nn]=CURVE(7,_nn)
if (lm[_nn]>0) _numberofcurves=_nn ; obtain the total number of curves fromt he curve file
if (lm[_nn]<=0) break
endloop

;**************************************************************
;END POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************
      ; Bus time overrides
; IF   (TBSSPEED>0 && TBSTIME==0) TBSTIME = (DISTANCE/TBSSPEED)*60.0
; IF   (TBSTIME>0)
;       M21TIMEPK=TBSTIME
;       M22TIMEPK=TBSTIME
;       M23TIMEPK=TBSTIME
; ENDIF

  LOOP _nn=1,_numberofcurves
    if ((FACILITY_TYPE >= LF[_nn]) & (FACILITY_TYPE <= HF[_nn]) & (AREA_TYPE >= LA[_nn]) & (AREA_TYPE <= HA[_nn]))
    if ((LM[_nn] >= 21) & (HM[_nn] <= 21)) spdratioM21 = SR[_nn]
    if ((LM[_nn] >= 22) & (HM[_nn] <= 22)) spdratioM22 = SR[_nn]
        if ((LM[_nn] >= 23) & (HM[_nn] <= 26)) spdratioM23 = SR[_nn]
    if ((LM[_nn] >= 27) & (HM[_nn] <= 27)) spdratioM27 = SR[_nn]  
    
    endif
  ENDLOOP
     ; APPLY DEFAULT CURVES
     IF (_AUTOSPEED>0)
       _TSPD21=spdratioM21*_AUTOSPEED  ; Bus Speeds
       _TSPD22=spdratioM22*_AUTOSPEED  ; Premium Bus
       _TSPD23=spdratioM23*_AUTOSPEED  ; Circulator Speeds (assumed same as buses)
             _TSPD27=spdratioM27*_AUTOSPEED  ; Project mode
       
       M21TIMEPK=60*(DISTANCE)/_TSPD21
       M22TIMEPK=60*(DISTANCE)/_TSPD22
         M23TIMEPK=60*(DISTANCE)/_TSPD23
             M27TIMEPK=60*(DISTANCE)/_TSPD27
       
 
 
     ENDIF
;OVERRIDES BUS TIMES FOR BUS LINKS FROM NETWORK
  ;   IF (TBSTIME>0)
  ;      M21TIMEOP=TBSTIME
  ;      M22TIMEOP=TBSTIME
  ;   ENDIF

    
      ; WALK CONTROLS
      WALKTIME=60*DISTANCE/{AVGWLKSPD}
 IF (FACILITY_TYPE=10-19,70-99)
      WALKTIME=999.99
 ENDIF
 
 IF (FACILITY_TYPE=59)
      WALKTIME=1
      DISTANCE=0.05
      ADJDISTANCE=DISTANCE
 ENDIF

 IF((A={FromNode}) && (B={ToNode}))

      list="\n\n"
      list="     An     Bn   Dist   ASpd   Atim   TSpd   Ttim    Crv"
      list=A(7.0),B(7.0),DISTANCE(7.2),_AUTOSPEED(7.2),TIME_1(7.2),_TSPD21(7.2),M21TIMEPK(7.2),_CURVEMODE21(7.0)," MODE21"
      list=A(7.0),B(7.0),DISTANCE(7.2),_AUTOSPEED(7.2),TIME_1(7.2),_TSPD22(7.2),M22TIMEPK(7.2),_CURVEMODE22(7.0)," MODE22"
        list=A(7.0),B(7.0),DISTANCE(7.2),_AUTOSPEED(7.2),TIME_1(7.2),_TSPD23(7.2),M23TIMEPK(7.2),_CURVEMODE23(7.0)," MODE23"
            list=A(7.0),B(7.0),DISTANCE(7.2),_AUTOSPEED(7.2),TIME_1(7.2),_TSPD27(7.2),M27TIMEPK(7.2),_CURVEMODE27(7.0)," MODE27"
      list="\n\n"
 ENDIF

 ENDPROCESS

ENDRUN
