; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00Gsb.PRN" MSG='Add auto-access vehicle trips'
FILEO MATO[1] = "{SCENARIO_DIR}\output\AutoAcc_Hwysb.MAT",
 MO=141-142, NAME=AutoAcc_SOV, AutoAcc_HOV2, DEC=2*S

FILEI MATI[4] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_{alt}{year}sb.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}sb.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}sb.MAT"

PAR ZONEMSG=100
DistributeINTRASTEP ProcessID="JTADist", ProcessList=1-3

FILLMW MW[1] =MI.1.1,2,3,4,5,6,7,8,9,10,11,12
FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12
FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12
FILLMW MW[71]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14           ; only statzone tables are needed - PK auto-bus, PK auto-prj, OP auto-bus, OP auto-prj

MW[101] = MW[6]                                                      ; peak period pnr-access vehicle trips for pnr-bus path
MW[102] = MW[7]                                                      ; peak period pnr-access vehicle trips for pnr-Prj path
MW[103] = MW[8]                                                      ; peak period knr-access vehicle trips for knr-bus path
MW[104] = MW[9]                                                      ; peak period knr-access vehicle trips for knr-Prj path
MW[105] = MW[10]                                                      ; peak period cbdknr-access vehicle trips for cbdknr-Prj path
MW[106] = MW[11]                                                      ; peak period cbdknr-access vehicle trips for cbdknr-Prj path
MW[107] = MW[12]                                                      ; peak period fringe-access vehicle trips for fringe path

MW[108] = (MW[26] + MW[46])                                          ; off-peak period pnr-access vehicle trips for pnr-bus path
MW[109] = (MW[27] + MW[47])                                          ; off-peak period pnr-access vehicle trips for pnr-prj path
MW[110] = (MW[28] + MW[48])                                          ; off-peak period knr-access vehicle trips for knr-bus path
MW[111] = (MW[29] + MW[49])                                          ; off-peak period knr-access vehicle trips for knr-prj path
MW[112] = (MW[30] + MW[50])                                          ; off-peak period cbdknr-access vehicle trips for cbdknr-prj path
MW[113] = (MW[31] + MW[51])                                          ; off-peak period cbdknr-access vehicle trips for cbdknr-prj path
MW[114] = (MW[32] + MW[52])                                          ; off-peak period fringe-access vehicle trips for fringe-prj path

JLOOP
 if (MW[101] > 0) ; PK period pnr-bus trips
  _parkingzone=MW[71][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
   MW[121][_parkingzone] = MW[121][_parkingzone] + MW[101]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[102] > 0) ; PK period pnr-prj trips
  _parkingzone=MW[72][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[122][_parkingzone] = MW[122][_parkingzone] + MW[102][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[103] > 0) ; PK period knr-bus trips
  _parkingzone=MW[73][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[123][_parkingzone] = MW[123][_parkingzone] + MW[103][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[104] > 0) ; PK period knr-prj trips
  _parkingzone=MW[74][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[124][_parkingzone] = MW[124][_parkingzone] + MW[104][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[105] > 0) ; PK period cbdknr-bus trips
  _parkingzone=MW[75][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[125][_parkingzone] = MW[125][_parkingzone] + MW[105][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[106] > 0) ; PK period cbdknr-prj trips
  _parkingzone=MW[76][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[126][_parkingzone] = MW[126][_parkingzone] + MW[106][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[107] > 0) ; PK period fringe trips
  _parkingzone=MW[77][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[127][_parkingzone] = MW[127][_parkingzone] + MW[107][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[108] > 0) ; OP period pnr-bus trips
  _parkingzone=MW[78][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
   MW[128][_parkingzone] = MW[128][_parkingzone] + MW[108]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[109] > 0) ; OP period pnr-prj trips
  _parkingzone=MW[79][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[129][_parkingzone] = MW[129][_parkingzone] + MW[109][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[110] > 0) ; OP period knr-bus trips
  _parkingzone=MW[80][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[130][_parkingzone] = MW[130][_parkingzone] + MW[110][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[121] > 0) ; OP period knr-prj trips
  _parkingzone=MW[81][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[131][_parkingzone] = MW[131][_parkingzone] + MW[121][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[122] > 0) ; OP period cbdknr-bus trips
  _parkingzone=MW[82][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[132][_parkingzone] = MW[132][_parkingzone] + MW[112][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[123] > 0) ; OP period cbdknr-prj trips
  _parkingzone=MW[83][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[133][_parkingzone] = MW[133][_parkingzone] + MW[123][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

 if (MW[124] > 0) ; OP period cbdknr-prj trips
  _parkingzone=MW[84][J]
  if (_parkingzone <= {ZONESA} & _parkingzone > 0)
  MW[134][_parkingzone] = MW[134][_parkingzone] + MW[124][J]
  else
   print list='************',I(5.0),J(5.0),_parkingzone(5.0),'*************'
  endif
 endif

ENDJLOOP

;combine PK and OP trips to daily trips
MW[141] = (MW[121] + MW[122] + MW[127] + MW[128] + MW[129] + MW[134])/{OCCPNRAccess}   ; PNR auto access trips will be added to the SOV table
MW[142] = (MW[123] + MW[124] + MW[125] + MW[126] + MW[130] + MW[131] + MW[132] + MW[133])/{OCCKNRAccess}   ; KNR auto access trips will be added to the HOV2 table

ENDRUN
