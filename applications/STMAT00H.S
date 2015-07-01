; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="D:\JTA RTS Model\APPLICATIONS\STMAT00A.PRN"
FILEI ZDATI[1] = "D:\JTA RTS Model\BASECF2005\OUTPUT\TAZDATA_A05.DBF"
FILEI MATI[1] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"

zonemsg=100

FILLMW MW[1]=MI.1.2

JLOOP
 _x1=MW[1][J]
 if (ZI.1.CBD_DUMMY[_x1]=1) print list=" **** CBD KNR path,",I(5), J(5)
ENDJLOOP

ENDRUN
