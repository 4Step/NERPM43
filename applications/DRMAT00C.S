;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO MATO[1] = "{SCENARIO_DIR}\output\@todToken@_rebuild_drive_to_skyway.MAT",
 MO=1, DEC= 1*d
FILEI MATI[1] = "{SCENARIO_DIR}\output\temp_drive-to-skyway.dbf",
 PATTERN=I:JV, FIELDS= I,J,Trips

      zones=2578
        mw[1] = mi.1.1

ENDRUN
