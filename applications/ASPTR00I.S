; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00I.PRN" MSG='Load Peak Trips to Transit Network (LEG Reports) with NT legs'
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHPK9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHPK8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHPK7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHPK6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHPK5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHPK4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHPK2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHPK1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO NTLEGO = "{SCENARIO_DIR}\output\ASPTR00D.NTL"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\TLOADNTPK_{alt}{year}.DBF",
  NTLEGS=T,ONOFFS=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00J.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\ASPTR00E.NET"

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
