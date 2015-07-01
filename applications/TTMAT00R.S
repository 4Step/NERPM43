; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC5.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC4.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC3.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC2.MAT"

FILEI MATI[1] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC1.MAT"


MW[1] = MI.1.1  + MI.2.1 + MI.3.1 + MI.4.1 + MI.5.1  ; DA 
MW[2] = MI.1.2  + MI.2.2 + MI.3.2 + MI.4.2 + MI.5.2  ; SR2 
MW[3] = MI.1.3  + MI.2.3 + MI.3.3 + MI.4.3 + MI.5.3  ; SR3+ 

ENDRUN
