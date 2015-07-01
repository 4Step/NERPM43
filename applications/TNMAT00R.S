; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\TNMAT00E.PRN" MSG='Truth table peak skims'
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIMPK3_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIMPK1_{Alt}{year}.MAT"
FILEO MATO[1] = "C:\NERPM50\APPLICATIONS\TNMAT00A.MAT",
 MO=1-4,NAME=Walk,PNR,KNR,Total

zonemsg=100

FILLMW MW[11]=MI.1.4,5,6,7,8,9,10
FILLMW MW[21]=MI.2.4,5,6,7,8,9,10
FILLMW MW[31]=MI.3.4,5,6,7,8,9,10

COMP total = ROWADD(51,11,12,13,14,15,16,17)
COMP total = ROWADD(52,21,22,23,24,25,26,27)
COMP total = ROWADD(53,31,32,33,34,35,36,37)

JLOOP
  IF (MW[51] > 0) MW[1]=1
  IF (MW[52] > 0) MW[2]=1
  IF (MW[53] > 0) MW[3]=1
  MW[4] = MW[1] + MW[2] + MW[3]
ENDJLOOP

ENDRUN
