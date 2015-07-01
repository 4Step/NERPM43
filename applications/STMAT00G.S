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
