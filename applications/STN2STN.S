; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

DistributeMULTISTEP ProcessID="JTADist", ProcessNum=1

; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00K.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00I2.PRN" MSG='pnr-bus stop to stop file'
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00J2.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK3_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=3,HDWAYPERIOD=1,
           TRIPSIJ[3]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\Models\NERPM_PT\applications\STPTR00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00A.PRN" MSG='knr-bus stop to stop file'
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHPK5_{Alt}{year}.RTE"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00B.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK5_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=5,HDWAYPERIOD=1,
           TRIPSIJ[5]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00A1.PRN" MSG='cbdknr-bus stop to stop file'
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHPK7_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00B1.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK7_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=7,HDWAYPERIOD=1,
           TRIPSIJ[7]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00L.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00K2.PRN" MSG='fringe-pnr stop to stop file'
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHPK9_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00L2.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK9_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=23, N={ZONESA1}-99999
; only circulators allowed in this path

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=9,HDWAYPERIOD=1,
           TRIPSIJ[9]=10

ENDRUN


; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\STMAT00A.PRN"
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2STPK_bus_{alt}{year}.MAT",
 MO=1,21-22,2,23-24,3,25-26,4,27-28,
 NAME=FromStation_pnrb,StationTAZ_pnrb,PKParkCost_pnrb,
      FromStation_knrb,StationTAZ_knrb,PKParkCost_knrb,
      FromStation_cbdknrb,StationTAZ_cbdknrb,PKParkCost_cbdknrb,
      FromStation_frgb,StationTAZ_frgb,PKParkCost_frgb
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI MATI[4] = "{SCENARIO_DIR}\output\ST2STPK9_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[3] = "{SCENARIO_DIR}\output\ST2STPK7_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[2] = "{SCENARIO_DIR}\output\ST2STPK5_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[1] = "{SCENARIO_DIR}\output\ST2STPK3_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE

PAR ZONES={ZONESA} zonemsg=100

;STATION PARKING COST INTO A LOOKUP TABLE - station, statnumber, spaces,pnrterm,knrterm,nearestzone(distance),nearestzone(statdata input),ampnrcost,mdpnrcost

LOOKUP LOOKUPI=1, NAME=STATIONS,
 LOOKUP[1]=2, RESULT=1,; STATION ZONE
 LOOKUP[2]=2, RESULT=6,; Peak Period Pakring Cost
 FAIL=0

MW[1]=MI.1.1 ;+ MI.1.23
MW[2]=MI.2.1 ;+ MI.1.23
MW[3]=MI.3.1 ;+ MI.1.23
MW[4]=MI.4.1 ;+ MI.1.23

JLOOP
 ;FIRST FIGURE OUT THE STATION EQUIVALENT FOR EACH CELL, 0 IF NO MATCH
 ;NEXT, ASSIGN THE STATION EQUIVALENT FOR EACH CELL TO A WORK MATRIX
  STATZONE1=STATIONS(1,MW[1][J],0)
  PARKINGCOST1=STATIONS(2,MW[1][J],0)
  MW[21][J]=STATZONE1
  MW[22][J]=PARKINGCOST1

  STATZONE2=STATIONS(1,MW[2][J],0)
  PARKINGCOST2=STATIONS(2,MW[2][J],0)
  MW[23][J]=STATZONE2
  MW[24][J]=PARKINGCOST2

  STATZONE3=STATIONS(1,MW[3][J],0)
  PARKINGCOST3=STATIONS(2,MW[3][J],0)
  MW[25][J]=STATZONE3
  MW[26][J]=PARKINGCOST3

  STATZONE4=STATIONS(1,MW[4][J],0)
  PARKINGCOST4=STATIONS(2,MW[4][J],0)
  MW[27][J]=STATZONE4
  MW[28][J]=PARKINGCOST4

  if (MW[21][J] == 0) MW[1][J]=0
  if (MW[23][J] == 0) MW[2][J]=0
  if (MW[25][J] == 0) MW[3][J]=0
  if (MW[27][J] == 0) MW[4][J]=0
  ;clean up where start and end stations are the same OR do not both board and alight at a station
;  if (mw[51][j]=mw[52][j]|MW[51][J]=0|MW[52][J]=0) mw[51][j]=0 mw[52][j]=0 mw[3][j]=0 mw[55]=0 mw[56]=0 mw[57]=0 mw[58]=0 MW[59]=0

ENDJLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

if ({isBRTProjectMode}=0)
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00M.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00M2.PRN" MSG='pnr-prj stop to stop file'
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHPK4_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00N2.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK4_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=4,HDWAYPERIOD=1,
           TRIPSIJ[4]=10


ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\Models\NERPM_PT\applications\STPTR00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00E.PRN" MSG='knr-prj stop to stop file'
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHPK6_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00F.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK6_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=6,HDWAYPERIOD=1,
           TRIPSIJ[6]=10


ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00C1.PRN" MSG='cbdknr-prj stop to stop file'
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHPK8_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00D1.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STPK8_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=8,HDWAYPERIOD=1,
           TRIPSIJ[8]=10


ENDRUN


; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\STMAT00B.PRN"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI MATI[3] = "{SCENARIO_DIR}\output\ST2STPK8_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[2] = "{SCENARIO_DIR}\output\ST2STPK6_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[1] = "{SCENARIO_DIR}\output\ST2STPK4_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2STPK_prj_{alt}{year}.MAT",
 MO=1,21-22,2,23-24,3,25-26,
 NAME=FromStation_pnrb,StationTAZ_pnrb,PKParkCost_pnrb,
      FromStation_knrb,StationTAZ_knrb,PKParkCost_knrb,
      FromStation_cbdknrb,StationTAZ_cbdknrb,PKParkCost_cbdknrb

PAR ZONES={ZONESA} zonemsg=100

; STATION PARKING COST INTO A LOOKUP TABLE
;station, statnumber, spaces,pnrterm,knrterm,nearestzone(distance),nearestzone(statdata input),ampnrcost,mdpnrcost

LOOKUP LOOKUPI=1, NAME=STATIONS,
 LOOKUP[1]=2, RESULT=1,; STATION ZONE
 LOOKUP[2]=2, RESULT=6,; Peak Period Pakring Cost
 FAIL=0

MW[1]=MI.1.1 ;+ MI.1.23
MW[2]=MI.2.1 ;+ MI.1.23
MW[3]=MI.3.1 ;+ MI.1.23

JLOOP
 ;FIRST FIGURE OUT THE STATION EQUIVALENT FOR EACH CELL, 0 IF NO MATCH
 ;NEXT, ASSIGN THE STATION EQUIVALENT FOR EACH CELL TO A WORK MATRIX
  STATZONE1=STATIONS(1,MW[1][J],0)
  PARKINGCOST1=STATIONS(2,MW[1][J],0)
  MW[21][J]=STATZONE1
  MW[22][J]=PARKINGCOST1

  STATZONE2=STATIONS(1,MW[2][J],0)
  PARKINGCOST2=STATIONS(2,MW[2][J],0)
  MW[23][J]=STATZONE2
  MW[24][J]=PARKINGCOST2

  STATZONE3=STATIONS(1,MW[3][J],0)
  PARKINGCOST3=STATIONS(2,MW[3][J],0)
  MW[25][J]=STATZONE3
  MW[26][J]=PARKINGCOST3

  if (MW[21][J] == 0) MW[1][J]=0
  if (MW[23][J] == 0) MW[2][J]=0
  if (MW[25][J] == 0) MW[3][J]=0
  ;clean up where start and end stations are the same OR do not both board and alight at a station
;  if (mw[51][j]=mw[52][j]|MW[51][J]=0|MW[52][J]=0) mw[51][j]=0 mw[52][j]=0 mw[3][j]=0 mw[55]=0 mw[56]=0 mw[57]=0 mw[58]=0 MW[59]=0

ENDJLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

else
; End of PILOT Script

; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2STPK_prj_{alt}{year}.MAT",
 MO=1-9,
 NAME=FromStation_pnrb,StationTAZ_pnrb,PKParkCost_pnrb,
      FromStation_knrb,StationTAZ_knrb,PKParkCost_knrb,
      FromStation_cbdknrb,StationTAZ_cbdknrb,PKParkCost_cbdknrb

PAR ZONES={ZONESA}, ZONEMSG=100

LOOP WW=1,9
  MW[WW]=0
ENDLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

endif

EndDistributeMULTISTEP

DistributeMULTISTEP ProcessID="JTADist", ProcessNum=2; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00O.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00Q2.PRN" MSG='knr-bus stop to stop file'
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00R2.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP3_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=3,HDWAYPERIOD=2,
           TRIPSIJ[3]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\Models\NERPM_PT\applications\STPTR00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00G.PRN" MSG='knr-bus stop to stop file'
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00H.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP5_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=5,HDWAYPERIOD=2,
           TRIPSIJ[5]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00E1.PRN" MSG='cbdknr-bus stop to stop file'
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00F1.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP7_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21,23, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=7,HDWAYPERIOD=2,
           TRIPSIJ[7]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00P.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00S2.PRN" MSG='fringe-pnr stop to stop file'
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHOP9_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00T2.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP9_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=23, N={ZONESA1}-99999
; - use only circulator for this path

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=9,HDWAYPERIOD=2,
           TRIPSIJ[9]=10

ENDRUN


; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\STMAT00C.PRN"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI MATI[4] = "{SCENARIO_DIR}\output\ST2STOP9_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[3] = "{SCENARIO_DIR}\output\ST2STOP7_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[2] = "{SCENARIO_DIR}\output\ST2STOP5_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[1] = "{SCENARIO_DIR}\output\ST2STOP3_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2STOP_bus_{alt}{year}.MAT",
 MO=1,21-22,2,23-24,3,25-26,4,27-28,
 NAME=FromStation_pnrb,StationTAZ_pnrb,OPParkCost_pnrb,
      FromStation_knrb,StationTAZ_knrb,OPParkCost_knrb,
      FromStation_cbdknrb,StationTAZ_cbdknrb,OPParkCost_cbdknrb,
      FromStation_frgb,StationTAZ_frgb,OPParkCost_frgb

PAR ZONES={ZONESA} zonemsg=100

; STATION PARKING COST INTO A LOOKUP TABLE
;station, statnumber, spaces,pnrterm,knrterm,nearestzone(distance),nearestzone(statdata input),ampnrcost,mdpnrcost

LOOKUP LOOKUPI=1, NAME=STATIONS,
 LOOKUP[1]=2, RESULT=1,; STATION ZONE
 LOOKUP[2]=2, RESULT=7,; Peak Period Pakring Cost
 FAIL=0

MW[1]=MI.1.1 ;+ MI.1.23
MW[2]=MI.2.1 ;+ MI.1.23
MW[3]=MI.3.1 ;+ MI.1.23
MW[4]=MI.4.1 ;+ MI.1.23

JLOOP
 ;FIRST FIGURE OUT THE STATION EQUIVALENT FOR EACH CELL, 0 IF NO MATCH
 ;NEXT, ASSIGN THE STATION EQUIVALENT FOR EACH CELL TO A WORK MATRIX
  STATZONE1=STATIONS(1,MW[1][J],0)
  PARKINGCOST1=STATIONS(2,MW[1][J],0)
  MW[21][J]=STATZONE1
  MW[22][J]=PARKINGCOST1

  STATZONE2=STATIONS(1,MW[2][J],0)
  PARKINGCOST2=STATIONS(2,MW[2][J],0)
  MW[23][J]=STATZONE2
  MW[24][J]=PARKINGCOST2

  STATZONE3=STATIONS(1,MW[3][J],0)
  PARKINGCOST3=STATIONS(2,MW[3][J],0)
  MW[25][J]=STATZONE3
  MW[26][J]=PARKINGCOST3

  STATZONE4=STATIONS(1,MW[4][J],0)
  PARKINGCOST4=STATIONS(2,MW[4][J],0)
  MW[27][J]=STATZONE4
  MW[28][J]=PARKINGCOST4

  if (MW[21][J] == 0) MW[1][J]=0
  if (MW[23][J] == 0) MW[2][J]=0
  if (MW[25][J] == 0) MW[3][J]=0
  if (MW[27][J] == 0) MW[4][J]=0
  ;clean up where start and end stations are the same OR do not both board and alight at a station
;  if (mw[51][j]=mw[52][j]|MW[51][J]=0|MW[52][J]=0) mw[51][j]=0 mw[52][j]=0 mw[3][j]=0 mw[55]=0 mw[56]=0 mw[57]=0 mw[58]=0 MW[59]=0

ENDJLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

if ({isBRTProjectMode}=0)
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00Q.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00U2.PRN" MSG='pnr-prj stop to stop file'
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHOP4_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00V2.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP4_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=4,HDWAYPERIOD=2,
           TRIPSIJ[4]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\Models\NERPM_PT\applications\STPTR00F.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00K.PRN" MSG='knr-prj stop to stop file'
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHOP6_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00L.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP6_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=6,HDWAYPERIOD=2,
           TRIPSIJ[6]=10

ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\MODELS\NERPM_PT\APPLICATIONS\STPTR00J.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\STPTR00G1.PRN" MSG='cbdknr-prj stop to stop file'
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHOP8_{Alt}{year}.RTE"
FILEO REPORTO = "{SCENARIO_DIR}\output\STPTR00H1.PRN"
FILEO STOP2STOPO = "{SCENARIO_DIR}\output\ST2STOP8_{alt}{year}.DBF",
     ACCUMULATE=firstlast, MODES=21-27, N={ZONESA1}-99999

PARAMETERS NOROUTEERRS=9999999, NOROUTEMSGS=0,USERCLASSES=8,HDWAYPERIOD=2,
           TRIPSIJ[8]=10

ENDRUN


; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\STMAT00D.PRN"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI MATI[3] = "{SCENARIO_DIR}\output\ST2STOP8_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[2] = "{SCENARIO_DIR}\output\ST2STOP6_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEI MATI[1] = "{SCENARIO_DIR}\output\ST2STOP4_{alt}{year}.DBF",
 PATTERN=IJM:V FIELDS=I,J,0,FROMNODE
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2STOP_prj_{alt}{year}.MAT",
 MO=1,21-22,2,23-24,3,25-26,
 NAME=FromStation_pnrb,StationTAZ_pnrb,OPParkCost_pnrb,
      FromStation_knrb,StationTAZ_knrb,OPParkCost_knrb,
      FromStation_cbdknrb,StationTAZ_cbdknrb,OPParkCost_cbdknrb

PAR ZONES={ZONESA} zonemsg=100

; STATION PARKING COST INTO A LOOKUP TABLE
;station, statnumber, spaces,pnrterm,knrterm,nearestzone(distance),nearestzone(statdata input),ampnrcost,mdpnrcost

LOOKUP LOOKUPI=1, NAME=STATIONS,
 LOOKUP[1]=2, RESULT=1,; STATION ZONE
 LOOKUP[2]=2, RESULT=7,; Peak Period Pakring Cost
 FAIL=0

MW[1]=MI.1.1 ;+ MI.1.23
MW[2]=MI.2.1 ;+ MI.1.23
MW[3]=MI.3.1 ;+ MI.1.23

JLOOP
 ;FIRST FIGURE OUT THE STATION EQUIVALENT FOR EACH CELL, 0 IF NO MATCH
 ;NEXT, ASSIGN THE STATION EQUIVALENT FOR EACH CELL TO A WORK MATRIX
  STATZONE1=STATIONS(1,MW[1][J],0)
  PARKINGCOST1=STATIONS(2,MW[1][J],0)
  MW[21][J]=STATZONE1
  MW[22][J]=PARKINGCOST1

  STATZONE2=STATIONS(1,MW[2][J],0)
  PARKINGCOST2=STATIONS(2,MW[2][J],0)
  MW[23][J]=STATZONE2
  MW[24][J]=PARKINGCOST2

  STATZONE3=STATIONS(1,MW[3][J],0)
  PARKINGCOST3=STATIONS(2,MW[3][J],0)
  MW[25][J]=STATZONE3
  MW[26][J]=PARKINGCOST3

  if (MW[21][J] == 0) MW[1][J]=0
  if (MW[23][J] == 0) MW[2][J]=0
  if (MW[25][J] == 0) MW[3][J]=0
  ;clean up where start and end stations are the same OR do not both board and alight at a station
;  if (mw[51][j]=mw[52][j]|MW[51][J]=0|MW[52][J]=0) mw[51][j]=0 mw[52][j]=0 mw[3][j]=0 mw[55]=0 mw[56]=0 mw[57]=0 mw[58]=0 MW[59]=0

ENDJLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

else
; End of PILOT Script

; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00F.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2STOP_prj_{alt}{year}.MAT",
 MO=1-9,
 NAME=FromStation_pnrb,StationTAZ_pnrb,OPParkCost_pnrb,
      FromStation_knrb,StationTAZ_knrb,OPParkCost_knrb,
      FromStation_cbdknrb,StationTAZ_cbdknrb,OPParkCost_cbdknrb

PAR ZONES={ZONESA}, ZONEMSG=100

LOOP WW=1,9
  MW[WW]=0
ENDLOOP


ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

endif


EndDistributeMULTISTEP

Wait4Files Files=JTADist1.script.end, JTADist2.script.end,
           CheckReturnCode=1, PrintFiles=SAVE

; End of PILOT Script

; Script for program MATRIX in file "D:\Models\NERPM_PT\applications\STMAT00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\STMAT00E.PRN" MSG='STATION TO STATION MATRIX'
FILEO MATO[1] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT",
 MO=1-14,NAME=PKStationTAZ_pnrb,PKStationTAZ_knrb,PKStationTAZ_cbdknrb,PKStationTAZ_frg,PKStationTAZ_pnrp,PKStationTAZ_knrp,PKStationTAZ_cbdknrp,
              OPStationTAZ_pnrb,OPStationTAZ_knrb,OPStationTAZ_cbdknrb,OPStationTAZ_frg,OPStationTAZ_pnrp,OPStationTAZ_knrp,OPStationTAZ_cbdknrp

FILEI MATI[4] = "{SCENARIO_DIR}\output\ST2STOP_prj_{alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\ST2STOP_bus_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\ST2STPK_prj_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\ST2STPK_bus_{alt}{year}.MAT"

zonemsg=100

; pull out only station zone number
FILLMW MW[1] =MI.1.2   ; pk pnr-bus
FILLMW MW[2] =MI.1.5
FILLMW MW[3] =MI.1.8
FILLMW MW[4] =MI.1.11
FILLMW MW[5] =MI.2.2
FILLMW MW[6] =MI.2.5
FILLMW MW[7] =MI.2.8

FILLMW MW[8] =MI.3.2
FILLMW MW[9] =MI.3.5
FILLMW MW[10] =MI.3.8
FILLMW MW[11] =MI.3.11
FILLMW MW[12] =MI.4.2
FILLMW MW[13] =MI.4.5
FILLMW MW[14] =MI.4.8

ENDRUN


