; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00H.PRN" MSG='Matrix Compression'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PTRIPS.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PTRIPSCMP.MAT",
 MO=1-5, NAME=HBW,HBSH,HBSR,HBO,NHB

MW[1]=MI.1.1
MW[2]=MI.1.2
MW[3]=MI.1.3
MW[4]=MI.1.4
MW[5]=MI.1.5

RENUMBER,
 FILE = "{CATALOG_DIR}\PARAMETERS\DISTRICTS.TXT",
        MISSINGZI=M,
        MISSINGZO=W

 
ENDRUN
