; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\NTMAT00A.PRN"
FILEO MATO[1] = "{SCENARIO_DIR}\output\FHSKIMS.{ALT}{YEAR}",MO=1-4,NAME=COST,DISTANCE,TIME,TIME2,FORMAT=TRANPLAN
FILEI MATI[1] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"

zonemsg=100

MW[1]=MI.1.1*100
MW[2]=MI.1.2*100
MW[3]=MI.1.3*100
MW[4]=MI.1.4*100

ENDRUN
