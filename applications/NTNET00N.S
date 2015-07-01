; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{Scenario_Dir}\output\HNET.PRN" MSG='Assigns Accel/Decel Attributes to Links'
FILEO PRINTO[3] = "{Scenario_Dir}\output\XY_{alt}{year}.DAT"
FILEI NODEI[3] = "{Scenario_Dir}\output\NODECNT.DBF"
FILEO PRINTO[2] = "{Scenario_Dir}\output\LINKS.{YEAR}{ALT}"
FILEO PRINTO[1] = "{Scenario_Dir}\output\NODES.CSV"
FILEI LOOKUPI[1] = "{Scenario_Dir}\input\TSPDS.CSV"
FILEO NETO = "{Scenario_Dir}\output\UNLOADEDpre.NET"
FILEI LINKI[1] = "{Scenario_Dir}\output\TEMP.NET"
FILEI NODEI[2] = "{Scenario_Dir}\output\TEMPNODE.DAT",
 VAR=N,_TOLL_ACC,_TOLL_DEC

PAR ZONES={ZONESA}


PROCESS  PHASE=INPUT, FILEI=LI.1
  TOLL_ACC=0
  TOLL_DEC=0
ENDPROCESS

PROCESS PHASE=NODEMERGE
   PRINT CSV=T, LIST=N(8.0),X,Y printo=1
   PRINT LIST=N(6.0),X(20.2),Y(20.2) printo=3
   IF (TIMESUSED=0) DELETE
ENDPROCESS

PROCESS PHASE=LINKMERGE   
  IF(B._TOLL_DEC=1) TOLL_DEC=1
  IF(A._TOLL_ACC=1) TOLL_ACC=1

_focus=1
_ft=int(facility_type/10)
_at=int(area_type/10)
print list=_focus(2.0),a(5.0),b(5.0),distance*100/5280(4.0),toll(2.0),_ft(1.0),_at(1.0), printo=2



;sks (5-11-2011) (Check CARTOLL NON-Zero but SVCSEC IS ZERO, then add a small/tiny SVCSEC)...

IF (CARTOLL>0 & SVCSECONDS=0) SVCSECONDS=0.00001
IF (CARTOLL>0 & PLZALNSMAX=0) PLZALNSMAX=NUM_LANES

ENDPROCESS



ENDRUN
