; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\DTMAT00A.PRN" MSG='Reformats Friction Factors for LOOKUP Function'
FILEO PRINTO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\FF.CSV"
FILEI RECI = "C:\NERPM43\APPLICATIONS\WARMSTART\FF.DBF"

print csv=t, list=ri.z,ri.hbw,ri.hbsh,ri.hbsr,ri.hbo,ri.nhb,ri.ltrk,ri.mtrk,ri.htrk,ri.soie,ri.hoie,ri.ldie,ri.hdie, printo=1

ENDRUN
