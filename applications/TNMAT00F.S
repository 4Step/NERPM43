; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\KumarA\NERPM\CUBE\TNMAT00H.PRN" MSG='Create STATAM.{ALT}{YEAR} for Mode Choice'
FILEO MATO[1] = "C:\KumarA\NERPM\CUBE\STATAM.{ALT}{YEAR}",
 MO=1-2, FORMAT=TRANPLAN
PAR ZONEMSG=100
JLOOP
  MW[1]=MAX(MI.2.1,MI.3.1)
  MW[2]=MAX(MI.5.1,MI.6.1)
ENDJLOOP

ENDRUN
