; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00G.PRN" MSG='knr-bus stop to stop file'
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00H.PRN"
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\ST2STOP5_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=5,HDWAYPERIOD=2,
           TRIPSIJ[5]=10

ENDRUN
