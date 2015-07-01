; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


Distribute MULTISTEP=1       

    ; NHBW PK purpose
    IF (PURPOSE=13) 
    PERIOD= 'PK'
    PURP='NHBW'
    PURPNO=8
    SHRNO=2
    SKIMFILE='PRELSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=' '
    noNHB=';'
    MARKETS=1
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 13 of 16 NHBW PK", printo=0
    
    ELSEIF (PURPOSE=14) ; NHBO PK purpose
    PERIOD= 'PK'
    PURP='NHBO'
    PURPNO=9
    SHRNO=3
    SKIMFILE='PRELSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=' '
    noNHB=';'
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number = 14 of 16 NHBO PK", printo=0
    
    ; NHBW OP purpose
    ELSEIF (PURPOSE=15) 
    PERIOD= 'OP'
    PURP='NHBW'
    PURPNO=8
    SHRNO=2
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=' '
    noNHB=';'
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number = 15 of 16 NHBW OP", printo=0
   
    ; NHBO OP purpose
    ELSEIF (PURPOSE=16) 
    PERIOD= 'OP'
    PURP='NHBO'
    PURPNO=9
    SHRNO=3
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=' '
    noNHB=';'
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number =16 of 16 NHBO OP", printo=0
    ENDIF
