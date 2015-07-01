; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=TPP2UB PRNFILE="{SCENARIO_DIR}\output\MCMAT00Fsb.PRN" MSG='Convert TPP matrices to Summit UB file'
FILEI VARI = "{SCENARIO_DIR}\output\@PURP@HEADsb.VAR"
FILEO MATO = "{SCENARIO_DIR}\output\@PURP@UTILsb.UB"


ENDRUN
