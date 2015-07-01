; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\TTMAT00E.PRN" MSG='Create IECar Period Hwy Veh TT by Mode/Dir'
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
