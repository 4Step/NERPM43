; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{CATALOG_DIR}\APPLICATIONS\TPNET00E.PRN" MSG='Add OP Period Parking'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\HwyLoad2_MD_{alt}{year}.net"
FILEI NODEI[2] = "{SCENARIO_DIR}\output\STATION_{alt}{year}.DAT",
var=STANUM,N,STAZ,MAXD,SPACE,STACOST_AM,STACOST_MD,STAW_PNR,STAW_KNR,TSTYPE,STA_NAME(C)

FILEO NETO = "{SCENARIO_DIR}\output\HWYLOAD2_PNR_MD_{Alt}{Year}.NET",
    EXCLUDE=STAPARKCOST_AM


ENDRUN
