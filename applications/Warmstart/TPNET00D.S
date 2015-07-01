; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{CATALOG_DIR}\APPLICATIONS\TPNET00D.PRN" MSG='Add PK Period Parking'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\HWYLOAD2_AM_{Alt}{Year}.NET"
FILEI NODEI[2] = "{SCENARIO_DIR}\output\STATION_{alt}{year}.DAT",
var=STANUM,N,STAZ,MAXD,SPACE,STACOST_AM,STACOST_MD,STAW_PNR,STAW_KNR,TSTYPE,STA_NAME(C)

FILEO NETO = "{SCENARIO_DIR}\output\HWYLOAD2_PNR_AM_{Alt}{Year}.NET"



ENDRUN
