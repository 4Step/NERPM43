; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="D:\JTA RTS Model\APPLICATIONS\TNMAT00H.PRN" MSG='Fringe parking path-check'
FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIMPK9_{alt}{year}.MAT"

ZONEMSG=100

FILLMW MW[1]=MI.1.1,2,3,4,5,6,7,8,9,10,11,12,13,14

IF (i==1) _max=0

JLOOP
  _ovt  = MW[1] + MW[3]
  _auto = MW[2]
  _wait = MW[12] + MW[13]
  _xfers= MW[11]
  _ivtt = MW[4] + MW[5] + MW[6] + MW[7] + MW[8] + MW[9] + MW[10]

  _total = _ovt * 2.0 + _auto + _wait * 2.0 + _xfers * 10.0 + _ivtt

  if (_total > _max) _max = _total

  if (_total > 250.0)
    LIST=I(5.0),"-",J(5.0),_total,_ovt,_auto,_wait,_xfers,_ivtt
  endif

ENDJLOOP

IF (i==_ZONES) LIST="\n","Max: ",_max,"\n"


ENDRUN
