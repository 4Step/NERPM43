; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="G:\D2\FDOT\NERPM4_Hwy\APPLICATIONS\HONET00A.PRN"
FILEO NETO = "{SCENARIO_DIR}\COMPARE.NET"
FILEI LINKI[2] = "{SCENARIO_DIR}\Output\FINAL ASGN.NET"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\HWYLOADED{alt}{year}.NET"

HWY=li.1.v_1
FULL=li.2.v_1
HWY_FULL=HWY-FULL

ENDRUN
