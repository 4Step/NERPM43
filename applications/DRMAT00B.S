;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO RECO[1] = "{SCENARIO_DIR}\output\temp_drive-to-skyway.DBF",
FIELDS=I,J,Trips
FILEI DBI[1] = "{SCENARIO_DIR}\output\drive-to-skyway.csv",
 DELIMITER=',' IZONE =1, JZONE = 2, PZONE =3, TRIPS = 4, SORT=PZONE, JZONE

ZONES=1                  
       LOOP K=2,DBI.1.NUMRECORDS
         X1=DBIReadRecord(1,K)
         ;IF(DI.1.PZONE>0 & DI.1.TRIPS >0.001) 
         IF(DI.1.PZONE>0) 
            RO.I = DI.1.PZONE
            RO.J = DI.1.JZONE
            RO.Trips = DI.1.TRIPS
            WRITE RECO=1
         ENDIF
       ENDLOOP

ENDRUN
