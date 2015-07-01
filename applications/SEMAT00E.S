; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00B.PRN" MSG='Combine selectlink matrices'
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT",
 MO=1-8,DEC=8*2,NAME=pkwalkbbrttime,pkpnrbbrttime,pkknrbbrttime,pkcbdknrbbrttime,opwalkbbrttime,oppnrbbrttime,opknrbbrttime,opcbdknrbbrttime

FILEI MATI[8] = "{SCENARIO_DIR}\output\SELLINKOP7_{alt}{year}.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\SELLINKOP5_{alt}{year}.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\SELLINKOP3_{alt}{year}.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\SELLINKOP1_{alt}{year}.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\SELLINKPK7_{alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\SELLINKPK5_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\SELLINKPK3_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELLINKPK1_{alt}{year}.MAT"

zonemsg=100

FILLMW MW[1]=MI.1.1
FILLMW MW[2]=MI.2.1
FILLMW MW[3]=MI.3.1
FILLMW MW[4]=MI.4.1
FILLMW MW[5]=MI.5.1
FILLMW MW[6]=MI.6.1
FILLMW MW[7]=MI.7.1
FILLMW MW[8]=MI.8.1

ENDRUN
