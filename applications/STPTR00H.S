; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00C1.PRN" MSG='cbdknr-prj stop to stop file'
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHPK8_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00D1.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STPK8_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=8,HDWAYPERIOD=1,
           TRIPSIJ[8]=10


ENDRUN
