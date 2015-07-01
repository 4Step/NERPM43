; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\KumarA\NERPM\CUBE\MCMAT00J.PRN" MSG='Create CODWMD.DBF'
FILEO RECO[1] = "C:\KumarA\NERPM\cube\CODWMD.dbf",
   FIELDS=TAZ, A1, A2
FILEI RECI = "C:\KumarA\NERPM\cube\CODWMD.{alt}{Year}",
   TAZ=1-5, A1=6-10, A2=11-15

RO.TAZ=RI.TAZ
RO.A1=RI.A1
RO.A2=RI.A2

WRITE RECO=1

ENDRUN
