    
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\@purpose@_modechoice.prn"
FILEI MATI[14] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_PERTRIPS_{Alt}{year}.MAT"

        ;===================================================================================================================================
        ; XCHOICE - Standard Output (MC trips and final logsums)
        ;===================================================================================================================================
FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MC1.MAT",
            MO=701-719,DEC=19*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE,PNRLOC

       ; Logsums by auto sufficiency (averaged across all access markets)
FILEO MATO[2] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCLS_{Alt}{year}.MAT",
       MO=571,DEC=1*D,NAME=LSUM_M1 
    
        ; Exp(AutoUtility) for user benefits
FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_expautoutil.mat",
        MO=561,DEC=1*D,NAME=EXPA_M1 
       
FILEO MATO[4] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCLS_XCHOICE_{Alt}{year}.MAT",
         MO=528,DEC=1*D,NAME=LSUM_M1
            
        ; Zone and station data
FILEI ZDATI[1] = "{SCENARIO_DIR}\input\ZDATA_{Year}{alt}.DBF"
FILEI ZDATI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{Year}.DBF"
    
        ; Modechoice coefficients and alternative specific constants
FILEI LOOKUPI[1] = "{CATALOG_DIR}\PARAMETERS\@PERIOD@_MC_CONSTANTS.CSV"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\PARAMETERS\@PERIOD@_TRN_COEFFICIENTS.CSV"
    
        ; Transit skim (1: Walk to Skyway)
FILEI MATI[1] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_SKYWAY_WALK_{Alt}{year}.MAT"
    
        ; Transit skim (2: Walk to Local Bus)
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_LOCAL_WALK_{Alt}{year}.MAT"
    
        ; Transit skim (3: Walk to Express Bus)
FILEI MATI[3] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_EXPRESS_WALK_{Alt}{year}.MAT"
    
        ; Transit skim (4: Walk to BRT-LRT)
FILEI MATI[4] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_BRTLRT_WALK_{Alt}{year}.MAT"
    
        ; Transit skim (5: Walk to Commuter Rail)
FILEI MATI[5] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_COMRAIL_WALK_{Alt}{year}.MAT"
    
        ; Transit skim (6: PNR to Express Bus)
FILEI MATI[6] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_EXPRESS_PNR_{Alt}{year}.MAT"
    
        ; Transit skim (7: PNR to BRT-LRT Bus)
FILEI MATI[7] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_BRTLRT_PNR_{Alt}{year}.MAT"
    
        ; Transit skim (8: PNR to Commuter Rail)
FILEI MATI[8] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_COMRAIL_PNR_{Alt}{year}.MAT"
    
        ; Transit skim (9: KNR to Express Bus)
FILEI MATI[9] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_EXPRESS_KNR_{Alt}{year}.MAT"
    
        ; Transit skim (10: KNR to BRT-LRT Bus)
FILEI MATI[10] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_BRTLRT_KNR_{Alt}{year}.MAT"
    
        ; Transit skim (11: KNR to Commuter Rail)
FILEI MATI[11] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_COMRAIL_KNR_{Alt}{year}.MAT"
    
        ; Highway skim (All Drive)
FILEI MATI[12] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"
    
        ; Highway skim (Drive to Skyway) 
FILEI MATI[13] = "{SCENARIO_DIR}\output\@PERIOD@_DRV_SKYWAY.MAT"

        ; HOV time savings
        ; Table 1 - HOV time savings for peak period
        ; Table 2 - HOV time savings for off-peak period
    
        ; Person trips
    
        ; Progress Bar update for evey 100 zones
        zonemsg=100
    
        ; Declare arrays to hold alternative specific constants
        ARRAY PARK=2578
        ARRAY TYPE=F K_AUT=5, K_SR=5, K_SR3=5, K_TRN=5, K_TDRV=5, K_TKNR=5, K_NMOT=5, K_BIKE=5, K_TDRVE=5, K_Prem_TDRV = 5, K_Prem_TKNR = 5, K_TRN_CR = 5
        ARRAY TYPE=C30 MARKET_NAME=5
    
        ; Read alternative specific Constants
        LOOKUP, NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, , LIST=Y, LOOKUPI=1
    
        ; Read mode choice coefficients
        LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=2
    
        ; Read coefficients and constants
        IF (i=FirstZone)
          ; Index _m identifies the market segment, as follows:
          ; All HB purposes except shcool, university and NNHB
          ; -------------------------------------------------------
          ;    _m = 1      zero-car households
          ;    _m = 2      low income, car insufficient hhlds
          ;    _m = 3      high income, car sufficient hhlds
          ;    _m = 4      low income, car sufficient hhlds
          ;    _m = 5      high income, car sufficient hhlds
    
          ; Household market stratified constants
          LOOP _m=1,@MARKETS@    
            K_AUT[_m]  = CONSTANTS(1,(_m-1)*10+1)            ; drive to skyway
            K_SR[_m]   = CONSTANTS(1,(_m-1)*10+2)            ; shared-ride 2 & 3+
            K_SR3[_m]  = CONSTANTS(1,(_m-1)*10+3)            ; shared ride 3+
            K_TRN[_m]  = CONSTANTS(1,(_m-1)*10+4)            ; transit
            K_TDRV[_m] = CONSTANTS(1,(_m-1)*10+5)            ; drive to local
            K_TKNR[_m] = CONSTANTS(1,(_m-1)*10+6)            ; knr to transit
            K_NMOT[_m] = CONSTANTS(1,(_m-1)*10+7)            ; non-motorized (walk & bike)
            K_BIKE[_m] = CONSTANTS(1,(_m-1)*10+8)            ; bike
            K_TDRVE[_m] = CONSTANTS(1,(_m-1)*10+9)           ; pnr to express
            K_Prem_TDRV[_m] = CONSTANTS(1,60 + _m)           ; drive to premium mode (61 - 65)
            K_Prem_TKNR[_m] = CONSTANTS(1,65 + _m)           ; knr to premium mode (66 - 70)    
            K_TRN_CR[_m] = CONSTANTS(1,70 + _m)              ; addtl trn to premium mode (71 - 75)                  
          ENDLOOP
    
          ; MARKETS=@MARKETS@
          MARKET_NAME[1] = '@Mkt1_Name@'
          MARKET_NAME[2] = '@Mkt2_Name@'
          MARKET_NAME[3] = '@Mkt3_Name@'
          MARKET_NAME[4] = '@Mkt4_Name@'
          MARKET_NAME[5] = '@Mkt5_Name@'
    
          ; Mode-specific constants -- same for all hhld markets
          K_SKY = CONSTANTS(1,51)                  ; Skyway
          K_EXP = CONSTANTS(1,52)                  ; express bus
          K_BRT = CONSTANTS(1,53)                  ; brt
          K_URL = CONSTANTS(1,54)                  ; urban rail
          K_CRL = CONSTANTS(1,55)                  ; commuter rail
          K_INFDA = CONSTANTS(1,56)                ; informal KNR-to-Localbus
          K_BRT_LB = CONSTANTS(1,57)               ; BRT + Local bus constant
          K_CRL_LB = CONSTANTS(1,58)               ; CR + Local bus constant  
          
          ; Define array to hold cost coefficients
          ARRAY TYPE=F COEFF_COST=5
          COEFF_COST[1]  = COEFF(1,5)
          COEFF_COST[2]  = COEFF(1,6)
          COEFF_COST[3]  = COEFF(1,7)
          COEFF_COST[4]  = COEFF(1,8)
          COEFF_COST[5]  = COEFF(1,9)
          
          ; Level of Service Coefficients
          COEFF_IVTT   = COEFF(1,1)                ; In-vehicle travel time coefficient
          COEFF_SWAIT  = COEFF(1,2)                ; Short wait(<5 minutes)
          COEFF_LWAIT  = COEFF(1,3)                ; Long wait (>5 minutes)
          COEFF_XWAIT  = COEFF(1,4)                ; Xfer wait
          COEFF_DRIVE  = COEFF(1,10)               ; Drive access
          COEFF_TERML  = COEFF(1,11)               ; Terminal time
          COEFF_WALK   = COEFF(1,12)               ; Walk access
          COEFF_WALK1  = COEFF(1,13)               ; Walk time < 1
          COEFF_WALK2  = COEFF(1,14)               ; Walk time > 1
          COEFF_BIKE1  = COEFF(1,15)               ; Bike time < 1
          COEFF_BIKE2  = COEFF(1,16)               ; Bike time > 1
          DWalkBIKE    = COEFF(1,17)               ; Walk and Bike threshold
 
          ; Nesting coefficients
          NC_1         = COEFF(1,18)               ; Level 1 - auto, trn, non-mot
          NC_2         = COEFF(1,19)               ; Level 2 - transit access mode choice
          NC_3         = COEFF(1,20)               ; Level 3 - transit access mode choice
          ; NCP = NC_1 * NC_2                      ; Product of nesting coefficients

          ; Calibration specific
          COEFF_CBD     = COEFF(1,21)              ; CBD dummy
          COEFF_NXFER   = COEFF(1,22)              ; number of xfers 
                    
        ENDIF
    
        ; Highway skims
        FILLMW MW[1]=MI.12.1,2,3,4,5,6,7,8 ;,9     ; highway skims
        FILLMW MW[241]=MI.13.1,2,3,4,5,6,7,8,9     ; drive to skyway best path
       ; FILLMW MW[11]=MI.14.HOVsave@PERIOD@        ; HOVsavePK for peak period and HOVsaveOP for off-peak period
       ; FILLMW MW[291]=MI.18.@STATION_TABLE@       ; 8 tables - PKStationTAZ_pnrb,PKParkCost_pnrb,termtimpnr,termtimknr,OPStationTAZ_pnrb,OPParkCost_pnrb,termtimpnr,termtimknr
    
        ; Transit (walk) skims
        FILLMW MW[21]=MI.1.1(15)                   ; walk to skyway
        FILLMW MW[41]=MI.2.1(15)                   ; walk to loc bus
        FILLMW MW[61]=MI.3.1(15)                   ; walk to exp bus
        FILLMW MW[81]=MI.4.1(15)                   ; walk to brt lrt
        FILLMW MW[101]=MI.5.1(15)                  ; walk to com rail
    
        ; Transit (PNR) skims
        FILLMW MW[121]=MI.6.1(15)                  ; pnr to exp bus
        FILLMW MW[141]=MI.7.1(15)                  ; pnr to brt lrt
        FILLMW MW[161]=MI.8.1(15)                  ; pnr to com rail
    
        ; Transit (KNR) skims
        FILLMW MW[181]=MI.9.1(15)                  ; knr to exp bus
        FILLMW MW[201]=MI.10.1(15)                 ; knr to brt lrt
        FILLMW MW[221]=MI.11.1(15)                 ; knr to com rail
    
        ; Walk and Bike
        ; distance portion that is 1 mile or less
        MW[12] = MIN(MW[2],1)
    
       JLOOP
            ; Distance portion that is longer than 1 mile
        JLOOP
            IF (MW[2][J] > 1)
                MW[13] = MW[2][J] - 1
            ELSE
                MW[13] = 0
            ENDIF

            ; CR unicluded attributes Walk
            IF(MW[108] >0) 
              ; if other modes ivtt exists
              IF((MW[105] + MW[106] +MW[107]) = 0)
                MW[901] = K_CRL
              ENDIF
              IF ((MW[105] + MW[106] +MW[107]) > 0)
                MW[901] = K_CRL_LB
              ENDIF
            ELSE
                MW[901] = 0
            ENDIF       
              
            ; CR unicluded attributes PNR
            IF(MW[168] >0) 
              ; if other modes ivtt exists
              IF((MW[165] + MW[166] +MW[167]) = 0)
                MW[902] = K_CRL
              ENDIF
              IF ((MW[165] + MW[166] +MW[167]) > 0)
                MW[902] = K_CRL_LB
              ENDIF
            ELSE
                MW[902] = 0
            ENDIF
            
            ; CR unicluded attributes KNR
            IF(MW[228] >0) 
              ; if other modes ivtt exists
              IF((MW[225] + MW[226] +MW[227]) = 0)
                MW[903] = K_CRL
              ENDIF
              IF ((MW[225] + MW[226] +MW[227]) > 0)
                MW[903] = K_CRL_LB
              ENDIF
            ELSE
                MW[903] = 0
            ENDIF
            
            ; BRT unicluded attributes Walk
            IF(MW[88] >0) 
              ; if other modes ivtt exists
              IF((MW[85] + MW[86] +MW[87]) = 0)
                MW[904] = K_CRL
              ENDIF
              IF ((MW[85] + MW[86] +MW[87]) > 0)
                MW[904] = K_CRL_LB
              ENDIF
            ELSE
                MW[904] = 0
            ENDIF 
            
            ; BRT/LRT unicluded attributes PNR
            IF(MW[148] >0) 
              ; if other modes ivtt exists
              IF((MW[145] + MW[146] +MW[147]) = 0)
                MW[905] = K_BRT
              ENDIF
              IF ((MW[145] + MW[146] +MW[147]) > 0)
                MW[905] = K_BRT_LB
              ENDIF
            ELSE
                MW[905] = 0
            ENDIF   
                     
            ; BRT unicluded attributes KNR
            IF(MW[208] >0) 
              ; if other modes ivtt exists
              IF((MW[205] + MW[206] +MW[207]) = 0)
                MW[906] = K_BRT
              ENDIF
              IF ((MW[205] + MW[206] +MW[207]) > 0)
                MW[906] = K_BRT_LB
              ENDIF
            ELSE
                MW[906] = 0
            ENDIF
                  
            ; Drive access ratio to CR
            MW[10] = MI.8.pnr_cr_dist / MI.12.Distance
            MW[11] = MI.11.knr_cr_dist / MI.12.Distance
            
        ENDJLOOP
               
        ; Person trips
        MW[251] = MI.14.6   ; Total Person Trips
    
        ;  Write out coefficients for debug and regular runs
        IF (I=1)  ; Write mode choice summary file                                                                                                
          ; DEBUG MODE CHOICE                                                                                                                   
          ;IF ({DebugMC}>0) 
             ; split this into two sections (1) DEBUG and (2) Regular 
            ; READ FILE = "WriteReport.S"
         ; ENDIF
        ENDIF
        
        ; ************************** PROCESS PERSON TRIPS INTO MARKETS ************************************       
        MW[252]= MI.14.1    ; Zero car HHs                     
        MW[253]= MI.14.2    ; Auto Insufficient Low Income HHs 
        MW[254]= MI.14.3    ; Auto Insufficient High Income HHs
        MW[255]= MI.14.4    ; Auto Sufficient Low Income HHs   
        MW[256]= MI.14.5    ; Auto Sufficient High Income HHs     

        ; Overwrite the above if there is only one market
        IF (@MARKETS@=1)
           MW[252]=MW[251]
           MW[253]=0
           MW[254]=0
           MW[255]=0
           MW[256]=0
        ENDIF
    
        ; Zero car transit sub-markets (can walk, must drive and no access)
        MW[261] = MW[252] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
        MW[262] = MW[252] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
        MW[263] = MW[252] - MW[261] - MW[262]                                                                 ; No Access
    
        ; Auto Insufficient Low Income transit sub-markets (can walk, must drive and no access)
        MW[264] = MW[253] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
        MW[265] = MW[253] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
        MW[266] = MW[253] - MW[264] - MW[265]                                                                 ; No Access
    
        ; Auto Insufficient Low Income transit sub-markets (can walk, must drive and no access)
        MW[267] = MW[254] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
        MW[268] = MW[254] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
        MW[269] = MW[254] - MW[267] - MW[268]                                                                 ; No Access
    
        ; Auto Sufficient Low Income transit sub-markets (can walk, must drive and no access)
        MW[270] = MW[255] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
        MW[271] = MW[255] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
        MW[272] = MW[255] - MW[270] - MW[271]                                                                 ; No Access
    
        ; Auto Sufficient Low Income transit sub-markets (can walk, must drive and no access)
        MW[273] = MW[256] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
        MW[274] = MW[256] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
        MW[275] = MW[256] - MW[273] - MW[274]                                                                 ; No Access

    
        ; *******************************************  WALK ACCESS MARKETS  ************************************************
        ; ******************************************************************************************************************
    
        ; Loop by access modes
        LOOP ACC=1,3
        
            ;**********************  ADD HOUSEHOLD MARKET SPECIFIC TERMS **********************************
            LOOP _m=1,@MARKETS@
              
               ; Drive alone
               MW[301+20*(_m-1)] = (COEFF_TERML    * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +           ; Terminal time
                                    COEFF_IVTT     * MW[4]             +                               ; IVTT
                                    COEFF_CBD      * ZI.1.CBD_DUMMY[J] +                               ; CBD dummy
                                    COEFF_COST[_m] * MW[1]             +                               ; Toll
                                    COEFF_COST[_m] * ZI.1.@PRK@[J]     +                               ; Auto parking cost
                                    COEFF_COST[_m] *  MW[2] * 9.5)                                     ; Auto operating cost
               MW[401+20*(_m-1)] = MW[301+20*(_m-1)] / NC_1 /NC_2                                      ; Scaled Utility
              
               ; Shared Ride 2-person
               MW[302+20*(_m-1)] = (K_SR[_m]       +                                                   ; Constant(s)
                                    COEFF_TERML * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +              ; Terminal time
                                    COEFF_IVTT  * MW[8]             -                                  ; IVTT
                                  ;  COEFF_IVTT  * (MAX (MW[11], 0)) +                                  ; HOV time savings
                                    COEFF_CBD   * ZI.1.CBD_DUMMY[J] +                                  ; CBD dummy               
                                    COEFF_COST[_m] * (MW[5]/ 2 )    +                                  ; Toll
                                    COEFF_COST[_m] * MW[2] * 9.5)                                      ; Auto operating cost
               MW[402+20*(_m-1)] =  MW[302+20*(_m-1)] / NC_1 / NC_2 / NC_3                             ; Scaled Utility
               
               ; Shared Ride 3+ person
               MW[303+20*(_m-1)] = (K_SR[_m] + K_SR3[_m] +                                             ; Constant(s)
                                    COEFF_TERML * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +              ; Terminal time 
                                    COEFF_IVTT  * MW[8]             -                                  ; IVTT
                                  ;  COEFF_IVTT  * (MAX (MW[11], 0)) +                                  ; HOV time savings
                                    COEFF_CBD   * ZI.1.CBD_DUMMY[J] +                                  ; CBD dummy               
                                    COEFF_COST[_m] * (MW[5]/@OCC3@) +                                  ; Toll
                                    COEFF_COST[_m] * MW[2] * 9.5)                                      ; Auto operating cost
               MW[403+20*(_m-1)] =  MW[303+20*(_m-1)] / NC_1 / NC_2 / NC_3                             ; Scaled Utility
                                                     
               ; Drive to Skyway
               MW[304+20*(_m-1)] = (K_AUT[_m]                                  +                       ; Constant(s)
                                   ; COEFF_DRIVE    *  MW[243]                  +                      ; Drive Access Time
                                    COEFF_WALK     *  MW[244]                  +                       ; Walk Access Time to skyway (PNR lot to skyway & walk egress)
                                    COEFF_SWAIT    *  MIN(MW[247],5)           +                       ; Short wait (< 5 mins)
                                    COEFF_LWAIT    * (MW[247] - MIN(MW[247],5))+                       ; Long wait (> 5 mins)
                                    COEFF_XWAIT    *  MW[248]                  +                       ; Xfer Wait
                                    COEFF_IVTT     * (MW[243] + MW[245])       +                       ; IVTT (hwy time + skyway time)
                                    COEFF_COST[_m] *  MW[249]                  +                       ; Transit Fare
                                    COEFF_COST[_m] *  MW[241]                  +                       ; Toll
                                    COEFF_COST[_m] *  MW[242] * 9.5            +                       ; Auto operating cost
                                    COEFF_NXFER    *  MW[246]                  +                       ; Num Xfers Dummy
                                    COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                               ; CBD dummy
               MW[404+20*(_m-1)] = MW[304+20*(_m-1)] /NC_1 /NC_2                                       ; Scaled Utility

               ; Walk to Skyway
               MW[305+20*(_m-1)] = (K_TRN[_m]      +  K_SKY                    +                       ; Constant(s)
                                    COEFF_DRIVE    *  MW[22]                   +                       ; Drive Access Time (zero for walk but to keep the code consistent)
                                    COEFF_WALK     * (MW[21] + MW[23])         +                       ; Walk Access Time + Xfer Time   
                                    COEFF_SWAIT    *  MIN(MW[32],5)            +                       ; Short wait (< 5 mins)
                                    COEFF_LWAIT    * (MW[32] - MIN(MW[32],5))  +                       ; Long wait (> 5 mins)
                                    COEFF_XWAIT    *  MW[33]                   +                       ; Xfer Wait
                                    COEFF_IVTT     *  MW[24]                   +                       ; IVTT (skyway time)
                                    COEFF_COST[_m] *  MW[34]                   +                       ; Transit Fare
                                    COEFF_NXFER    *  MW[31]                   +                       ; Num Xfers Dummy
                                    COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                               ; CBD dummy
               MW[405+20*(_m-1)] = MW[305+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; Walk to Local Bus
               MW[306+20*(_m-1)] = (K_TRN[_m]                                   +                      ; Transit Constant
                                    COEFF_DRIVE    *  MW[42]                    +                      ; Drive Access Time (zero for walk but to keep the code consistent)
                                    COEFF_WALK     * (MW[41] + MW[43])          +                      ; Walk Access Time + Xfer Time
                                    COEFF_SWAIT    *  MIN(MW[52],5)             +                      ; Short wait (< 5 mins)
                                    COEFF_LWAIT    * (MW[52] - MIN(MW[52],5))   +                      ; Long wait (> 5 mins)
                                    COEFF_XWAIT    *  MW[53]                    +                      ; Xfer Wait
                                    COEFF_IVTT     * (MW[44] + MW[45])          +                      ; IVTT (skyway + local bus time)
                                    COEFF_COST[_m] *  MW[54]                    +                      ; Transit Fare
                                    COEFF_NXFER    *  MW[51]                    +                      ; Num Xfers Dummy
                                    COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                               ; CBD dummy
               MW[406+20*(_m-1)] = MW[306+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
    
               ; Walk to Express Bus
               MW[307+20*(_m-1)] = (K_TRN[_m] + K_EXP  +                                               ; Constant(s)
                                    COEFF_DRIVE    *  MW[62]                    +                      ; Drive Access Time (zero for walk but to keep the code consistent)
                                    COEFF_WALK     * (MW[61] + MW[63])          +                      ; Walk Access Time + Xfer Time
                                    COEFF_SWAIT    *  MIN(MW[72],5)             +                      ; Short wait (< 5 mins)
                                    COEFF_LWAIT    * (MW[72] - MIN(MW[72],5))   +                      ; Long wait (> 5 mins)
                                    COEFF_XWAIT    *  MW[73]                    +                      ; Xfer Wait
                                    COEFF_IVTT     * (MW[64] + MW[65] + MW[66]) +                      ; IVTT (skyway + local + express bus time)
                                    COEFF_COST[_m] *  MW[74]                    +                      ; Transit Fare
                                    COEFF_NXFER    *  MW[71]                    +                      ; Num Xfers Dummy
                                    COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                               ; CBD dummy
               MW[407+20*(_m-1)] = MW[307+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
    
               ; Walk to BRT-LRT
               MW[308+20*(_m-1)] = (K_TRN[_m]                                   +                      ; Constant(s)
                                    MW[904]                                      +                     ; BRT Unincluded constants for walk access
                                    COEFF_DRIVE    *  (MW[82]+MW[96])           +                      ; Drive Access Time (zero for walk but to keep the code consistent)
                                    COEFF_WALK     * (MW[81] + MW[83] + MW[89] +MW[95])          +     ; Walk Access Time + Xfer Time
                                    COEFF_SWAIT    *  MIN(MW[92],5)             +                      ; Short wait (< 5 mins)
                                    COEFF_LWAIT    * (MW[92] - MIN(MW[92],5))   +                      ; Long wait (> 5 mins)
                                    COEFF_XWAIT    *  MW[93]                    +                      ; Xfer Wait
                                    COEFF_IVTT     * (MW[84]+MW[85]+MW[86]+MW[87]) +                   ; IVTT (skyway + local + express + BRT time)
                                    COEFF_COST[_m] *  MW[94]                    +                      ; Transit Fare
                                    COEFF_NXFER    *  MW[91]                    +                      ; Num Xfers Dummy
                                    COEFF_CBD      *  ZI.1.CBD_DUMMY[J] )                              ; CBD dummy
               MW[408+20*(_m-1)] = MW[308+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; Walk to Commuter Rail
               MW[309+20*(_m-1)] = (K_TRN[_m] + K_TRN_CR[_m]                     +                     ; Constant(s)
                                    MW[901]                                      +                     ; CR Unincluded constants for walk access
                                    COEFF_DRIVE    *  (MW[102]+MW[119])          +                     ; Drive Access Time (zero for walk but to keep the code consistent)
                                    COEFF_WALK     *  (MW[101] + MW[103]+MW[109]+MW[110]+MW[118])+     ; Walk Access Time + Xfer Time
                                    COEFF_SWAIT    *  MIN(MW[112],5)             +                     ; Short wait (< 5 mins)
                                    COEFF_LWAIT    * (MW[112] - MIN(MW[92],5))   +                     ; Long wait (> 5 mins)
                                    COEFF_XWAIT    *  MW[113]                    +                     ; Xfer Wait
                                    COEFF_IVTT     *  (MW[104] + MW[105] + MW[106]+ MW[107]+MW[108])+  ; IVTT (skyway + local + express + BRT + CRL time)
                                    COEFF_COST[_m] *  MW[114]                    +                     ; Transit Fare
                                    COEFF_NXFER    *  MW[111]                    +                     ; Num Xfers Dummy
                                    COEFF_CBD      *  ZI.1.CBD_DUMMY[J] )                              ; CBD dummy
               MW[409+20*(_m-1)] = MW[309+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; PNR to Local Bus (Walk skim with drive time)
               MW[319+20*(_m-1)] = (K_TRN[_m] + K_TDRV[_m]                        +                    ; Constant(s)
                                   COEFF_DRIVE    * (MW[41]/2/10)                 +                    ; Drive Access Time (Drive time = Walk access time/10; assuming drive speed of 30 MPH & 50%-50% access-egress split)
                                   COEFF_WALK     * (MW[43] + MW[41]/2)           +                    ; Xfer Time (here we don't have walk egress time, so assume a 50%-50% access-egress split)
                                   COEFF_SWAIT    *  MIN(MW[52],5)                +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[52] - MIN(MW[52],5))      +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[53]                       +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[44] + MW[45])             +                    ; IVTT (skyway + local bus time)
                                   COEFF_COST[_m] *  MW[54]                       +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[51]                       +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[419+20*(_m-1)] = MW[319+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
        
               ; PNR to Express Bus
               MW[310+20*(_m-1)] = (K_TRN[_m] + K_TDRVE[_m] + K_EXP               +                    ; Constant(s)
                                   COEFF_DRIVE    *  MW[122]                      +                    ; Drive Access Time 
                                   COEFF_WALK     * (MW[121] + MW[123])           +                    ; Walk Access Time + Xfer Time
                                   COEFF_SWAIT    *  MIN(MW[132],5)               +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[132] - MIN(MW[132],5))    +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[133]                      +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[124] + MW[125] + MW[126]) +                    ; IVTT (skyway + local + express bus time)
                                   COEFF_COST[_m] *  MW[134]                      +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[131]                      +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[410+20*(_m-1)] = MW[310+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; PNR to BRT-LRT Bus
               MW[311+20*(_m-1)] = (K_TRN[_m] + K_Prem_TDRV[_m]                   +                    ; Constant(s)
                                   MW[905]                                        +                    ; BRT Unincluded constants for PNR access
                                   COEFF_DRIVE    *  (MW[142]+MW[156])            +                    ; Drive Access Time 
                                   COEFF_WALK     * (MW[141] + MW[143] +MW[149]+MW[155])  +            ; Walk Access Time + Xfer Time
                                   COEFF_SWAIT    *  MIN(MW[152],5)               +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[152] - MIN(MW[152],5))    +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[153]                      +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[144]+MW[145]+MW[146]+MW[147]) +                ; IVTT (skyway + local + express + BRT time)
                                   COEFF_COST[_m] *  MW[154]                      +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[151]                      +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[411+20*(_m-1)] = MW[311+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; PNR to Commuter Rail
               MW[312+20*(_m-1)] = (K_TRN[_m] + K_Prem_TDRV[_m]  + K_TRN_CR[_m]   +                    ; Constant(s)
                                   -3.0 * MAX((MW[10]-0.5),0)                     +                    ; Drive access ratio
                                   MW[902]                                        +                    ; CR Unincluded constants for PNR access
                                   COEFF_DRIVE    *  (MW[162]+MW[176]+MW[179])    +                    ; Drive Access Time 
                                   COEFF_WALK     * (MW[161] + MW[163] + MW[169] +MW[170]) +           ; Walk Access Time + Xfer Time
                                   COEFF_SWAIT    *  MIN(MW[172],5)               +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[172] - MIN(MW[172],5))    +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[173]                      +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[164] + MW[165] + MW[166] + MW[167] +MW[168])+  ; IVTT (skyway + local + express + BRT + CRL time)
                                   COEFF_COST[_m] *  MW[174]                      +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[171]                      +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[412+20*(_m-1)] = MW[312+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; KNR to Local Bus
               MW[313+20*(_m-1)] = (K_TRN[_m]     + K_TKNR[_m]   + K_INFDA        +                    ; Constant(s)
                                   COEFF_DRIVE    * (MW[41]/10)                   +                    ; Drive Access Time (Drive time = Walk time/10; assuming drive speed of 30 MPH)
                                   COEFF_WALK     * (MW[43] + 3)                  +                    ; Xfer Time (here we don't have walk egress time, so assume 3 minutes)
                                   COEFF_SWAIT    *  MIN(MW[52],5)                +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[52] - MIN(MW[52],5))      +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[53]                       +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[44] + MW[45])             +                    ; IVTT (skyway + local bus time)
                                   COEFF_COST[_m] *  MW[54]                       +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[51]                       +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[413+20*(_m-1)] = MW[313+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
    
               ; KNR to Express Bus
               MW[314+20*(_m-1)] = (K_TRN[_m] + K_TKNR[_m] + K_EXP                +                    ; Constant(s)
                                   COEFF_DRIVE    *  MW[182]                      +                    ; Drive Access Time 
                                   COEFF_WALK     * (MW[181] + MW[183])           +                    ; Walk Access Time + Xfer Time
                                   COEFF_SWAIT    *  MIN(MW[192],5)               +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[192] - MIN(MW[192],5))    +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[193]                      +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[184] + MW[185] + MW[186]) +                    ; IVTT (skyway + local + express bus time)
                                   COEFF_COST[_m] *  MW[194]                      +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[191]                      +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[414+20*(_m-1)] = MW[314+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; KNR to BRT-LRT Bus
               MW[315+20*(_m-1)] = (K_TRN[_m] + K_Prem_TKNR[_m]                   +                    ; Constant(s)
                                   MW[906]                                        +                    ; BRT Unincluded constants for KNR access
                                   COEFF_DRIVE    * (MW[202]+MW[217])             +                    ; Drive Access Time 
                                   COEFF_WALK     * (MW[201] + MW[203] +MW[209]+ MW[215])  +           ; Walk Access Time + Xfer Time
                                   COEFF_SWAIT    *  MIN(MW[212],5)               +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[212] - MIN(MW[212],5))    +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[213]                      +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[204]+MW[205]+MW[206]+MW[207]) +                ; IVTT (skyway + local + express + BRT time)
                                   COEFF_COST[_m] *  MW[214]                      +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[211]                      +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[415+20*(_m-1)] = MW[315+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
               
               ; KNR to Commuter Rail
               MW[316+20*(_m-1)] = (K_TRN[_m] + K_Prem_TKNR[_m] + K_TRN_CR[_m]    +                    ; Constant(s)
                                   MW[903]                                        +                    ; CR Unincluded constants for KNR access
                                   -3.0 * MAX((MW[11]-0.5),0)                     +                    ; Drive access ratio
                                   COEFF_DRIVE    * (MW[222]+ MW[240])            +                    ; Drive Access Time 
                                   COEFF_WALK     * (MW[221] + MW[223] + MW[229] +MW[230]) +           ; Walk Access Time + Xfer Time
                                   COEFF_SWAIT    *  MIN(MW[232],5)               +                    ; Short wait (< 5 mins)
                                   COEFF_LWAIT    * (MW[232] - MIN(MW[232],5))    +                    ; Long wait (> 5 mins)
                                   COEFF_XWAIT    *  MW[233]                      +                    ; Xfer Wait
                                   COEFF_IVTT     * (MW[224] + MW[225] + MW[226]  +MW[227] +MW[228])+  ; IVTT (skyway + local + express + BRT + CRL time)
                                   COEFF_COST[_m] *  MW[234]                      +                    ; Transit Fare
                                   COEFF_NXFER    *  MW[231]                      +                    ; Num Xfers Dummy
                                   COEFF_CBD      *  ZI.1.CBD_DUMMY[J])                                ; CBD dummy
               MW[416+20*(_m-1)] = MW[316+20*(_m-1)] /NC_1 /NC_2 /NC_3                                 ; Scaled Utility
                          
               ; Walk
               MW[317+20*(_m-1)] = (K_NMOT[_m]                                    +                    ; Constant(s)
                                   COEFF_WALK1  * MW[12]                          +                    ; Walk time if less than 1 mile
                                   COEFF_WALK2  * MW[13])                                              ; Walk time if more than 1 mile
               MW[417+20*(_m-1)] = MW[317+20*(_m-1)] / NC_1 /NC_2                                      ; Scaled Utility
                      
               ; Bike
               MW[318+20*(_m-1)] = (K_NMOT[_m] + K_BIKE[_m]                       +                    ; Constant(s)
                                   COEFF_BIKE1  * MW[12]                          +                    ; Bike time if less than 1 mile
                                   COEFF_BIKE2  * MW[13])                                              ; Bike time if more than 1 mile
               MW[418+20*(_m-1)] = MW[318+20*(_m-1)] / NC_1 /NC_2                                      ; Scaled Utility

            
            ENDLOOP
    
            ;***************************    MODE AVAILABILITY CHECKS    ************************************
            ;  Drive alone and PNR to transit not available to zero car households
            IF (@Mkt1_0car@=1)
              MW[401] = -9999.99  ; Drive alone
              MW[404] = -9999.99  ; Drive to Skyway
              MW[410] = -9999.99  ; PNR to Express
              MW[411] = -9999.99  ; PNR to BRT
              MW[412] = -9999.99  ; PNR to Com Rail
              MW[419] = -9999.99  ; PNR to Local
            ENDIF
    
            LOOP _m=1,@MARKETS@
              JLOOP
                 ; Transit not available if no line-haul in-vehicle time on the transit path
                 ; Drive to skyway 
                 IF (MW[245] == 0)  MW[404+20*(_m-1)]=-9999.99
                 
                 ; Walk to skyway
                 IF (MW[24] == 0)  MW[405+20*(_m-1)]=-9999.99
    
                 ; Walk to local bus
                 IF (MW[45] == 0)  MW[406+20*(_m-1)]=-9999.99
    
                 ; Walk to express bus
                 IF (MW[66] == 0)  MW[407+20*(_m-1)]=-9999.99
    
                 ; Walk to BRT-LRT bus
                 IF (MW[87] == 0)  MW[408+20*(_m-1)]=-9999.99
    
                 ; Walk to Commuter Rail
                 IF (MW[108] == 0)  MW[409+20*(_m-1)]=-9999.99
                 
                 ; KNR to local bus
                 IF (MW[45] == 0)  MW[419+20*(_m-1)]=-9999.99
                 
                 ; PNR to express bus
                 IF (MW[126] == 0)  MW[410+20*(_m-1)]=-9999.99
    
                 ; PNR to BRT-LRT
                 IF (MW[147] == 0)  MW[411+20*(_m-1)]=-9999.99
    
                 ; PNR to Commuter rail
                 IF (MW[168] == 0) MW[412+20*(_m-1)]=-9999.99
    
                 ; KNR to local bus
                 IF (MW[45] == 0)  MW[413+20*(_m-1)]=-9999.99
    
                 ; KNR to express bus
                 IF (MW[186] == 0)  MW[414+20*(_m-1)]=-9999.99
    
                 ; KNR to BRT-LRT
                 IF (MW[207] == 0)  MW[415+20*(_m-1)]=-9999.99
    
                 ; KNR to Commuter rail
                 IF (MW[228] == 0) MW[416+20*(_m-1)]=-9999.99
                 
                 /*
                 ; If walk access distance less than minimum, no walk access to transit
                 ;IF (MW[2] < 0.6)
                 ;   MW[405+20*(_m-1)]=-9999.99
                 ;   MW[406+20*(_m-1)]=-9999.99
                 ;   MW[407+20*(_m-1)]=-9999.99
                 ;   MW[408+20*(_m-1)]=-9999.99
                 ;   MW[409+20*(_m-1)]=-9999.99
                 ;ENDIF
                 ;
                 ;; If drive access distance less than minimum, no drive access to transit
                 ;IF (MW[2] < 1.2)
                 ;   MW[410+20*(_m-1)]=-9999.99
                 ;   MW[411+20*(_m-1)]=-9999.99
                 ;   MW[412+20*(_m-1)]=-9999.99
                 ;   MW[419+20*(_m-1)]=-9999.99
                 ;ENDIF
                 */
                 
                 ; Walk to transit not available for the MD or NT access markets;
                 IF(ACC==2 || ACC==3)
                    MW[405+20*(_m-1)]=-9999.99
                    MW[406+20*(_m-1)]=-9999.99
                    MW[407+20*(_m-1)]=-9999.99
                    MW[408+20*(_m-1)]=-9999.99
                    MW[409+20*(_m-1)]=-9999.99
                 ENDIF
    
                 ; Transit not available for NT access markets;
                 IF(ACC==3)
                   MW[404+20*(_m-1)]=-9999.99
                   MW[410+20*(_m-1)]=-9999.99
                   MW[411+20*(_m-1)]=-9999.99
                   MW[412+20*(_m-1)]=-9999.99
                   MW[413+20*(_m-1)]=-9999.99
                   MW[414+20*(_m-1)]=-9999.99
                   MW[415+20*(_m-1)]=-9999.99
                   MW[416+20*(_m-1)]=-9999.99
                   MW[419+20*(_m-1)]=-9999.99
                 ENDIF
                 
              ENDJLOOP
           ENDLOOP    ; end market segment loop to set mode availability
           /*
           ; Write out the utilities
           JLOOP                                                                                                                                         
             if (ACC=1-3)                                                                                                                                  
               IF (ACC==1) then                                                                                                                            
                  ACC_NAME='CAN WALK TO TRANSIT'                                                                                                           
               ELSEIF (ACC==2)                                                                                                                             
                  ACC_NAME='MUST DRIVE TO TRANSIT'                                                                                                         
               ELSEIF (ACC==3)                                                                                                                             
                  ACC_NAME='NO TRANSIT'                                                                                                                    
               ENDIF                                                                                                                                       
                                                                                                                                                           
              ; IF (({DebugMC} > 0) && (I=501) && (J=690))   
              IF ((I=501) && (J=690))   
                  READ FILE = "WriteCompositeUtility.S"
              ENDIF
            ENDIF  
          ENDJLOOP 
          */
           ; ############################# XCHOICE SETUP ###################################
           ; Use DEMAND=1 to generate probabilities.
           ; 0-Car Households
                 _DMD=260+ACC
                 XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,pnrloc,
                 UTILITIESMW=401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,
                 DEMANDMW=_DMD,
                 ODEMANDMW=601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,
                 STARTMW=900,
           ;     Model Structure
           ;     Top level nest
                 SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
                 SPLITCOMP=528,
                 ;SPLITCOMP=521,
           ;     Auto nest
                 SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
                 SPLITCOMP=525,
                 ;SPLITCOMP=541,
           ;     Shared-ride nest
                 SPLIT = sr NC_3 sr2 NC_3 sr3,
                 SPLITCOMP=521,
           ;     Transit nest
                 SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
                 SPLITCOMP=526,
           ;     Walk to Transit nest
                 SPLIT = wlktrn NC_3 walksky NC_3 walkloc NC_3 walkexp NC_3 walkbrt NC_3 walkcom,
                 SPLITCOMP=522,
           ;     PNR to Transit nest
                 SPLIT = pnrtrn  NC_3 pnrloc NC_3 pnrexp NC_3 pnrbrt NC_3 pnrcom,
                 SPLITCOMP=523,
           ;     KNR to Transit nest
                 SPLIT = knrtrn NC_3 knrloc NC_3 knrexp NC_3 knrbrt NC_3 knrcom,
                 SPLITCOMP=524,
           ;     Non-Motorized nest
                 SPLIT= nonmot NC_2 walk NC_2 bike,
                 SPLITCOMP=527
    
           IF(@MARKETS@==1) GOTO next
           ; Car-insufficient, Low Income Households
                 _DMD=263+ACC
                 XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,pnrloc,
                 UTILITIESMW=421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,
                 DEMANDMW=_DMD,
                 ODEMANDMW=621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,639,
                 STARTMW=920,
           ;     Model Structure
           ;     Top level nest
                 SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
                 SPLITCOMP=536,
                 ;SPLITCOMP=522,
           ;     Auto nest
                 SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
                 SPLITCOMP=533,
                 ;SPLITCOMP=542,
           ;     Shared-ride nest
                 SPLIT = sr NC_3 sr2 NC_3 sr3,
                 SPLITCOMP=529,
           ;     Transit nest
                 SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
                 SPLITCOMP=534,
           ;     Walk to Transit nest
                 SPLIT = wlktrn NC_3 walksky NC_3 walkloc NC_3 walkexp NC_3 walkbrt NC_3 walkcom,
                 SPLITCOMP=530,
           ;     PNR to Transit nest
                 SPLIT = pnrtrn  NC_3 pnrloc NC_3 pnrexp NC_3 pnrbrt NC_3 pnrcom,
                 SPLITCOMP=531,
           ;     KNR to Transit nest
                 SPLIT = knrtrn NC_3 knrloc NC_3 knrexp NC_3 knrbrt NC_3 knrcom,
                 SPLITCOMP=532,
           ;     Non-Motorized nest
                 SPLIT= nonmot NC_2 walk NC_2 bike,
                 SPLITCOMP=535

           ; Car-insufficient, High Income Households
                 _DMD=266+ACC
                 XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,pnrloc,
                 UTILITIESMW=441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,
                 DEMANDMW=_DMD,
                 ODEMANDMW=641,642,643,644,645,646,647,648,649,650,651, 652,653,654,655,656,657,658,659,
                 STARTMW=940,
           ;     Model Structure
           ;     Top level nest
                 SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
                 SPLITCOMP=544,
                 ;SPLITCOMP=523,
           ;     Auto nest
                 SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
                 SPLITCOMP=541,
                 ;SPLITCOMP=543,
           ;     Shared-ride nest
                 SPLIT = sr NC_3 sr2 NC_3 sr3,
                 SPLITCOMP=537,
           ;     Transit nest
                 SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
                 SPLITCOMP=542,
           ;     Walk to Transit nest
                 SPLIT = wlktrn NC_3 walksky NC_3 walkloc NC_3 walkexp NC_3 walkbrt NC_3 walkcom,
                 SPLITCOMP=538,
           ;     PNR to Transit nest
                 SPLIT = pnrtrn  NC_3 pnrloc NC_3 pnrexp NC_3 pnrbrt NC_3 pnrcom,
                 SPLITCOMP=539,
           ;     KNR to Transit nest
                 SPLIT = knrtrn NC_3 knrloc NC_3 knrexp NC_3 knrbrt NC_3 knrcom,
                 SPLITCOMP=540,
           ;     Non-Motorized nest
                 SPLIT= nonmot NC_2 walk NC_2 bike,
                 SPLITCOMP=543
    
           ; Car-sufficient, Low Income Households
                 _DMD=269+ACC
                 XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,pnrloc,
                 UTILITIESMW=461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,
                 DEMANDMW=_DMD,
                 ODEMANDMW=661,662,663,664,665,666,667,668,668,670,671,672,673,674,675,676,677,678,679,
                 STARTMW=960,
           ;     Model Structure
           ;     Top level nest
                 SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
                 SPLITCOMP=552,
                 ;SPLITCOMP=524,
           ;     Auto nest
                 SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
                 SPLITCOMP=549,
                 ;SPLITCOMP=544,
           ;     Shared-ride nest
                 SPLIT = sr NC_3 sr2 NC_3 sr3,
                 SPLITCOMP=545,
           ;     Transit nest
                 SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
                 SPLITCOMP=550,
           ;     Walk to Transit nest
                 SPLIT = wlktrn NC_3 walksky NC_3 walkloc NC_3 walkexp NC_3 walkbrt NC_3 walkcom,
                 SPLITCOMP=546,
           ;     PNR to Transit nest
                 SPLIT = pnrtrn  NC_3 pnrloc NC_3 pnrexp NC_3 pnrbrt NC_3 pnrcom,
                 SPLITCOMP=547,
           ;     KNR to Transit nest
                 SPLIT = knrtrn NC_3 knrloc NC_3 knrexp NC_3 knrbrt NC_3 knrcom,
                 SPLITCOMP=548,
           ;     Non-Motorized nest
                 SPLIT= nonmot NC_2 walk NC_2 bike,
                 SPLITCOMP=551
    
           ; Car-sufficient, High Income Households
                 _DMD=272+ACC
                 XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,pnrloc,
                 UTILITIESMW=481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,
                 DEMANDMW=_DMD,
                 ODEMANDMW=681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,699,
                 STARTMW=980,
           ;     Model Structure
           ;     Top level nest
                 SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
                 SPLITCOMP=560,
                 ;SPLITCOMP=525,
           ;     Auto nest
                 SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
                 SPLITCOMP=557,
                 ;SPLITCOMP=545,
           ;     Shared-ride nest
                 SPLIT = sr NC_3 sr2 NC_3 sr3,
                 SPLITCOMP=553,
           ;     Transit nest
                 SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
                 SPLITCOMP=558,
           ;     Walk to Transit nest
                 SPLIT = wlktrn NC_3 walksky NC_3 walkloc NC_3 walkexp NC_3 walkbrt NC_3 walkcom,
                 SPLITCOMP=554,
           ;     PNR to Transit nest
                 SPLIT = pnrtrn  NC_3 pnrloc NC_3 pnrexp NC_3 pnrbrt NC_3 pnrcom,
                 SPLITCOMP=555,
           ;     KNR to Transit nest
                 SPLIT = knrtrn NC_3 knrloc NC_3 knrexp NC_3 knrbrt NC_3 knrcom,
                 SPLITCOMP=556,
           ;     Non-Motorized nest
                 SPLIT= nonmot NC_2 walk NC_2 bike,
                 SPLITCOMP=559
           :next
           
           ; Aggregate trips for all access markets
           LOOP _m=1,@MARKETS@              ; For each auto sufficiency market
               LOOP _c=1,19                 ; 19 choices
                   _n=700+_c+(_m-1)*20      ; 701 to 719: Zero auto market trips, 721 - 739 is auto insufficient low inc...
                   _d=600+_c + (_m-1)*20    
                   MW[_n]= MW[_n] + MW[_d]  ; MW[_n] --> MW(701 to 799)
               ENDLOOP
           ENDLOOP
           
           ; Store logsums for each access market 
           LOOP _m = 1, @MARKETS@
             IF (ACC==1) 
               MW[800+(_m-1)*20] = MW[521+(_m-1)*8]    ; Util_SR   (MWs => 800 = ZA, 820 = A<W Low, 840 = A<W Hi, 860 = A>W Lo, 880 = A>w Hi) 
               MW[801+(_m-1)*20] = MW[522+(_m-1)*8]    ; Util_WTrn   
               MW[802+(_m-1)*20] = MW[523+(_m-1)*8]    ; Util_DTrn   
               MW[803+(_m-1)*20] = MW[524+(_m-1)*8]    ; Util_KTrn   
               MW[804+(_m-1)*20] = MW[525+(_m-1)*8]    ; Util_Auto            
               MW[805+(_m-1)*20] = MW[526+(_m-1)*8]    ; Util_Trn    
               MW[806+(_m-1)*20] = MW[527+(_m-1)*8]    ; Util_NonMot 
               MW[807+(_m-1)*20] = MW[528+(_m-1)*8]    ; Logsums                        
             ELSEIF(ACC==2)
               MW[808+(_m-1)*20] = MW[521+(_m-1)*8]    ; Util_SR   (MWs => 808 = ZA, 828 = A<W Low, 848 = A<W Hi, 868 = A>W Lo, 888 = A>w Hi) 
               ; MW[808+(_m-1)*20] = MW[522+(_m-1)*8]  ; Util_WTrn   
               MW[809+(_m-1)*20] = MW[523+(_m-1)*8]    ; Util_DTrn   
               MW[810+(_m-1)*20] = MW[524+(_m-1)*8]    ; Util_KTrn   
               MW[811+(_m-1)*20] = MW[525+(_m-1)*8]    ; Util_Auto            
               MW[812+(_m-1)*20] = MW[526+(_m-1)*8]    ; Util_Trn    
               MW[813+(_m-1)*20] = MW[527+(_m-1)*8]    ; Util_NonMot 
               MW[814+(_m-1)*20] = MW[528+(_m-1)*8]    ; Logsums   
             ELSEIF(ACC==3)
               MW[815+(_m-1)*20] = MW[521+(_m-1)*8]    ; Util_SR   (MWs => 815 = ZA, 835 = A<W Low, 855 = A<W Hi, 875 = A>W Lo, 895 = A>w Hi) 
              ; MW[808+(_m-1)*20] = MW[522+(_m-1)*8]   ; Util_WTrn   
              ; MW[809+(_m-1)*20] = MW[523+(_m-1)*8]   ; Util_DTrn   
              ; MW[810+(_m-1)*20] = MW[524+(_m-1)*8]   ; Util_KTrn   
               MW[816+(_m-1)*20] = MW[525+(_m-1)*8]    ; Util_Auto            
               MW[817+(_m-1)*20] = MW[526+(_m-1)*8]    ; Util_Trn    
               MW[818+(_m-1)*20] = MW[527+(_m-1)*8]    ; Util_NonMot 
               MW[819+(_m-1)*20] = MW[528+(_m-1)*8]    ; Logsums 
            ENDIF
          ENDLOOP
         
           
           ; Store probabilities for each transit access category
           ;  IF (ACC == 1)
           ;      LOOP _m=1,@MARKETS@
           ;          LOOP _c=1,11
           ;              _n=320+_c+(_m-1)*11
           ;              _d=600+_c + (_m-1)*20
           ;              MW[_n]=MW[_d]         ; MW[_n] --> MW(321 to 397)
           ;          ENDLOOP
           ;      ENDLOOP
           ;  ELSEIF (ACC == 2)
           ;      LOOP _m=1,@MARKETS@
           ;          LOOP _c=1,11
           ;;             _n=320+_c+(_m-1)*11
           ;              _n=740+_c+(_m-1)*11
           ;              _d=600+_c + (_m-1)*20
           ;              MW[_n]=MW[_d]         ; MW[_n] --> MW(741 to 817)
           ;          ENDLOOP
           ;      ENDLOOP
           ;  ENDIF
    
            ; exponentiated auto utility -- for user benefits
            LOOP _m=1,@MARKETS@
              MW[560+_m]=exp(NC_1 * MW[525+(_m-1)*8])     
            ENDLOOP                               

            ; Calculate access market shares
            ARRAY TYPE=F ACCShare=ZONES,ZONES,3
            JLOOP
              IF (ACC==1)
                  ACCShare[I][J][ACC] = (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)         ; Can Walk
              ELSEIF (ACC==2)
                  ACCShare[I][J][ACC] = (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)   ; Must Drive
              ELSEIF (ACC==3)
                  ACCShare[I][J][ACC] = 1 - ACCShare[I][J][1] - ACCShare[I][J][2]                                 ; No Transit
              ENDIF
            ENDJLOOP
           
            ; Calculate logit average of the mode choice logsums (composite utilities) across access markets
            LOOP _m=1,@MARKETS@
             JLOOP
               MW[570+_m] = MW[570+_m] + EXP(MW[528+(_m-1)*8]) * ACCShare[I][J][ACC]
               IF(ACC==3)
                if (MW[570+_m]> 0) 
                  MW[570+_m] = LN(MW[570+_m])
                else 
                  MW[570+_m] = 0
                endif
               ENDIF
             ENDJLOOP
             
            ENDLOOP
        ENDLOOP ; end access loop
ENDRUN
