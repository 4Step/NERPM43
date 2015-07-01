; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\TPPTR00C.PRN" MSG='Load Off-peak BRT-related Trips (LEG Reports)'
FILEI MATI[1] = "{SCENARIO_DIR}\output\BRTTRIPS_{alt}{year}.MAT"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHOP9_{alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHOP8_{alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHOP6_{alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHOP4_{alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHOP2_{alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHOP1_{alt}{year}.RTE"
FILEO NTLEGO = "{SCENARIO_DIR}\output\TPPTR00B.NTL"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\BRTLEGSOP.DBF",
  NTLEGS=N,ONOFFS=T
FILEO REPORTO = "{SCENARIO_DIR}\output\TPPTR00D.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\TPPTR00B.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES={RunUserClasses},HDWAYPERIOD=2,
    TRIPSIJ[1]=MI.1.10,   ;walkbus
    TRIPSIJ[2]=MI.1.11,   ;walkprem
    TRIPSIJ[3]=MI.1.12,   ;pnrbus
    TRIPSIJ[4]=MI.1.13,   ;pnrprem
    TRIPSIJ[5]=MI.1.14,   ;knrbus
    TRIPSIJ[6]=MI.1.15,   ;knrprem
    TRIPSIJ[7]=MI.1.16,   ;knrbus
    TRIPSIJ[8]=MI.1.17,   ;knrprem
    TRIPSIJ[9]=MI.1.18    ;fringe

REPORT LINES=T, LINEVOLS=T

ENDRUN
