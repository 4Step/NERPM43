; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\TTMAT00J.PRN" MSG='Create Transit Auto Access Car Period Hwy Pax TT by Mode/Dir'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4


FILEO MATO[4] = "{SCENARIO_DIR}\output\TrnDrv_NT_TEM.MAT",
  MO=61-66, NAME= NT_TrnCar_DA_P2A, NT_TrnCar_SR2_P2A, NT_TrnCar_SR3_P2A,
                  NT_TrnCar_DA_A2P, NT_TrnCar_SR2_A2P, NT_TrnCar_SR3_A2P, dec=6*S

FILEO MATO[3] = "{SCENARIO_DIR}\output\TrnDrv_PM_TEM.MAT",
  MO=51-56, NAME= PM_TrnCar_DA_P2A, PM_TrnCar_SR2_P2A, PM_TrnCar_SR3_P2A,
                  PM_TrnCar_DA_A2P, PM_TrnCar_SR2_A2P, PM_TrnCar_SR3_A2P, dec=6*S

FILEO MATO[2] = "{SCENARIO_DIR}\output\TrnDrv_MD_TEM.MAT",
  MO=41-46, NAME= MD_TrnCar_DA_P2A, MD_TrnCar_SR2_P2A, MD_TrnCar_SR3_P2A,
                  MD_TrnCar_DA_A2P, MD_TrnCar_SR2_A2P, MD_TrnCar_SR3_A2P, dec=6*S

FILEO MATO[1] = "{SCENARIO_DIR}\output\TrnDrv_AM_TEM.MAT",
  MO=31-36, NAME= AM_TrnCar_DA_P2A, AM_TrnCar_SR2_P2A, AM_TrnCar_SR3_P2A,
                  AM_TrnCAr_DA_A2P, AM_TrnCar_SR2_A2P, AM_TrnCar_SR3_A2P, dec=6*S


PAR ZONEMSG=100

FILLMW MW[201]=MI.1.1,2               ;201/202: TransitAutoAccessCars-SO,HO

FILLMW MW[301]=MI.1.1.T,2.T           ;301/302: TransitAutoAccessCars-SO,HO -Transposed


MW[1]=MW[201]                           ; TransitCar - DA
MW[2]=MW[202]*(1.0-{TRNDRV_SR3_Fac})    ; TransitCar - SR2
MW[3]=MW[202]*{TRNDRV_SR3_Fac}          ; TransitCar - SR3

MW[101]=MW[301]                           ; TransitCar - DA - Transposed
MW[102]=MW[302]*(1.0-{TRNDRV_SR3_Fac})    ; TransitCar - SR2 - Transposed
MW[103]=MW[302]*{TRNDRV_SR3_Fac}          ; TransitCar - SR3 - Transposed

TRNDRV_NT_Frac=1-({TRNDRV_AM_Frac}+{TRNDRV_MD_Frac}+{TRNDRV_PM_Frac})

;AMPK-TransitCar: 31=DA_PA, 32=SR2_PA, 33=SR3_PA, 34=DA_AP, 35=SR2_AP, 36=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=30+K
  _KAP=33+K
  MW[_KPA]=MW[K]*{TRNDRV_AM_Frac}*0.5
  MW[_KAP]=MW[KK]*{TRNDRV_AM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;MidDay-TransitCar: 41=DA_PA, 42=SR2_PA, 43=SR3_PA, 44=DA_AP, 45=SR2_AP, 46=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=40+K
  _KAP=43+K
  MW[_KPA]=MW[K]*{TRNDRV_MD_Frac}*0.5
  MW[_KAP]=MW[KK]*{TRNDRV_MD_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP

;PMPK-TransitCar: 51=DA_PA, 52=SR2_PA, 53=SR3_PA, 54=DA_AP, 55=SR2_AP, 56=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=50+K
  _KAP=53+K
  MW[_KPA]=MW[K]*{TRNDRV_PM_Frac}*0.5
  MW[_KAP]=MW[KK]*{TRNDRV_PM_Frac}*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


;OverNight-TransitCar: 61=DA_PA, 62=SR2_PA, 63=SR3_PA, 64=DA_AP, 65=SR2_AP, 66=SR3_AP
LOOP K=1,3
  KK=100+K 
  _KPA=60+K
  _KAP=63+K
  MW[_KPA]=MW[K]*TRNDRV_NT_Frac*0.5
  MW[_KAP]=MW[KK]*TRNDRV_NT_Frac*0.5
  JLOOP
    if (MW[_KPA]<0.0) MW[_KPA]=0.0  
    if (MW[_KAP]<0.0) MW[_KAP]=0.0
  ENDJLOOP
ENDLOOP


ENDRUN
