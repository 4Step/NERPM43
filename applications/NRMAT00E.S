; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\NRMAT00A.PRN" MSG='D2D table of mode choice output trip tables'
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_A05.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_A05.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_A05.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\D2DTransitTrip.MAT",
MO=1-15,NAME=hbwWalk,hbwPNR,hbwKNR,hbwKNRtoDT,hbwFringe,hbnwWalk,hbnwPNR,hbnwKNR,hbnwKNRtoDT,hbnwFringe,nhbWalk,nhbPNR,nhbKNR,nhbKNRtoDT,nhbFringe

zonemsg=100

FILLMW MW[1] =MI.1.4,6,8,10,12
FILLMW MW[6] =MI.2.4,6,8,10,12
FILLMW MW[11]=MI.3.4,6,8,10,12

RENUMBER,
 FILE = "{CATALOG_DIR}\PARAMETERS\MODEL_TAZ_DISTRICT_LOOKUP.PRN",
        MISSINGZI=M,
        MISSINGZO=W

ENDRUN
