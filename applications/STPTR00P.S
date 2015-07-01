; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00S2.PRN" MSG='fringe-pnr stop to stop file'
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHOP9_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00T2.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STOP9_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=23, N={ZONESA1}-99999
; - use only circulator for this path

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=9,HDWAYPERIOD=2,
           TRIPSIJ[9]=10

ENDRUN
