; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\KumarA\NERPM\CUBE\MCMAT00K.PRN" MSG='Create CODW.DBF'
FILEO RECO[1] = "C:\KumarA\NERPM\cube\CODW.dbf",
   FIELDS=TAZ,CODWLKAM,CODWLKMD

PAR ZONES={ZONESA} ZONEMSG=100

RO.TAZ=zi.1.TAZ
RO.CODWLKAM=zi.1.A1
RO.CODWLKMD=zi.2.A1

WRITE RECO=1

ENDRUN
