; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00C.PRN" MSG='Build survey trip table'
FILEO MATO[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\MODEL_DATA\NERPM_DATA\JTA_SURVEYS\SURVEYTRIPTABLE.MAT",
MO=1-12,NAME=hbwWalk,hbwPNR,hbwKNR,hbwTotal,hbnwWalk,hbnwPNR,hbnwKNR,hbnwTotal,nhbWalk,nhbPNR,nhbKNR,nhbTotal
FILEI MATI[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\Model_Data\NERPM_Data\jta_surveys\ODbyAccess.csv",
pattern=IJM:V, FIELDS=#1,#2,#6,#3

par zones={ZONESA} zonemsg=100

MW[1]=MI.1.1
MW[2]=MI.1.2
MW[3]=MI.1.3
COMP total = ROWADD(4,1,2,3)
MW[5]=MI.1.4
MW[6]=MI.1.5
MW[7]=MI.1.6
COMP total = ROWADD(8,5,6,7)
MW[9] =MI.1.7
MW[10]=MI.1.8
MW[11]=MI.1.9
COMP total = ROWADD(12,9,10,11)

JLOOP
  IF (I==J)
    IF (MW[1]>0) MW[1]=0
    IF (MW[2]>0) MW[2]=0
    IF (MW[3]>0) MW[3]=0
    IF (MW[4]>0) MW[4]=0
    IF (MW[5]>0) MW[5]=0
    IF (MW[6]>0) MW[6]=0
    IF (MW[7]>0) MW[7]=0
    IF (MW[8]>0) MW[8]=0
    IF (MW[9]>0) MW[9]=0
    IF (MW[10]>0) MW[10]=0
    IF (MW[11]>0) MW[11]=0
    IF (MW[12]>0) MW[12]=0
  ENDIF
ENDJLOOP

ENDRUN
