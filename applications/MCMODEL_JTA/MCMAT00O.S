/*
  Mode Choice Model
  Purpose and Market Definitions:

  Num  Purpose  Segment  ||  Seg     AutoSufficiency
   1   HBW        5      ||   1      Zero Auto
   2   HBO        5      ||   2      A<W Low Inc
   3   HBS        5      ||   3      A<W High Inc
   4   HBSR       5      ||   4      A>=W Low Inc
   5   SCH        1      ||   5      A>=W High Inc
   6   HBCU       1      ||
   7   NHBW       1      ||
   8   NHBO       1      ||

   ; Market stratification for all trip purposes except student trips is based on Car Sufficiency.

*/

; PURPNO = 1

; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00D.PRN" MSG='Utilities and XCHOICE'
FILEI MATI[12] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
FILEO MATO[8] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_1CAR.MAT"
FILEO MATO[9] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_2CAR.MAT"
FILEO MATO[10] = "{SCENARIO_DIR}\output\@PURP@Trip.MAT"
FILEO MATO[11] = "{SCENARIO_DIR}\output\expautoutil_tmp.mat"
FILEO MATO[12] = "{SCENARIO_DIR}\output\farexfer_tmp.mat"

    ; Multi-core processing
    ; DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F

/*
    ; Mode choice output files
      FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_0CAR.MAT",
      MO=701-712,DEC=12*s,NAME=DACW0CAR,SR2CW0CAR,SR3CW0CAR,WBCW0CAR,WPCW0CAR,PBCW0CAR,PPCW0CAR,KBCW0CAR,KPCW0CAR,CKBCW0CAR,CKPCW0CAR,FRGPNRCW0CAR
      FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_1CAR.MAT",
      MO=713-724,DEC=12*s,NAME=DACW1CAR,SR2CW1CAR,SR3CW1CAR,WBCW1CAR,WPCW1CAR,PBCW1CAR,PPCW1CAR,KBCW1CAR,KPCW1CAR,CKBCW1CAR,CKPCW1CAR,FRGPNRCW1CAR
      FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_2CAR.MAT",
      MO=725-736,DEC=12*s,NAME=DACW2CAR,SR2CW2CAR,SR3CW2CAR,WBCW2CAR,WPCW2CAR,PBCW2CAR,PPCW2CAR,KBCW2CAR,KPCW2CAR,CKBCW2CAR,CKPCW2CAR,FRGPNRCW2CAR
      FILEO MATO[4] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_0CAR.MAT",
      MO=737-748,DEC=12*s,NAME=DAMD0CAR,SR2MD0CAR,SR3MD0CAR,WBMD0CAR,WPMD0CAR,PBMD0CAR,PPMD0CAR,KBMD0CAR,KPMD0CAR,CKBMD0CAR,CKPMD0CAR,FRGPNRMD0CAR
      FILEO MATO[5] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_1CAR.MAT",
      MO=749-760,DEC=12*s,NAME=DAMD1CAR,SR2MD1CAR,SR3MD1CAR,WBMD1CAR,WPMD1CAR,PBMD1CAR,PPMD1CAR,KBMD1CAR,KPMD1CAR,CKBMD1CAR,CKPMD1CAR,FRGPNRMD1CAR
      FILEO MATO[6] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_2CAR.MAT",
      MO=761-772,DEC=12*s,NAME=DAMD2CAR,SR2MD2CAR,SR3MD2CAR,WBMD2CAR,WPMD2CAR,PBMD2CAR,PPMD2CAR,KBMD2CAR,KPMD2CAR,CKBMD2CAR,CKPMD2CAR,FRGPNRMD2CAR
      FILEO MATO[7] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_0CAR.MAT",
      MO=773-784,DEC=12*s,NAME=DANT0CAR,SR2NT0CAR,SR3NT0CAR,WBNT0CAR,WPNT0CAR,PBNT0CAR,PPNT0CAR,KBNT0CAR,KPNT0CAR,CKBNT0CAR,CKPNT0CAR,FRGPNRNT0CAR
      FILEO MATO[8] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_1CAR.MAT",
      MO=785-796,DEC=12*s,NAME=DANT1CAR,SR2NT1CAR,SR3NT1CAR,WBNT1CAR,WPNT1CAR,PBNT1CAR,PPNT1CAR,KBNT1CAR,KPNT1CAR,CKBNT1CAR,CKPNT1CAR,FRGPNRNT1CAR
      FILEO MATO[9] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_2CAR.MAT",
      MO=797-808,DEC=12*s,NAME=DANT2CAR,SR2NT2CAR,SR3NT2CAR,WBNT2CAR,WPNT2CAR,PBNT2CAR,PPNT2CAR,KBNT2CAR,KPNT2CAR,CKBNT2CAR,CKPNT2CAR,FRGPNRNT2CAR
      FILEO MATO[10] = "{SCENARIO_DIR}\output\@PURP@Trip.MAT",
      MO=601-612,621-632,641-652,251-254,261-269,DEC=49*S
      FILEO MATO[11] = "{SCENARIO_DIR}\output\expautoutil_tmp.mat",
      MO=56-58,36-38,DEC=6*D,NAME=EXPA_0CAR,EXPA_1CAR,EXPA_2CAR,SPLITCMP_0CAR,SPLITCMP_1CAR,SPLITCMP_2CAR
      FILEO MATO[12] = "{SCENARIO_DIR}\output\farexfer_tmp.mat",
      MO=211-228,DEC=18*2,NAME=farewb,farewp,farepb,farepp,farekb,farekp,fareckb,fareckp,farefp,xferwb,xferwp,xferpb,xferpp,xferkb,xferkp,xferckb,xferckp,xferfp

*/               
   
    ; Composite Logsums by Market
FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_0CAR.MAT",
        MO=340-344,DEC=5*S,
            NAME=LSUM_M1,LSUM_M2,LSUM_M3,LSUM_M4,LSUM_M5
            
FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_1CAR.MAT",
        MO=350-354,330-334,DEC=10*S,NAME=EXPA_M1,EXPA_M2,EXPA_M3,EXPA_M4,EXPA_M5,
           SPLITCMP_M1,SPLITCMP_M2,SPLITCMP_M3,SPLITCMP_M4,SPLITCMP_M5
    
FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_2CAR.MAT",
        MO=701-718,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
FILEO MATO[4] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_0CAR.MAT",
        MO=721-738,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
FILEO MATO[5] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_1CAR.MAT",
        MO=741-758,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
FILEO MATO[6] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_2CAR.MAT",
        MO=761-778,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
    
FILEO MATO[7] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_0CAR.MAT",
        MO=781-798,DEC=18*D,
            NAME=DA,SR2,SR3,DRVSKY,WALKSKY,WALKLOC,WALKEXP,WALKBRT,WALKCOM,PNREXP,PNRBRT,PNRCOM,KNRLOC,KNREXP,KNRBRT,KNRCOM,WALK,BIKE
     

    ; Print outputs
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebug.TXT",
append=t
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSum.TXT",
 append=t

    ; Zone and station data
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
FILEI ZDATI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"

    ; Modechoice coefficients and alternative specific constants
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"

    ; Highway Skim Tables
    ; Tables 1-4 for SOV: 1-Toll, 2-Distance, 3-Time, 4-Weighted Time
    ; Tables 5-8 for HOV: 5-Toll, 6-Distance, 7-Time, 8-Weighted Time
    ; Table 9 is terminal time

    ; Transit Skim Tables
    ; Tables 1-6: 1-WalkTime, 2-AutoTime, 3-XferTime, 
    ; Tables 4-8: 4-Skyway, 5-BusTime, 6-ExpBus, 7-BRT, 8-ComRail
    ; Tables 9-10:
    ; Tables 11-15: 11-NumXfers, 12-InitialWaitTime, 13-XferWaitTime, 14-Fare, 15-Total time

    ; Transit skim (1: Walk to Skyway)
FILEI MATI[1] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"

    ; Transit skim (2: Walk to Local Bus)
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@1_{Alt}{year}.MAT"

    ; Transit skim (3: Walk to Express Bus)
FILEI MATI[3] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@2_{Alt}{year}.MAT"

    ; Transit skim (4: Walk to BRT-LRT)
FILEI MATI[4] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@3_{Alt}{year}.MAT"

    ; Transit skim (5: Walk to Commuter Rail)
FILEI MATI[5] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@4_{Alt}{year}.MAT"

    ; Transit skim (6: Drive to Local Bus)
    ; FILEI MATI[6] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@6_{Alt}{year}.MAT"

    ; Transit skim (6: PNR to Express Bus)
FILEI MATI[6] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@5_{Alt}{year}.MAT"

    ; Transit skim (7: PNR to BRT-LRT Bus)
FILEI MATI[7] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@6_{Alt}{year}.MAT"

    ; Transit skim (8: PNR to Commuter Rail)
FILEI MATI[8] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@7_{Alt}{year}.MAT"

    ; Transit skim (9: KNR to Express Bus)
FILEI MATI[9] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@8_{Alt}{year}.MAT"

    ; Transit skim (10: KNR to BRT-LRT Bus)
FILEI MATI[10] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@9_{Alt}{year}.MAT"

    ; Transit skim (11: KNR to Commuter Rail)
FILEI MATI[11] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT"

    ; Highway skim (All Drive)
FILEI MATI[13] = "{SCENARIO_DIR}\output\PTRIPSMC.MAT"

    ; Highway skim (Drive to Skyway) // Need to repalce with sky
FILEI MATI[14] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT"

    ; Non-Motorized skim (All Walk)
    ; FILEI MATI[15] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"

    ; Non-Motorized skim (All Bike)
    ; FILEI MATI[16] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"

    ; HOV time savings
    ; Table 1 - HOV time savings for peak period
    ; Table 2 - HOV time savings for off-peak period

    ; Station to station table
    ; 1-4 tables - PKStationTAZ_pnrb, PKParkCost_pnrb, termtimpnr, termtimknr,
    ; 5-8 tables - OPStationTAZ_pnrb, OPParkCost_pnrb, termtimpnr, termtimknr

    ; Select link matrices??

    ; Person trips


    ; Progress Bar update for evey 100 zones
    zonemsg=100

    ; Declare arrays to hold alternative specific constants
    ARRAY PARK={ZONESA}
    ARRAY TYPE=F K_AUT=5, K_SR=5, K_SR3=5, K_TRN=5, K_TDRV=5, K_TKNR=5, K_NMOT=5, K_BIKE=5
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
      LOOP _m=1,5
         K_AUT[_m]  = CONSTANTS(1,(_m-1)*10+1)            ; auto
         K_SR[_m]   = CONSTANTS(1,(_m-1)*10+2)            ; shared-ride 2 & 3+
         K_SR3[_m]  = CONSTANTS(1,(_m-1)*10+3)            ; shared ride 3+
         K_TRN[_m]  = CONSTANTS(1,(_m-1)*10+4)            ; transit
         K_TDRV[_m] = CONSTANTS(1,(_m-1)*10+5)            ; drive to transit
         K_TKNR[_m] = CONSTANTS(1,(_m-1)*10+6)            ; knr to transit
         K_NMOT[_m] = CONSTANTS(1,(_m-1)*10+7)            ; non-motorized (walk & bike)
         K_BIKE[_m] = CONSTANTS(1,(_m-1)*10+8)            ; bike
      ENDLOOP

      ; MARKETS=@MARKETS@
      MARKET_NAME[1] = '@Mkt1_Name@'
      MARKET_NAME[2] = '@Mkt2_Name@'
      MARKET_NAME[3] = '@Mkt3_Name@'
      MARKET_NAME[4] = '@Mkt4_Name@'
      MARKET_NAME[5] = '@Mkt5_Name@'

      ; Mode-specific constants -- same for all hhld markets
      K_SKY = CONSTANTS(1,51)                        ; Skyway
      K_EXP = CONSTANTS(1,52)                        ; express bus
      K_BRT = CONSTANTS(1,53)                        ; brt
      K_UR  = CONSTANTS(1,54)                        ; urban rail
      K_CR  = CONSTANTS(1,55)                        ; commuter rail

      ; Nesting coefficients
      NC_1        = COEFF(1,10)                      ; Level 1 - auto, trn, non-mot
      NC_2        = COEFF(1,11)                      ; Level 2 - transit access mode choice
      NCP = NC_1 * NC_2                              ; Product of nesting coefficients

      ; Level of Service Coefficients
      COEFF_IVTT   = COEFF(1,1)                      ; In-vehicle travel time coefficient
      COEFF_OVT    = COEFF(1,3)                      ; Out-of-vehicle travel time coefficient
      COEFF_AAT    = COEFF(1,5)                      ; Access coefficient?
      COEFF_XFER   = COEFF(1,6)                      ; transfer
      COEFF_DCBD   = COEFF(1,7)                      ;
      COEFF_DEXUP  = COEFF(1,8)                      ;
      COEFF_DEXUA  = COEFF(1,9)                      ;

      COEFF_DCBD_WALK = COEFF(1,15)                  ;
      COEFF_DCBD_PNR  = COEFF(1,16)                  ;
      COEFF_DCBD_KNR  = COEFF(1,17)                  ;

      ; Cost Coefficients
      ARRAY TYPE=F COEFF_COST=7
      COEFF_COST[1]  = COEFF(1,21)
      COEFF_COST[2]  = COEFF(1,22)
      COEFF_COST[3]  = COEFF(1,23)
      COEFF_COST[4]  = COEFF(1,24)
      COEFF_COST[5]  = COEFF(1,25)
      COEFF_COST[6]  = COEFF(1,26)
      COEFF_COST[7]  = COEFF(1,27)

    ENDIF

    ; Highway skims
    FILLMW MW[1]=MI.13.1,2,3,4,5,6,7,8 ;,9     ; highway skims
    FILLMW MW[241]=MI.14.1,2,3,4,5,6,7,8 ;,9   ; drive toskyway best path
    FILLMW MW[11]=MI.17.HOVsave@PERIOD@        ; HOVsavePK for peak period and HOVsaveOP for off-peak period
    FILLMW MW[291]=MI.18.@STATION_TABLE@       ; 8 tables - PKStationTAZ_pnrb,PKParkCost_pnrb,termtimpnr,termtimknr,OPStationTAZ_pnrb,OPParkCost_pnrb,termtimpnr,termtimknr

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
    FILLMW MW[181]=MI.6.1(15)                  ; knr to exp bus
    FILLMW MW[201]=MI.7.1(15)                  ; knr to brt lrt
    FILLMW MW[221]=MI.8.1(15)                  ; knr to com rail

    ; Walk and Bike
    ; distance portion that is 1 mile or less
    MW[12] = MIN(MW[2],1)

    ; Distance portion that is longer than 1 mile
    JLOOP
      IF (MW[2][J] > 1)
          MW[13] = MW[2][J] - 1
      ELSE
          MW[13] = 0
      ENDIF
    ENDJLOOP

    ; Person trips
    MW[251] = MI.20.1

    ;  Write out coefficients for debug and regular runs
    IF (I=1)  ; Write mode choice summary file                                                                                                
      ; DEBUG MODE CHOICE                                                                                                                   
      IF ({DebugMC}>0) 
         ; split this into two sections (1) DEBUG and (2) Regular 
         READ FILE = "C:\NERPM50\APPLICATIONS\MCMODEL_JTA\WRITEREPORT.S"
      ENDIF
    ENDIF
    
    ; ************************** PROCESS PERSON TRIPS INTO MARKETS ************************************
    ; Divide person trip table into different markets
      MW[252]=MW[251] * ZI.1.PERCAUTO0[I]                                                                   ; Zero car HHs
      MW[253]=MW[251] * ZI.1.PERCAUTO1[I]                                                                   ; Auto Insufficient Low Income HHs
      MW[254]=MW[251] * ZI.1.PERCAUTO3[I]                                                                   ; Auto Insufficient High Income HHs
      MW[255]=MW[251] * ZI.1.PERCAUTO4[I]                                                                   ; Auto Sufficient Low Income HHs
      MW[256]=(MW[251] - MW[252] - MW[253] - MW[254] - MW[255])                                             ; Auto Sufficient High Income HHs

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

        ; ************************** COMMON UTILITY CALCULATIONS ************************************
        ; Computes utility that is common across all household market segments

        ; DRIVE ALONE UTILITY:
              MW[301]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[1] * {CTOLL} * 60))) +               ; IVTT
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; SHARED RIDE PERSONS/SHARE RIDE - ONE PASSENGER UTILITY:
              MW[302]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[8] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) -               ; IVTT
                       COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP


        ; SHARED RIDE - 2+ PASSENGER UTILITY:
              MW[303]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[8] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) -               ; IVTT
                       COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; DRIVE TO SKYWAY UTILITY:
              MW[304]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
                       COEFF_IVTT * (MW[241] - ({InflationToll} * (MW[245] * {CTOLL} * 60))) -           ; IVTT
                       COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
        @isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP

        ; WALK ACCESS - SKYWAY UTILITY:
              MW[305]=(COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time (skyway has no xfer time)
                       COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[24] + MW[25] + MW[26] + MW[27] + MW[28]) +                       ; IVTT
                       COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
                       K_SKY +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - LOCAL BUS UTILITY:
              MW[306]=(COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
                       COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[48]) +                       ; IVTT
                       COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - EXPRESS BUS UTILITY:
              MW[307]=(COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
                       COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[68]) +                       ; IVTT
                       COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
                       K_EXP +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - BRT-LRT UTILITY:
              MW[308]=(COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
                       COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[88])+                        ; IVTT
                       COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
                       K_BRT +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; WALK ACCESS - COMMUTER RAIL UTILITY:
              MW[309]=(COEFF_OVT * (MW[101] + MW[103]) +                                                 ; Walk & transfer time
                       COEFF_OVT * (MW[112] + MW[113]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[104] + MW[105] + MW[106] + MW[107] + MW[108]) +                  ; IVTT
                       COEFF_XFER * (MW[111]) +                                                          ; Number of transfers
                       K_CR +                                                                            ; ASC
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; PNR ACCESS - EXPRESS BUS UTILITY:
              MW[310]=(COEFF_OVT * (MW[121] + MW[123]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[132] + MW[133]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[122]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[124] + MW[125] + MW[126] + MW[127] + MW[128]) +                  ; IVTT
                       COEFF_XFER * (MW[131]) +                                                          ; Number of transfers
                       K_EXP +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; PNR ACCESS - BRT-LRT UTILITY:
              MW[311]=(COEFF_OVT * (MW[141] + MW[143]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[152] + MW[153]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[142]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[144] + MW[145] + MW[146] + MW[147] + MW[148]) +                  ; IVTT
                       COEFF_XFER * (MW[151]) +                                                          ; Number of transfers
                       K_BRT +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; PNR ACCESS - COMMUTER RAIL UTILITY:
              MW[312]=(COEFF_OVT * (MW[161] + MW[163]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[172] + MW[173]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[162]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[164] + MW[165] + MW[166] + MW[167] + MW[168]) +                  ; IVTT
                       COEFF_XFER * (MW[171]) +                                                          ; Number of transfers
                       K_CR +                                                                            ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; KNR ACCESS - LOCAL BUS UTILITY (WALK SKIM with drive access time:
              MW[313]=(COEFF_OVT * ((MW[41]/10) + MW[43]) +                                              ; Drive time = Walk time/10, assuming drive speed of 30 MPH and Walk speed of 3 MPH (limitations on not having separate access & egress links) & transfer time
                       COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
                       COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[48]) +                       ; IVTT
                       COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
        @isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

        ; KNR ACCESS - EXPRESS BUS UTILITY:
              MW[314]=(COEFF_OVT * (MW[181] + MW[183]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[192] + MW[193]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[182]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[184] + MW[185] + MW[186] + MW[187] + MW[188]) +                  ; IVTT
                       COEFF_XFER * (MW[191]) +                                                          ; Number of transfers
                       K_EXP +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; KNR ACCESS - BRT-LRT UTILITY:
              MW[315]=(COEFF_OVT * (MW[201] + MW[203]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[212] + MW[213]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[202]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[204] + MW[205] + MW[206] + MW[207] + MW[208]) +                  ; IVTT
                       COEFF_XFER * (MW[211]) +                                                          ; Number of transfers
                       K_BRT +                                                                           ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; KNR ACCESS - COMMUTER RAIL UTILITY:
              MW[316]=(COEFF_OVT * (MW[221] + MW[223]) +                                                 ; Drive & transfer time
                       COEFF_OVT * (MW[232] + MW[233]) +                                                 ; Initial & transfer wait
                       COEFF_IVTT * (MW[222]) +                                                          ; Auto access time
                       COEFF_IVTT * (MW[224] + MW[225] + MW[226] + MW[227] + MW[228]) +                  ; IVTT
                       COEFF_XFER * (MW[231]) +                                                          ; Number of transfers
                       K_CR +                                                                            ; ASC
        @isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
        @noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
                       COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
                       COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

        ; WALK MODE ELEMENTS OF UTILITY ARE:
             MW[317]=(COEFF_IVTT * 2 * (60/3) * MW[12] +                                                 ; walking time if less than 1 mile
                      COEFF_IVTT * 3 * (60/3) * MW[13]) / NCP                                            ; walking time if more than 1 mile

        ;BIKE MODE ELEMENTS OF UTILITY ARE
             MW[318]=(COEFF_IVTT * 2 * (60/10) * MW[12] +                                                ; biking time if less than 1 mile
                      COEFF_IVTT * 3 * (60/10) * MW[13]) / NCP                                           ; biking time if more than 1 mile

        ;************************** END COMMON UTILITY CALCULATIONS ************************************

        ;**********************  ADD HOUSEHOLD MARKET SPECIFIC TERMS **********************************
        ;                              Cost utility and constants
        LOOP _m=1,@MARKETS@

           ; Drive alone
           MW[401+20*(_m-1)] = MW[301] + (0                +                                                    ; Constant(s)
                                   COEFF_COST[_m] * {InflationToll} * MW[1]        +                            ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +     ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +     ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost
           ; Shared Ride 2-person
           MW[402+20*(_m-1)] = MW[302] + (K_SR[_m]       +                                                      ; Constant(s)
                                   COEFF_COST[_m] * ({InflationToll} * MW[5] / 2.0) +                           ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 2.0) +     ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 1.0) +     ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost (not shared among occupants)

           ; Shared Ride 3+ person
           MW[403+20*(_m-1)] = MW[303] + (K_SR[_m] + K_SR3[_m] +                                                ; Constant(s)
                                   COEFF_COST[_m] * ({InflationToll} * MW[5] / @OCC3@) +                        ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 2.0) +  ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 1.0) +  ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost (not shared among occupants)
           ; Drive to Skyway
           MW[404+20*(_m-1)] = MW[304] + (0                +                                                    ; Constant(s)
                                   COEFF_COST[_m] * {InflationToll} * MW[1]        +                            ; Toll
           @noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +     ; Auto parking cost
           @isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +     ; Auto parking cost (NHB)
                                   COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost
                                   
           ; Walk to Skyway
           MW[405+20*(_m-1)] = MW[305] + (K_TRN[_m]      +                                                      ; Constant(s)
                                  COEFF_COST[_m] * {InflationFare} * (MW[34]) ) / NCP                           ; Transit fare

           ; Walk to Local Bus
           MW[406+20*(_m-1)] = MW[306] + (K_TRN[_m]      +                                                      ; Constant(s)
                                  COEFF_COST[_m] * {InflationFare} * (MW[54]) ) / NCP                           ; Transit fare

           ; Walk to Express Bus
           MW[407+20*(_m-1)] = MW[307] + (K_TRN[_m] + K_EXP  +                                                  ; Constant(s)
                                 COEFF_COST[_m] * {InflationFare} * (MW[74]) ) / NCP                            ; Transit fare

           ; Walk to BRT-LRT
           MW[408+20*(_m-1)] = MW[308] + (K_TRN[_m] + K_EXP  +                                                  ; Constant(s)
                                 COEFF_COST[_m] * {InflationFare} * (MW[94]) ) / NCP                            ; Transit fare

           ; Walk to Commuter Rail
           MW[409+20*(_m-1)] = MW[309] + (K_TRN[_m] + K_EXP  +                                                  ; Constant(s)
                                 COEFF_COST[_m] * {InflationFare} * (MW[114]) ) / NCP                           ; Transit fare

           ; PNR to Express Bus
           MW[410+20*(_m-1)] = MW[310] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@         COEFF_COST[_m] * ((({InflationFare}*MW[291])/{OCCPNRAccess})/2.0) +                  ; add in other half of NHB PNR parking cost
                                  COEFF_COST[_m] * {InflationFare} * (MW[134])  ) / NCP                         ; Transit fare

           ; PNR to BRT-LRT Bus
           MW[411+20*(_m-1)] = MW[311] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[154]) ) / NCP                         ; Transit fare

           ; PNR to Commuter Rail
           MW[412+20*(_m-1)] = MW[312] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[174]) ) / NCP                         ; Transit fare

           ; KNR to Local Bus
           MW[413+20*(_m-1)] = MW[313] + (K_TRN[_m] + K_TDRV[_m] + K_TKNR[_m] +                                 ; Constant(s)
                                  COEFF_COST[_m] * {InflationFare} * (MW[34]) ) / NCP                           ; Transit fare

           ; KNR to Express Bus
           MW[414+20*(_m-1)] = MW[314] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@         COEFF_COST[_m] * ((({InflationFare}*MW[291])/{OCCPNRAccess})/2.0) +                  ; add in other half of NHB PNR parking cost
                                  COEFF_COST[_m] * {InflationFare} * (MW[134])  ) / NCP                         ; Transit fare

           ; KNR to BRT-LRT Bus
           MW[415+20*(_m-1)] = MW[315] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[154]) ) / NCP                         ; Transit fare

           ; KNR to Commuter Rail
           MW[416+20*(_m-1)] = MW[316] + (K_TRN[_m] + K_TDRV[_m] +                                              ; Constant(s)
           @isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                                   COEFF_COST[_m] * {InflationFare} * (MW[174]) ) / NCP                         ; Transit fare
           ; Walk
           MW[417+20*(_m-1)] = MW[317] + (K_NMOT[_m])/NCP                                                       ; Constant(s)

           ; Bike
           MW[418+20*(_m-1)] = MW[318] + (K_NMOT[_m] + K_BIKE[_m])/NCP                                          ; Constant(s)

        ENDLOOP

        ;***************************    MODE AVAILABILITY CHECKS    ************************************
        ;  Drive alone and PNR to transit not available to zero car households
        IF (@Mkt1_0car@=1)
          MW[401] = -9999.99
          MW[404] = -9999.99
          MW[410] = -9999.99
          MW[411] = -9999.99
          MW[412] = -9999.99
        ENDIF

        LOOP _m=1,@MARKETS@
          JLOOP
             ; Transit not available if no line-haul in-vehicle time on the transit path
             ; Walk to skyway
             IF (MW[24] == 0)  MW[405+20*(_m-1)]=-9999.99

             ; Walk to local bus
             IF (MW[44] == 0)  MW[406+20*(_m-1)]=-9999.99

             ; Walk to express bus
             IF (MW[64] == 0)  MW[407+20*(_m-1)]=-9999.99

             ; Walk to BRT-LRT bus
             IF (MW[84] == 0)  MW[408+20*(_m-1)]=-9999.99

             ; Walk to Commuter Rail
             IF (MW[104] == 0)  MW[409+20*(_m-1)]=-9999.99

             ; PNR to express bus
             IF (MW[124] == 0)  MW[410+20*(_m-1)]=-9999.99

             ; PNR to BRT-LRT
             IF (MW[144] == 0)  MW[411+20*(_m-1)]=-9999.99

             ; PNR to Commuter rail
             IF (MW[164] == 0) MW[412+20*(_m-1)]=-9999.99

             ; KNR to express bus
             IF (MW[184] == 0)  MW[413+20*(_m-1)]=-9999.99

             ; KNR to BRT-LRT
             IF (MW[204] == 0)  MW[414+20*(_m-1)]=-9999.99

             ; KNR to Commuter rail
             IF (MW[224] == 0) MW[415+20*(_m-1)]=-9999.99

             ; If walk access distance less than minimum, no walk access to transit
             IF (MW[2] < {MinDistWalkAcc})
                 MW[405+20*(_m-1)]=-9999.99
                 MW[406+20*(_m-1)]=-9999.99
                 MW[407+20*(_m-1)]=-9999.99
                 MW[408+20*(_m-1)]=-9999.99
                 MW[409+20*(_m-1)]=-9999.99
             ENDIF

             ; If drive access distance less than minimum, no drive access to transit
             IF (MW[2] < {MinDistAutoAcc})
                MW[410+20*(_m-1)]=-9999.99
                MW[411+20*(_m-1)]=-9999.99
                MW[412+20*(_m-1)]=-9999.99
             ENDIF

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
               MW[410+20*(_m-1)]=-9999.99
               MW[411+20*(_m-1)]=-9999.99
               MW[412+20*(_m-1)]=-9999.99
               MW[413+20*(_m-1)]=-9999.99
               MW[414+20*(_m-1)]=-9999.99
               MW[415+20*(_m-1)]=-9999.99
               MW[416+20*(_m-1)]=-9999.99
             ENDIF
          ENDJLOOP
       ENDLOOP    ; end market segment loop to set mode availability

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
                                                                                                                                                       
           IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))    
              READ FILE = "C:\NERPM50\APPLICATIONS\MCMODEL_JTA\WRITECOMPOSITEUTILITY.S"
          ENDIF
        ENDIF  
      ENDJLOOP 

       ; ############################# XCHOICE SETUP ###################################
       ; Use DEMAND=1 to generate probabilities.
       ; 0-Car Households
             _DMD=260+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,
             DEMAND=_DMD,
             ODEMANDMW=601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=321,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=331,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       IF(@MARKETS@==1) GOTO next
       ; Car-insufficient, Low Income Households
             _DMD=263+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,
             DEMAND=_DMD,
             ODEMANDMW=621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=322,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=332,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       ; Car-insufficient, High Income Households
             _DMD=266+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,
             DEMAND=_DMD,
             ODEMANDMW=641,642,643,644,645,646,647,648,649,650,651, 652,653,654,655,656,657,658,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=323,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=333,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       ; Car-sufficient, Low Income Households
             _DMD=269+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,
             DEMAND=_DMD,
             ODEMANDMW=661,662,663,664,665,666,667,668,668,670,671,672,673,674,675,676,677,678,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=324,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=334,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       ; Car-sufficient, High Income Households
             _DMD=271+ACC
             XCHOICE ALTERNATIVES=da,sr2,sr3,drvsky,walksky,walkloc,walkexp,walkbrt,walkcom,pnrexp,pnrbrt,pnrcom,knrloc,knrexp,knrbrt,knrcom,walk,bike,
             UTILITIESMW=481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,
             DEMAND=_DMD,
             ODEMANDMW=681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,
             STARTMW=900,
       ;     Model Structure
       ;     Top level nest
             SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot,
             SPLITCOMP=325,
       ;     Auto nest
             SPLIT = auto NC_2 da NC_2 sr NC_2 drvsky,
             SPLITCOMP=335,
       ;     Shared-ride nest
             SPLIT = sr 1.0 sr2 1.0 sr3,
       ;     Transit nest
             SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
       ;     Walk to Transit nest
             SPLIT = wlktrn 1.0 walksky 1.0 walkloc 1.0 walkexp 1.0 walkbrt 1.0 walkcom,
       ;     PNR to Transit nest
             SPLIT = pnrtrn 1.0 pnrexp 1.0 pnrbrt 1.0 pnrcom,
       ;     KNR to Transit nest
             SPLIT = knrtrn 1.0 knrloc 1.0 knrexp 1.0 knrbrt 1.0 knrcom,
       ;     Non-Motorized nest
             SPLIT= nonmot NC_2 walk NC_2 bike

       :next
       
       ; Aggregate trips for all access markets
       LOOP _m=1,@MARKETS@              ; For each auto sufficiency market
           LOOP _c=1,18                 ; 17 choices
               _n=700+_c+(_m-1)*20      ; 701 to 717: Zero auto market trips, 721 - 737 is auto insufficient low inc...
               _d=600+_c + (_m-1)*20    
               MW[_n]=MW[_d]            ; MW[_n] --> MW(701 to 797)
           ENDLOOP
       ENDLOOP

       ; Exponentiated composite utilities
         LOOP _m=1,@MARKETS@
           MW[350+_m]=exp(NC_2 * MW[330+_m])   ; exponentiated auto utility -- for user benefits
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
           MW[340+_m] = MW[340+_m] + EXP(MW[320+_m]) * ACCShare[I][J][ACC]
           IF(ACC==3) MW[340+_m] = LN(MW[340+_m])
         ENDJLOOP

        ENDLOOP
       ; ############################################ END XCHOICE #################################


        ; Now some debuging

          LOOP _m=1,@MARKETS@

           _cnt=(_m-1)*20
           M1=601+_cnt, M2=602+_cnt, M3=603+_cnt, M4=604+_cnt, M5=605+_cnt, M6=606+_cnt,
           M7=607+_cnt, M8=608+_cnt, M9=609+_cnt, M10=610+_cnt, M11=611+_cnt


           IF ({DebugMC}>0)
            JLOOP
             if ((I={SelOrigin}) && (J={SelDest}))




       ; ##################### XCHOICE RESULTS###############################

              print list='\n\n-------------------------------------------------------------',printo=1
              print list='\nCUBE UTILITY BASED XCHOICE MODEL\n',printo=1
              print list='\nMARKET:                                     ',MARKET_NAME[_m],printo=1
           print list='Access market (1=CW | 2=MD | 3= NT):         ',ACC(2.0),printo=1
              print list='Access market share:                         ',ACCShare[I][J][ACC](6.4),printo=1

         IF ((MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J])>0)
              xcshrda  = MW[M1][J]
              xcshrhov2= MW[M2][J]
              xcshrhov3= MW[M3][J]
              xcshrwkb = MW[M4][J]
              xcshrwkp = MW[M5][J]
              xcshrpnrb= MW[M6][J]
              xcshrpnrp= MW[M7][J]
              xcshrknrb= MW[M8][J]
              xcshrknrp= MW[M9][J]
              xcshrnmw = MW[M10][J]
              xcshrnmb = MW[M11][J]

              xcshrtot=xcshrda+xcshrhov2+xcshrhov3+xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrnmw+xcshrnmb
              print list='\n\nSHARE BY MODE:',printo=1
              print list='\n    Mode:                           Share',printo=1
              print list='    Drive Alone                  ',xcshrda(7.4),printo=1
              print list='    HOV2                         ',xcshrhov2(7.4),printo=1
              print list='    HOV3                         ',xcshrhov3(7.4),printo=1
              print list='    Walk Bus                     ',xcshrwkb(7.4),printo=1
              print list='    Walk Prj                     ',xcshrwkp(7.4),printo=1
              print list='    PNR Bus                      ',xcshrpnrb(7.4),printo=1
              print list='    PNR Prj                      ',xcshrpnrp(7.4),printo=1
              print list='    KNR Bus                      ',xcshrknrb(7.4),printo=1
              print list='    KNR Prj                      ',xcshrknrp(7.4),printo=1
              print list='    Walk                         ',xcshrnmw(7.4),printo=1
              print list='    Bike                         ',xcshrnmb(7.4),printo=1

              print list='\n\n\nOutput shares by XCHOICE:                      ', printo=1
              print list='   Top Nest:                                         ', printo=1
              print list='        Auto Share               ',(xcshrda+xcshrhov2+xcshrhov3)(7.4), printo=1
              print list='        Transit Share            ',(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp)(7.4), printo=1
              print list='        Non-Motorized Share      ',(xcshrnmw+xcshrnmb)(7.4), printo=1
              print list='\n\n   Auto Nest:                                    ', printo=1
              print list='        Drive Alone Share        ',(xcshrda/(xcshrda+xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='        Shared Ride Share        ',((xcshrhov2+xcshrhov3)/(xcshrda+xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='\n\n   Shared Ride Nest:                             ', printo=1
              print list='        HOV2 Share               ',(xcshrhov2/(xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='        HOV3 Share               ',(xcshrhov3/(xcshrhov2+xcshrhov3))(7.4), printo=1
              print list='\n\n   Transit Nest:                                 ', printo=1
              print list='        Walk Transit Share       ',((xcshrwkb+xcshrwkp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='        PNR Transit Share        ',((xcshrpnrb+xcshrpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='        KNR Transit Share        ',((xcshrknrb+xcshrpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='\n\n   Walk Nest:                                 ', printo=1
              print list='        Walk Bus Share           ',(xcshrwkb/(xcshrwkb+xcshrwkp))(7.4), printo=1
              print list='        Walk Prj Share           ',(xcshrwkp/(xcshrwkb+xcshrwkp))(7.4), printo=1
              print list='\n\n   PNR Nest:                                 ', printo=1
              print list='        PNR Bus Share            ',(xcshrpnrb/(xcshrpnrb+xcshrpnrp))(7.4), printo=1
              print list='        PNR Prj Share            ',(xcshrpnrp/(xcshrpnrb+xcshrpnrp))(7.4), printo=1
              print list='\n\n   KNR Nest:                                 ', printo=1
              print list='        KNR Bus Share            ',(xcshrknrb/(xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='        KNR Prj Share            ',(xcshrknrp/(xcshrknrb+xcshrknrp))(7.4), printo=1
              print list='\n\n   Non-Motorized Nest:                                 ', printo=1
              print list='        Walk Share               ',((xcshrnmw)/(xcshrnmw+xcshrnmb))(7.4), printo=1
              print list='        Bike Share               ',((xcshrnmb)/(xcshrnmw+xcshrnmb))(7.4), printo=1

              print list='\n\n\nTotal composite utilities by XCHOICE:          ', MW[100+_m][J](7.4),printo=1
              print list='Auto composite utilities by XCHOICE:           ', MW[110+_m][J](7.4),printo=1
            IF (ACC==3)
              print list='Averaged composite utility:                    ', MW[290+_m][J](7.4),printo=1
           ENDIF
              print list='\n\n',printo=1

              IF (_m=@MARKETS@)
               print list='\n\n\n','END TRACE @PURP@-@PERIOD@','\n',printo=1
               print list='========================================================================================',printo=1
              ENDIF

             ELSE
              print list='No demand (input trips) from this access type and market segment............... ',printo=1
              print list='\n\n',printo=1

             ENDIF

             ENDIF
            ENDJLOOP
           ENDIF

          ENDLOOP ; end market loop created for reporting purposes

       ; ###############################################################################


    ENDLOOP      ; end access loop
    ; ******************************************************************************************************************

ENDRUN
