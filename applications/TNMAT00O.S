; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00A1.PRN"
FILEO RECO[1] = "{SCENARIO_DIR}\output\WLB_DISCONNECT.DBF",
FIELDS=Z,CONNECTED
FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIMPK1_{Alt}{year}.MAT"

zonemsg=100, zones={ZONESA}

FILLMW MW[1]=MI.1.1

_x1=ROWSUM(1)

if (_x1=0) CONNECTED=0
if (_x1>0) CONNECTED=1
WRITE RECO=1

ENDRUN
