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
