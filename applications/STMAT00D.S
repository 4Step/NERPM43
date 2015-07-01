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

ENDJLOOP

ENDRUN
