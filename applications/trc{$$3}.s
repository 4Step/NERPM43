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


