; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00B.PRN" MSG='Prepare Matrices for GNL'
FILEO MATO[4] = "{SCENARIO_DIR}\output\PERSONS2.TEM",
 MO=1-3, NAME=HBW,HBO,NHB
FILEO MATO[3] = "{SCENARIO_DIR}\output\HFSKIMS.{ALT}{YEAR}",
 mo=15-18, name=COST,DISTANCE,TIME,TIME2, FORMAT=TRANPLAN
FILEO MATO[2] = "{SCENARIO_DIR}\output\FHSKIMS.{ALT}{YEAR}",
 mo=11-14, name=COST,DISTANCE,TIME,TIME2, FORMAT=TRANPLAN
FILEO MATO[1] = "{SCENARIO_DIR}\output\PERSONS.TEM",
 MO=1-3, NAME=HBW,HBO,NHB, FORMAT=TRANPLAN
FILEI MATI[1] = "{SCENARIO_DIR}\output\PTRIP1.MAT"

PAR ZONEMSG=100
array bucket={zonesa}

MW[1]=MI.1.1
MW[2]=MI.1.2+MI.1.3+MI.1.4
MW[3]=MI.1.5

; TRANPLAN STYLE row bucket rounder
loop k=1,3
  jloop
    if (i=1&J=1) BUCKET[K]=0.5
    FRONTEND=(mw[k][j]+bucket[k])
    mw[k][j]=INT(FRONTEND)
    bucket[k]=FRONTEND-(mw[k][j])
  endjloop
endloop


MW[11]=mi.2.1*100
MW[12]=mi.2.2*100
MW[13]=mi.2.3*100
MW[14]=mi.2.4*100
MW[15]=mi.2.5*100
MW[16]=mi.2.6*100
MW[17]=mi.2.7*100
MW[18]=mi.2.8*100


ENDRUN
