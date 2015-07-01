; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00E.PRN" MSG='Combine CG HBW with Other PTRIPS'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PTRIP1.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\CGHBW.MAT"
FILEO MATO[3] = "{SCENARIO_DIR}\output\PTRIPSMC.MAT",
 MO=11-13, NAME=HBW,HBNW,NHB, DEC=3*S
FILEO MATO[1] = "{SCENARIO_DIR}\output\PTRIPS.MAT",
 MO=1-5, NAME=HBW,HBSH,HBSR,HBO,NHB, DEC=5*S

PAR ZONEMSG=100
array bucket=255

MW[1]=MI.2.1
MW[2]=MI.1.2
MW[3]=MI.1.3
MW[4]=MI.1.4
MW[5]=MI.1.5


MW[11]=MI.2.1
MW[12]=MI.1.2+MI.1.3+MI.1.4
MW[13]=MI.1.5

/*
; TRANPLAN STYLE row bucket rounder
loop k=11,13
  jloop
    if (i=1&J=1) BUCKET[K]=0.5
    FRONTEND=(mw[k][j]+bucket[k])
    mw[k][j]=INT(FRONTEND)
    bucket[k]=FRONTEND-(mw[k][j])
  endjloop
endloop
*/


ENDRUN
