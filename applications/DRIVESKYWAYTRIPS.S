LOOP per = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


    IF (per =1)
     todToken = 'PK'
    Else
     todToken = 'OP'
    EndIF; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DRMAT00A.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\drive-to-skyway.csv"
FILEI MATI[2] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_PNR.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@todToken@_DRV_SKYWAY_ZONES.MAT"

      MW[1] = mi.1.1 ; PNR Zone
      MW[2] = mi.2.1 ; drive-to-skyway
      
      ; Add header
      IF (I=1 & J =1) PRINT PRINTO=1 CSV=T LIST='I' 'J' 'P' 'Trips'
       
      ; Add 1.01 trips to avoid null matrix (885 is PNR Skyway zone)
      IF (I=1 & J =1) PRINT PRINTO=1 CSV=T FORM=0 LIST= I(5), J(5), '665', '1.01'
      
      JLOOP
        PRINT PRINTO=1 CSV=T FORM=0 LIST= I(5), J(5), MW[1](5), MW[2](8.6)
      ENDJLOOP

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DRMAT00B.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO RECO[1] = "{SCENARIO_DIR}\output\temp_drive-to-skyway.DBF",FIELDS=I,J,Trips
FILEI DBI[1] = "{SCENARIO_DIR}\output\drive-to-skyway.csv", DELIMITER=',' IZONE =1, JZONE = 2, PZONE =3, TRIPS = 4, SORT=PZONE, JZONE

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


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DRMAT00C.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO MATO[1] = "{SCENARIO_DIR}\output\@todToken@_rebuild_drive_to_skyway.MAT", MO=1, DEC= 1*d
FILEI MATI[1] = "{SCENARIO_DIR}\output\temp_drive-to-skyway.dbf", PATTERN=I:JV, FIELDS= I,J,Trips

      zones=2578
        mw[1] = mi.1.1

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DRMAT00D.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX

FILEI MATI[3] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_PNR.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_Walk.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@todToken@_rebuild_drive_to_skyway.MAT"

FILEO MATO[2] = "{SCENARIO_DIR}\output\tload_@todToken@_PNR.mat",mo = 6-10, DEC=5*D,
                 NAME= PNRSKY,PNRLOC,PNREXP,PNRBRT,PNRCOM
FILEO MATO[1] = "{SCENARIO_DIR}\output\tload_@todToken@_Walk.mat",mo = 1-5, DEC=5*D,
                 NAME= WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM
    

      MW[1] = mi.1.1 + mi.2.1        ; Drive (portion of pnr to jzome) + walk to skyway
      FILLMW MW[2] = mi.2.2(4)
      
      MW[6] = 0
      FILLMW MW[7]= mi.3.2(4)

ENDRUN


ENDLOOP

