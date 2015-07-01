; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\PANET00A.PRN" MSG='Add Congested Transit Speeds'
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\TSPDS.CSV"
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD.NET"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PRELOAD.NET"

process phase=linkmerge
  if (time_1>0)
    _AUTOSPEED=60*(DISTANCE/5280)/TIME_1
  else
    _AUTOSPEED=15
  ENDIF

  LOOKUP name=curve,
     lookup[1]=1, result=16,
     lookup[2]=2, result=17,
     lookup[3]=3, result=18,
     lookup[4]=4, result=19,
     lookup[5]=5, result=20,
     lookup[6]=6, result=21,
     lookup[7]=7, result=22,
     lookup[8]=8, result=23,
     lookup[9]=9, result=24,
     lookup[10]=10, result=25,
     lookup[11]=11, result=26,
     lookup[12]=12, result=27,
     lookup[13]=13, result=28,
     lookup[14]=14, result=29,
     lookup[15]=15, result=30,
     interpolate=y, list=y, lookupi=1

read,
 FILE = "{SCENARIO_DIR}\INPUT\CURVES.TXT"

     ; APPLY DEFAULT CURVES
     IF (_AUTOSPEED>0) 
       _TSPD4=CURVE(_CURVEMODE4,_AUTOSPEED)
       _TSPD5=CURVE(_CURVEMODE5,_AUTOSPEED)
       _TSPD6=CURVE(_CURVEMODE6,_AUTOSPEED)
       _TSPD7=CURVE(_CURVEMODE7,_AUTOSPEED)
       _TSPD8=CURVE(_CURVEMODE8,_AUTOSPEED)
       LB4TIME=60*(DISTANCE/5280)/_TSPD4
       LB5TIME=60*(DISTANCE/5280)/_TSPD5
       EB6TIME=60*(DISTANCE/5280)/_TSPD6
       RL7TIME=60*(DISTANCE/5280)/_TSPD7
       RL8TIME=60*(DISTANCE/5280)/_TSPD8
     ENDIF
     ; OVERRIDES FROM NETWORK
     IF (TTIME>0&TMODE= 4) LB4TIME=TTIME
     IF (TTIME>0&TMODE= 5) LB5TIME=TTIME
     IF (TTIME>0&TMODE= 6) EB6TIME=TTIME
     IF (TTIME>0&TMODE= 7) RL7TIME=TTIME
     IF (TTIME>0&TMODE= 8) RL8TIME=TTIME
     ; ASSIGNS THINGS WITH MISSING VALUES A 99
     IF (LB4TIME=0) LB4TIME=99
     IF (LB5TIME=0) LB5TIME=99
     IF (EB6TIME=0) EB6TIME=99
     IF (RL7TIME=0) RL7TIME=99
     IF (RL8TIME=0) RL8TIME=99

ENDPROCESS



ENDRUN
