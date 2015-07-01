; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\TTMAT00H.PRN" MSG='Create EECar Period Hwy Veh TT by Mode/Dir'
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
