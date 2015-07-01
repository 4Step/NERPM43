; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00E1.PRN" MSG='cbdknr-bus stop to stop file'
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00F1.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STOP7_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=7,HDWAYPERIOD=2,
           TRIPSIJ[7]=10

ENDRUN
