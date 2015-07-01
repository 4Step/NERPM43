; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\ACNET01G.PRN" MSG='Peak add PNR Lot data to Station Node'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"
FILEI NODEI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{Year}.DAT" ,
var=STANUM,N,STAZ,MAXD,SPACE,STACOST_AM,STACOST_MD,STAW_PNR,STAW_KNR,TSTYPE,STA_NAME(C)
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD_PT_TEMP.NET"

ENDRUN
