; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\ASNET00B.PRN" MSG='Add link volumes to network for display'
FILEI LINKI[3] = "{SCENARIO_DIR}\output\TLINKOP_{alt}{year}.DBF"
FILEI LINKI[2] = "{SCENARIO_DIR}\output\TLINKPK_{alt}{year}.DBF"
FILEO NETO = "{SCENARIO_DIR}\output\TransitLinkLoad.NET",
  INCLUDE=A,B,NTVOL_PK,TVOL_PK,NTVL_OP,TVOL_OP,TOTAL_VOLUME
FILEI LINKI[1] = "{SCENARIO_DIR}\output\TransitPK.NET"

MERGE RECORD=F

PROCESS  PHASE=LINKMERGE
  NTVOL_PK = LI.2.NTVOL
  TVOL_PK  = LI.2.TVOL
  NTVOL_OP = LI.3.NTVOL
  TVOL_OP  = LI.3.TVOL
  TOTAL_VOLUME = LI.2.NTVOL + LI.2.TVOL + LI.3.NTVOL + LI.3.TVOL
ENDPROCESS

ENDRUN
