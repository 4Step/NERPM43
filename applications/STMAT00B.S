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
