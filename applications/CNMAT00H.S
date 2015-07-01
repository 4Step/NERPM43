;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Combine HBNW PK & OP'
FILEI MATI[10] = "{SCENARIO_DIR}\output\HBSCOP_MC1.MAT"
FILEI MATI[9] = "{SCENARIO_DIR}\output\HBSCPK_MC1.mat"
FILEI MATI[8] = "{SCENARIO_DIR}\output\HBCUOP_MC1.mat"
FILEI MATI[7] = "{SCENARIO_DIR}\output\HBCUPK_MC1.mat"
FILEI MATI[6] = "{SCENARIO_DIR}\output\HBSHOP_MCALL.mat"
FILEI MATI[5] = "{SCENARIO_DIR}\output\HBSHPK_MCALL.mat"
FILEI MATI[4] = "{SCENARIO_DIR}\output\HBSROP_MCALL.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\output\HBSRPK_MCALL.mat"

FILEI MATI[2] = "{SCENARIO_DIR}\output\HBOOP_MCALL.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBOPK_MCALL.mat"
FILEO MATO[1] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}.MAT",
 mo = 1-12, NAME = DA, SR2, SR3P  

   MW[1] = Mi.1.1 + mi.2.1 +mi.3.1+mi.4.1+mi.5.1+mi.6.1+mi.7.1+mi.8.1+mi.9.1 + mi.10.1
   MW[2] = Mi.1.2 + mi.2.2 +mi.3.2+mi.4.2+mi.5.2+mi.6.2+mi.7.2+mi.8.2+mi.9.2 + mi.10.2  
   MW[3] = Mi.1.3 + mi.2.3 +mi.3.1+mi.4.3+mi.5.3+mi.6.3+mi.7.3+mi.8.3+mi.9.3 + mi.10.3 
       

ENDRUN
