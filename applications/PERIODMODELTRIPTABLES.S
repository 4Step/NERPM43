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


