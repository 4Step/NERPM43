; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="C:\KumarA\NERPM\CUBE\S2PTR00K.PRN" MSG='Auto to RL Station to Station'
FILEO REPORTO = "C:\KumarA\NERPM\CUBE\S2PTR00L.PRN"
FILEO STOP2STOPO = "C:\KumarA\NERPM\CUBE\S2PTR00F.DBF",
     ACCUMULATE=firstlastbymode, MODES=7-8, N=1650-99999
PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,
           TRIPSIJ[1]=0,
           TRIPSIJ[2]=0,
           TRIPSIJ[3]=100
ENDRUN
