; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43\APPLICATIONS\BFHWY00B.PRN" MSG='A Free flow extrated net and Port Trk to see bandwidth'
FILEO NETO = "{Catalog_Dir}\output_SWM\base_SWM\PORT_LOD_Base.NET"
FILEI NETI = "{Catalog_Dir}\input_SWM\base_SWM\Nerpm4 Extractx.net"
FILEI MATI[1] = "{CATALOG_DIR}\output_SWM\base_SWM\Port_trk_od.mat"

PAR MAXITERS=1

PHASE=LINKREAD
T0=LI.TIME
ENDPHASE

PROCESS PHASE=ILOOP
      PATHLOAD  PATH=COST, VOL[1]=MI.1.2    ; load trips
ENDPROCESS


ENDRUN
