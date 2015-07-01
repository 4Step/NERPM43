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
