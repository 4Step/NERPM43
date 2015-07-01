; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00J.PRN" MSG='Transit and Walk Accessibility'
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\CONGSKIM_{ALT}{Year}_AM.MAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\OUTPUT\Float_ZnData.csv"
FILEO RECO[1] = "{SCENARIO_DIR}\OUTPUT\WalkTranAcc.dbf"
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\AccCalcsDebug.TXT"
ENDRUN
