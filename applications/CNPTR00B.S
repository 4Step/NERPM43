; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\CNPTR00B.PRN" MSG='Off-peak period connectors'
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkPrj.FAC"
FILEO NETO = "{SCENARIO_DIR}\output\NTLEGSOP.NET"
FILEO NTLEGO = "{SCENARIO_DIR}\output\NTLEGOP_{YEAR}{ALT}.NTL"
FILEO REPORTO = "{SCENARIO_DIR}\output\NTLEGOP.RPT"


ENDRUN
