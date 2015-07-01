; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00A1.PRN"
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT",
 MO=1-8, DEC=8*2,NAME=pkwalkbbrttime,pkpnrbbrttime,pkknrbbrttime,pkcbdknrbbrttime,opwalkbbrttime,oppnrbbrttime,opknrbbrttime,opcbdknrbbrttime

zonemsg=100
zones={ZONESA}

MW[1]=0
MW[2]=0
MW[3]=0
MW[4]=0
MW[5]=0
MW[6]=0
MW[7]=0
MW[8]=0

ENDRUN
