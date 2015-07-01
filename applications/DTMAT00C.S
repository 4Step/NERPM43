; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00C.PRN" MSG='Prepares tables for preload - Original 24-Hour Preassignment'
FILEO MATO[1] = "{SCENARIO_DIR}\output\PRELOAD1.MAT",
MO=1-10, NAME=AUTO1,AUTO2,AUTO3HBW,AUTO3HBO,AUTO3NHB,EESO,IEHO,EEHO,IIIETK,EETK, DEC=10*s


zonemsg=100

MW[1]=MI.1.1+MI.1.5+MI.1.9+MI.2.4
MW[2]=MI.1.2+MI.1.6+MI.1.10
MW[3]=MI.1.3
MW[4]=MI.1.7
MW[5]=MI.1.11
MW[6]=MI.3.1
MW[7]=MI.2.5
MW[8]=MI.3.2
MW[9]=MI.2.1+MI.2.2+MI.2.3+MI.2.6+MI.2.7
MW[10]=MI.3.3+MI.3.4

ENDRUN
