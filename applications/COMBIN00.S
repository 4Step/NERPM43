LOOP per = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
    IF (per ==1)
     todToken = 'PK'
    Else
     todToken = 'OP'
    EndIF

; End of PILOT Script

  LOOP pur = 1, 4, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


    IF(pur==1)
       purposeToken = 'HBW'
       mkt = 5
    Elseif (pur==2)
       purposeToken = 'HBO'
       mkt = 5
    ElseIf (pur==3)
       purposeToken = 'HBSH'
       mkt = 5
    ElseIf (pur==4)
       purposeToken = 'HBSR'
       mkt = 5        
    Endif; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00F.S"
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


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; End of PILOT Script

  ENDLOOP

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00J.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX

FILEI MATI[8] = "{SCENARIO_DIR}\output\NHBO@todToken@_MC1.mat"
FILEI MATI[7] = "{SCENARIO_DIR}\output\NHBW@todToken@_MC1.mat"
FILEI MATI[6] = "{SCENARIO_DIR}\output\HBCU@todToken@_MC1.mat"
FILEI MATI[5] = "{SCENARIO_DIR}\output\HBSC@todToken@_MC1.mat"
FILEI MATI[4] = "{SCENARIO_DIR}\output\HBSR@todToken@_MCALL.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\output\HBSH@todToken@_MCALL.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBO@todToken@_MCALL.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW@todToken@_MCALL.mat"

FILEO MATO[3] = "{SCENARIO_DIR}\output\tload_@todToken@_KNR.mat",mo =20,13-16, DEC=5*D,
             NAME= KNRSKY,KNRLOC,KNREXP,KNRBRT,KNRCOM

FILEO MATO[2] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_PNR.mat",  mo = 4,19,10-12, DEC=5*D,
             NAME= PNRSKY,PNRLOC,PNREXP,PNRBRT,PNRCOM
             
FILEO MATO[1] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_Walk.mat", mo = 5-9, DEC=5*D,
             NAME= WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM
             
 
       ; Add matrices across purposes
       /*
                 Skyway   Local   Express     BRT/LRT    ComRail
        Walk       5        6        7           8           9
        PNR        4       19       10          11          12
        KNR                13       14          15          16
       */  
                                                                                         
       ; MW[1 ] = MI.1.1 + MI.2.1 + MI.3.1 + MI.4.1 + MI.5.1 + MI.6.1  + MI.7.1  + MI.8.1
       ; MW[2 ] = MI.1.2 + MI.2.2 + MI.3.2 + MI.4.2 + MI.5.2 + MI.6.2  + MI.7.2  + MI.8.2
       ; MW[3 ] = MI.1.3 + MI.2.3 + MI.3.3 + MI.4.3 + MI.5.3 + MI.6.3  + MI.7.3  + MI.8.3
       MW[4 ] = MI.1.4 + MI.2.4 + MI.3.4 + MI.4.4 + MI.5.4 + MI.6.4  + MI.7.4  + MI.8.4  
       MW[5 ] = MI.1.5 + MI.2.5 + MI.3.5 + MI.4.5 + MI.5.5 + MI.6.5  + MI.7.5  + MI.8.5  
       MW[6 ] = MI.1.6 + MI.2.6 + MI.3.6 + MI.4.6 + MI.5.6 + MI.6.6  + MI.7.6  + MI.8.6  
       MW[7 ] = MI.1.7 + MI.2.7 + MI.3.7 + MI.4.7 + MI.5.7 + MI.6.7  + MI.7.7  + MI.8.7  
       MW[8 ] = MI.1.8 + MI.2.8 + MI.3.8 + MI.4.8 + MI.5.8 + MI.6.8  + MI.7.8  + MI.8.8  
       MW[9 ] = MI.1.9 + MI.2.9 + MI.3.9 + MI.4.9 + MI.5.9 + MI.6.9  + MI.7.9  + MI.8.9  
       MW[10] = MI.1.10+ MI.2.10+ MI.3.10+ MI.4.10+ MI.5.10+ MI.6.10 + MI.7.10 + MI.8.10 
       MW[11] = MI.1.11+ MI.2.11+ MI.3.11+ MI.4.11+ MI.5.11+ MI.6.11 + MI.7.11 + MI.8.11 
       MW[12] = MI.1.12+ MI.2.12+ MI.3.12+ MI.4.12+ MI.5.12+ MI.6.12 + MI.7.12 + MI.8.12 
       MW[13] = MI.1.13+ MI.2.13+ MI.3.13+ MI.4.13+ MI.5.13+ MI.6.13 + MI.7.13 + MI.8.13 
       MW[14] = MI.1.14+ MI.2.14+ MI.3.14+ MI.4.14+ MI.5.14+ MI.6.14 + MI.7.14 + MI.8.14 
       MW[15] = MI.1.15+ MI.2.15+ MI.3.15+ MI.4.15+ MI.5.15+ MI.6.15 + MI.7.15 + MI.8.15 
       MW[16] = MI.1.16+ MI.2.16+ MI.3.16+ MI.4.16+ MI.5.16+ MI.6.16 + MI.7.16 + MI.8.16 
       MW[17] = MI.1.17+ MI.2.17+ MI.3.17+ MI.4.17+ MI.5.17+ MI.6.17 + MI.7.17 + MI.8.17 
       MW[18] = MI.1.18+ MI.2.18+ MI.3.18+ MI.4.18+ MI.5.18+ MI.6.18 + MI.7.18 + MI.8.18 
       MW[19] = MI.1.19+ MI.2.19+ MI.3.19+ MI.4.19+ MI.5.19+ MI.6.19 + MI.7.19 + MI.8.19 
       MW[20] = 0 ; Dummy matrix            
             

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; End of PILOT Script

ENDLOOP

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00G.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Combine HBW PK & OP'
FILEO MATO[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT",mo = 1-12, NAME = DA, SR2, SR3P  
  
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBWOP_MCALL.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBWPK_MCALL.mat"

   MW[1] = Mi.1.1 + mi.2.1
   MW[2] = Mi.1.2 + mi.2.2   
   MW[3] = Mi.1.3 + mi.2.3 

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00H.S"
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


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00I.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Combine NHB PK & OP'
FILEI MATI[4] = "{SCENARIO_DIR}\output\NHBOOP_MC1.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHBOPK_MC1.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\output\NHBWOP_MC1.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\output\NHBWPK_MC1.mat"

FILEO MATO[1] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.mat", mo = 1-12, NAME = DA, SR2, SR3P  
   MW[1] = Mi.1.1 + mi.2.1 + Mi.3.1 + mi.4.1
   MW[2] = Mi.1.2 + mi.2.2 + Mi.3.2 + mi.4.2   
   MW[3] = Mi.1.3 + mi.2.3 + Mi.3.3 + mi.4.3  

ENDRUN


