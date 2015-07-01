; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{OUTDIR}\STPTR00C.PRN" MSG='auto-prj stop to stop file'
FILEI ROUTEI[4] = "{OUTDIR}\TPATHPK4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{OUTDIR}\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{OUTDIR}\TPATHPK2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{OUTDIR}\TPATHPK1_{Alt}{year}.RTE"
FILEI NETI = "{OUTDIR}\TransitPK.NET"
FILEO REPORTO = "{OUTDIR}\STPTR00D.PRN"

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=4,
           TRIPSIJ[1]=0,
           TRIPSIJ[2]=0,
           TRIPSIJ[3]=0,
           TRIPSIJ[4]=10


ENDRUN
