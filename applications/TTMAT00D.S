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
