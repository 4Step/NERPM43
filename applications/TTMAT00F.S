; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\TTMAT00F.PRN" MSG='Create IETrk Period Hwy Veh TT by CLS (LD/HD)/Dir'
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
