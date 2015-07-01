; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=TPP2UB PRNFILE="{SCENARIO_DIR}\output\MCMAT00F.PRN" MSG='Convert TPP matrices to Summit UB file'
FILEI VARI = "{SCENARIO_DIR}\output\@PURP@HEAD.VAR"
FILEI MATI = "{SCENARIO_DIR}\output\@PURP@UTIL_{alt}{year}.MAT"
FILEO MATO = "{SCENARIO_DIR}\output\@PURP@UTIL.UB"


ENDRUN
