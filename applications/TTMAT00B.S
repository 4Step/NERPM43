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
