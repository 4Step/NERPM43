
IF (PURPOSE=1) ; HBW PK purpose
PERIOD='PK'
PURP='HBW'
PURPNO=2
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS1'
OCC3={oc3vhbw}
RUNDATE='@DATE.RUNDATE@'
RUNTIME=@TIME.RUNTIME@
PRK='LONGPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 1 of 16 HBW PK", printo=0

ELSEIF (PURPOSE=2) ; NHBW PK purpose
PERIOD= 'PK'
PURP='NHBW'
PURPNO=4
SHRNO=2
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
Mkt2_Name='                              '
Mkt3_Name='                              '
Mkt4_Name='                              '
Mkt5_Name='                              '
Mkt6_Name='                              '
Mkt7_Name='                              '
PRINT LIST="Mode Choice Loop Number = 2 of 16 HBNW PK", printo=0

ELSEIF (PURPOSE=3) ; HBSH PK purpose 
PERIOD='PK'
PURP='HBSH'
PURPNO=3
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 3 of 16 HBSH PK", printo=0

ELSEIF (PURPOSE=4) ; HBSR PK purpose 
PERIOD='PK'
PURP='HBSR'
PURPNO=3
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 4 of 16 HBSR PK", printo=0

ELSEIF (PURPOSE=5) ; HBO PK purpose 
PERIOD='PK'
PURP='HBO'
PURPNO=3
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 5 of 16 HBO PK", printo=0

ELSEIF (PURPOSE=6) ; NHBO PK purpose
PERIOD= 'PK'
PURP='NHBO'
PURPNO=4
SHRNO=3
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number = 6 of 16 NHBO PK", printo=0

ELSEIF (PURPOSE=7) ; HBW OP purpose
PERIOD='OP'
PURP='HBW'
PURPNO=2
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS1'
OCC3={oc3vhbw}
RUNDATE='@DATE.RUNDATE@'
RUNTIME=@TIME.RUNTIME@
PRK='LONGPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 7 of 16 HBW OP", printo=0

ELSEIF (PURPOSE=8) ; NHBW OP purpose
PERIOD= 'OP'
PURP='NHBW'
PURPNO=4
SHRNO=2
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number = 8 of 16 NHBW OP", printo=0

ELSEIF (PURPOSE=9) ; HBSH OP purpose 
PERIOD='OP'
PURP='HBSH'
PURPNO=3
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number = 9 of 16 HBSH OP", printo=0

ELSEIF (PURPOSE=10) ; HBSR OP purpose 
PERIOD='OP'
PURP='HBSR'
PURPNO=3
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number =10 of 16 HBSR OP", printo=0

ELSEIF (PURPOSE=11) ; HBO OP purpose 
PERIOD='OP'
PURP='HBO'
PURPNO=3
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=7
Mkt1_0Car=1
Mkt1_Name='Zero Cars All Income          '
Mkt2_Name='Car Insuficient Low Income    '
Mkt3_Name='Car Insuficient Medium Income '
Mkt4_Name='Car Insuficient High Income   '
Mkt5_Name='Car Suficient Low Income      '
Mkt6_Name='Car Suficient Medium Income   '
Mkt7_Name='Car Suficient High Income     '
PRINT LIST="Mode Choice Loop Number =11 of 16 HBO OP", printo=0

ELSEIF (PURPOSE=12) ; NHBO OP purpose
PERIOD= 'OP'
PURP='NHBO'
PURPNO=4
SHRNO=3
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=' '
noNHB=';'
MARKETS=1
Mkt1_0Car=0
Mkt1_Name='All Cars  All Income          '
PRINT LIST="Mode Choice Loop Number =12 of 16 NHBO OP", printo=0

; HBCU and HBSC
ELSEIF (PURPOSE=13) ; HBCU PK purpose 
PERIOD='PK'
PURP='HBCU'
PURPNO=2
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=4
Mkt1_0Car=0
Mkt1_Name='One Person Household          '
Mkt2_Name='Two Person Households         '
Mkt3_Name='Three Person Households       '
Mkt4_Name='Four+ Person Households       '
PRINT LIST="Mode Choice Loop Number =13 of 16 HBCU PK", printo=0

ELSEIF (PURPOSE=14) ; HBSC PK purpose 
PERIOD='PK'
PURP='HBSC'
PURPNO=3
SKIMFILE='PKSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='2,3,4,5,6,7,8'
isNHB=';'
noNHB=' '
MARKETS=4
Mkt1_0Car=0
Mkt1_Name='One Person Household          '
Mkt2_Name='Two Person Households         '
Mkt3_Name='Three Person Households       '
Mkt4_Name='Four+ Person Households       '
PRINT LIST="Mode Choice Loop Number =14 of 16 HBSC PK", printo=0

ELSEIF (PURPOSE=15) ; HBCU OP purpose 
PERIOD='OP'
PURP='HBCU'
PURPNO=2
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=4
Mkt1_0Car=0
Mkt1_Name='One Person Household          '
Mkt2_Name='Two Person Households         '
Mkt3_Name='Three Person Households       '
Mkt4_Name='Four+ Person Households       '
PRINT LIST="Mode Choice Loop Number =15 of 16 HBCU OP", printo=0

ELSEIF (PURPOSE=16) ; HBSC OP purpose 
PERIOD='OP'
PURP='HBSC'
PURPNO=3
SKIMFILE='OPSKIM_{alt}{year}'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='SHORTPARK'
STATION_TABLE='10,11,12,13,14,15,16'
isNHB=';'
noNHB=' '
MARKETS=4
Mkt1_0Car=0
Mkt1_Name='One Person Household          '
Mkt2_Name='Two Person Households         '
Mkt3_Name='Three Person Households       '
Mkt4_Name='Four+ Person Households       '
PRINT LIST="Mode Choice Loop Number =16 of 16 HBSC OP", printo=0

ENDIF

