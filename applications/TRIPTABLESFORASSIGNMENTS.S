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
    Endif
; End of PILOT Script

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

FILEO MATO[3] = "{SCENARIO_DIR}\output\tload_@todToken@_KNR.mat",
mo =20,13-16, DEC=5*D,
             NAME= KNRSKY,KNRLOC,KNREXP,KNRBRT,KNRCOM

FILEO MATO[2] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_PNR.mat",
  mo = 4,19,10-12, DEC=5*D,
             NAME= PNRSKY,PNRLOC,PNREXP,PNRBRT,PNRCOM
             
FILEO MATO[1] = "{SCENARIO_DIR}\output\tload_@todToken@_temp_Walk.mat",
 mo = 5-9, DEC=5*D,
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
FILEO MATO[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT",
mo = 1-12, NAME = DA, SR2, SR3P  
  
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

FILEO MATO[1] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.mat",
 mo = 1-12, NAME = DA, SR2, SR3P  
   MW[1] = Mi.1.1 + mi.2.1 + Mi.3.1 + mi.4.1
   MW[2] = Mi.1.2 + mi.2.2 + Mi.3.2 + mi.4.2   
   MW[3] = Mi.1.3 + mi.2.3 + Mi.3.3 + mi.4.3  

ENDRUN


LOOP per = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


    IF (per =1)
     todToken = 'PK'
    Else
     todToken = 'OP'
    EndIF
; End of PILOT Script

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


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DRMAT00C.S"
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


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\DRMAT00D.S"
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


ENDLOOP

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TTMAT00A.PRN" MSG='Combine trip tables for 24-Hour Assignment'
FILEI MATI[7] = "{SCENARIO_DIR}\output\PORT_TRK_24H_{Year}.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_{alt}{year}.MAT",
MO=121-128, NAME=DA_IEII,SR_IEII,TRK_IEII,TRK_EE,
                 DA_EE,SR_EE,PortTrk,24H_Total, DEC=8*s
                 
FILEI MATI[4] = "{SCENARIO_DIR}\Output\VTRIP1.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT"

PAR ZONEMSG=100

FILLMW MW[1]  = MI.1.1,2,3,4,5,6,7,8,9,10,11,12   ; - HBW trips
FILLMW MW[21] = MI.2.1,2,3,4,5,6,7,8,9,10,11,12   ; - HBNW trips
FILLMW MW[41] = MI.3.1,2,3,4,5,6,7,8,9,10,11,12   ; - NHB trips
FILLMW MW[61] = MI.4.1,2,3,4,5,6,7                ; Veh Trips (TRK - LT,MT,HT & IE - SO,HO,LD,HD)
FILLMW MW[81] = MI.5.1,2,3,4,5                    ; EE Trips (SOV,HOV,LT,HT,Tot)


; DRIVE ALONE
; MW[101]=(MW[1] + MW[21] + MW[41] + MW[64] + MI.1.1.T + MI.2.1.T + MI.3.1.T + MI.4.4.T )*0.5
 
 ; Drive Alone - Add 20% of NHB trips (under reporting)
 MW[101]=(MW[1] + MW[21] + (MW[41] * 1.2) + MW[64] + MI.1.1.T + MI.2.1.T + (MI.3.1.T * 1.2) + MI.4.4.T )*0.5
 
; AUTO 2
;===Mistake to include MW[12] instead of MW[22]==>MW[102]=(MW[2] + MW[12] + MW[42] + MW[92] + MI.1.2.T + MI.2.2.T + MI.3.2.T + MI.6.2.T)/2*0.5
; MW[102]=(MW[2] + MW[22] + MW[42] + MI.1.2.T + MI.2.2.T + MI.3.2.T )/2*0.5
 MW[102]=(MW[2] + MW[22] + (MW[42] * 1.2) + MI.1.2.T + MI.2.2.T + (MI.3.2.T * 1.2) )/2*0.5
; AUTO 3+ HBW
; MW[103]=(MW[3] + MI.1.3.T)/{OC3VHBW}*0.5   ; include this modifier if model is revalidated
MW[103]=((MW[3] + MI.1.3.T)* 1.2)/{OC3VHBW}*0.5   ; include this modifier if model is revalidated
; AUTO 3+ HBO
; MW[104]=(MW[23] + MI.2.3.T)/{OC3VHBNW}*0.5  ; include this modifier if model is revalidated
MW[104]=((MW[23] + MI.2.3.T)*1.2) /{OC3VHBNW}*0.5  ; include this modifier if model is revalidated
; AUTO 3+ NHB
;===Another Mistake to include MW[3] instead of MW[43] ==> MW[105]=(MW[3] + MI.3.3.T)/{OC3VNHB}*0.5   
;  include this modifier if model is revalidated
; MW[105]=(MW[43] + MI.3.3.T)/{OC3VNHB}*0.5   ;  include this modifier if model is revalidated
MW[105]=((MW[43] + MI.3.3.T)*1.2)/{OC3VNHB} *0.5   ;  include this modifier if model is revalidated
; HOV IE
MW[106]=(MW[65] + MI.4.5.T)*0.5
; II/IE TRK
MW[107]=(MW[61] + MW[62] + MW[63] + MW[66] + MW[67] + MI.4.1.T + MI.4.2.T + MI.4.3.T + MI.4.6.T + MI.4.7.T)*0.5
; EE TRUCK
MW[108]=(MW[83] + MW[84] + MI.5.3.T + MI.5.4.T)*0.5
; EE SOV
MW[109]=(MW[81] + MI.5.1.T)*0.5
; EE HOV
MW[110]=(MW[82] + MI.5.2.T)*0.5

; FINAL TABLE ORDERING FOR HIGHWAY SIDE
MW[121]=MW[101]                                  ; DA_IEII
MW[122]=MW[102]+MW[103]+MW[104]+MW[105]+MW[106]  ; SR_IEII
MW[123]=MW[107]                                  ; TRK_IEII
MW[124]=MW[108]                                  ; TRK_EE
MW[125]=MW[109]                                  ; DA_EE
MW[126]=MW[110]                                  ; SR_EE
MW[127]=MI.7.1                                   ; JaxPortTrucks

LOOP K=121,127
  MW[128]=MW[128]+MW[K]                          ;TotVeh
ENDLOOP

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


if({TOD_HwyMdl}=1)   ;Time of Day (4 periods) Highway Model
; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00B.PRN" MSG='Create HBW Period Hwy Pax TT by Mode/Dir'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[4] = "{SCENARIO_DIR}\output\HBW_NT_TEM.MAT",
  MO=61-66, NAME= NT_HBW_DA_P2A, NT_HBW_SR2_P2A, NT_HBW_SR3_P2A,
                  NT_HBW_DA_A2P, NT_HBW_SR2_A2P, NT_HBW_SR3_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\HBW_PM_TEM.MAT",
  MO=51-56, NAME= PM_HBW_DA_P2A, PM_HBW_SR2_P2A, PM_HBW_SR3_P2A,
                  PM_HBW_DA_A2P, PM_HBW_SR2_A2P, PM_HBW_SR3_A2P, dec=6*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\HBW_MD_TEM.MAT",
  MO=41-46, NAME= MD_HBW_DA_P2A, MD_HBW_SR2_P2A, MD_HBW_SR3_P2A,
                  MD_HBW_DA_A2P, MD_HBW_SR2_A2P, MD_HBW_SR3_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\HBW_AM_TEM.MAT",
  MO=31-36, NAME= AM_HBW_DA_P2A, AM_HBW_SR2_P2A, AM_HBW_SR3_P2A,
                  AM_HBW_DA_A2P, AM_HBW_SR2_A2P, AM_HBW_SR3_A2P, dec=6*S

FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT"

PAR ZONEMSG=100

FILLMW MW[1]=MI.1.1,2,3                 ;1/2/3: HBW-DA,SR2,SR3
;FILLMW MW[11]=MI.2.1,2,3                ;11/12/13: HBNW-DA,SR2,SR3   
;FILLMW MW[21]=MI.3.1,2,3                ;21/22/23: NHB-DA,SR2,SR3  

FILLMW MW[101]=MI.1.1.T,2.T,3.T         ;101/102/103: HBW-DA,SR2,SR3-Transposeed
;FILLMW MW[111]=MI.2.1.T,2.T,3.T         ;111/112/113: HBNW-DA,SR2,SR3-Transposed   
;FILLMW MW[121]=MI.3.1.T,2.T,3.T         ;121/122/123: NHB-DA,SR2,SR3-Transposed  


HBW_NT_Frac=1-({HBW_AM_Frac}+{HBW_MD_Frac}+{HBW_PM_Frac})
;HBNW_NT_Frac=1-({HBNW_AM_Frac}+{HBNW_MD_Frac}+{HBNW_PM_Frac})
;NHB_NT_Frac=1-({NHB_AM_Frac}+{NHB_MD_Frac}+{NHB_PM_Frac})


;AMPK-HBW: 31=DA_PA, 32=SR2_PA, 33=SR3_PA, 34=DA_AP, 35=SR2_AP, 36=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  MW[_KPA]=MW[K]*{HBW_AM_Frac}*{HBW_AM_PA_Fac}
  MW[_KAP]=MW[KK]*{HBW_AM_Frac}*(1.0-{HBW_AM_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-HBW: 41=DA_PA, 42=SR2_PA, 43=SR3_PA, 44=DA_AP, 45=SR2_AP, 46=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  MW[_KPA]=MW[K]*{HBW_MD_Frac}*{HBW_MD_PA_Fac}
  MW[_KAP]=MW[KK]*{HBW_MD_Frac}*(1.0-{HBW_MD_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;PMPK-HBW: 51=DA_PA, 52=SR2_PA, 53=SR3_PA, 54=DA_AP, 55=SR2_AP, 56=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  MW[_KPA]=MW[K]*{HBW_PM_Frac}*{HBW_PM_PA_Fac}
  MW[_KAP]=MW[KK]*{HBW_PM_Frac}*(1.0-{HBW_PM_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-HBW: 61=DA_PA, 62=SR2_PA, 63=SR3_PA, 64=DA_AP, 65=SR2_AP, 66=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  MW[_KPA]=MW[K]*HBW_NT_Frac*{HBW_NT_PA_Fac}
  MW[_KAP]=MW[KK]*HBW_NT_Frac*(1.0-{HBW_NT_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP





ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00C.PRN" MSG='Create HBNW Period Hwy Pax TT by Mode/Dir'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[4] = "{SCENARIO_DIR}\output\HBNW_NT_TEM.MAT",
  MO=61-66, NAME= NT_HBNW_DA_P2A, NT_HBNW_SR2_P2A, NT_HBNW_SR3_P2A,
                  NT_HBNW_DA_A2P, NT_HBNW_SR2_A2P, NT_HBNW_SR3_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\HBNW_PM_TEM.MAT",
  MO=51-56, NAME= PM_HBNW_DA_P2A, PM_HBNW_SR2_P2A, PM_HBNW_SR3_P2A,
                  PM_HBNW_DA_A2P, PM_HBNW_SR2_A2P, PM_HBNW_SR3_A2P, dec=6*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\HBNW_MD_TEM.MAT",
  MO=41-46, NAME= MD_HBNW_DA_P2A, MD_HBNW_SR2_P2A, MD_HBNW_SR3_P2A,
                  MD_HBNW_DA_A2P, MD_HBNW_SR2_A2P, MD_HBNW_SR3_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\HBNW_AM_TEM.MAT",
  MO=31-36, NAME= AM_HBNW_DA_P2A, AM_HBNW_SR2_P2A, AM_HBNW_SR3_P2A,
                  AM_HBNW_DA_A2P, AM_HBNW_SR2_A2P, AM_HBNW_SR3_A2P, dec=6*S

FILEI MATI[1] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}.MAT"

PAR ZONEMSG=100

FILLMW MW[1]=MI.1.1,2,3                 ;1/2/3: HBNW-DA,SR2,SR3

FILLMW MW[101]=MI.1.1.T,2.T,3.T         ;101/102/103: HBNW-DA,SR2,SR3-Transposed


HBNW_NT_Frac=1-({HBNW_AM_Frac}+{HBNW_MD_Frac}+{HBNW_PM_Frac})


;AMPK-HBNW: 31=DA_PA, 32=SR2_PA, 33=SR3_PA, 34=DA_AP, 35=SR2_AP, 36=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  MW[_KPA]=MW[K]*{HBNW_AM_Frac}*{HBNW_AM_PA_Fac}
  MW[_KAP]=MW[KK]*{HBNW_AM_Frac}*(1.0-{HBNW_AM_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-HBNW: 41=DA_PA, 42=SR2_PA, 43=SR3_PA, 44=DA_AP, 45=SR2_AP, 46=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  MW[_KPA]=MW[K]*{HBNW_MD_Frac}*{HBNW_MD_PA_Fac}
  MW[_KAP]=MW[KK]*{HBNW_MD_Frac}*(1.0-{HBNW_MD_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;PMPK-HBNW: 51=DA_PA, 52=SR2_PA, 53=SR3_PA, 54=DA_AP, 55=SR2_AP, 56=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  MW[_KPA]=MW[K]*{HBNW_PM_Frac}*{HBNW_PM_PA_Fac}
  MW[_KAP]=MW[KK]*{HBNW_PM_Frac}*(1.0-{HBNW_PM_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-HBNW: 61=DA_PA, 62=SR2_PA, 63=SR3_PA, 64=DA_AP, 65=SR2_AP, 66=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  MW[_KPA]=MW[K]*HBNW_NT_Frac*{HBNW_NT_PA_Fac}
  MW[_KAP]=MW[KK]*HBNW_NT_Frac*(1.0-{HBNW_NT_PA_Fac})
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP





ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00D.PRN" MSG='Create NHB Period Hwy Pax TT by Mode/Dir'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[4] = "{SCENARIO_DIR}\output\NHB_NT_TEM.MAT",
  MO=61-66, NAME= NT_NHB_DA_P2A, NT_NHB_SR2_P2A, NT_NHB_SR3_P2A,
                  NT_NHB_DA_A2P, NT_NHB_SR2_A2P, NT_NHB_SR3_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\NHB_PM_TEM.MAT",
  MO=51-56, NAME= PM_NHB_DA_P2A, PM_NHB_SR2_P2A, PM_NHB_SR3_P2A,
                  PM_NHB_DA_A2P, PM_NHB_SR2_A2P, PM_NHB_SR3_A2P, dec=6*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\NHB_MD_TEM.MAT",
  MO=41-46, NAME= MD_NHB_DA_P2A, MD_NHB_SR2_P2A, MD_NHB_SR3_P2A,
                  MD_NHB_DA_A2P, MD_NHB_SR2_A2P, MD_NHB_SR3_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\NHB_AM_TEM.MAT",
  MO=31-36, NAME= AM_NHB_DA_P2A, AM_NHB_SR2_P2A, AM_NHB_SR3_P2A,
                  AM_NHB_DA_A2P, AM_NHB_SR2_A2P, AM_NHB_SR3_A2P, dec=6*S

FILEI MATI[1] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.MAT"

PAR ZONEMSG=100

FILLMW MW[1]=MI.1.1,2,3                 ;1/2/3: NHB-DA,SR2,SR3

FILLMW MW[101]=MI.1.1.T,2.T,3.T         ;101/102/103: NHB-DA,SR2,SR3-Transposed


NHB_NT_Frac=1-({NHB_AM_Frac}+{NHB_MD_Frac}+{NHB_PM_Frac})


;AMPK-NHB: 31=DA_PA, 32=SR2_PA, 33=SR3_PA, 34=DA_AP, 35=SR2_AP, 36=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  MW[_KPA]=MW[K]*{NHB_AM_Frac}*0.5
  MW[_KAP]=MW[KK]*{NHB_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-NHB: 41=DA_PA, 42=SR2_PA, 43=SR3_PA, 44=DA_AP, 45=SR2_AP, 46=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  MW[_KPA]=MW[K]*{NHB_MD_Frac}*0.5
  MW[_KAP]=MW[KK]*{NHB_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;PMPK-NHB: 51=DA_PA, 52=SR2_PA, 53=SR3_PA, 54=DA_AP, 55=SR2_AP, 56=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  MW[_KPA]=MW[K]*{NHB_PM_Frac}*0.5
  MW[_KAP]=MW[KK]*{NHB_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-NHB: 61=DA_PA, 62=SR2_PA, 63=SR3_PA, 64=DA_AP, 65=SR2_AP, 66=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  MW[_KPA]=MW[K]*NHB_NT_Frac*0.5
  MW[_KAP]=MW[KK]*NHB_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP





ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00E.PRN" MSG='Create IECar Period Hwy Veh TT by Mode/Dir'
FILEI MATI[1] = "{SCENARIO_DIR}\output\VTRIP1.mat"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[4] = "{SCENARIO_DIR}\output\IECar_NT_TEM.MAT",
  MO=61-66, NAME= NT_IECar_DA_P2A, NT_IECar_SR2_P2A, NT_IECar_SR3_P2A,
                  NT_IECar_DA_A2P, NT_IECar_SR2_A2P, NT_IECar_SR3_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\IECar_PM_TEM.MAT",
  MO=51-56, NAME= PM_IECar_DA_P2A, PM_IECar_SR2_P2A, PM_IECar_SR3_P2A,
                  PM_IECar_DA_A2P, PM_IECar_SR2_A2P, PM_IECar_SR3_A2P, dec=6*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\IECar_MD_TEM.MAT",
  MO=41-46, NAME= MD_IECar_DA_P2A, MD_IECar_SR2_P2A, MD_IECar_SR3_P2A,
                  MD_IECar_DA_A2P, MD_IECAr_SR2_A2P, MD_IECAr_SR3_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\IECar_AM_TEM.MAT",
  MO=31-36, NAME= AM_IECar_DA_P2A, AM_IECar_SR2_P2A, AM_IECar_SR3_P2A,
                  AM_IECAr_DA_A2P, AM_IECar_SR2_A2P, AM_IECar_SR3_A2P, dec=6*S


PAR ZONEMSG=100

FILLMW MW[201]=MI.1.4,5               ;201/202: IE-SO,HO

FILLMW MW[301]=MI.1.4.T,5.T           ;301/302: IE-SO,HO -Transposed


MW[1]=MW[201]                           ; IECarVeh - DA
MW[2]=MW[202]*(1.0-{EXTHOV_SR3_Fac})    ; IECarVeh - SR2
MW[3]=MW[202]*{EXTHOV_SR3_Fac}          ; IECarVeh - SR3

MW[101]=MW[301]                           ; IECarVeh - DA - Transposed
MW[102]=MW[302]*(1.0-{EXTHOV_SR3_Fac})    ; IECarVeh - SR2 - Transposed
MW[103]=MW[302]*{EXTHOV_SR3_Fac}          ; IECarVeh - SR3 - Transposed

EXT_NT_Frac=1-({EXT_AM_Frac}+{EXT_MD_Frac}+{EXT_PM_Frac})

;AMPK-IECar: 31=DA_PA, 32=SR2_PA, 33=SR3_PA, 34=DA_AP, 35=SR2_AP, 36=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  MW[_KPA]=MW[K]*{EXT_AM_Frac}*0.5
  MW[_KAP]=MW[KK]*{EXT_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-IECar: 41=DA_PA, 42=SR2_PA, 43=SR3_PA, 44=DA_AP, 45=SR2_AP, 46=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  MW[_KPA]=MW[K]*{EXT_MD_Frac}*0.5
  MW[_KAP]=MW[KK]*{EXT_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;PMPK-IECar: 51=DA_PA, 52=SR2_PA, 53=SR3_PA, 54=DA_AP, 55=SR2_AP, 56=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  MW[_KPA]=MW[K]*{EXT_PM_Frac}*0.5
  MW[_KAP]=MW[KK]*{EXT_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-IECar: 61=DA_PA, 62=SR2_PA, 63=SR3_PA, 64=DA_AP, 65=SR2_AP, 66=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  MW[_KPA]=MW[K]*EXT_NT_Frac*0.5
  MW[_KAP]=MW[KK]*EXT_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00F.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00F.PRN" MSG='Create IETrk Period Hwy Veh TT by CLS (LD/HD)/Dir'
FILEI MATI[1] = "{SCENARIO_DIR}\output\VTRIP1.mat"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4


FILEO MATO[4] = "{SCENARIO_DIR}\output\IETrk_NT_TEM.MAT",
  MO=61-64, NAME= NT_IETrk_LD_P2A, NT_IETrk_HD_P2A,
                  NT_IETrk_LD_A2P, NT_IETrk_HD_A2P, dec=4*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\IETrk_PM_TEM.MAT",
  MO=51-54, NAME= PM_IETrk_LD_P2A, PM_IETrk_HD_P2A,
                  PM_IETrk_LD_A2P, PM_IETrk_HD_A2P, dec=4*S


FILEO MATO[2] = "{SCENARIO_DIR}\output\IETrk_MD_TEM.MAT",
  MO=41-44, NAME= MD_IETrk_LD_P2A, MD_IETrk_HD_P2A,
                  MD_IETrk_LD_A2P, MD_IETrk_HD_A2P, dec=4*S


FILEO MATO[1] = "{SCENARIO_DIR}\output\IETrk_AM_TEM.MAT",
  MO=31-34, NAME= AM_IETrk_LD_P2A, AM_IETrk_HD_P2A,
                  AM_IETrk_LD_A2P, AM_IETrk_HD_A2P, dec=4*S

PAR ZONEMSG=100

FILLMW MW[1]=MI.1.6,7                 ;1/2: IETrk-LD,HD

FILLMW MW[101]=MI.1.6.T,7.T           ;101/102: IETrk-LD,HD -Transposed


LDTRK_NT_Frac=1-({LDTRK_AM_Frac}+{LDTRK_MD_Frac}+{LDTRK_PM_Frac})
HDTRK_NT_Frac=1-({HDTRK_AM_Frac}+{HDTRK_MD_Frac}+{HDTRK_PM_Frac})

;AMPK-IETrk: 31=LD_PA, 32=HD_PA, 33=LD_AP, 34=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=30+K
  _KAP=32+K
  if (_KPA=31) MW[_KPA]=MW[K]*{LDTRK_AM_Frac}*0.5
  if (_KPA=32) MW[_KPA]=MW[K]*{HDTRK_AM_Frac}*0.5
  if (_KAP=33) MW[_KAP]=MW[KK]*{LDTRK_AM_Frac}*0.5
  if (_KAP=34) MW[_KAP]=MW[KK]*{HDTRK_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-IETrk: 41=LD_PA, 42=HD_PA, 43=LD_AP, 44=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=40+K
  _KAP=42+K
  if (_KPA=41) MW[_KPA]=MW[K]*{LDTRK_MD_Frac}*0.5
  if (_KPA=42) MW[_KPA]=MW[K]*{HDTRK_MD_Frac}*0.5
  if (_KAP=43) MW[_KAP]=MW[KK]*{LDTRK_MD_Frac}*0.5
  if (_KAP=44) MW[_KAP]=MW[KK]*{HDTRK_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;PMPK-IETrk: 51=LD_PA, 52=HD_PA, 53=LD_AP, 54=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=50+K
  _KAP=52+K
  if (_KPA=51) MW[_KPA]=MW[K]*{LDTRK_PM_Frac}*0.5
  if (_KPA=52) MW[_KPA]=MW[K]*{HDTRK_PM_Frac}*0.5
  if (_KAP=53) MW[_KAP]=MW[KK]*{LDTRK_PM_Frac}*0.5
  if (_KAP=54) MW[_KAP]=MW[KK]*{HDTRK_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-IETrk: 61=LD_PA, 62=HD_PA, 63=LD_AP, 64=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=60+K
  _KAP=62+K
  if (_KPA=61) MW[_KPA]=MW[K]*LDTRK_NT_Frac*0.5
  if (_KPA=62) MW[_KPA]=MW[K]*HDTRK_NT_Frac*0.5
  if (_KAP=63) MW[_KAP]=MW[KK]*LDTRK_NT_Frac*0.5
  if (_KAP=64) MW[_KAP]=MW[KK]*HDTRK_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00G.PRN" MSG='Create InternalTrk Period Hwy Veh TT by CLS (LT/MT/HT)/Dir'
FILEI MATI[1] = "{SCENARIO_DIR}\output\VTRIP1.mat"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4


FILEO MATO[4] = "{SCENARIO_DIR}\output\IITrk_NT_TEM.MAT",
  MO=61-66, NAME= NT_IITRK_LT_P2A, NT_IITRK_MT_P2A, NT_IITRK_HT_P2A,
                  NT_IITRK_LT_A2P, NT_IITRK_MT_A2P, NT_IITRK_HT_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\IITrk_PM_TEM.MAT",
  MO=51-56, NAME= PM_IITRK_LT_P2A, PM_IITRK_MT_P2A, PM_IITRK_HT_P2A,
                  PM_IITRK_LT_A2P, PM_IITRK_MT_A2P, PM_IITRK_HT_A2P, dec=6*S


FILEO MATO[2] = "{SCENARIO_DIR}\output\IITrk_MD_TEM.MAT",
  MO=41-46, NAME= MD_IITRK_LT_P2A, MD_IITRK_MT_P2A, MD_IITRK_HT_P2A,
                  MD_IITRK_LT_A2P, MD_IITRK_MT_A2P, MD_IITRK_HT_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\IITrk_AM_TEM.MAT",
  MO=31-36, NAME= AM_IITRK_LT_P2A, AM_IITRK_MT_P2A, AM_IITRK_HT_P2A,
                  AM_IITRK_LT_A2P, AM_IITRK_MT_A2P, AM_IITRK_HT_A2P, dec=6*S

PAR ZONEMSG=100

FILLMW MW[1]=MI.1.1,2,3               ;1/2/3: IntTrk-LT-4Tire,MT-SU,HT-COMB

FILLMW MW[101]=MI.1.1.T,2.T,3.T       ;101/102/103: IntTrk-LT-4Tire,MT-SU,HT-COMB -Transposed


LDTRK_NT_Frac=1-({LDTRK_AM_Frac}+{LDTRK_MD_Frac}+{LDTRK_PM_Frac})
HDTRK_NT_Frac=1-({HDTRK_AM_Frac}+{HDTRK_MD_Frac}+{HDTRK_PM_Frac})

;AMPK-IITrk: 31=LT_PA, 32=MT_PA, 33=HT_PA, 34=LT_AP, 35=LT_AP, 36=HD_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  if (_KPA=31,32) MW[_KPA]=MW[K]*{LDTRK_AM_Frac}*0.5
  if (_KPA=33)    MW[_KPA]=MW[K]*{HDTRK_AM_Frac}*0.5
  if (_KAP=34,35) MW[_KAP]=MW[KK]*{LDTRK_AM_Frac}*0.5
  if (_KAP=36)    MW[_KAP]=MW[KK]*{HDTRK_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-IITrk: 41=LT_PA, 42=MT_PA, 43=HT_PA, 44=LT_AP, 45=LT_AP, 46=HD_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  if (_KPA=41,42) MW[_KPA]=MW[K]*{LDTRK_MD_Frac}*0.5
  if (_KPA=43)    MW[_KPA]=MW[K]*{HDTRK_MD_Frac}*0.5
  if (_KAP=44,45) MW[_KAP]=MW[KK]*{LDTRK_MD_Frac}*0.5
  if (_KAP=46)    MW[_KAP]=MW[KK]*{HDTRK_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;PMPK-IITrk: 51=LT_PA, 52=MT_PA, 53=HT_PA, 54=LT_AP, 55=LT_AP, 56=HD_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  if (_KPA=51,52) MW[_KPA]=MW[K]*{LDTRK_PM_Frac}*0.5
  if (_KPA=53)    MW[_KPA]=MW[K]*{HDTRK_PM_Frac}*0.5
  if (_KAP=54,55) MW[_KAP]=MW[KK]*{LDTRK_PM_Frac}*0.5
  if (_KAP=56)    MW[_KAP]=MW[KK]*{HDTRK_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-IITrk: 61=LT_PA, 62=MT_PA, 63=HT_PA, 64=LT_AP, 65=LT_AP, 66=HD_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  if (_KPA=61,62) MW[_KPA]=MW[K]*LDTRK_NT_Frac*0.5
  if (_KPA=63)    MW[_KPA]=MW[K]*HDTRK_NT_Frac*0.5
  if (_KAP=64,65) MW[_KAP]=MW[KK]*LDTRK_NT_Frac*0.5
  if (_KAP=66)    MW[_KAP]=MW[KK]*HDTRK_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00H.PRN" MSG='Create EECar Period Hwy Veh TT by Mode/Dir'
FILEI MATI[1] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4


FILEO MATO[4] = "{SCENARIO_DIR}\output\EECar_NT_TEM.MAT",
  MO=61-66, NAME= NT_EECar_DA_P2A, NT_EECar_SR2_P2A, NT_EECar_SR3_P2A,
                  NT_EECar_DA_A2P, NT_EECar_SR2_A2P, NT_EECar_SR3_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\EECar_PM_TEM.MAT",
  MO=51-56, NAME= PM_EECar_DA_P2A, PM_EECar_SR2_P2A, PM_EECar_SR3_P2A,
                  PM_EECar_DA_A2P, PM_EECar_SR2_A2P, PM_EECar_SR3_A2P, dec=6*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\EECar_MD_TEM.MAT",
  MO=41-46, NAME= MD_EECar_DA_P2A, MD_EECar_SR2_P2A, MD_EECar_SR3_P2A,
                  MD_EECar_DA_A2P, MD_EECAr_SR2_A2P, MD_EECAr_SR3_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\EECar_AM_TEM.MAT",
  MO=31-36, NAME= AM_EECar_DA_P2A, AM_EECar_SR2_P2A, AM_EECar_SR3_P2A,
                  AM_EECAr_DA_A2P, AM_EECar_SR2_A2P, AM_EECar_SR3_A2P, dec=6*S


PAR ZONEMSG=100

FILLMW MW[201]=MI.1.1,2               ;201/202: EE-SO,HO

FILLMW MW[301]=MI.1.1.T,2.T           ;301/302: EE-SO,HO -Transposed


MW[1]=MW[201]                           ; EECarVeh - DA
MW[2]=MW[202]*(1.0-{EXTHOV_SR3_Fac})    ; EECarVeh - SR2
MW[3]=MW[202]*{EXTHOV_SR3_Fac}          ; EECarVeh - SR3

MW[101]=MW[301]                           ; EECarVeh - DA - Transposed
MW[102]=MW[302]*(1.0-{EXTHOV_SR3_Fac})    ; EECarVeh - SR2 - Transposed
MW[103]=MW[302]*{EXTHOV_SR3_Fac}          ; EECarVeh - SR3 - Transposed

EXT_NT_Frac=1-({EXT_AM_Frac}+{EXT_MD_Frac}+{EXT_PM_Frac})

;AMPK-EECar: 31=DA_PA, 32=SR2_PA, 33=SR3_PA, 34=DA_AP, 35=SR2_AP, 36=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  MW[_KPA]=MW[K]*{EXT_AM_Frac}*0.5
  MW[_KAP]=MW[KK]*{EXT_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-EECar: 41=DA_PA, 42=SR2_PA, 43=SR3_PA, 44=DA_AP, 45=SR2_AP, 46=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  MW[_KPA]=MW[K]*{EXT_MD_Frac}*0.5
  MW[_KAP]=MW[KK]*{EXT_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;PMPK-EECar: 51=DA_PA, 52=SR2_PA, 53=SR3_PA, 54=DA_AP, 55=SR2_AP, 56=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  MW[_KPA]=MW[K]*{EXT_PM_Frac}*0.5
  MW[_KAP]=MW[KK]*{EXT_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-EECar: 61=DA_PA, 62=SR2_PA, 63=SR3_PA, 64=DA_AP, 65=SR2_AP, 66=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  MW[_KPA]=MW[K]*EXT_NT_Frac*0.5
  MW[_KAP]=MW[KK]*EXT_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00I.PRN" MSG='Create EETrk Period Hwy Veh TT by CLS (LD/HD)/Dir'
FILEI MATI[1] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4


FILEO MATO[4] = "{SCENARIO_DIR}\output\EETrk_NT_TEM.MAT",
  MO=61-64, NAME= NT_EETrk_LD_P2A, NT_EETrk_HD_P2A,
                  NT_EETrk_LD_A2P, NT_EETrk_HD_A2P, dec=4*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\EETrk_PM_TEM.MAT",
  MO=51-54, NAME= PM_EETrk_LD_P2A, PM_EETrk_HD_P2A,
                  PM_EETrk_LD_A2P, PM_EETrk_HD_A2P, dec=4*S


FILEO MATO[2] = "{SCENARIO_DIR}\output\EETrk_MD_TEM.MAT",
  MO=41-44, NAME= MD_EETrk_LD_P2A, MD_EETrk_HD_P2A,
                  MD_EETrk_LD_A2P, MD_EETrk_HD_A2P, dec=4*S


FILEO MATO[1] = "{SCENARIO_DIR}\output\EETrk_AM_TEM.MAT",
  MO=31-34, NAME= AM_EETrk_LD_P2A, AM_EETrk_HD_P2A,
                  AM_EETrk_LD_A2P, AM_EETrk_HD_A2P, dec=4*S

PAR ZONEMSG=100

FILLMW MW[1]=MI.1.3,4                 ;1/2: EETrk-LD,HD

FILLMW MW[101]=MI.1.3.T,4.T           ;101/102: EETrk-LD,HD -Transposed


LDTRK_NT_Frac=1-({LDTRK_AM_Frac}+{LDTRK_MD_Frac}+{LDTRK_PM_Frac})
HDTRK_NT_Frac=1-({HDTRK_AM_Frac}+{HDTRK_MD_Frac}+{HDTRK_PM_Frac})

;AMPK-EETrk: 31=LD_PA, 32=HD_PA, 33=LD_AP, 34=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=30+K
  _KAP=32+K
  if (_KPA=31) MW[_KPA]=MW[K]*{LDTRK_AM_Frac}*0.5
  if (_KPA=32) MW[_KPA]=MW[K]*{HDTRK_AM_Frac}*0.5
  if (_KAP=33) MW[_KAP]=MW[KK]*{LDTRK_AM_Frac}*0.5
  if (_KAP=34) MW[_KAP]=MW[KK]*{HDTRK_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-EETrk: 41=LD_PA, 42=HD_PA, 43=LD_AP, 44=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=40+K
  _KAP=42+K
  if (_KPA=41) MW[_KPA]=MW[K]*{LDTRK_MD_Frac}*0.5
  if (_KPA=42) MW[_KPA]=MW[K]*{HDTRK_MD_Frac}*0.5
  if (_KAP=43) MW[_KAP]=MW[KK]*{LDTRK_MD_Frac}*0.5
  if (_KAP=44) MW[_KAP]=MW[KK]*{HDTRK_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;PMPK-EETrk: 51=LD_PA, 52=HD_PA, 53=LD_AP, 54=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=50+K
  _KAP=52+K
  if (_KPA=51) MW[_KPA]=MW[K]*{LDTRK_PM_Frac}*0.5
  if (_KPA=52) MW[_KPA]=MW[K]*{HDTRK_PM_Frac}*0.5
  if (_KAP=53) MW[_KAP]=MW[KK]*{LDTRK_PM_Frac}*0.5
  if (_KAP=54) MW[_KAP]=MW[KK]*{HDTRK_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-EETrk: 61=LD_PA, 62=HD_PA, 63=LD_AP, 64=HD_AP
LOOP K=1,2
  KK=100+K 
  _KPA=60+K
  _KAP=62+K
  if (_KPA=61) MW[_KPA]=MW[K]*LDTRK_NT_Frac*0.5
  if (_KPA=62) MW[_KPA]=MW[K]*HDTRK_NT_Frac*0.5
  if (_KAP=63) MW[_KAP]=MW[KK]*LDTRK_NT_Frac*0.5
  if (_KAP=64) MW[_KAP]=MW[KK]*HDTRK_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00K.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00K.PRN" MSG='Create JaxPortTrk Period Hwy Veh TT by Direction'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PORT_TRK_24H_10.mat"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4


FILEO MATO[4] = "{SCENARIO_DIR}\output\JaxPrtTrk_NT_TEM.MAT",
  MO=61-62, NAME= NT_JPRTTrk_P2A, NT_JPRTTrk_A2P, dec=2*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\JaxPrtTrk_PM_TEM.MAT",
  MO=51-52, NAME= PM_JPRTTrk_P2A, PM_JPRTTrk_A2P, dec=2*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\JaxPrtTrk_MD_TEM.MAT",
 MO=41-42, NAME= MD_JPRTTrk_P2A, MD_JPRTTrk_A2P, dec=2*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\JaxPrtTrk_AM_TEM.MAT",
   MO=31-32, NAME= AM_JPRTTrk_P2A, AM_JPRTTrk_A2P, dec=2*S


PAR ZONEMSG=100

FILLMW MW[1]=MI.1.1               ;1: JPRTTrk

FILLMW MW[101]=MI.1.1.T           ;101: JPRTTrk-Transposed


HDTRK_NT_Frac=1-({HDTRK_AM_Frac}+{HDTRK_MD_Frac}+{HDTRK_PM_Frac})

;AMPK-JPRTTrk: 31=JPrtTrk_PA, 32=JPrtTrk_AP
LOOP K=1
  KK=100+K 
  _KPA=30+K
  _KAP=31+K
  if (_KPA=31) MW[_KPA]=MW[K]*{HDTRK_AM_Frac}*0.5
  if (_KAP=32) MW[_KAP]=MW[KK]*{HDTRK_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-JPRTTrk: 41=JPrtTrk_PA, 42=JPrtTrk_AP
LOOP K=1
  KK=100+K 
  _KPA=40+K
  _KAP=41+K
  if (_KPA=41) MW[_KPA]=MW[K]*{HDTRK_MD_Frac}*0.5
  if (_KAP=42) MW[_KAP]=MW[KK]*{HDTRK_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;PMPK-JPRTTrk: 51=JPrtTrk_PA, 52=JPrtTrk_AP
LOOP K=1
  KK=100+K 
  _KPA=50+K
  _KAP=51+K
  if (_KPA=51) MW[_KPA]=MW[K]*{HDTRK_PM_Frac}*0.5
  if (_KAP=52) MW[_KAP]=MW[KK]*{HDTRK_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-JPRTTrk: 61=JPrtTrk_PA, 62=JPrtTrk_AP
LOOP K=1
  KK=100+K 
  _KPA=60+K
  _KAP=61+K
  if (_KPA=61) MW[_KPA]=MW[K]*HDTRK_NT_Frac*0.5
  if (_KAP=62) MW[_KAP]=MW[KK]*HDTRK_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00L.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00L.PRN" MSG='Combine HWY trip tables - AM Period'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI MATI[10] = "{SCENARIO_DIR}\output\JaxPrtTrk_AM_TEM.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\EETrk_AM_TEM.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\EECar_AM_TEM.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\IITrk_AM_TEM.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\IETrk_AM_TEM.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\IECar_AM_TEM.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_AM_TEM.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_AM_TEM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_AM_TEM.MAT"

FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_AM_{alt}{year}.MAT",
 MO=121-130, NAME=AM_DA_IEII,AM_SR2_IEII,AM_SR3_IEII,AM_TRK_IEII,AM_TRK_EE,
                  AM_DA_EE,AM_SR2_EE,AM_SR3_EE,AM_PortTrk,AM_Total, DEC=10*s

FILEO MATO[2] = "{SCENARIO_DIR}\output\HWYTTBP_AM_{alt}{year}.MAT",
 MO=211-213,221-223,231-233, NAME=AM_HBW_DA,AM_HBW_SR2,AM_HBW_SR3P,
                                  AM_HBO_DA,AM_HBO_SR2,AM_HBO_SR3P,
                                  AM_NHB_DA,AM_NHB_SR2,AM_NHB_SR3P, DEC=9*s


PAR ZONEMSG=100

FILLMW MW[11]  = MI.1.1,2,3,4,5,6   ;HBW:     11/12/13-DA_P2A,SR2_P2A,SR3_P2A |14/15/16-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[21]  = MI.2.1,2,3,4,5,6   ;HBNW:    21/22/23-DA_P2A,SR2_P2A,SR3_P2A |24/25/26-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[31]  = MI.3.1,2,3,4,5,6   ;NHB:     31/32/33-DA_P2A,SR2_P2A,SR3_P2A |34/35/36-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[41]  = MI.4.1,2,3,4,5,6   ;IE-Cars: 41/42/43-DA_P2A,SR2_P2A,SR3_P2A |44/45/46-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[51]  = MI.5.1,2,3,4       ;IE-Trks: 51/52   -LD_P2A,HD_P2A          |53/54   -LD_A2P,HD_A2P
FILLMW MW[61]  = MI.6.1,2,3,4,5,6   ;II-Trks: 61/62/63-LT_P2A,MT_P2A,HT_P2A   |64/65/66-LT_A2P,MT_A2P,HT_A2P
FILLMW MW[71]  = MI.7.1,2,3,4,5,6   ;EE-Cars: 71/72/73-DA_P2A,SR2_P2A,SR3_P2A |74/75/76-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[81]  = MI.8.1,2,3,4       ;EE-Trks: 81/82   -LD_P2A,HD_P2A          |83/84   -LD_A2P,HD_A2P
;FILLMW MW[91]  = MI.9.1,2,3,4,5,6   ;TRN-DRV: 91/92/93-DA_P2A,SR2_P2A,SR3_P2A |94/95/96-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[98]  = MI.10.1,2          ;JaxPort-FreightTrucks: 98-JPRTTrk_P2A    |99      -JPRTTrk_A2P

MW[91] = 0
MW[92] = 0
MW[93] = 0
MW[94] = 0
MW[95] = 0
MW[96] = 0


; DRIVE ALONE
MW[101]=(MW[11] + MW[21] + MW[31] + MW[41] +  MW[91]) +
        (MW[14] + MW[24] + MW[34] + MW[44] +  MW[94]) 

; AUTO 2 (SR2)
MW[102]=((MW[12] + MW[22] + MW[32] +  MW[92]) +
         (MW[15] + MW[25] + MW[35] +  MW[95]))/2 

; AUTO 3+ (SR3+)
MW[103]=((MW[13] + MW[93]) +(MW[16] + MW[96]))/{OC3VHBW} +        ;HBW & Transit-AutoAccess
        (MW[23] + MW[26])/{OC3VHBNW} +                            ;HBNW
        (MW[33] + MW[36])/{OC3VNHB}                               ;NHB

; SR2_IE
MW[104]= MW[42]+
         MW[45] 

; SR3_IE
MW[105]= MW[43]+
         MW[46] 

; II/IE TRK
MW[106]= (MW[61] + MW[62] + MW[63] + MW[51] +  MW[52]) +
         (MW[64] + MW[65] + MW[66] + MW[53] +  MW[54]) 

; EE TRUCK
MW[107]= (MW[81] + MW[82])+
         (MW[83] + MW[84]) 

; EE SOV/DA
MW[108]= MW[71] +
         MW[74]

; EE SR2
MW[109]= MW[72]+
         MW[75] 

; EE SR3
MW[110]= MW[73]+
         MW[76] 

; JaxPort Freight TRUCK
MW[111]= MW[98] +
         MW[99]

; FINAL TABLE ORDERING FOR Period HIGHWAY Assignnment
MW[121]=MW[101]              ;DA_IEII
MW[122]=MW[102]+MW[104]      ;SR2_IEII
MW[123]=MW[103]+MW[105]      ;SR3_IEII
MW[124]=MW[106]                        ;TRK_IEII
MW[125]=MW[107]                        ;TRK_EE
MW[126]=MW[108]                        ;DA_EE
MW[127]=MW[109]                        ;SR2_EE
MW[128]=MW[110]                        ;SR3_EE
MW[129]=MW[111]                        ;JaxPortTrk

LOOP K=121,129
  MW[130]=MW[130]+MW[K]                ;TotVeh for Period XX
ENDLOOP

;==============Purpose Specific Matrices by Mode=====================

;HBW DA Trips (vehicles)
MW[211]=(MW[11]+(MW[14]+MW[41]+ MW[44]+MW[91])+MW[94])     ;PtoA + AtoP Trips - HBW & IE & TranDRV
;HBO DA Trips (vehicles)
MW[221]=(MW[21] + MW[24])                                  ;PtoA + AtoP Trips - HBO
;NHB DA Trips (vehicles)
MW[231]=(MW[31] + MW[34])                                  ;PtoA + AtoP Trips - NHB
    
;HBW SR2 Trips (vehicles)
MW[212]=((MW[12]+MW[15]+MW[92]+MW[95])/2)+(MW[42]+ MW[45]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR2 Trips (vehicles)
MW[222]=(MW[22]+MW[25])/2                                  ;PtoA + AtoP Trips - HBO
;NHB SR2 Trips (vehicles)
MW[232]=(MW[32]+MW[35])/2                                  ;PtoA + AtoP Trips - NHB

;HBW SR3+ Trips (vehicles)
MW[213]=((MW[13]+MW[16]+MW[93]+MW[96])/{OC3VHBW})+(MW[43]+ MW[46]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR3+ Trips (vehicles)
MW[223]=(MW[23]+MW[26])/{OC3VHBNW}                                 ;PtoA + AtoP Trips - HBO
;NHB SR3+ Trips (vehicles)
MW[233]=(MW[33]+MW[36])/{OC3VNHB}                                  ;PtoA + AtoP Trips - NHB


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00M.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00M.PRN" MSG='Combine HWY trip tables - Mid-Day Period'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI MATI[10] = "{SCENARIO_DIR}\output\JaxPrtTrk_MD_TEM.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\EETrk_MD_TEM.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\EECar_MD_TEM.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\IITrk_MD_TEM.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\IETrk_MD_TEM.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\IECar_MD_TEM.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_MD_TEM.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_MD_TEM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_MD_TEM.MAT"

FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_MD_{alt}{year}.MAT",
 MO=121-130, NAME=MD_DA_IEII,MD_SR2_IEII,MD_SR3_IEII,MD_TRK_IEII,MD_TRK_EE,
                  MD_DA_EE,MD_SR2_EE,MD_SR3_EE,MD_PortTrk,MD_Total, DEC=10*s

FILEO MATO[2] = "{SCENARIO_DIR}\output\HWYTTBP_MD_{alt}{year}.MAT",
 MO=211-213,221-223,231-233, NAME=MD_HBW_DA,MD_HBW_SR2,MD_HBW_SR3P,
                                  MD_HBO_DA,MD_HBO_SR2,MD_HBO_SR3P,
                                  MD_NHB_DA,MD_NHB_SR2,MD_NHB_SR3P, DEC=9*s



PAR ZONEMSG=100

FILLMW MW[11]  = MI.1.1,2,3,4,5,6   ;HBW:     11/12/13-DA_P2A,SR2_P2A,SR3_P2A |14/15/16-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[21]  = MI.2.1,2,3,4,5,6   ;HBNW:    21/22/23-DA_P2A,SR2_P2A,SR3_P2A |24/25/26-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[31]  = MI.3.1,2,3,4,5,6   ;NHB:     31/32/33-DA_P2A,SR2_P2A,SR3_P2A |34/35/36-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[41]  = MI.4.1,2,3,4,5,6   ;IE-Cars: 41/42/43-DA_P2A,SR2_P2A,SR3_P2A |44/45/46-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[51]  = MI.5.1,2,3,4       ;IE-Trks: 51/52   -LD_P2A,HD_P2A          |53/54   -LD_A2P,HD_A2P
FILLMW MW[61]  = MI.6.1,2,3,4,5,6   ;II-Trks: 61/62/63-LT_P2A,MT_P2A,HT_P2A   |64/65/66-LT_A2P,MT_A2P,HT_A2P
FILLMW MW[71]  = MI.7.1,2,3,4,5,6   ;EE-Cars: 71/72/73-DA_P2A,SR2_P2A,SR3_P2A |74/75/76-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[81]  = MI.8.1,2,3,4       ;EE-Trks: 81/82   -LD_P2A,HD_P2A          |83/84   -LD_A2P,HD_A2P
; FILLMW MW[91]  = MI.9.1,2,3,4,5,6   ;TRN-DRV: 91/92/93-DA_P2A,SR2_P2A,SR3_P2A |94/95/96-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[98]  = MI.10.1,2          ;JaxPort-FreightTrucks: 98-JPRTTrk_P2A    |99      -JPRTTrk_A2P

MW[91] = 0
MW[92] = 0
MW[93] = 0
MW[94] = 0
MW[95] = 0
MW[96] = 0


; DRIVE ALONE
MW[101]=(MW[11] + MW[21] + MW[31] + MW[41] +  MW[91]) +
        (MW[14] + MW[24] + MW[34] + MW[44] +  MW[94]) 

; AUTO 2 (SR2)
MW[102]=((MW[12] + MW[22] + MW[32] +  MW[92]) +
         (MW[15] + MW[25] + MW[35] +  MW[95]))/2 

; AUTO 3+ (SR3+)
MW[103]=((MW[13] + MW[93]) +(MW[16] + MW[96]))/{OC3VHBW} +        ;HBW & Transit-AutoAccess
        (MW[23] + MW[26])/{OC3VHBNW} +                            ;HBNW
        (MW[33] + MW[36])/{OC3VNHB}                               ;NHB

; SR2_IE
MW[104]= MW[42]+
         MW[45] 

; SR3_IE
MW[105]= MW[43]+
         MW[46] 

; II/IE TRK
MW[106]= (MW[61] + MW[62] + MW[63] + MW[51] +  MW[52]) +
         (MW[64] + MW[65] + MW[66] + MW[53] +  MW[54]) 

; EE TRUCK
MW[107]= (MW[81] + MW[82])+
         (MW[83] + MW[84]) 

; EE SOV/DA
MW[108]= MW[71] +
         MW[74]

; EE SR2
MW[109]= MW[72]+
         MW[75] 

; EE SR3
MW[110]= MW[73]+
         MW[76] 

; JaxPort Freight TRUCK
MW[111]= MW[98] +
         MW[99]

; FINAL TABLE ORDERING FOR Period HIGHWAY Assignnment
MW[121]=MW[101]              ;DA_IEII
MW[122]=MW[102]+MW[104]      ;SR2_IEII
MW[123]=MW[103]+MW[105]      ;SR3_IEII
MW[124]=MW[106]                        ;TRK_IEII
MW[125]=MW[107]                        ;TRK_EE
MW[126]=MW[108]                        ;DA_EE
MW[127]=MW[109]                        ;SR2_EE
MW[128]=MW[110]                        ;SR3_EE
MW[129]=MW[111]                        ;JaxPortTrk

LOOP K=121,129
  MW[130]=MW[130]+MW[K]                ;TotVeh for Period XX
ENDLOOP

;==============Purpose Specific Matrices by Mode=====================

;HBW DA Trips (vehicles)
MW[211]=(MW[11]+(MW[14]+MW[41]+ MW[44]+MW[91])+MW[94])     ;PtoA + AtoP Trips - HBW & IE & TranDRV
;HBO DA Trips (vehicles)
MW[221]=(MW[21] + MW[24])                                  ;PtoA + AtoP Trips - HBO
;NHB DA Trips (vehicles)
MW[231]=(MW[31] + MW[34])                                  ;PtoA + AtoP Trips - NHB
 
;HBW SR2 Trips (vehicles)
MW[212]=((MW[12]+MW[15]+MW[92]+MW[95])/2)+(MW[42]+ MW[45]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR2 Trips (vehicles)
MW[222]=(MW[22]+MW[25])/2                                  ;PtoA + AtoP Trips - HBO
;NHB SR2 Trips (vehicles)
MW[232]=(MW[32]+MW[35])/2                                  ;PtoA + AtoP Trips - NHB

;HBW SR3+ Trips (vehicles)
MW[213]=((MW[13]+MW[16]+MW[93]+MW[96])/{OC3VHBW})+(MW[43]+ MW[46]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR3+ Trips (vehicles)
MW[223]=(MW[23]+MW[26])/{OC3VHBNW}                                 ;PtoA + AtoP Trips - HBO
;NHB SR3+ Trips (vehicles)
MW[233]=(MW[33]+MW[36])/{OC3VNHB}                                  ;PtoA + AtoP Trips - NHB


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00N.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00N.PRN" MSG='Combine HWY trip tables - PM Period'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI MATI[10] = "{SCENARIO_DIR}\output\JaxPrtTrk_PM_TEM.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\EETrk_PM_TEM.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\EECar_PM_TEM.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\IITrk_PM_TEM.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\IETrk_PM_TEM.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\IECar_PM_TEM.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_PM_TEM.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_PM_TEM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_PM_TEM.MAT"

FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_PM_{alt}{year}.MAT",
 MO=121-130, NAME=PM_DA_IEII,PM_SR2_IEII,PM_SR3_IEII,PM_TRK_IEII,PM_TRK_EE,
                  PM_DA_EE,PM_SR2_EE,PM_SR3_EE,PM_PortTrk,PM_Total, DEC=10*s

FILEO MATO[2] = "{SCENARIO_DIR}\output\HWYTTBP_PM_{alt}{year}.MAT",
 MO=211-213,221-223,231-233, NAME=PM_HBW_DA,PM_HBW_SR2,PM_HBW_SR3P,
                                  PM_HBO_DA,PM_HBO_SR2,PM_HBO_SR3P,
                                  PM_NHB_DA,PM_NHB_SR2,PM_NHB_SR3P, DEC=9*s

PAR ZONEMSG=100

FILLMW MW[11]  = MI.1.1,2,3,4,5,6   ;HBW:     11/12/13-DA_P2A,SR2_P2A,SR3_P2A |14/15/16-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[21]  = MI.2.1,2,3,4,5,6   ;HBNW:    21/22/23-DA_P2A,SR2_P2A,SR3_P2A |24/25/26-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[31]  = MI.3.1,2,3,4,5,6   ;NHB:     31/32/33-DA_P2A,SR2_P2A,SR3_P2A |34/35/36-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[41]  = MI.4.1,2,3,4,5,6   ;IE-Cars: 41/42/43-DA_P2A,SR2_P2A,SR3_P2A |44/45/46-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[51]  = MI.5.1,2,3,4       ;IE-Trks: 51/52   -LD_P2A,HD_P2A          |53/54   -LD_A2P,HD_A2P
FILLMW MW[61]  = MI.6.1,2,3,4,5,6   ;II-Trks: 61/62/63-LT_P2A,MT_P2A,HT_P2A   |64/65/66-LT_A2P,MT_A2P,HT_A2P
FILLMW MW[71]  = MI.7.1,2,3,4,5,6   ;EE-Cars: 71/72/73-DA_P2A,SR2_P2A,SR3_P2A |74/75/76-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[81]  = MI.8.1,2,3,4       ;EE-Trks: 81/82   -LD_P2A,HD_P2A          |83/84   -LD_A2P,HD_A2P
; FILLMW MW[91]  = MI.9.1,2,3,4,5,6   ;TRN-DRV: 91/92/93-DA_P2A,SR2_P2A,SR3_P2A |94/95/96-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[98]  = MI.10.1,2          ;JaxPort-FreightTrucks: 98-JPRTTrk_P2A    |99      -JPRTTrk_A2P

MW[91] = 0
MW[92] = 0
MW[93] = 0
MW[94] = 0
MW[95] = 0
MW[96] = 0


; DRIVE ALONE
MW[101]=(MW[11] + MW[21] + MW[31] + MW[41] +  MW[91]) +
        (MW[14] + MW[24] + MW[34] + MW[44] +  MW[94]) 

; AUTO 2 (SR2)
MW[102]=((MW[12] + MW[22] + MW[32] +  MW[92]) +
         (MW[15] + MW[25] + MW[35] +  MW[95]))/2 

; AUTO 3+ (SR3+)
MW[103]=((MW[13] + MW[93]) +(MW[16] + MW[96]))/{OC3VHBW} +        ;HBW & Transit-AutoAccess
        (MW[23] + MW[26])/{OC3VHBNW} +                            ;HBNW
        (MW[33] + MW[36])/{OC3VNHB}                               ;NHB

; SR2_IE
MW[104]= MW[42]+
         MW[45] 

; SR3_IE
MW[105]= MW[43]+
         MW[46] 

; II/IE TRK
MW[106]= (MW[61] + MW[62] + MW[63] + MW[51] +  MW[52]) +
         (MW[64] + MW[65] + MW[66] + MW[53] +  MW[54]) 

; EE TRUCK
MW[107]= (MW[81] + MW[82])+
         (MW[83] + MW[84]) 

; EE SOV/DA
MW[108]= MW[71] +
         MW[74]

; EE SR2
MW[109]= MW[72]+
         MW[75] 

; EE SR3
MW[110]= MW[73]+
         MW[76] 

; JaxPort Freight TRUCK
MW[111]= MW[98] +
         MW[99]

; FINAL TABLE ORDERING FOR Period HIGHWAY Assignnment
MW[121]=MW[101]              ;DA_IEII
MW[122]=MW[102]+MW[104]      ;SR2_IEII
MW[123]=MW[103]+MW[105]      ;SR3_IEII
MW[124]=MW[106]                        ;TRK_IEII
MW[125]=MW[107]                        ;TRK_EE
MW[126]=MW[108]                        ;DA_EE
MW[127]=MW[109]                        ;SR2_EE
MW[128]=MW[110]                        ;SR3_EE
MW[129]=MW[111]                        ;JaxPortTrk

LOOP K=121,129
  MW[130]=MW[130]+MW[K]                ;TotVeh for Period XX
ENDLOOP

;==============Purpose Specific Matrices by Mode=====================

;HBW DA Trips (vehicles)
MW[211]=(MW[11]+(MW[14]+MW[41]+ MW[44]+MW[91])+MW[94])     ;PtoA + AtoP Trips - HBW & IE & TranDRV
;HBO DA Trips (vehicles)
MW[221]=(MW[21] + MW[24])                                  ;PtoA + AtoP Trips - HBO
;NHB DA Trips (vehicles)
MW[231]=(MW[31] + MW[34])                                  ;PtoA + AtoP Trips - NHB
    
;HBW SR2 Trips (vehicles)
MW[212]=((MW[12]+MW[15]+MW[92]+MW[95])/2)+(MW[42]+ MW[45]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR2 Trips (vehicles)
MW[222]=(MW[22]+MW[25])/2                                  ;PtoA + AtoP Trips - HBO
;NHB SR2 Trips (vehicles)
MW[232]=(MW[32]+MW[35])/2                                  ;PtoA + AtoP Trips - NHB

;HBW SR3+ Trips (vehicles)
MW[213]=((MW[13]+MW[16]+MW[93]+MW[96])/{OC3VHBW})+(MW[43]+ MW[46]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR3+ Trips (vehicles)
MW[223]=(MW[23]+MW[26])/{OC3VHBNW}                                 ;PtoA + AtoP Trips - HBO
;NHB SR3+ Trips (vehicles)
MW[233]=(MW[33]+MW[36])/{OC3VNHB}                                  ;PtoA + AtoP Trips - NHB



ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00O.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00O.PRN" MSG='Combine HWY trip tables - NT Period'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI MATI[10] = "{SCENARIO_DIR}\output\JaxPrtTrk_NT_TEM.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\EETrk_NT_TEM.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\EECar_NT_TEM.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\IITrk_NT_TEM.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\IETrk_NT_TEM.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\IECar_NT_TEM.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_NT_TEM.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_NT_TEM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_NT_TEM.MAT"

FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_NT_{alt}{year}.MAT",
 MO=121-130, NAME=NT_DA_IEII,NT_SR2_IEII,NT_SR3_IEII,NT_TRK_IEII,NT_TRK_EE,
                  NT_DA_EE,NT_SR2_EE,NT_SR3_EE,NT_PortTrk,NT_Total, DEC=10*s

FILEO MATO[2] = "{SCENARIO_DIR}\output\HWYTTBP_NT_{alt}{year}.MAT",
 MO=211-213,221-223,231-233, NAME=NT_HBW_DA,NT_HBW_SR2,NT_HBW_SR3P,
                                  NT_HBO_DA,NT_HBO_SR2,NT_HBO_SR3P,
                                  NT_NHB_DA,NT_NHB_SR2,NT_NHB_SR3P, DEC=9*s

PAR ZONEMSG=100

FILLMW MW[11]  = MI.1.1,2,3,4,5,6   ;HBW:     11/12/13-DA_P2A,SR2_P2A,SR3_P2A |14/15/16-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[21]  = MI.2.1,2,3,4,5,6   ;HBNW:    21/22/23-DA_P2A,SR2_P2A,SR3_P2A |24/25/26-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[31]  = MI.3.1,2,3,4,5,6   ;NHB:     31/32/33-DA_P2A,SR2_P2A,SR3_P2A |34/35/36-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[41]  = MI.4.1,2,3,4,5,6   ;IE-Cars: 41/42/43-DA_P2A,SR2_P2A,SR3_P2A |44/45/46-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[51]  = MI.5.1,2,3,4       ;IE-Trks: 51/52   -LD_P2A,HD_P2A          |53/54   -LD_A2P,HD_A2P
FILLMW MW[61]  = MI.6.1,2,3,4,5,6   ;II-Trks: 61/62/63-LT_P2A,MT_P2A,HT_P2A   |64/65/66-LT_A2P,MT_A2P,HT_A2P
FILLMW MW[71]  = MI.7.1,2,3,4,5,6   ;EE-Cars: 71/72/73-DA_P2A,SR2_P2A,SR3_P2A |74/75/76-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[81]  = MI.8.1,2,3,4       ;EE-Trks: 81/82   -LD_P2A,HD_P2A          |83/84   -LD_A2P,HD_A2P
; FILLMW MW[91]  = MI.9.1,2,3,4,5,6   ;TRN-DRV: 91/92/93-DA_P2A,SR2_P2A,SR3_P2A |94/95/96-DA_A2P,SR2_A2P,SR3_A2P
FILLMW MW[98]  = MI.10.1,2          ;JaxPort-FreightTrucks: 98-JPRTTrk_P2A    |99      -JPRTTrk_A2P

MW[91] = 0
MW[92] = 0
MW[93] = 0
MW[94] = 0
MW[95] = 0
MW[96] = 0


; DRIVE ALONE
MW[101]=(MW[11] + MW[21] + MW[31] + MW[41] +  MW[91]) +
        (MW[14] + MW[24] + MW[34] + MW[44] +  MW[94]) 

; AUTO 2 (SR2)
MW[102]=((MW[12] + MW[22] + MW[32] +  MW[92]) +
         (MW[15] + MW[25] + MW[35] +  MW[95]))/2 

; AUTO 3+ (SR3+)
MW[103]=((MW[13] + MW[93]) +(MW[16] + MW[96]))/{OC3VHBW} +        ;HBW & Transit-AutoAccess
        (MW[23] + MW[26])/{OC3VHBNW} +                            ;HBNW
        (MW[33] + MW[36])/{OC3VNHB}                               ;NHB

; SR2_IE
MW[104]= MW[42]+
         MW[45] 

; SR3_IE
MW[105]= MW[43]+
         MW[46] 

; II/IE TRK
MW[106]= (MW[61] + MW[62] + MW[63] + MW[51] +  MW[52]) +
         (MW[64] + MW[65] + MW[66] + MW[53] +  MW[54]) 

; EE TRUCK
MW[107]= (MW[81] + MW[82])+
         (MW[83] + MW[84]) 

; EE SOV/DA
MW[108]= MW[71] +
         MW[74]

; EE SR2
MW[109]= MW[72]+
         MW[75] 

; EE SR3
MW[110]= MW[73]+
         MW[76] 

; JaxPort Freight TRUCK
MW[111]= MW[98] +
         MW[99]

; FINAL TABLE ORDERING FOR Period HIGHWAY Assignnment
MW[121]=MW[101]              ;DA_IEII
MW[122]=MW[102]+MW[104]      ;SR2_IEII
MW[123]=MW[103]+MW[105]      ;SR3_IEII
MW[124]=MW[106]                        ;TRK_IEII
MW[125]=MW[107]                        ;TRK_EE
MW[126]=MW[108]                        ;DA_EE
MW[127]=MW[109]                        ;SR2_EE
MW[128]=MW[110]                        ;SR3_EE
MW[129]=MW[111]                        ;JaxPortTrk

LOOP K=121,129
  MW[130]=MW[130]+MW[K]                ;TotVeh for Period XX
ENDLOOP

;==============Purpose Specific Matrices by Mode=====================

;HBW DA Trips (vehicles)
MW[211]=(MW[11]+(MW[14]+MW[41]+ MW[44]+MW[91])+MW[94])     ;PtoA + AtoP Trips - HBW & IE & TranDRV
;HBO DA Trips (vehicles)
MW[221]=(MW[21] + MW[24])                                  ;PtoA + AtoP Trips - HBO
;NHB DA Trips (vehicles)
MW[231]=(MW[31] + MW[34])                                  ;PtoA + AtoP Trips - NHB
 
;HBW SR2 Trips (vehicles)
MW[212]=((MW[12]+MW[15]+MW[92]+MW[95])/2)+(MW[42]+ MW[45]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR2 Trips (vehicles)
MW[222]=(MW[22]+MW[25])/2                                  ;PtoA + AtoP Trips - HBO
;NHB SR2 Trips (vehicles)
MW[232]=(MW[32]+MW[35])/2                                  ;PtoA + AtoP Trips - NHB

;HBW SR3+ Trips (vehicles)
MW[213]=((MW[13]+MW[16]+MW[93]+MW[96])/{OC3VHBW})+(MW[43]+ MW[46]) ;PtoA + AtoP Trips - HBW  & TranDRV & IE
;HBO SR3+ Trips (vehicles)
MW[223]=(MW[23]+MW[26])/{OC3VHBNW}                                 ;PtoA + AtoP Trips - HBO
;NHB SR3+ Trips (vehicles)
MW[233]=(MW[33]+MW[36])/{OC3VNHB}                                  ;PtoA + AtoP Trips - NHB


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00Q.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00Q.PRN" MSG='Sum 4 Period Tables for Check'
FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_AllPeriod_Chk_{alt}{year}.MAT",
 MO=11-20, NAME=AD_DA_IEII,AD_SR2_IEII,AD_SR3_IEII,AD_TRK_IEII,AD_TRK_EE,
               AD_DA_EE,AD_SR2_EE,AD_SR3_EE,AD_PortTrk,AD_Total, DEC=10*s

FILEI MATI[4] = "{SCENARIO_DIR}\output\HWYTTAB_NT_{alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\HWYTTAB_PM_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HWYTTAB_MD_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HWYTTAB_AM_{alt}{year}.MAT"

PAR ZONEMSG=100

MW[11]=MI.1.1+MI.2.1+MI.3.1+MI.4.1
MW[12]=MI.1.2+MI.2.2+MI.3.2+MI.4.2
MW[13]=MI.1.3+MI.2.3+MI.3.3+MI.4.3
MW[14]=MI.1.4+MI.2.4+MI.3.4+MI.4.4
MW[15]=MI.1.5+MI.2.5+MI.3.5+MI.4.5
MW[16]=MI.1.6+MI.2.6+MI.3.6+MI.4.6
MW[17]=MI.1.7+MI.2.7+MI.3.7+MI.4.7
MW[18]=MI.1.8+MI.2.8+MI.3.8+MI.4.8
MW[19]=MI.1.9+MI.2.9+MI.3.9+MI.4.9

MW[20]=MI.1.10+MI.2.10+MI.3.10+MI.4.10

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

endif           ;Time of Day (4 periods) Highway Model
; End of PILOT Script

