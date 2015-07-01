
IF (PURPOSE=1) ; HBW PK
PURP='HBW'
PERIOD='PK'
PURPNO=1
MARKETS=5
isHBW=' '
noHBW=';'
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 1 of 16 HBW PK", printo=0

ELSEIF (PURPOSE=2) ; NHBW PK 
PURP='NHBW'
PERIOD='PK'
PURPNO=2
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number = 2 of 16 NHBW PK", printo=0

ELSEIF (PURPOSE=3) ; HBSH PK 
PURP='HBSH'
PERIOD='PK'
PURPNO=3
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 3 of 16 HBSH PK", printo=0

ELSEIF (PURPOSE=4) ; HBSR PK  
PURP='HBSR'
PERIOD='PK'
PURPNO=4
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 4 of 16 HBSR PK", printo=0

ELSEIF (PURPOSE=5) ; HBO PK 
PURP='HBO'
PERIOD='PK'
PURPNO=5
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 5 of 16 HBO PK", printo=0

ELSEIF (PURPOSE=6) ; NHB PK
PURP='NHBO'
PERIOD='PK'
PURPNO=6
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number = 6 of 16 NHBO PK", printo=0

ELSEIF (PURPOSE=7) ; HBW OP 
PURP='HBW'
PERIOD='OP'
PURPNO=7
MARKETS=5
isHBW=' '
noHBW=';'
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 7 of 16 HBW OP", printo=0

ELSEIF (PURPOSE=8) ; NHBW OP 
PURP='NHBW'
PERIOD='OP'
PURPNO=8
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number = 8 of 16 NHBW OP", printo=0

ELSEIF (PURPOSE=9) ; HBSH OP  
PURP='HBSH'
PERIOD='OP'
PURPNO=9
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number = 9 of 16 HBSH OP", printo=0

ELSEIF (PURPOSE=10) ; HBSR OP  
PURP='HBSR'
PERIOD='OP'
PURPNO=10
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number =10 of 16 HBSR OP", printo=0

ELSEIF (PURPOSE=11) ; HBO OP  
PURP='HBO'
PERIOD='OP'
PURPNO=11
MARKETS=5
isHBW=';'
noHBW=' '
isNHB=';'
noNHB=' '
PRINT LIST="Trip Distribution Loop Number =11 of 16 HBO OP", printo=0

ELSEIF (PURPOSE=12) ; NHB OP
PURP='NHBO'
PERIOD='OP'
PURPNO=12
MARKETS=1
isHBW=';'
noHBW=' '
isNHB=' '
noNHB=';'
PRINT LIST="Trip Distribution Loop Number =12 of 16 NHBO OP", printo=0

ENDIF
