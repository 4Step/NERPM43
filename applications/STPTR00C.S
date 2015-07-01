; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00E.PRN" MSG='knr-prj stop to stop file'
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHPK6_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00F.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STPK6_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=6,HDWAYPERIOD=1,
           TRIPSIJ[6]=10


ENDRUN
