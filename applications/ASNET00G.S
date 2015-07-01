; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\ASNET00A.PRN"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEO NETO = "{SCENARIO_DIR}\output\ASNET00A.NET"
FILEI LINKI[2] = "{SCENARIO_DIR}\output\TLOAD2PK_{alt}{year}.DBF"



ENDRUN
