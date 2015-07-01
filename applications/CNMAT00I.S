;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Combine NHB PK & OP'
FILEI MATI[4] = "{SCENARIO_DIR}\output\NHBOOP_MC1.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHBOPK_MC1.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\output\NHBWOP_MC1.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\NHBWPK_MC1.mat"

FILEO MATO[1] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.mat",
 mo = 1-12, NAME = DA, SR2, SR3P  
   MW[1] = Mi.1.1 + mi.2.1 + Mi.3.1 + mi.4.1
   MW[2] = Mi.1.2 + mi.2.2 + Mi.3.2 + mi.4.2   
   MW[3] = Mi.1.3 + mi.2.3 + Mi.3.3 + mi.4.3  

ENDRUN
