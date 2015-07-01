; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00B.PRN" MSG='for JUATS'
FILEO MATO[1] = "{SCENARIO_DIR}\output\DTMAT00A.MAT",
 MO=1-3, NAME=HBW,HBO,NHB

MW[1]=MI.1.1
MW[2]=MI.1.2
MW[3]=MI.1.3


RENUMBER,
 FILE = "C:\NERPM43\PARAMETERS\JUATS_LOOKUP.PRN",
        MISSINGZI=M,
        MISSINGZO=W

 
ENDRUN
