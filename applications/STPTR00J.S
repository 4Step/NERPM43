; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00G1.PRN" MSG='cbdknr-prj stop to stop file'
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHOP8_{Alt}{year}.RTE"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00H1.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STOP8_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=8,HDWAYPERIOD=2,
           TRIPSIJ[8]=10

ENDRUN
