; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="D:\JTA RTS Model\APPLICATIONS\SBMAT01A.PRN"
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIMPK1_TEM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT"

zonemsg=100

FILLMW MW[1]=MI.1.1     ; time spent on guideway for the trip
FILLMW MW[11]=MI.2.4    ; total bus time for the trip

JLOOP
 if ((MW[1] - MW[11]) > 0.00001 ) print list=I(5), J(5), ' guideway time: ', MW[1](10.2), ' total time on trip: ', MW[11](10.2)
ENDJLOOP

ENDRUN
