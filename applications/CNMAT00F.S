;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEO MATO[1] = "{SCENARIO_DIR}\output\@purposeToken@@todToken@_MCALL.mat",
MO=1-19,DEC=19*D, NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE,PNRLOC

FILEI MATI[5] = "{SCENARIO_DIR}\output\@purposeToken@@todToken@_MC5.mat"
FILEI MATI[4] = "{SCENARIO_DIR}\output\@purposeToken@@todToken@_MC4.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\output\@purposeToken@@todToken@_MC3.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\output\@purposeToken@@todToken@_MC2.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@purposeToken@@todToken@_MC1.mat"

         
MW[1 ] = MI.1.1 + MI.2.1 + MI.3.1 + MI.4.1 + MI.5.1 
           MW[2 ] = MI.1.2 + MI.2.2 + MI.3.2 + MI.4.2 + MI.5.2 
           MW[3 ] = MI.1.3 + MI.2.3 + MI.3.3 + MI.4.3 + MI.5.3 
           MW[4 ] = MI.1.4 + MI.2.4 + MI.3.4 + MI.4.4 + MI.5.4 
           MW[5 ] = MI.1.5 + MI.2.5 + MI.3.5 + MI.4.5 + MI.5.5 
           MW[6 ] = MI.1.6 + MI.2.6 + MI.3.6 + MI.4.6 + MI.5.6 
           MW[7 ] = MI.1.7 + MI.2.7 + MI.3.7 + MI.4.7 + MI.5.7 
           MW[8 ] = MI.1.8 + MI.2.8 + MI.3.8 + MI.4.8 + MI.5.8 
           MW[9 ] = MI.1.9 + MI.2.9 + MI.3.9 + MI.4.9 + MI.5.9 
           MW[10] = MI.1.10+ MI.2.10+ MI.3.10+ MI.4.10+ MI.5.10
           MW[11] = MI.1.11+ MI.2.11+ MI.3.11+ MI.4.11+ MI.5.11
           MW[12] = MI.1.12+ MI.2.12+ MI.3.12+ MI.4.12+ MI.5.12
           MW[13] = MI.1.13+ MI.2.13+ MI.3.13+ MI.4.13+ MI.5.13
           MW[14] = MI.1.14+ MI.2.14+ MI.3.14+ MI.4.14+ MI.5.14
           MW[15] = MI.1.15+ MI.2.15+ MI.3.15+ MI.4.15+ MI.5.15
           MW[16] = MI.1.16+ MI.2.16+ MI.3.16+ MI.4.16+ MI.5.16
           MW[17] = MI.1.17+ MI.2.17+ MI.3.17+ MI.4.17+ MI.5.17
           MW[18] = MI.1.18+ MI.2.18+ MI.3.18+ MI.4.18+ MI.5.18
           MW[19] = MI.1.19+ MI.2.19+ MI.3.19+ MI.4.19+ MI.5.19
           
ENDRUN
