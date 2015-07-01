; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00K2.PRN" MSG='fringe-pnr stop to stop file'
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHPK9_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00L2.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STPK9_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=23, N={ZONESA1}-99999
; only circulators allowed in this path

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=9,HDWAYPERIOD=1,
           TRIPSIJ[9]=10

ENDRUN
