; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

    IF (PURPOSE=1) ; HBW PK purpose
    PERIOD='PK'
    PURP='HBW'
    PURPNO=2
    SKIMFILE='PRELSKIMS'
    STATPRKCOST='STPKCS1'
    OCC3=3.37 
    RUNDATE='@DATE.RUNDATE@'
    RUNTIME=@TIME.RUNTIME@
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 1 of 16 HBW PK", printo=0
    
    ELSEIF (PURPOSE=2) ; HBO PK purpose 
    PERIOD='PK'
    PURP='HBO'
    PURPNO=3
    SKIMFILE='PRELSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 2 of 16 HBO PK", printo=0
    
    ELSEIF (PURPOSE=3) ; HBSH PK purpose 
    PERIOD='PK'
    PURP='HBSH'
    PURPNO=4
    SKIMFILE='PRELSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 3 of 16 HBSH PK", printo=0
    
    ELSEIF (PURPOSE=4) ; HBSR PK purpose 
    PERIOD='PK'
    PURP='HBSR'
    PURPNO=5
    SKIMFILE='PRELSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 4 of 16 HBSR PK", printo=0
    
    ; HBSC PK purpose 
    ELSEIF (PURPOSE=5) 
    PERIOD='PK'
    PURP='HBSC'
    PURPNO=6
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=';'
    noNHB=' '
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number =8 of 16 HBSC PK", printo=0  
    
    ; HBCU
    ELSEIF (PURPOSE=6) ; HBCU PK purpose 
    PERIOD='PK'
    PURP='HBCU'
    PURPNO=7
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='2,3,4,5,6,7,8'
    isNHB=';'
    noNHB=' '
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number =7 of 16 HBCU PK", printo=0
    
    ; NHBW PK purpose
    ELSEIF (PURPOSE=7) 
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
    PRINT LIST="Mode Choice Loop Number = 5 of 16 NHBW PK", printo=0
    
    ELSEIF (PURPOSE=8) ; NHBO PK purpose
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
    PRINT LIST="Mode Choice Loop Number = 6 of 16 NHBO PK", printo=0
    
    ; HBW OP purpose        
    ELSEIF (PURPOSE=9) 
    PERIOD='OP'
    PURP='HBW'
    PURPNO=2
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS1'
    OCC3=3.37 
    RUNDATE='@DATE.RUNDATE@'
    RUNTIME=@TIME.RUNTIME@
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 9 of 16 HBW OP", printo=0
    
    ; HBO OP purpose
    ELSEIF (PURPOSE=10)  
    PERIOD='OP'
    PURP='HBO'
    PURPNO=3
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number =10 of 16 HBO OP", printo=0
    
    ; HBSH OP purpose
    ELSEIF (PURPOSE=11)  
    PERIOD='OP'
    PURP='HBSH'
    PURPNO=4
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number = 11 of 16 HBSH OP", printo=0
    
    ; HBSR OP purpose
    ELSEIF (PURPOSE=12)  
    PERIOD='OP'
    PURP='HBSR'
    PURPNO=5
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=';'
    noNHB=' '
    MARKETS=5
    Mkt1_0Car=1
    Mkt1_Name='Zero Cars All Income          '
    Mkt2_Name='Car Insuficient Low Income    '
    Mkt3_Name='Car Insuficient High Income   '
    Mkt4_Name='Car Suficient Low Income      '
    Mkt5_Name='Car Suficient High Income     '
    PRINT LIST="Mode Choice Loop Number =12 of 16 HBSR OP", printo=0

    ; HBSC OP purpose 
    ELSEIF (PURPOSE=13) 
    PERIOD='OP'
    PURP='HBSC'
    PURPNO=6
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=';'
    noNHB=' '
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number =16 of 16 HBSC OP", printo=0
    
    ; HBCU OP purpose
    ELSEIF (PURPOSE=14)  
    PERIOD='OP'
    PURP='HBCU'
    PURPNO=7
    SKIMFILE='FHSKIMS'
    STATPRKCOST='STPKCS2'
    OCC3=3.37 
    PRK='LONGPARK'
    STATION_TABLE='10,11,12,13,14,15,16'
    isNHB=';'
    noNHB=' '
    MARKETS=1
    Mkt1_0Car=0
    Mkt1_Name='All Cars  All Income          '
    PRINT LIST="Mode Choice Loop Number =15 of 16 HBCU OP", printo=0
       
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
    PRINT LIST="Mode Choice Loop Number = 13 of 16 NHBW OP", printo=0
   
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
    PRINT LIST="Mode Choice Loop Number =14 of 16 NHBO OP", printo=0
    ENDIF
