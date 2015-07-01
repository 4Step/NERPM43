; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\TNMAT00F.PRN" MSG='Survey trips on transit interchanges'
FILEO PRINTO[1] = "C:\NERPM50\APPLICATIONS\TNMAT00A.PRN"
FILEI MATI[2] = "C:\NERPM50\APPLICATIONS\TNMAT00A.MAT"
FILEI MATI[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\MODEL_DATA\NERPM_DATA\JTA_SURVEYS\SURVEYTRIPTABLE.MAT"
FILEO MATO[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\MODEL_DATA\NERPM_DATA\JTA_SURVEYS\SurveyTripsOnTransit.MAT",
 MO=1-4,NAME=Walk,PNR,KNR,Total

zonemsg=100

FILLMW MW[11]=MI.1.1,2,3
FILLMW MW[21]=MI.2.1,2,3

JLOOP
  IF (MW[11] > 0)
    IF (MW[21] > 0)
      MW[1] = MW[11]
    ELSE
      LIST = I(5.0),"-",J(5.0),MW[11](5.0)," Walk ",printo=1
      MW[1] = 0
    ENDIF
  ELSE
    MW[1] = 0
  ENDIF
  IF (MW[12] > 0)
    IF (MW[22] > 0)
      MW[2] = MW[12]
    ELSE
      LIST = I(5.0),"-",J(5.0),MW[12](5.0)," PNR  ",printo=1
      MW[2] = 0
    ENDIF
  ELSE
    MW[2] = 0
  ENDIF
  IF (MW[13] > 0)
    IF (MW[23] > 0)
      MW[3] = MW[13]
    ELSE
      LIST = I(5.0),"-",J(5.0),MW[13](5.0)," KNR  ",printo=1
      MW[3] = 0
    ENDIF
  ELSE
    MW[3] = 0
  ENDIF
  MW[4] = MW[1] + MW[2] + MW[3]
ENDJLOOP

ENDRUN
