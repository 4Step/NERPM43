; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\ETNET00A.PRN" MSG='Fix N4 Extracted Subnet for double coding freeway external stations'
FILEO PRINTO[1] = "{CATALOG_DIR}\output_SWM\EC2030_SWM\EQ.csv"
FILEO NETO = "{Catalog_Dir}\input_SWM\EC2030_SWM\Nerpm4 Extractx.net"
FILEI LINKI[1] = "{CATALOG_DIR}\input_SWM\EC2030_SWM\Nerpm4 Extract.net"

PROCESS  PHASE=INPUT,filei=LI.1
if(A=503) A=504
if(B=503) B=504
if(A=479) A=480
if(B=479) B=480
ENDPROCESS

PROCESS  PHASE=INPUT,filei=NI.1
if(N=503) N=504
if(N=479) N=480
ENDPROCESS


PROCESS  PHASE=NODEMERGE  
; Use this phase to make computations and selections of any data on the NODEI files.

if(n<=508) print csv=T, list=n(5.0),old_node(5.0),printo=1

ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS

ENDRUN
