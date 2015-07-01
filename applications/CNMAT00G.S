;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Combine HBW PK & OP'
FILEO MATO[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT",
mo = 1-12, NAME = DA, SR2, SR3P  
  
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBWOP_MCALL.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBWPK_MCALL.mat"

   MW[1] = Mi.1.1 + mi.2.1
   MW[2] = Mi.1.2 + mi.2.2   
   MW[3] = Mi.1.3 + mi.2.3 

ENDRUN
