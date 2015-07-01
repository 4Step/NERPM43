; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TPMAT00A.PRN" MSG='Extract transit trips using BRT system'
FILEO MATO[1] = "{SCENARIO_DIR}\output\BRTTRIPS_{alt}{year}.MAT",
  MO=1-18,NAME=pkWalkBus,pkWalkPrj,pkPNRBus,pkPNRprj,pkKNRBus,pkKNRprj,pkCBDKNRBus,pkCBDKNRprj,pkFringe,
               opWalkBus,opWalkPrj,opPNRBus,opPNRprj,opKNRBus,opKNRprj,opCBDKNRBus,opCBDKNRprj,opFringe
FILEI MATI[2] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT"

; Select link tables
; 1- pkWalkBRTtime, 2- pkPNRBRTtime, 3- pkKNRBRTtime, 4- pkCBDKNRBRTtime
; 5- opWalkBRTtime, 6- opPNRBRTtime, 7- opKNRBRTtime, 8- opCBDKNRBRTtime

; Transit trip tables
; 1- pkWalkBus,   2- pkWalkPrj
; 3- pkPNRBus,    4- pkPNRPrj
; 5- pkKNRBus,    6- pkKNRPrj
; 7- pkCBDKNRBus, 8- pkCBDKNRPrj
; 9- pkFringe
; 10- opWalkBus,  11- opWalkPrj
; 12- opPNRBus,   13- opPNRPrj
; 14- opKNRBus,   15- opKNRPrj
; 16- opCBDKNRBus,17- opCBDKNRPrj
; 18- opFringe

ZONEMSG=100

FILLMW MW[101]=MI.1.1,2,3,4,5,6,7,8
FILLMW MW[111]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18

; Extract transit trips on interchanges using the BRT system
JLOOP

  MW[1]=0,  MW[2]=0,  MW[3]=0,  MW[4]=0,  MW[5]=0,  MW[6]=0,  MW[7]=0,  MW[8]=0,  MW[9]=0,
  MW[10]=0, MW[11]=0, MW[12]=0, MW[13]=0, MW[14]=0, MW[15]=0, MW[16]=0, MW[17]=0, MW[18]=0

  IF (MW[101] > 0) MW[1] = MW[111]
  IF (MW[102] > 0) MW[2] = MW[112]
  IF (MW[103] > 0) MW[3] = MW[113]
  IF (MW[104] > 0) MW[4] = MW[114]
  IF (MW[105] > 0) MW[5] = MW[115]
  IF (MW[106] > 0) MW[6] = MW[116]
  IF (MW[107] > 0) MW[7] = MW[117]
  IF (MW[108] > 0) MW[8] = MW[118]
  MW[9] = 0
  IF (MW[101] > 0) MW[10]= MW[120]
  IF (MW[102] > 0) MW[11]= MW[121]
  IF (MW[103] > 0) MW[12]= MW[122]
  IF (MW[104] > 0) MW[13]= MW[123]
  IF (MW[105] > 0) MW[14]= MW[124]
  IF (MW[106] > 0) MW[15]= MW[125]
  IF (MW[107] > 0) MW[16]= MW[126]
  IF (MW[108] > 0) MW[17]= MW[127]
  MW[18]= 0

ENDJLOOP

ENDRUN
