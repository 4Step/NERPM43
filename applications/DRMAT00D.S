;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX

FILEI MATI[3] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_PNR.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_Walk.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@todToken@_rebuild_drive_to_skyway.MAT"

FILEO MATO[2] = "{SCENARIO_DIR}\output\tload_@todToken@_PNR.mat",
mo = 6-10, DEC=5*D,
                 NAME= PNRSKY,PNRLOC,PNREXP,PNRBRT,PNRCOM
FILEO MATO[1] = "{SCENARIO_DIR}\output\tload_@todToken@_Walk.mat",
mo = 1-5, DEC=5*D,
                 NAME= WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM
    

      MW[1] = mi.1.1 + mi.2.1        ; Drive (portion of pnr to jzome) + walk to skyway
      FILLMW MW[2] = mi.2.2(4)
      
      MW[6] = 0
      FILLMW MW[7]= mi.3.2(4)

ENDRUN
