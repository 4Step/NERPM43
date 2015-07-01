; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00Hsb.PRN" MSG='Combine trip tables for assignment'
FILEO MATO[2] = "{SCENARIO_DIR}\output\TRANSITTABsb_{alt}{year}.MAT",
 MO=131-139,141-149, DEC=18*S,
 NAME=PKWlkBus,PKWlkPrj,PKPNRBus,PKPNRPrj,PKKNRBus,PKKNRPrj,PKCBDKNRBus,PKCBDKNRPrj,PKFringe,
      OPWlkBus,OPWlkPrj,OPPNRBus,OPPNRPrj,OPKNRBus,OPKNRPrj,OPCBDKNRBus,OPCBDKNRPrj,OPFringe
FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTABsb_{alt}{year}.MAT",
 MO=121-126, NAME=TRKIEII,SOVIEII,HOVIEII,TRKEE,SOVEE,HOVEE, DEC=6*S

FILEI MATI[6] = "{SCENARIO_DIR}\output\AutoAcc_Hwysb.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\VTRIP1.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_{alt}{year}sb.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}sb.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}sb.MAT"

PAR ZONEMSG=100
DistributeINTRASTEP ProcessID="JTADist", ProcessList=1-3

FILLMW MW[1]  = MI.1.1,2,3,4,5,6,7,8,9,10,11,12   ; - HBW trips
FILLMW MW[21] = MI.2.1,2,3,4,5,6,7,8,9,10,11,12   ; - HBNW trips
FILLMW MW[41] = MI.3.1,2,3,4,5,6,7,8,9,10,11,12   ; - NHB trips
FILLMW MW[61] = MI.4.1,2,3,4,5,6,7
FILLMW MW[81] = MI.5.1,2,3,4,5
FILLMW MW[91] = MI.6.1,2

; DRIVE ALONE
MW[101]=(MW[1] + MW[21] + MW[41] + MW[64] + MW[91] + MI.1.1.T + MI.2.1.T + MI.3.1.T + MI.4.4.T + MI.6.1.T)*0.5
; AUTO 2
MW[102]=(MW[2] + MW[12] + MW[42] + MW[92] + MI.1.2.T + MI.2.2.T + MI.3.2.T + MI.6.2.T)/2*0.5
; AUTO 3+ HBW
MW[103]=(MW[3] + MI.1.3.T)/{OC3VHBW}*0.5   ; include this modifier if model is revalidated
; AUTO 3+ HBO
MW[104]=(MW[23] + MI.2.3.T)/{OC3VHBNW}*0.5  ; include this modifier if model is revalidated
; AUTO 3+ NHB
MW[105]=(MW[3] + MI.3.3.T)/{OC3VNHB}*0.5   ;  include this modifier if model is revalidated
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
MW[121]=MW[107]                                  ; TRKIEII
MW[122]=MW[101]                                  ; SOVIEII
MW[123]=MW[102]+MW[103]+MW[104]+MW[105]+MW[106]  ; HOVIEII
MW[124]=MW[108]                                  ; TRKEE
MW[125]=MW[109]                                  ; SOVEE
MW[126]=MW[110]                                  ; HOVEE

; PEAK TRANSIT
MW[131]=MW[4]
MW[132]=MW[5]
MW[133]=MW[6]
MW[134]=MW[7]
MW[135]=MW[8]
MW[136]=MW[9]
MW[137]=MW[10]
MW[138]=MW[11]
MW[139]=MW[12]

; OFF-PEAK TRANSIT
MW[141]=MW[24] + MW[44]
MW[142]=MW[25] + MW[45]
MW[143]=MW[26] + MW[46]
MW[144]=MW[27] + MW[47]
MW[145]=MW[28] + MW[48]
MW[146]=MW[29] + MW[49]
MW[147]=MW[30] + MW[50]
MW[148]=MW[31] + MW[51]
MW[149]=MW[32] + MW[52]

ENDRUN
