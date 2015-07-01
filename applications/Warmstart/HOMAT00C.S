; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\HOMAT00C.PRN" MSG='Initial Factor Development- Only for Developer :run copy the result to "parameters"'
FILEO MATO[1] = "{SCENARIO_DIR}\\input\HWYFACTOR_{alt}{year}.mat",
MO=11-17  dec=7*d
FILEI MATI[2] = "{CATALOG_DIR}\\parameters\HWYTTAB_{alt}{year}.mat"
FILEI MATI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\HOMAT00B.MAT"


jloop
if (mi.1.1>0)mw[11]=(mi.2.1/mi.1.1)*10000
if (mi.1.2>0)mw[12]=(mi.2.2/mi.1.2)*10000

if (mi.1.3>0)mw[13]=(mi.2.3/mi.1.3)*10000

if (mi.1.4>0)mw[14]=(mi.2.4/mi.1.4)*10000

if (mi.1.5>0)mw[15]=(mi.2.5/mi.1.5)*10000

if (mi.1.6>0)mw[16]=(mi.2.6/mi.1.6)*10000

if (mi.1.7>0)mw[17]=(mi.2.7/mi.1.7)*10000


endjloop
ENDRUN
