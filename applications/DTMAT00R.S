; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\DTMAT00D.PRN" MSG='Reformats (Rural Co.) Friction Factors for LOOKUP Function'
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\FF_Rural.CSV"
FILEI RECI = "{SCENARIO_DIR}\input\FF_Rural.DBF"

print csv=t, list=ri.z,ri.hbw,ri.hbsh,ri.hbsr,ri.hbo,ri.nhb,ri.ltrk,ri.mtrk,ri.htrk,ri.soie,ri.hoie,ri.ldie,ri.hdie, printo=1

ENDRUN
