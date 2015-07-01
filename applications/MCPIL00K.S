; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


IF (PURPOSE=1) ; HBW purpose
 PERIOD='PK'
 PURP='HBW'
 PURPNO=2
*del "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV"
*del "{SCENARIO_DIR}\output\NEW_TRNCOEFF.CSV"
ELSEIF (PURPOSE=2) ; HBO purpose
 PERIOD='OP'
 PURP='HBNW'
 PURPNO=3
ELSEIF (PURPOSE=3) ; NHB purpose
 PERIOD='OP'
 PURP='NHB'
 PURPNO=4
ENDIF

