; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\PAMAT00A2.PRN"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PERSON3.TEM",
MO=11-13,NAME=HBW,HBNW,NHB
FILEI MATI[2] = "{SCENARIO_DIR}\output\FFHBW.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\PERSONS2.TEM"

zonemsg=100

FILLMW MW[11]=MI.2.1
FILLMW MW[12]=MI.1.2
FILLMW MW[13]=MI.1.3

ENDRUN
