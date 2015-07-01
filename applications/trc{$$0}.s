; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TTMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TTMAT00A.PRN" MSG='Combine trip tables for 24-Hour Assignment'
FILEI MATI[7] = "{SCENARIO_DIR}\output\PORT_TRK_24H_{Year}.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\EETRIPS.MAT"
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_{alt}{year}.MAT",
MO=121-128, NAME=DA_IEII,SR_IEII,TRK_IEII,TRK_EE,
                 DA_EE,SR_EE,PortTrk,24H_Total, DEC=8*s
                 
FILEI MATI[4] = "{SCENARIO_DIR}\Output\VTRIP1.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\NHB_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNW_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBW_{alt}{year}.MAT"

PAR ZONEMSG=100

FILLMW MW[1]  = MI.1.1,2,3,4,5,6,7,8,9,10,11,12   ; - HBW trips
FILLMW MW[21] = MI.2.1,2,3,4,5,6,7,8,9,10,11,12   ; - HBNW trips
FILLMW MW[41] = MI.3.1,2,3,4,5,6,7,8,9,10,11,12   ; - NHB trips
FILLMW MW[61] = MI.4.1,2,3,4,5,6,7                ; Veh Trips (TRK - LT,MT,HT & IE - SO,HO,LD,HD)
FILLMW MW[81] = MI.5.1,2,3,4,5                    ; EE Trips (SOV,HOV,LT,HT,Tot)


; DRIVE ALONE
 MW[101]=(MW[1] + MW[21] + MW[41] + MW[64] + MI.1.1.T + MI.2.1.T + MI.3.1.T + MI.4.4.T )*0.5

; AUTO 2
;===Mistake to include MW[12] instead of MW[22]==>MW[102]=(MW[2] + MW[12] + MW[42] + MW[92] + MI.1.2.T + MI.2.2.T + MI.3.2.T + MI.6.2.T)/2*0.5
 MW[102]=(MW[2] + MW[22] + MW[42] + MI.1.2.T + MI.2.2.T + MI.3.2.T )/2*0.5

; AUTO 3+ HBW
MW[103]=(MW[3] + MI.1.3.T)/{OC3VHBW}*0.5   ; include this modifier if model is revalidated
; AUTO 3+ HBO
MW[104]=(MW[23] + MI.2.3.T)/{OC3VHBNW}*0.5  ; include this modifier if model is revalidated
; AUTO 3+ NHB
;===Another Mistake to include MW[3] instead of MW[43] ==> MW[105]=(MW[3] + MI.3.3.T)/{OC3VNHB}*0.5   ;  include this modifier if model is revalidated
MW[105]=(MW[43] + MI.3.3.T)/{OC3VNHB}*0.5   ;  include this modifier if model is revalidated
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
MW[121]=MW[101]                                  ; DA_IEII
MW[122]=MW[102]+MW[103]+MW[104]+MW[105]+MW[106]  ; SR_IEII
MW[123]=MW[107]                                  ; TRK_IEII
MW[124]=MW[108]                                  ; TRK_EE
MW[125]=MW[109]                                  ; DA_EE
MW[126]=MW[110]                                  ; SR_EE
MW[127]=MI.7.1                                   ; JaxPortTrucks

LOOP K=121,127
  MW[128]=MW[128]+MW[K]                          ;TotVeh
ENDLOOP

ENDRUN


