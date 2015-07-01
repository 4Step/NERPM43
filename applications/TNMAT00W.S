; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\TNMAT00J.PRN" MSG='comparison by access'
FILEI MATI[4] = "C:\NERPM50\APPLICATIONS\TNMAT00D.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIMPK3_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIMPK1_{Alt}{year}.MAT"
FILEO MATO[1] = "C:\NERPM50\APPLICATIONS\TNMAT00E.MAT",
 MO=1-6,NAME=SkimWlkBoard,SurveyWlkBoard,SkimPNRBoard,SurveyPNRBoard,SkimKNRBoard,SurveyKNRBoard

zonemsg=100

FILLMW MW[11]=MI.1.4,6,11
FILLMW MW[21]=MI.2.4,6,11
FILLMW MW[31]=MI.3.4,6,11
FILLMW MW[41]=MI.4.1,2,3

JLOOP
  IF (MW[42] = 1)   ; walk access
     IF (MW[11]+MW[12] = 0)
        MW[1]=-999           ; no path
     ELSE
        MW[1]=MW[13]+1
     ENDIF
        MW[2]=MW[43]
  ENDIF
  IF (MW[42] = 2)   ; pnr access
     IF (MW[21]+MW[22] = 0)
        MW[3]=-999           ; no path
     ELSE
        MW[3]=MW[23]+1
     ENDIF
        MW[4]=MW[43]
  ENDIF
  IF (MW[42] = 3)   ; knr access
     IF (MW[31]+MW[32] = 0)
        MW[5]=-999           ; no path
     ELSE
        MW[5]=MW[33]+1
     ENDIF
        MW[6]=MW[43]
  ENDIF
ENDJLOOP

ENDRUN
