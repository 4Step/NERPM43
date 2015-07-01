
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TDMAT00D.PRN" MSG='Combine trip tables for assignment'

;Off-Peak Period Trip Tables
FILEI MATI[16] = "{SCENARIO_DIR}\OUTPUT\HBSC_OP_{alt}{year}.mat"
FILEI MATI[15] = "{SCENARIO_DIR}\OUTPUT\HBCU_OP_{alt}{year}.mat"
FILEI MATI[14] = "{SCENARIO_DIR}\OUTPUT\NHBO_OP_{alt}{year}.mat"
FILEI MATI[13] = "{SCENARIO_DIR}\OUTPUT\HBO_OP_{alt}{year}.mat"
FILEI MATI[12] = "{SCENARIO_DIR}\OUTPUT\HBSR_OP_{alt}{year}.mat"
FILEI MATI[11] = "{SCENARIO_DIR}\OUTPUT\HBSH_OP_{alt}{year}.mat"
FILEI MATI[10] = "{SCENARIO_DIR}\OUTPUT\NHBW_OP_{alt}{year}.mat"
FILEI MATI[9] = "{SCENARIO_DIR}\OUTPUT\HBW_OP_{alt}{year}.mat"
;Peak Period Trip Tables
FILEI MATI[8] = "{SCENARIO_DIR}\OUTPUT\HBSC_PK_{alt}{year}.mat"
FILEI MATI[7] = "{SCENARIO_DIR}\OUTPUT\HBCU_PK_{alt}{year}.mat"
FILEI MATI[6] = "{SCENARIO_DIR}\OUTPUT\NHBO_PK_{alt}{year}.mat"
FILEI MATI[5] = "{SCENARIO_DIR}\OUTPUT\HBO_PK_{alt}{year}.mat"
FILEI MATI[4] = "{SCENARIO_DIR}\OUTPUT\HBSR_PK_{alt}{year}.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\OUTPUT\HBSH_PK_{alt}{year}.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\OUTPUT\NHBW_PK_{alt}{year}.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\HBW_PK_{alt}{year}.mat"

; Transit Trips by Period by Mode
FILEO MATO[10] = "{SCENARIO_DIR}\OUTPUT\TRANSITTAB_{ALT}{YEAR}.MAT",
    MO=319,329,339,349,359,369,419,429,439,449,459,469,370,470, DEC=12*S,
  NAME=PKWlkBus,PKWlkPrj,PKPNRBus,PKPNRPrj,PKKNRBus,PKKNRPrj,
     OPWlkBus,OPWlkPrj,OPPNRBus,OPPNRPrj,OPKNRBus,OPKNRPrj,PKTOT,OPTOT

; Vehicle Trips by Period by Mode
FILEO MATO[9] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_TOTVEH_TEMP_{ALT}{YEAR}.MAT",
    MO=135,235,DEC=2*S,NAME=PK_TOTVEH,OP_TOTVEH
FILEO MATO[8] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_HBSC_TEMP_{ALT}{YEAR}.MAT",
    MO=132-134,232-234,DEC=6*S,NAME=PK_HBSC_DA,PK_HBSC_SR2,PK_HBSC_SR3,
                                     OP_HBSC_DA,OP_HBSC_SR2,OP_HBSC_SR3
FILEO MATO[7] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_HBCU_TEMP_{ALT}{YEAR}.MAT",
    MO=129-131,229-231,DEC=6*S,NAME=PK_HBCU_DA,PK_HBCU_SR2,PK_HBCU_SR3,
                                     OP_HBCU_DA,OP_HBCU_SR2,OP_HBCU_SR3
FILEO MATO[6] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_NHBO_TEMP_{ALT}{YEAR}.MAT",
    MO=126-128,226-228,DEC=6*S,NAME=PK_NHBO_DA,PK_NHBO_SR2,PK_NHBO_SR3,
                                     OP_NHBO_DA,OP_NHBO_SR2,OP_NHBO_SR3
FILEO MATO[5] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_HBO_TEMP_{ALT}{YEAR}.MAT",
    MO=123-125,223-225,DEC=6*S,NAME=PK_HBO_DA,PK_HBO_SR2,PK_HBO_SR3,
                                     OP_HBO_DA,OP_HBO_SR2,OP_HBO_SR3
FILEO MATO[4] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_HBSR_TEMP_{ALT}{YEAR}.MAT",
    MO=120-122,220-222,DEC=6*S,NAME=PK_HBSR_DA,PK_HBSR_SR2,PK_HBSR_SR3,
                                     OP_HBSR_DA,OP_HBSR_SR2,OP_HBSR_SR3
FILEO MATO[3] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_HBSH_TEMP_{ALT}{YEAR}.MAT",
    MO=117-119,217-219,DEC=6*S,NAME=PK_HBSH_DA,PK_HBSH_SR2,PK_HBSH_SR3,
                                     OP_HBSH_DA,OP_HBSH_SR2,OP_HBSH_SR3
FILEO MATO[2] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_NHBW_TEMP_{ALT}{YEAR}.MAT",
    MO=114-116,214-216,DEC=6*S,NAME=PK_NHBW_DA,PK_NHBW_SR2,PK_NHBW_SR3,
                                     OP_NHBW_DA,OP_NHBW_SR2,OP_NHBW_SR3
FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\HWYTTAB_HBW_TEMP_{ALT}{YEAR}.MAT",
    MO=111-113,211-213,DEC=6*S,NAME=PK_HBW_DA,PK_HBW_SR2,PK_HBW_SR3,
                                     OP_HBW_DA,OP_HBW_SR2,OP_HBW_SR3

PAR ZONEMSG=100

DistributeINTRASTEP ProcessID="TMUDemoDist", ProcessList=1-%NUMBER_OF_PROCESSORS%

; Vehicle Trips

; Peak Period
MW[111]=MI.1.1                            ; HBW PK: DA
MW[112]=MI.1.2 / 2                        ; HBW PK: SR2
MW[113]=MI.1.3 / {oc3vhbw}                ; HBW PK: SR3

MW[114]=MI.2.1                            ; NHBW PK: DA
MW[115]=MI.2.2 / 2                        ; NHBW PK: SR2
MW[116]=MI.2.3 / {oc3vhbw}                ; NHBW PK: SR3

MW[117]=MI.3.1                            ; HBSH PK: DA
MW[118]=MI.3.2 / 2                        ; HBSH PK: SR2
MW[119]=MI.3.3 / {oc3vhbnw}               ; HBSH PK: SR3

MW[120]=MI.4.1                            ; HBSR PK: DA
MW[121]=MI.4.2 / 2                        ; HBSR PK: SR2
MW[122]=MI.4.3 / {oc3vhbnw}               ; HBSR PK: SR3
    
MW[123]=MI.5.1                            ; HBO PK: DA
MW[124]=MI.5.2 / 2                        ; HBO PK: SR2
MW[125]=MI.5.3 / {oc3vhbnw}               ; HBO PK: SR3
    
MW[126]=MI.6.1                            ; NHBO PK: DA
MW[127]=MI.6.2 / 2                        ; NHBO PK: SR2
MW[128]=MI.6.3 / {oc3vnhb}                ; NHBO PK: SR3
    
MW[129]=MI.7.1                            ; HBCU PK: DA
MW[130]=MI.7.2 / 2                        ; HBCU PK: SR2
MW[131]=MI.7.3 / {oc3vhbw}                ; HBCU PK: SR3
    
MW[132]=MI.8.1                            ; HBSC PK: DA
MW[133]=MI.8.2 / 2                        ; HBSC PK: SR2
MW[134]=MI.8.3 / {oc3vhbnw}               ; HBSC PK: SR3

MW[135]=MW[111]+MW[112]+MW[113]+MW[114]+
        MW[115]+MW[116]+MW[117]+MW[118]+
    MW[119]+MW[120]+MW[121]+MW[122]+
    MW[123]+MW[124]+MW[125]+MW[126]+
    MW[127]+MW[128]+MW[129]+MW[130]+
    MW[131]+MW[132]+MW[133]+MW[134]    ; PK TOTAL

; Off-Peak Period
MW[211]=MI.9.1                             ; HBW OP: DA
MW[212]=MI.9.2 / 2                         ; HBW OP: SR2
MW[213]=MI.9.3 / {oc3vhbw}                 ; HBW OP: SR3
    
MW[214]=MI.10.1                            ; NHBW OP: DA
MW[215]=MI.10.2 / 2                        ; NHBW OP: SR2
MW[216]=MI.10.3 / {oc3vhbw}                ; NHBW OP: SR3
    
MW[217]=MI.11.1                            ; HBSH OP: DA
MW[218]=MI.11.2 / 2                        ; HBSH OP: SR2
MW[219]=MI.11.3 / {oc3vhbnw}               ; HBSH OP: SR3

MW[220]=MI.12.1                            ; HBSR OP: DA
MW[221]=MI.12.2 / 2                        ; HBSR OP: SR2
MW[222]=MI.12.3 / {oc3vhbnw}               ; HBSR OP: SR3
    
MW[223]=MI.13.1                            ; HBO OP: DA
MW[224]=MI.13.2 / 2                        ; HBO OP: SR2
MW[225]=MI.13.3 / {oc3vhbnw}               ; HBO OP: SR3
    
MW[226]=MI.14.1                            ; NHBO OP: DA
MW[227]=MI.14.2 / 2                        ; NHBO OP: SR2
MW[228]=MI.14.3 / {oc3vnhb}                ; NHBO OP: SR3
    
MW[229]=MI.15.1                            ; HBCU OP: DA
MW[230]=MI.15.2 / 2                        ; HBCU OP: SR2
MW[231]=MI.15.3 / {oc3vhbw}                ; HBCU OP: SR3
    
MW[232]=MI.16.1                            ; HBSC OP: DA
MW[233]=MI.16.2 / 2                        ; HBSC OP: SR2
MW[234]=MI.16.3 / {oc3vhbnw}               ; HBSC OP: SR3

MW[235]=MW[211]+MW[212]+MW[213]+MW[214]+
        MW[215]+MW[216]+MW[217]+MW[218]+
    MW[219]+MW[220]+MW[221]+MW[222]+
    MW[223]+MW[224]+MW[225]+MW[226]+
    MW[227]+MW[228]+MW[229]+MW[230]+
    MW[231]+MW[232]+MW[233]+MW[234]    ; PK TOTAL


; Transit Trips

; Peak Period by Transit Mode
MW[311]=MI.1.4                             ; HBW PK: WalkBus
MW[312]=MI.2.4                             ; NHBW PK: WalkBus
MW[313]=MI.3.4                             ; HBSH PK: WalkBus
MW[314]=MI.4.4                             ; HBSR PK: WalkBus
MW[315]=MI.5.4                             ; HBO PK: WalkBus
MW[316]=MI.6.4                             ; NHBO PK: WalkBus
MW[317]=MI.7.4                             ; HBCU PK: WalkBus
MW[318]=MI.8.4                             ; HBSC PK: WalkBus
MW[319]=MW[311]+MW[312]+MW[313]+MW[314]+
        MW[315]+MW[316]+MW[317]+MW[318]    ; PK: WalkBus

MW[321]=MI.1.5                             ; HBW PK: WalkPrj
MW[322]=MI.2.5                             ; NHBW PK: WalkPrj
MW[323]=MI.3.5                             ; HBSH PK: WalkPrj
MW[324]=MI.4.5                             ; HBSR PK: WalkPrj
MW[325]=MI.5.5                             ; HBO PK: WalkPrj
MW[326]=MI.6.5                             ; NHBO PK: WalkPrj
MW[327]=MI.7.5                             ; HBCU PK: WalkPrj
MW[328]=MI.8.5                             ; HBSC PK: WalkPrj
MW[329]=MW[321]+MW[322]+MW[323]+MW[324]+
        MW[325]+MW[326]+MW[327]+MW[328]    ; PK: WalkPrj

MW[331]=MI.1.6                             ; HBW PK: PNRBus
MW[332]=MI.2.6                             ; NHBW PK: PNRBus
MW[333]=MI.3.6                             ; HBSH PK: PNRBus
MW[334]=MI.4.6                             ; HBSR PK: PNRBus
MW[335]=MI.5.6                             ; HBO PK: PNRBus
MW[336]=MI.6.6                             ; NHBO PK: PNRBus
MW[337]=MI.7.6                             ; HBCU PK: PNRBus
MW[338]=MI.8.6                             ; HBSC PK: PNRBus
MW[339]=MW[331]+MW[332]+MW[333]+MW[334]+
        MW[335]+MW[336]+MW[337]+MW[338]    ; PK: PNRBus
    
MW[341]=MI.1.7                             ; HBW PK: PNRPrj
MW[342]=MI.2.7                             ; NHBW PK: PNRPrj
MW[343]=MI.3.7                             ; HBSH PK: PNRPrj
MW[344]=MI.4.7                             ; HBSR PK: PNRPrj
MW[345]=MI.5.7                             ; HBO PK: PNRPrj
MW[346]=MI.6.7                             ; NHBO PK: PNRPrj
MW[347]=MI.7.7                             ; HBCU PK: PNRPrj
MW[348]=MI.8.7                             ; HBSC PK: PNRPrj
MW[349]=MW[341]+MW[342]+MW[343]+MW[344]+
        MW[345]+MW[346]+MW[347]+MW[348]    ; PK: PNRPrj

MW[351]=MI.1.8                             ; HBW PK: KNRBus
MW[352]=MI.2.8                             ; NHBW PK: KNRBus
MW[353]=MI.3.8                             ; HBSH PK: KNRBus
MW[354]=MI.4.8                             ; HBSR PK: KNRBus
MW[355]=MI.5.8                             ; HBO PK: KNRBus
MW[356]=MI.6.8                             ; NHBO PK: KNRBus
MW[357]=MI.7.8                             ; HBCU PK: KNRBus
MW[358]=MI.8.8                             ; HBSC PK: KNRBus
MW[359]=MW[351]+MW[352]+MW[353]+MW[354]+
        MW[355]+MW[356]+MW[357]+MW[358]    ; PK: KNRBus

MW[361]=MI.1.9                             ; HBW PK: KNRBus
MW[362]=MI.2.9                             ; NHBW PK: KNRBus
MW[363]=MI.3.9                             ; HBSH PK: KNRBus
MW[364]=MI.4.9                             ; HBSR PK: KNRBus
MW[365]=MI.5.9                             ; HBO PK: KNRBus
MW[366]=MI.6.9                             ; NHBO PK: KNRBus
MW[367]=MI.7.9                             ; HBCU PK: KNRBus
MW[368]=MI.8.9                             ; HBSC PK: KNRBus
MW[369]=MW[361]+MW[362]+MW[363]+MW[364]+
        MW[365]+MW[366]+MW[367]+MW[368]    ; PK: KNRBus

    
; Off Peak Period by Transit Mode
MW[411]=MI.9.4                              ; HBW OP: WalkBus
MW[412]=MI.10.4                             ; NHBW OP: WalkBus
MW[413]=MI.11.4                             ; HBSH OP: WalkBus
MW[414]=MI.12.4                             ; HBSR OP: WalkBus
MW[415]=MI.13.4                             ; HBO OP: WalkBus
MW[416]=MI.14.4                             ; NHBO OP: WalkBus
MW[417]=MI.15.4                             ; HBCU OP: WalkBus
MW[418]=MI.16.4                             ; HBSC OP: WalkBus
MW[419]=MW[411]+MW[412]+MW[413]+MW[414]+
        MW[415]+MW[416]+MW[417]+MW[418]     ; OP: WalkBus

MW[421]=MI.9.5                              ; HBW OP: WalkPrj
MW[422]=MI.10.5                             ; NHBW OP: WalkPrj
MW[423]=MI.11.5                             ; HBSH OP: WalkPrj
MW[424]=MI.12.5                             ; HBSR OP: WalkPrj
MW[425]=MI.13.5                             ; HBO OP: WalkPrj
MW[426]=MI.14.5                             ; NHBO OP: WalkPrj
MW[427]=MI.15.5                             ; HBCU OP: WalkPrj
MW[428]=MI.16.5                             ; HBSC OP: WalkPrj
MW[429]=MW[421]+MW[422]+MW[423]+MW[424]+
        MW[425]+MW[426]+MW[427]+MW[428]     ; OP: WalkPrj

MW[431]=MI.9.6                              ; HBW OP: PNRBus
MW[432]=MI.10.6                             ; NHBW OP: PNRBus
MW[433]=MI.11.6                             ; HBSH OP: PNRBus
MW[434]=MI.12.6                             ; HBSR OP: PNRBus
MW[435]=MI.13.6                             ; HBO OP: PNRBus
MW[436]=MI.14.6                             ; NHBO OP: PNRBus
MW[437]=MI.15.6                             ; HBCU OP: PNRBus
MW[438]=MI.16.6                             ; HBSC OP: PNRBus
MW[439]=MW[431]+MW[432]+MW[433]+MW[534]+
        MW[435]+MW[436]+MW[437]+MW[538]     ; OP: PNRBus
                
MW[441]=MI.9.7                              ; HBW OP: PNRPrj
MW[442]=MI.10.7                             ; NHBW OP: PNRPrj
MW[443]=MI.11.7                             ; HBSH OP: PNRPrj
MW[444]=MI.12.7                             ; HBSR OP: PNRPrj
MW[445]=MI.13.7                             ; HBO OP: PNRPrj
MW[446]=MI.14.7                             ; NHBO OP: PNRPrj
MW[447]=MI.15.7                             ; HBCU OP: PNRPrj
MW[448]=MI.16.7                             ; HBSC OP: PNRPrj
MW[449]=MW[441]+MW[442]+MW[443]+MW[444]+
        MW[445]+MW[446]+MW[447]+MW[448]     ; OP: PNRPrj

MW[451]=MI.9.8                              ; HBW OP: KNRBus
MW[452]=MI.10.8                             ; NHBW OP: KNRBus
MW[453]=MI.11.8                             ; HBSH OP: KNRBus
MW[454]=MI.12.8                             ; HBSR OP: KNRBus
MW[455]=MI.13.8                             ; HBO OP: KNRBus
MW[456]=MI.14.8                             ; NHBO OP: KNRBus
MW[457]=MI.15.8                             ; HBCU OP: KNRBus
MW[458]=MI.16.8                             ; HBSC OP: KNRBus
MW[459]=MW[451]+MW[452]+MW[453]+MW[454]+
        MW[455]+MW[456]+MW[457]+MW[458]     ; OP: KNRBus

MW[461]=MI.9.9                              ; HBW OP: KNRBus
MW[462]=MI.10.9                             ; NHBW OP: KNRBus
MW[463]=MI.11.9                             ; HBSH OP: KNRBus
MW[464]=MI.12.9                             ; HBSR OP: KNRBus
MW[465]=MI.13.9                             ; HBO OP: KNRBus
MW[466]=MI.14.9                             ; NHBO OP: KNRBus
MW[467]=MI.15.9                             ; HBCU OP: KNRBus
MW[468]=MI.16.9                             ; HBSC OP: KNRBus
MW[469]=MW[461]+MW[462]+MW[463]+MW[464]+
        MW[465]+MW[466]+MW[467]+MW[468]     ; OP: KNRBus               
    
   

; Total Transit
MW[370]=MW[319] + MW[329] + MW[339] + 
        MW[349] + MW[359] + MW[369]         ; PK: All Transit
MW[470]=MW[419] + MW[429] + MW[439] + 
        MW[449] + MW[459] + MW[469]         ; OP: All Transit




ENDRUN
