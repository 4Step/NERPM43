; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00F.PRN" MSG='Check selectlink calculations'
FILEI MATI[4] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP2.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP2.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\TNMAT00A.MAT",
MO=101,102,DEC=2
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIMPK3_TEM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIMPK1_TEM.MAT"

zonemsg=100

FILLMW MW[1] =MI.1.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[41]=MI.3.1 ;,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
FILLMW MW[61]=MI.4.1 ;,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19

JLOOP
; if ( (MW[43] > 0) && (MW[11] = 0) ) print list=I(5.0),'-',J(5.0),'***************** Problematic interchange ************'
; MW[1] = MAX( MW[56], MW[57])
; MW[2] = MAX( 1, 0 )

 if ((MW[41] - MW[4]) > 0.0001) print list=I(5.0),'-',J(5.0),MW[4](10.6),MW[41](10.6),'***************** Problematic interchange in mat 1************'
 if ((MW[61] - MW[24]) > 0.0001) print list=I(5.0),'-',J(5.0),MW[24](10.6),MW[61](10.6),'***************** Problematic interchange in mat 2************'
 if (MW[4] > 0) MW[101]=MW[41]/MW[4]
 if (MW[24] > 0) MW[102]=MW[61]/MW[24]

ENDJLOOP

ENDRUN
