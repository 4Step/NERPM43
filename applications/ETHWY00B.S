; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\ETHWY00B.PRN" MSG='A Free flow extrated net and Port Trk to see bandwidth'
FILEI NETI = "{Catalog_Dir}\input_SWM\EC2030_SWM\Nerpm4 Extractx.net"
FILEI MATI[1] = "{CATALOG_DIR}\output_SWM\EC2030_SWM\Port_trk_od.mat"
FILEO NETO = "{Catalog_Dir}\output_SWM\EC2030_SWM\PORT_LOD_Futr.NET"

PAR MAXITERS=1

PHASE=LINKREAD
T0=LI.TIME
ENDPHASE

PROCESS PHASE=ILOOP
      PATHLOAD  PATH=COST, VOL[1]=MI.1.2    ; load trips
ENDPROCESS


ENDRUN
