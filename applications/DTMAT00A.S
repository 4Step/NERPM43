; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00A.PRN" MSG='Reformats Friction Factors for LOOKUP Function'
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\FF.CSV"
FILEI RECI = "{SCENARIO_DIR}\input\FF.DBF"

print csv=t, list=ri.z,ri.hbw,ri.hbsh,ri.hbsr,ri.hbo,ri.nhb,ri.ltrk,ri.mtrk,ri.htrk,ri.soie,ri.hoie,ri.ldie,ri.hdie, printo=1

ENDRUN
