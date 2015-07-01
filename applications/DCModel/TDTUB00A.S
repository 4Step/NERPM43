; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=TPP2UB PRNFILE="{CATALOG_DIR}\APPLICATIONS\TDTUB00A.PRN" MSG='Convert Voyager matrices to Summit Datafile'
FILEI VARI = "{SCENARIO_DIR}\output\@_PURP@@_PERIOD@HEAD.VAR"
FILEO MATO = "{SCENARIO_DIR}\OUTPUT\@_PURP@_@_PERIOD@UTIL.UB"


ENDRUN
