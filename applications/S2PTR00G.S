; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="C:\KumarA\NERPM\CUBE\S2PTR00A.PRN" MSG='Walk to LB Station to Station'
FILEO REPORTO = "C:\KumarA\NERPM\CUBE\S2PTR00B.PRN"
FILEO STOP2STOPO = "C:\KumarA\NERPM\CUBE\S2PTR00A.DBF",
     ACCUMULATE=firstlastbymode, MODES=4-5, N=1650-99999
PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0, HDWAYPERIOD=2, 
           TRIPSIJ[1]=100,
           TRIPSIJ[2]=0,
           TRIPSIJ[3]=0
ENDRUN
