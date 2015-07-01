; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
IF (PP=1) ; HBW PK purpose
PERIOD='PK'
PURP='HBW'

ELSEIF (PP=2) ; HBO PK purpose
PERIOD='PK'
PURP='HBO'

ELSEIF (PP=3) ; HBSH PK purpose
PERIOD='PK'
PURP='HBSH'

ELSEIF (PP=4) ; HBSR PK purpose
PERIOD='PK'
PURP='HBSR'

ELSEIF (PP=5) ; HBW OP purpose
PERIOD='OP'
PURP='HBW'

ELSEIF (PP=6) ; HBO OP purpose
PERIOD='OP'
PURP='HBO'

ELSEIF (PP=7) ; HBSH PK purpose
PERIOD='OP'
PURP='HBSH'

ELSEIF (PP=8) ; HBSR PK purpose
PERIOD='OP'
PURP='HBSR'
ENDIF



