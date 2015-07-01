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
