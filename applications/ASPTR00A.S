; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00A.PRN" MSG='Load Peak Trips to Transit Network (LEG Reports)'
FILEO NTLEGO = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.NTL"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.DBF",
NTLEGS=N,ONOFFS=T
;FILEO LINKO[1] = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.DBF",
;NTLEGS=N,ONOFFS=T
;FILEO LINKO[2] = "{SCENARIO_DIR}\output\TLOAD2PK_{alt}{year}.DBF",
;NTLEGS=N,ONELINKREC=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00E.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES={RunUserClasses},HDWAYPERIOD=1,
    TRIPSIJ[1]=MI.1.1,   ;walkbus
    TRIPSIJ[2]=MI.1.2,   ;walkprem
    TRIPSIJ[3]=MI.1.3,   ;pnrbus
    TRIPSIJ[4]=MI.1.4,   ;pnrprem
    TRIPSIJ[5]=MI.1.5,   ;knrbus
    TRIPSIJ[6]=MI.1.6,   ;knrprem
    TRIPSIJ[7]=MI.1.7,   ;knrbus
    TRIPSIJ[8]=MI.1.8,   ;knrprem
    TRIPSIJ[9]=MI.1.9    ;fringe

REPORT LINES=T, LINEVOLS=T

ENDRUN
