; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\MCMAT00A_@PURP@_@PERIOD@.PRN" MSG='Mode Choice Probabilities'
FILEI MATI[12] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"

FILEI MATI[11] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT"
           ; Table 1 - HOV time savings for peak period
           ; Table 2 - HOV time savings for off-peak period
     
FILEI MATI[5] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@4.{Alt}{year}"
FILEI MATI[4] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@3.{Alt}{year}"
FILEI MATI[3] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@2.{Alt}{year}"
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@1.{Alt}{year}"
           ; Tables 1-6: 1-WalkTime, 2-AutoTime, 3-XferTime, 4-BusTime, 5-PRJBusTime, 6-CircTime
           ; Tables 7-10: 7-RailTime, 8-CommuterRailTime, 9-OtherModeTime, 10-ProjectModeTime
           ; Tables 11-15: 11-NumXfers, 12-InitialWaitTime, 13-XferWaitTime, 14-Fare, 15-Total time
     
FILEI MATI[1] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"
           ; Tables 1-4 for SOV: 1-Toll, 2-Distance, 3-Time, 4-Weighted Time
           ; Tables 5-8 for HOV: 5-Toll, 6-Distance, 7-Time, 8-Weighted Time
           ; Table 9 is terminal time
                     
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"

FILEI ZDATI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
  
 
FILEO MATO[12] = "{SCENARIO_DIR}\output\farexfer_tmp_@PERIOD@.mat",
    MO=211-216,220-225,DEC=12*2,NAME=farewb,farewp,farepb,farepp,farekb,farekp,xferwb,xferwp,xferpb,xferpp,xferkb,xferkp
 
FILEO MATO[11] = "{SCENARIO_DIR}\output\expautoutil_tmp_@PERIOD@.mat",
    MO=156-162,111-117,DEC=14*S,NAME=EXPA_M1,EXPA_M2,EXPA_M3,EXPA_M4,EXPA_M5,EXPA_M6,EXPA_M7,
        SPLITCMP_M1,SPLITCMP_M2,SPLITCMP_M3,SPLITCMP_M4,SPLITCMP_M5,SPLITCMP_M6,SPLITCMP_M7
   
FILEO MATO[8] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB7.MAT",
    MO=387-397,807-817,721-731,DEC=33*S, 
        NAME=DA_CWM7,SR2_CWM7,SR3_CWM7,WBUS_CWM7,WPRJ_CWM7,PBUS_CWM7,PPRJ_CWM7,KBUS_CWM7,KPRJ_CWM7,WALK_CWM7,BIKE_CWM7,
        DA_MDM7,SR2_MDM7,SR3MD_M7,WBUS_MDM7,WPRJ_MDM7,PBUS_MDM7,PPRJ_MDM7,KBUS_MDM7,KPRJ_MDM7,WALK_MDM7,BIKE_MDM7,
        DA_NTM7,SR2_NTM7,SR3_NTM7,WBUS_NTM7,WPRJ_NTM7,PBUS_NTM7,PPRJ_NTM7,KBUS_NTM7,KPRJ_NTM7,WALK_NTM7,BIKE_NTM7

FILEO MATO[7] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB6.MAT",
    MO=376-386,796-806,701-711,DEC=33*S, 
        NAME=DA_CWM6,SR2_CWM6,SR3_CWM6,WBUS_CWM6,WPRJ_CWM6,PBUS_CWM6,PPRJ_CWM6,KBUS_CWM6,KPRJ_CWM6,WALK_CWM6,BIKE_CWM6,
        DA_MDM6,SR2_MDM6,SR3MD_M6,WBUS_MDM6,WPRJ_MDM6,PBUS_MDM6,PPRJ_MDM6,KBUS_MDM6,KPRJ_MDM6,WALK_MDM6,BIKE_MDM6,
        DA_NTM6,SR2_NTM6,SR3_NTM6,WBUS_NTM6,WPRJ_NTM6,PBUS_NTM6,PPRJ_NTM6,KBUS_NTM6,KPRJ_NTM6,WALK_NTM6,BIKE_NTM6

FILEO MATO[6] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB5.MAT",
    MO=365-375,785-795,681-691,DEC=33*S, 
        NAME=DA_CWM5,SR2_CWM5,SR3_CWM5,WBUS_CWM5,WPRJ_CWM5,PBUS_CWM5,PPRJ_CWM5,KBUS_CWM5,KPRJ_CWM5,WALK_CWM5,BIKE_CWM5,
        DA_MDM5,SR2_MDM5,SR3MD_M5,WBUS_MDM5,WPRJ_MDM5,PBUS_MDM5,PPRJ_MDM5,KBUS_MDM5,KPRJ_MDM5,WALK_MDM5,BIKE_MDM5,
        DA_NTM5,SR2_NTM5,SR3_NTM5,WBUS_NTM5,WPRJ_NTM5,PBUS_NTM5,PPRJ_NTM5,KBUS_NTM5,KPRJ_NTM5,WALK_NTM5,BIKE_NTM5
  
FILEO MATO[5] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB4.MAT",
    MO=354-364,774-784,661-671,DEC=33*S, 
        NAME=DA_CWM4,SR2_CWM4,SR3_CWM4,WBUS_CWM4,WPRJ_CWM4,PBUS_CWM4,PPRJ_CWM4,KBUS_CWM4,KPRJ_CWM4,WALK_CWM4,BIKE_CWM4,
        DA_MDM4,SR2_MDM4,SR3MD_M4,WBUS_MDM4,WPRJ_MDM4,PBUS_MDM4,PPRJ_MDM4,KBUS_MDM4,KPRJ_MDM4,WALK_MDM4,BIKE_MDM4,
        DA_NTM4,SR2_NTM4,SR3_NTM4,WBUS_NTM4,WPRJ_NTM4,PBUS_NTM4,PPRJ_NTM4,KBUS_NTM4,KPRJ_NTM4,WALK_NTM4,BIKE_NTM4
  
FILEO MATO[4] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB3.MAT",
    MO=343-353,763-773,641-651,DEC=33*S, 
        NAME=DA_CWM3,SR2_CWM3,SR3_CWM3,WBUS_CWM3,WPRJ_CWM3,PBUS_CWM3,PPRJ_CWM3,KBUS_CWM3,KPRJ_CWM3,WALK_CWM3,BIKE_CWM3,
        DA_MDM3,SR2_MDM3,SR3MD_M3,WBUS_MDM3,WPRJ_MDM3,PBUS_MDM3,PPRJ_MDM3,KBUS_MDM3,KPRJ_MDM3,WALK_MDM3,BIKE_MDM3,
        DA_NTM3,SR2_NTM3,SR3_NTM3,WBUS_NTM3,WPRJ_NTM3,PBUS_NTM3,PPRJ_NTM3,KBUS_NTM3,KPRJ_NTM3,WALK_NTM3,BIKE_NTM3
  
FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB2.MAT",
    MO=332-342,752-762,621-631,DEC=33*S, 
        NAME=DA_CWM2,SR2_CWM2,SR3_CWM2,WBUS_CWM2,WPRJ_CWM2,PBUS_CWM2,PPRJ_CWM2,KBUS_CWM2,KPRJ_CWM2,WALK_CWM2,BIKE_CWM2,
        DA_MDM2,SR2_MDM2,SR3MD_M2,WBUS_MDM2,WPRJ_MDM2,PBUS_MDM2,PPRJ_MDM2,KBUS_MDM2,KPRJ_MDM2,WALK_MDM2,BIKE_MDM2,
        DA_NTM2,SR2_NTM2,SR3_NTM2,WBUS_NTM2,WPRJ_NTM2,PBUS_NTM2,PPRJ_NTM2,KBUS_NTM2,KPRJ_NTM2,WALK_NTM2,BIKE_NTM2
  
FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@@PERIOD@_MCPRB1.MAT",
    MO=321-331,741-751,601-611,DEC=33*S, 
        NAME=DA_CWM1,SR2_CWM1,SR3_CWM1,WBUS_CWM1,WPRJ_CWM1,PBUS_CWM1,PPRJ_CWM1,KBUS_CWM1,KPRJ_CWM1,WALK_CWM1,BIKE_CWM1,
        DA_MDM1,SR2_MDM1,SR3MD_M1,WBUS_MDM1,WPRJ_MDM1,PBUS_MDM1,PPRJ_MDM1,KBUS_MDM1,KPRJ_MDM1,WALK_MDM1,BIKE_MDM1,
        DA_NTM1,SR2_NTM1,SR3_NTM1,WBUS_NTM1,WPRJ_NTM1,PBUS_NTM1,PPRJ_NTM1,KBUS_NTM1,KPRJ_NTM1,WALK_NTM1,BIKE_NTM1
  
FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\@PURP@@PERIOD@_MCLS_{ALT}{Year}.MAT",
    MO=291-297,DEC=7*S,
        NAME=LSUM_M1,LSUM_M2,LSUM_M3,LSUM_M4,LSUM_M5,LSUM_M6,LSUM_M7

FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSum.TXT",
    append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebug.TXT",
    append=t

 
zonemsg=10
ARRAY PARK={ZONESA}
ARRAY TYPE=F K_AUT=7, K_SR=7, K_SR3=7, K_TRN=7, K_TDRV=7, K_TKNR=7, K_NMOT=7, K_BIKE=7
ARRAY TYPE=C30 MARKET_NAME=7

DistributeINTRASTEP ProcessID="TMUDemoDist", ProcessList=1-%NUMBER_OF_PROCESSORS%

;Coefficients
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=2

;Constants
LOOKUP, NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, , LIST=Y, LOOKUPI=1

; Market stratification for all trip purposes except student trips is based on Car Sufficiency.
; Market stratification for student trips (HBCU & HBSC) is based on Household Size.

IF (i=FirstZone)

;   Index _m identifies the market segment, as follows:

;               All HB purposes except school                 HBCU and HBSC
;               ---------------------------------------------------------------
;      _m = 1      zero-car households                         1  person hhld
;      _m = 2      low income, car insufficient hhlds          2  person hhld
;      _m = 3      medium income, car insufficient hhlds       3  person hhld
;      _m = 4      high income, car sufficient hhlds           4+ person hhld
;      _m = 5      low income, car sufficient hhlds
;      _m = 6      medium income, car sufficient hhlds
;      _m = 7      high income, car sufficient hhlds

    LOOP _m=1,7
    
  ; Household market stratified constants
  
    K_AUT[_m]  = CONSTANTS(1,(_m-1)*10+1)            ; auto 
    K_SR[_m]   = CONSTANTS(1,(_m-1)*10+2)            ; shared-ride 2 & 3+
    K_SR3[_m]  = CONSTANTS(1,(_m-1)*10+3)            ; shared ride 3+
    K_TRN[_m]  = CONSTANTS(1,(_m-1)*10+4)            ; transit
    K_TDRV[_m] = CONSTANTS(1,(_m-1)*10+5)            ; drive to transit
    K_TKNR[_m] = CONSTANTS(1,(_m-1)*10+6)            ; knr to transit
    K_NMOT[_m] = CONSTANTS(1,(_m-1)*10+7)            ; non-motorized (walk & bike)
    K_BIKE[_m] = CONSTANTS(1,(_m-1)*10+8)            ; bike
   
   ENDLOOP

;  MARKETS=@MARKETS@
  MARKET_NAME[1] = '@Mkt1_Name@'
  MARKET_NAME[2] = '@Mkt2_Name@'
  MARKET_NAME[3] = '@Mkt3_Name@'
  MARKET_NAME[4] = '@Mkt4_Name@'
  MARKET_NAME[5] = '@Mkt5_Name@'
  MARKET_NAME[6] = '@Mkt6_Name@'
  MARKET_NAME[7] = '@Mkt7_Name@'
  
; Mode-specific constants -- same for all hhld markets

   K_EXP = CONSTANTS(1,71)                        ; premium bus
   K_BRT = CONSTANTS(1,72)                        ; brt
   K_UR  = CONSTANTS(1,73)                        ; urban rail
   K_CR  = CONSTANTS(1,74)                        ; commuter rail
                                        
; Nesting coefficients
   NC_1        = COEFF(1,10)                          ; Level 1 - auto, trn, non-mot
   NC_2        = COEFF(1,11)                          ; Level 2 - transit access mode choice
   NCP = NC_1 * NC_2

; Level of Service Coefficients
   COEFF_IVTT   = COEFF(1,1) 
   COEFF_OVT    = COEFF(1,3) 
   COEFF_AAT    = COEFF(1,5) 
   COEFF_XFER   = COEFF(1,6) 
   COEFF_DCBD   = COEFF(1,7) 
   COEFF_DEXUP  = COEFF(1,8) 
   COEFF_DEXUA  = COEFF(1,9) 

   COEFF_DCBD_WALK = COEFF(1,15) 
   COEFF_DCBD_PNR  = COEFF(1,16) 
   COEFF_DCBD_KNR  = COEFF(1,17) 

 
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


FILLMW MW[1]=MI.1.1,2,3,4,5,6,7,8 ;,9        ; highway skims
FILLMW MW[11]=MI.11.HOVsave@PERIOD@          ; HOVsavePK for peak period and HOVsaveOP for off-peak period 
FILLMW MW[291]=MI.12.@STATION_TABLE@         ; 8 tables - PKStationTAZ_pnrb,PKParkCost_pnrb,termtimpnr,termtimknr,OPStationTAZ_pnrb,OPParkCost_pnrb,termtimpnr,termtimknr

FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ; tskim1 -- walk to local bus
FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ; tskim2 -- walk to project bus
FILLMW MW[61]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ; tskim3 -- drive to local bus
FILLMW MW[81]=MI.5.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ; tskim4 -- drive to project bus


; Distance for the walk and bike modes

;  distance portion that is 1 mile or less
MW[12] = MIN(MW[2],1)

; distance portion that is longer than 1 mile
JLOOP
    IF (MW[2][J] > 1)
      MW[13] = MW[2][J] - 1
  ELSE
      MW[13] = 0
  ENDIF
ENDJLOOP


IF (I=1)  ; Write mode choice summary file
    ; DEBUG MODE CHOICE
    IF ({DebugMC}>0)
    
   print list='MODE CHOICE TRACE @PURP@-@PERIOD@','\n\n',printo=1
   print list='-- @DATE.RUNDATE@     ',printo=1
   print list='-- @TIME.RUNTIME@     ','\n\n',printo=1
   print list='Transit Modeling Update DEMO \n\nSelected Interchange for Tracing:    ',{SelOrigin}(4.0),'-',{SelDest}(4.0),'\n\n',printo=1
   print list='PURPOSE -                   @PURP@  ',printo=1
   print list='SKIMS/PERIOD                @PERIOD@',printo=1
   
   print list='\n\nCoefficients                ',printo=1
   print list='       IVTT                                 ',COEFF_IVTT(7.4),printo=1
   print list='       OVT                                  ',COEFF_OVT(7.4),printo=1
   print list='       AAT                                  ',COEFF_AAT(7.4),printo=1
   print list='       XFER                                 ',COEFF_XFER(7.4),printo=1
   print list='       COST ', MARKET_NAME[1],'  ',COEFF_COST[1](7.4),printo=1
   print list='       COST ', MARKET_NAME[2],'  ',COEFF_COST[2](7.4),printo=1
   print list='       COST ', MARKET_NAME[3],'  ',COEFF_COST[3](7.4),printo=1
   print list='       COST ', MARKET_NAME[4],'  ',COEFF_COST[4](7.4),printo=1
   print list='       COST ', MARKET_NAME[5],'  ',COEFF_COST[5](7.4),printo=1
   print list='       COST ', MARKET_NAME[6],'  ',COEFF_COST[6](7.4),printo=1
   print list='       COST ', MARKET_NAME[7],'  ',COEFF_COST[7](7.4),printo=1
   PRINT LIST='       DUM_CBD_WALK                         ',COEFF_DCBD_WALK(7.4),printo=1
   PRINT LIST='       DUM_CBD_PNR                          ',COEFF_DCBD_PNR(7.4),printo=1
   PRINT LIST='       DUM_CBD_KNR                          ',COEFF_DCBD_KNR(7.4),printo=1
   
   print list='\n\nNesting Coefficients      ',printo=1
   print list='       Level 1 (pmode)                      ',NC_1(7.4),printo=1
   print list='       Level 2 (trn access)                 ',NC_2(7.4),printo=1
   
  LOOP _m=1,@MARKETS@
   print list='\n\nConstants ', MARKET_NAME[_m],printo=1
   print list='       Auto                                ',K_AUT[_m](8.4),printo=1
   print list='       Shared Ride                         ',K_SR[_m](8.4),printo=1
   print list='       Shared Ride 3+                      ',K_SR3[_m](8.4),printo=1
   print list='       Transit                             ',K_TRN[_m](8.4),printo=1
   print list='       Drive to Transit                    ',K_TDRV[_m](8.4),printo=1
   print list='       KNR to Transit                      ',K_TKNR[_m](8.4),printo=1
   print list='       Non Motorized                       ',K_NMOT[_m](8.4),printo=1
   print list='       Bike                                ',K_BIKE[_m](8.4),printo=1
  ENDLOOP
  
   print list='\n\nConstants (mode-specific)           ',printo=1
   print list='       Express bus                         ',K_EXP(8.4),printo=1
   print list='       Urban rail                          ',K_UR(8.4),printo=1
   print list='       Commuter rail                       ',K_CR(8.4),printo=1

   print list='\n\nParameters used in utility calculations:            ', printo=1
   print list='       Highway Operating Cost (cents/mi)      ',{hwyopcost}(5.3),printo=1
   print list='       CTOLL Multiplier (toll to time)        ',{CTOLL}(5.3),printo=1
   print list='       Value of ZAPZERO                       ',{ZAPZERO}(5.3),printo=1
   print list='       Auto Occupancy 3+ (HBW)                ',{oc3vhbw}(5.3),printo=1
   print list='       Auto Occupancy 3+ (HBNW)               ',{oc3vhbnw}(5.3),printo=1
   print list='       Inflation factor - Tolls               ',{InflationToll}(5.3),printo=1
   print list='       Inflation factor - Auto Op Cost        ',{InflationAOC}(5.3),printo=1
   print list='       Inflation factor - Parking Cost        ',{InflationParkCost}(5.3),printo=1
   print list='       Inflation factor - Transit Fare        ',{InflationFare}(5.3),printo=1
   print list='       Auto Access Auto Occupancy Factor      ',{OCCPNRAccess}(5.3),printo=1
   print list='       Times are in minutes. Costs are in cents. ',printo=1
   
ENDIF    ; DEBUG MODE CHOICE


    ; Echo to Mode Choice summary file
   PRINT LIST="\f+++++++++ MODE XCHOICE SUMMARY +++++++++\n" PRINTO=2
   PRINT LIST='-- @DATE.RUNDATE@     ','-- @TIME.RUNTIME@     ','\n',PRINTO=2
   PRINT LIST="{SCENARIO_FULLNAME}" PRINTO=2
   PRINT LIST="{SCENARIO_SHORTNAME}\n" PRINTO=2
   PRINT LIST='PURPOSE -           @PURP@  ',printo=2
   PRINT LIST='SKIMS/PERIOD        @PERIOD@',printo=2
   PRINT LIST='\n\nCoefficients                ',printo=2
   PRINT LIST='       IVTT                                        ',COEFF_IVTT(7.4),printo=2
   PRINT LIST='       OVT                                         ',COEFF_OVT(7.4),printo=2
   PRINT LIST='       AAT                                         ',COEFF_AAT(7.4),printo=2
   PRINT LIST='       XFER                                        ',COEFF_XFER(7.4),printo=2
   print list='       COST ', MARKET_NAME[1],'  ',COEFF_COST[1](7.4),printo=2
   print list='       COST ', MARKET_NAME[2],'  ',COEFF_COST[2](7.4),printo=2
   print list='       COST ', MARKET_NAME[3],'  ',COEFF_COST[3](7.4),printo=2
   print list='       COST ', MARKET_NAME[4],'  ',COEFF_COST[4](7.4),printo=2
   print list='       COST ', MARKET_NAME[5],'  ',COEFF_COST[5](7.4),printo=2
   print list='       COST ', MARKET_NAME[6],'  ',COEFF_COST[6](7.4),printo=2
   print list='       COST ', MARKET_NAME[7],'  ',COEFF_COST[7](7.4),printo=2
   PRINT LIST='       DUM_CBD_WALK                                ',COEFF_DCBD_WALK(7.4),printo=2
   PRINT LIST='       DUM_CBD_PNR                                 ',COEFF_DCBD_PNR(7.4),printo=2
   PRINT LIST='       DUM_CBD_KNR                                 ',COEFF_DCBD_KNR(7.4),printo=2

   print list='\n\nNesting Coeffcients     ',printo=2
   print list='       Level 1 (pmode)                             ',NC_1(7.4),printo=2
   print list='       Level 2 (trn access)                        ',NC_2(7.4),printo=2
   
  LOOP _m=1,@MARKETS@
   print list='\n\nConstants ', MARKET_NAME[_m],printo=2
   print list='       Auto                                     ',K_AUT[_m](8.4),printo=2
   print list='       Shared Ride                              ',K_SR[_m](8.4),printo=2
   print list='       Shared Ride 3+                           ',K_SR3[_m](8.4),printo=2
   print list='       Transit                                  ',K_TRN[_m](8.4),printo=2
   print list='       Drive to Transit                         ',K_TDRV[_m](8.4),printo=2
   print list='       KNR to Transit                           ',K_TKNR[_m](8.4),printo=2
   print list='       Non Motorized                            ',K_NMOT[_m](8.4),printo=2
   print list='       Bike                                     ',K_BIKE[_m](8.4),printo=2
  ENDLOOP
  
   print list='\n\nConstants (mode-specific)           ',printo=2
   print list='       Express bus                              ',K_EXP(8.4),printo=2
   print list='       Urban rail                               ',K_UR(8.4),printo=2
   print list='       Commuter rail                            ',K_CR(8.4),printo=2
  
   PRINT LIST='\n\nParameters used in utility calculations:            ', printo=2
   PRINT LIST='       Highway Operating Cost (cents/mi)           ',{hwyopcost}(5.3),printo=2
   PRINT LIST='       CTOLL Multiplier (toll to time)             ',{CTOLL}(5.3),printo=2
   PRINT LIST='       Value of ZAPZERO                            ',{ZAPZERO}(5.3),printo=2
   PRINT LIST='       Auto Occupancy 3+ (HBNW)                    ',{oc3vhbnw}(5.3),printo=2
   PRINT LIST='       Auto Occupancy 3+ (NHB)                     ',{oc3vnhb}(5.3),printo=2
   PRINT LIST='       Inflation factor - Tolls                    ',{InflationToll}(5.3),printo=2
   PRINT LIST='       Inflation factor - Auto Op Cost             ',{InflationAOC}(5.3),printo=2
   PRINT LIST='       Inflation factor - Parking Cost             ',{InflationParkCost}(5.3),printo=2
   PRINT LIST='       Inflation factor - Transit Fare             ',{InflationFare}(5.3),printo=2
   PRINT LIST='       Auto Access Auto Occupancy Factor           ',{OCCPNRAccess}(5.3),printo=2
   PRINT LIST='       Times are in minutes.                       ',printo=2
   PRINT LIST='       Costs are in cents.                         ',printo=2
    
ENDIF    ; Write mode choice summary file

;JLOOP  ; highway skim checks - reset no access skim values (9999.00) to zero
;   IF (MW[1]>=9999.00) MW[1]=0
;   IF (MW[2]>=9999.00) MW[2]=0
;   IF (MW[3]>=9999.00) MW[3]=0
;   IF (MW[4]>=9999.00) MW[4]=0
;   IF (MW[5]>=9999.00) MW[5]=0
;   IF (MW[6]>=9999.00) MW[6]=0
;   IF (MW[7]>=9999.00) MW[7]=0
;   IF (MW[8]>=9999.00) MW[8]=0
;ENDJLOOP

;IF(I==20) EXIT     ; temp -- debugging only

LOOP ACC=1,3

; ===================================================================================
; @PURP@ (@PERIOD@) TRIP PURPOSE
; ===================================================================================

; (1) Terminal Time (both at production-end and attraction-end)
; (2) Auto run time
; (3) highway operating cost
; (4) Toll (assumed in $)
; (5) Parking cost
; (6) CBD/EXURBAN dummy variables
; (7) Transit fare
; (8) Out-of vehicle time (walk/transfer time/wait)
;
; (9) Walking time
; (10) Biking time


; These terms were used to unallow transit choices based on the walk market segment;
; they have been replaced by mode availability checks

;IF (ACC==1) then
;    ACC_NAME='CAN WALK TO TRANSIT'
;    walk_acc_dum = 0.0            ; added to the utility
;    auto_acc_dum = 0.0            ; added to the utility
; ELSEIF (ACC==2)
;    ACC_NAME='MUST DRIVE TO TRANSIT'
;    walk_acc_dum = -9999.99
;    auto_acc_dum = 0.0
;ELSEIF (ACC==3)
;    ACC_NAME='NO TRANSIT'
;    walk_acc_dum = -9999.99
;    auto_acc_dum = -9999.99
;ENDIF


; ************************** COMMON UTILITY CALCULATIONS ************************************
; Computes utility that is common across all household market segments

  ;   DRIVE ALONE ELEMENTS OF UTILITY ARE:
      MW[301]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
               COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[1] * {CTOLL} * 60))) +               ; IVTT
@isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

  ;   SHARED RIDE PERSONS/SHARE RIDE - ONE PASSENGER ELEMENTS OF UTILITY ARE:
      MW[302]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
               COEFF_IVTT * (MW[8] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) -               ; IVTT
               COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
@isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

  ;   SHARED RIDE - 2+ PASSENGER ELEMENTS OF UTILITY ARE:
      MW[303]=(COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                               ; Terminal time
               COEFF_IVTT * (MW[8] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) -               ; IVTT
               COEFF_IVTT * (MAX (MW[11], 0)) +                                                  ; HOV time savings
@isNHB@        COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

 ;   WALK ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[304]=(COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time
               COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
               COEFF_IVTT * (MW[24] + MW[25] + MW[26] + MW[27] + MW[28] + MW[29] + MW[30]) +     ; IVTT
               COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
@isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

  ;   WALK ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[305]=(COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
               COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
               COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[48] + MW[49] + MW[50]) +     ; IVTT
               COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
@isNHB@        COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy
       
 ;   PNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[306]=(COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
               COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
               COEFF_IVTT * (MW[62]) +                                                           ; Auto access time
               COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70]) +     ; IVTT
               COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
@isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J] ) / NCP                                           ; Exurban attraction dummy

;   PNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[307]=(COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
               COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
               COEFF_IVTT * (MW[82]) +                                                           ; Auto access time
               COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[88] + MW[89] + MW[90]) +     ; IVTT
               COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
@isNHB@        COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy
       
  ;   KNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[308]=(COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
               COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
               COEFF_IVTT * (MW[62]-({InflationFare}*(COEFF(1,23)/COEFF(1,1))*MW[291])+(COEFF(1,3)/COEFF(1,1))*(-mw[292]+mw[293])) +                                 ; Auto access time
               COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70]) +     ; IVTT
               COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
@isNHB@        COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy

  ;   KNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[309]=(COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
               COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
               COEFF_IVTT * (MW[82]-({InflationFare}*(COEFF(1,23)/COEFF(1,1))*MW[295])+(COEFF(1,3)/COEFF(1,1))*(-mw[296]+mw[297])) +                                  ; Auto access time
               COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[88] + MW[89] + MW[90]) +     ; IVTT
               COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
@isNHB@        COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@        COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
               COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
               COEFF_DEXUA * ZI.1.EXU_DUMMY[J]) / NCP                                            ; Exurban attraction dummy
       
 ;    WALK MODE ELEMENTS OF UTILITY ARE:
      MW[310]=(COEFF_IVTT * 2 * (60/3) * MW[12] +                                                ; walking time if less than 1 mile
               COEFF_IVTT * 3 * (60/3) * MW[13]) / NCP                                           ; walking time if more than 1 mile
       
 ;    BIKE MODE ELEMENTS OF UTILITY ARE
      MW[311]=(COEFF_IVTT * 2 * (60/10) * MW[12] +                                               ; biking time if less than 1 mile
               COEFF_IVTT * 3 * (60/10) * MW[13]) / NCP                                          ; biking time if more than 1 mile
 

;************************** END COMMON UTILITY CALCULATIONS ************************************

;**********************  ADD HOUSEHOLD MARKET SPECIFIC TERMS **********************************
;                              Cost utility and constants

LOOP _m=1,@MARKETS@

  ; Drive alone
  MW[401+20*(_m-1)] = MW[301] + (0                +                                                  ; Constant(s)
                        COEFF_COST[_m] * {InflationToll} * MW[1]        +                            ; Toll
@noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +     ; Auto parking cost
@isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +     ; Auto parking cost (NHB)
                        COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost
  ; Shared Ride 2-person
 MW[402+20*(_m-1)] = MW[302] + (K_SR[_m]       +                                                    ; Constant(s)
                        COEFF_COST[_m] * ({InflationToll} * MW[5] / 2.0) +                           ; Toll
@noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 2.0) +     ; Auto parking cost
@isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 1.0) +     ; Auto parking cost (NHB)
                        COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost (not shared among occupants)
 
  ; Shared Ride 3+ person 
  MW[403+20*(_m-1)] = MW[303] + (K_SR[_m] + K_SR3[_m] +                                              ; Constant(s)
                        COEFF_COST[_m] * ({InflationToll} * MW[5] / @OCC3@) +                        ; Toll
@noNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 2.0) +  ; Auto parking cost
@isNHB@                 COEFF_COST[_m] * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 1.0) +  ; Auto parking cost (NHB)
                        COEFF_COST[_m] * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) ) / NCP      ; Auto operating cost (not shared among occupants)

  ; Walk to Local Bus       
 MW[404+20*(_m-1)] = MW[304] + (K_TRN[_m]      +                                                    ; Constant(s)
                        COEFF_COST[_m] * {InflationFare} * (MW[34]) ) / NCP                          ; Transit fare
 
  ; Walk to Project
  MW[405+20*(_m-1)] = MW[305] + (K_TRN[_m] + K_EXP  +                                                ; Constant(s)
                        COEFF_COST[_m] * {InflationFare} * (MW[54]) ) / NCP                          ; Transit fare

  ; PNR to Local Bus
 MW[406+20*(_m-1)] = MW[306] + (K_TRN[_m] + K_TDRV[_m] +                                            ; Constant(s)
@isNHB@         COEFF_COST[_m] * ((({InflationFare}*MW[291])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                        COEFF_COST[_m] * {InflationFare} * (MW[74])  ) / NCP                         ; Transit fare
  
 ; PNR to Project
 MW[407+20*(_m-1)] = MW[307] + (K_TRN[_m] + K_TDRV[_m] + K_EXP +                                    ; Constant(s)
@isNHB@                 COEFF_COST[_m] * ((({InflationFARE}*MW[295])/{OCCPNRAccess})/2.0) +          ; add in other half of NHB PNR parking cost
                        COEFF_COST[_m] * {InflationFare} * (MW[94]) ) / NCP                          ; Transit fare
 
 ; KNR to Local Bus
 MW[408+20*(_m-1)] = MW[308] + (K_TRN[_m] + K_TDRV[_m] + K_TKNR[_m] +                               ; Constant(s)
                        COEFF_COST[_m] * {InflationFare} * (MW[74]) ) / NCP                          ; Transit fare
 
  ; KNR to Project Bus
 MW[409+20*(_m-1)] = MW[309] + (K_TRN[_m] + K_TDRV[_m] + K_TKNR[_m] + K_EXP +                       ; Constant(s)
              COEFF_COST[_m] * {InflationFare} * (MW[94]) ) / NCP                          ; Transit fare
 
  ; Walk
 MW[410+20*(_m-1)] = MW[310] + (K_NMOT[_m])/NCP                                                     ; Constant(s)
 
 ; Bike
 MW[411+20*(_m-1)] = MW[311] + (K_NMOT[_m] + K_BIKE[_m])/NCP                                        ; Constant(s)
 
ENDLOOP


;***************************    MODE AVAILABILITY CHECKS    ************************************

;  Drive alone and PNR to transit not available to zero car households

  IF (@Mkt1_0car@=1)
   MW[401] = -9999.99
   MW[406] = -9999.99
   MW[407] = -9999.99
  ENDIF

 LOOP _m=1,@MARKETS@

    JLOOP

; Transit not available if no line-haul in-vehicle time on the transit path

    ; Walk to local bus
      IF ((MW[24] + MW[26]) == 0)  MW[404+20*(_m-1)]=-9999.99

   ; Walk to project
     IF ((MW[45] + MW[47] + MW[48] + MW[49] + MW[50]) == 0)  MW[405+20*(_m-1)]=-9999.99
   
    ; PNR to local bus
     IF ((MW[64] + MW[66]) == 0)  MW[406+20*(_m-1)]=-9999.99
    
    ; PNR to project
      IF ((MW[85] + MW[87] + MW[88] + MW[89] + MW[90]) == 0)  MW[407+20*(_m-1)]=-9999.99
    
   ; KNR to local bus
     IF ((MW[64] + MW[66]) == 0) MW[408+20*(_m-1)]=-9999.99
   
    ; KNR to project
      IF ((MW[85] + MW[87] + MW[88] + MW[89] + MW[90]) == 0)  MW[409+20*(_m-1)]=-9999.99

 
;  If walk access distance less than minimum, no walk access to transit

      IF (MW[2] < {MinDistWalkAcc})
          MW[404+20*(_m-1)]=-9999.99
          MW[405+20*(_m-1)]=-9999.99
      ENDIF

;  If drive access distance less than minimum, no drive access to transit

      IF (MW[2] < {MinDistAutoAcc})
          MW[406+20*(_m-1)]=-9999.99
          MW[407+20*(_m-1)]=-9999.99
          MW[408+20*(_m-1)]=-9999.99
          MW[409+20*(_m-1)]=-9999.99
      ENDIF

; Walk to transit not available for the MD or NT access markets;

      IF(ACC==2 || ACC==3)
      MW[404+20*(_m-1)]=-9999.99
     MW[405+20*(_m-1)]=-9999.99
   ENDIF

; Transit not available for NT access markets;

      IF(ACC==3)
          MW[406+20*(_m-1)]=-9999.99
          MW[407+20*(_m-1)]=-9999.99
          MW[408+20*(_m-1)]=-9999.99
          MW[409+20*(_m-1)]=-9999.99
   ENDIF
   
   ENDJLOOP 

 ENDLOOP    ; end market segment loop to set mode availability
    
   
 JLOOP
 if (ACC=1-3)
   IF (ACC==1) then
      ACC_NAME='CAN WALK TO TRANSIT'
   ELSEIF (ACC==2)
      ACC_NAME='MUST DRIVE TO TRANSIT'
   ELSEIF (ACC==3)
      ACC_NAME='NO TRANSIT'
   ENDIF

  if (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
   print list='\n\n********************************************************************************************', printo=1
   print list=' Access Type: ',ACC(1.0),'. ',ACC_NAME, printo=1
   print list='********************************************************************************************','\n' printo=1
   print list='\n\nPercent walk at Production zone               ',(ZI.1.PCWPRD@PERIOD@[I] * 0.01),printo=1
   print list='Percent walk at Attraction zone               ',(ZI.1.PCWPRD@PERIOD@[J] * 0.01),printo=1
   print list='Value of CBD dummy at attraction end (1 or 0)                                      ',ZI.1.CBD_DUMMY[J],printo=1
   print list='Value of EXURBAN dummy at production end (1 or 0)                                  ',ZI.1.EXU_DUMMY[I],printo=1
   print list='Value of EXURBAN dummy at attraction end (1 or 0)                                  ',ZI.1.EXU_DUMMY[J],printo=1
   
   print list='\n\n\nElements used in Drive Alone disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                                    ',MW[3][J],printo=1
   print list='In-Vehicle time including time equivalent cost of tolls                            ',MW[4][J],printo=1
   print list='Out of Vehicle time (Terminal time at production-end)                              ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)                              ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                                       ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                                        ',MW[2][J],printo=1
   print list='Highway Toll (in $)                                                                ',MW[1][J],printo=1
   print list='Drive alone common disutility, scaled                                            ',MW[301][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[1], '                 ',MW[401][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[2], '                 ',MW[421][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[3], '                 ',MW[441][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[4], '                 ',MW[461][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[5], '                 ',MW[481][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[6], '                 ',MW[501][J](12.4),printo=1
   print list='Drive alone composite disutility, ', Market_Name[7], '                 ',MW[521][J](12.4),printo=1
   
   print list='\n\n\nElements used in Shared Ride 2 disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                                    ',MW[7][J],printo=1
   print list='In-Vehicle time including time equivalent cost of tolls                            ',MW[8][J],printo=1
   print list='In-Vehicle time savings by using HOV lanes                                         ',MAX((MW[7][J]-MW[3][J]), 0),printo=1
   print list='Out of Vehicle time (Terminal time at production-end)                              ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)                              ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                                       ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                                        ',MW[6][J],printo=1
   print list='Highway Toll (in $)                                                                ',MW[5][J],printo=1
   print list='Shared ride 2 common disutility, scaled                                          ',MW[302][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[1], '               ',MW[402][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[2], '               ',MW[422][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[3], '               ',MW[442][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[4], '               ',MW[462][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[5], '               ',MW[482][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[6], '               ',MW[502][J](12.4),printo=1
   print list='Shared ride 2 composite disutility, ', Market_Name[7], '               ',MW[522][J](12.4),printo=1

   print list='\n\n\nElements used in Shared Ride 3+ disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                                    ',MW[7][J],printo=1
   print list='In-Vehicle time including time equivalent cost of tolls                            ',MW[8][J],printo=1
   print list='In-Vehicle time savings by using HOV lanes                                         ',MAX((MW[7][J]-MW[3][J]), 0),printo=1
   print list='Out of Vehicle time (Terminal time at production-end)                              ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)                              ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                                       ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                                        ',MW[6][J],printo=1
   print list='Occupancy rate for 2+ car market                                                   ',@OCC3@,printo=1
   print list='Highway Toll (in $)                                                                ',MW[5][J],printo=1
   print list='Shared ride 2+ common disutility, scaled                                         ',MW[303][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[1], '              ',MW[403][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[2], '              ',MW[423][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[3], '              ',MW[443][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[4], '              ',MW[463][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[5], '              ',MW[483][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[6], '              ',MW[503][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility, ', Market_Name[7], '              ',MW[523][J](12.4),printo=1

   print list='\n\n\nElements used in Walk Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                                              ',MW[24][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                                          ',MW[25][J],printo=1
   print list='In-Vehicle time (Circulator)                                                       ',MW[26][J],printo=1
   print list='In-Vehicle time (Rail)                                                             ',(MW[27][J]+MW[28][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                                     ',MW[30][J],printo=1
   print list='Out of Vehicle time (Walk)                                                         ',MW[21][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                                                ',MW[23][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                                        ',MW[32][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                                        ',MW[33][J],printo=1
   print list='Number of transfers                                                                ',MW[31][J],printo=1
   print list='Transit Fare (in cents)                                                            ',MW[34][J],printo=1
   print list='Walk Bus common disutility, scaled                                               ',MW[304][J](12.4),printo=1
   ;print list='Walk access dummy (added to the utility)                                           ',walk_acc_dum,printo=1
   print list='Walk Bus composite disutility, ', Market_Name[1], '                    ',MW[404][J](12.4),printo=1
   print list='Walk Bus composite disutility, ', Market_Name[2], '                    ',MW[424][J](12.4),printo=1
   print list='Walk Bus composite disutility, ', Market_Name[3], '                    ',MW[444][J](12.4),printo=1
   print list='Walk Bus composite disutility, ', Market_Name[4], '                    ',MW[464][J](12.4),printo=1
   print list='Walk Bus composite disutility, ', Market_Name[5], '                    ',MW[484][J](12.4),printo=1
   print list='Walk Bus composite disutility, ', Market_Name[6], '                    ',MW[504][J](12.4),printo=1
   print list='Walk Bus composite disutility, ', Market_Name[7], '                    ',MW[524][J](12.4),printo=1

   print list='\n\n\nElements used in Walk Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                                              ',MW[44][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                                          ',MW[45][J],printo=1
   print list='In-Vehicle time (Circulator)                                                       ',MW[46][J],printo=1
   print list='In-Vehicle time (Rail)                                                             ',(MW[47][J]+MW[48][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                                     ',MW[50][J],printo=1
   print list='Out of Vehicle time (Walk)                                                         ',MW[41][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                                                ',MW[43][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                                        ',MW[52][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                                        ',MW[53][J],printo=1
   print list='Number of transfers                                                                ',MW[51][J],printo=1
   print list='Transit Fare (in cents)                                                            ',MW[54][J],printo=1
   print list='Walk Prj common disutility, scaled                                               ',MW[305][J](12.4),printo=1
   ;print list='Walk access dummy (added to the utility)                                           ',walk_acc_dum,printo=1
   print list='Walk Prj composite disutility, ', Market_Name[1], '                    ',MW[405][J](12.4),printo=1
   print list='Walk Prj composite disutility, ', Market_Name[2], '                    ',MW[525][J](12.4),printo=1
   print list='Walk Prj composite disutility, ', Market_Name[3], '                    ',MW[445][J](12.4),printo=1
   print list='Walk Prj composite disutility, ', Market_Name[4], '                    ',MW[465][J](12.4),printo=1
   print list='Walk Prj composite disutility, ', Market_Name[5], '                    ',MW[485][J](12.4),printo=1
   print list='Walk Prj composite disutility, ', Market_Name[6], '                    ',MW[505][J](12.4),printo=1
   print list='Walk Prj composite disutility, ', Market_Name[7], '                    ',MW[525][J](12.4),printo=1
  
   print list='\n\n\nElements used in PNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                                              ',MW[64][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                                          ',MW[65][J],printo=1
   print list='In-Vehicle time (Circulator)                                                       ',MW[66][J],printo=1
   print list='In-Vehicle time (Rail)                                                             ',(MW[67][J]+MW[68][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                                     ',MW[70][J],printo=1
   print list='Out of Vehicle time (Walk)                                                         ',MW[61][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min - weighted)                       ',MW[62][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                                                ',MW[63][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                                        ',MW[72][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                                        ',MW[73][J],printo=1
   print list='Number of transfers                                                                ',MW[71][J],printo=1
   print list='Transit Fare (in cents)                                                            ',MW[74][J],printo=1
   print list='Parking cost at PNR location (in cents)                                            ',MW[291][J],printo=1
   print list='Terminal time at PNR location                                                      ',MW[292][J],printo=1
   print list='PNR Bus common disutility, scaled                                                ',MW[306][J](12.4),printo=1
   ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1
   print list='PNR Bus composite disutility, ', Market_Name[1], '                     ',MW[406][J](12.4),printo=1
   print list='PNR Bus composite disutility, ', Market_Name[2], '                     ',MW[426][J](12.4),printo=1
   print list='PNR Bus composite disutility, ', Market_Name[3], '                     ',MW[446][J](12.4),printo=1
   print list='PNR Bus composite disutility, ', Market_Name[4], '                     ',MW[466][J](12.4),printo=1
   print list='PNR Bus composite disutility, ', Market_Name[5], '                     ',MW[486][J](12.4),printo=1
   print list='PNR Bus composite disutility, ', Market_Name[6], '                     ',MW[506][J](12.4),printo=1
   print list='PNR Bus composite disutility, ', Market_Name[7], '                     ',MW[526][J](12.4),printo=1
  
   print list='\n\n\nElements used in PNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                                              ',MW[84][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                                          ',MW[85][J],printo=1
   print list='In-Vehicle time (Circulator)                                                       ',MW[86][J],printo=1
   print list='In-Vehicle time (Rail)                                                             ',(MW[87][J]+MW[88][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                                     ',MW[90][J],printo=1
   print list='Out of Vehicle time (Walk)                                                         ',MW[81][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min - weighted)                       ',MW[82][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                                                ',MW[83][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                                        ',MW[92][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                                        ',MW[93][J],printo=1
   print list='Number of transfers                                                                ',MW[91][J],printo=1
   print list='Transit Fare (in cents)                                                            ',MW[94][J],printo=1
   print list='Parking cost at PNR location (in cents)                                            ',MW[295][J],printo=1
   print list='Terminal time at PNR location                                                      ',MW[296][J],printo=1
   print list='PNR Prj common disutility, scaled                                                ',MW[307][J](12.4),printo=1
   ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1
   print list='PNR Prj composite disutility, ', Market_Name[1], '                     ',MW[407][J](12.4),printo=1
   print list='PNR Prj composite disutility, ', Market_Name[2], '                     ',MW[427][J](12.4),printo=1
   print list='PNR Prj composite disutility, ', Market_Name[3], '                     ',MW[447][J](12.4),printo=1
   print list='PNR Prj composite disutility, ', Market_Name[4], '                      ',MW[467][J](12.4),printo=1
   print list='PNR Prj composite disutility, ', Market_Name[5], '                     ',MW[487][J](12.4),printo=1
   print list='PNR Prj composite disutility, ', Market_Name[6], '                     ',MW[507][J](12.4),printo=1
   print list='PNR Prj composite disutility, ', Market_Name[7], '                     ',MW[527][J](12.4),printo=1

   print list='\n\n\nElements used in KNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                                              ',MW[64][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                                          ',MW[65][J],printo=1
   print list='In-Vehicle time (Circulator)                                                       ',MW[66][J],printo=1
   print list='In-Vehicle time (Rail)                                                             ',(MW[67][J]+MW[108][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                                     ',MW[70][J],printo=1
   print list='Out of Vehicle time (Walk)                                                         ',MW[61][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                                  ',MW[62][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                                                ',MW[63][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                                        ',MW[62][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                                        ',MW[73][J],printo=1
   print list='Transit Fare (in cents)                                                            ',MW[74][J],printo=1
   print list='Terminal time at KNR location                                                      ',MW[293][J],printo=1
   print list='KNR Bus common disutility, scaled                                                ',MW[308][J](12.4),printo=1
   ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1
   print list='KNR Bus composite disutility, ', Market_Name[1], '                     ',MW[408][J](12.4),printo=1
   print list='KNR Bus composite disutility, ', Market_Name[2], '                     ',MW[428][J](12.4),printo=1
   print list='KNR Bus composite disutility, ', Market_Name[3], '                     ',MW[448][J](12.4),printo=1
   print list='KNR Bus composite disutility, ', Market_Name[4], '                     ',MW[468][J](12.4),printo=1
   print list='KNR Bus composite disutility, ', Market_Name[5], '                     ',MW[488][J](12.4),printo=1
   print list='KNR Bus composite disutility, ', Market_Name[6], '                     ',MW[508][J](12.4),printo=1
   print list='KNR Bus composite disutility, ', Market_Name[7], '                     ',MW[528][J](12.4),printo=1

   print list='\n\n\nElements used in KNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                                              ',MW[84][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                                          ',MW[85][J],printo=1
   print list='In-Vehicle time (Circulator)                                                       ',MW[86][J],printo=1
   print list='In-Vehicle time (Rail)                                                             ',(MW[87][J]+MW[128][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                                     ',MW[90][J],printo=1
   print list='Out of Vehicle time (Walk)                                                         ',MW[81][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                                  ',MW[82][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                                                ',MW[83][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                                        ',MW[82][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                                        ',MW[93][J],printo=1
   print list='Number of transfers                                                                ',MW[91][J],printo=1
   print list='Transit Fare (in cents)                                                            ',MW[94][J],printo=1
   print list='Terminal time at KNR location                                                      ',MW[297][J],printo=1
   print list='KNR Prj common disutility, scaled                                                ',MW[309][J](12.4),printo=1
   ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1
   print list='KNR Prj composite disutility, ', Market_Name[1], '                     ',MW[409][J](12.4),printo=1
   print list='KNR Prj composite disutility, ', Market_Name[2], '                     ',MW[429][J](12.4),printo=1
   print list='KNR Prj composite disutility, ', Market_Name[3], '                     ',MW[449][J](12.4),printo=1
   print list='KNR Prj composite disutility, ', Market_Name[4], '                     ',MW[469][J](12.4),printo=1
   print list='KNR Prj composite disutility, ', Market_Name[5], '                     ',MW[489][J](12.4),printo=1
   print list='KNR Prj composite disutility, ', Market_Name[6], '                     ',MW[509][J](12.4),printo=1
   print list='KNR Prj composite disutility, ', Market_Name[7], '                     ',MW[529][J](12.4),printo=1

   print list='\n\n\nElements used in Non-Motorized Walk disutility calculations: *****************', printo=1
   print list='WalkDist1 (in miles)                                                               ',MW[12][J],printo=1
   print list='WalkDist2 (in miles)                                                               ',MW[13][J],printo=1
   print list='Walk disutility                                                                  ',MW[310][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[1], '                        ',MW[410][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[2], '                        ',MW[430][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[3], '                        ',MW[450][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[4], '                        ',MW[470][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[5], '                        ',MW[490][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[6], '                        ',MW[510][J](12.4),printo=1
   print list='Walk composite disutility, ', Market_Name[7], '                        ',MW[530][J](12.4),printo=1

   print list='\n\n\nElements used in Non-Motorized Bike disutility calculations: *****************', printo=1
   print list='BikeDist1 (in miles)                                                               ',MW[12][J],printo=1
   print list='BikeDist2 (in miles)                                                               ',MW[13][J],printo=1
   print list='Bike disutility                                                                  ',MW[311][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[1], '                        ',MW[411][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[2], '                        ',MW[431][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[3], '                        ',MW[451][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[4], '                        ',MW[471][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[5], '                        ',MW[491][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[6], '                        ',MW[511][J](12.4),printo=1
   print list='Bike composite disutility, ', Market_Name[7], '                        ',MW[531][J](12.4),printo=1
        
   ;print list='PNR parkcost                                                                       ',(COEFF(1,23)/COEFF(1,1))*MW[292]
   ;print list='termtime difference betn PNR and KNR                                               ',(COEFF(1,3)/COEFF(1,1))*(-mw[293]+mw[294])
   ;print list='see this',(MW[62]-({InflationFare}*(COEFF(1,23)/COEFF(1,1))*MW[292])+(COEFF(1,3)/COEFF(1,1))*(-mw[293]+mw[294]))

  ENDIF
 ENDIF
ENDJLOOP  

 

; ############################# XCHOICE SETUP ###################################

; Use DEMAND=1 to generate probabilities.
            
; 0-Car Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=401,402,403,404,405,406,407,408,409,410,411,
      DEMAND=_DMD,
      ODEMANDMW=601,602,603,604,605,606,607,608,609,610,611,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=101,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=111,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0 walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike

IF(@MARKETS@==1) GOTO next   

; Car-insufficient, Low Income Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=421,422,423,424,425,426,427,428,429,430,431,
      DEMAND=_DMD,
      ODEMANDMW=621,622,623,624,625,626,627,628,629,630,631,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=102,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=112,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0  walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike

; Car-insufficient, Medium Income Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=441,442,443,444,445,446,447,448,449,450,451,
      DEMAND=_DMD,
      ODEMANDMW=641,642,643,644,645,646,647,648,649,650,651,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=103,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=113,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0  walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike

; Car-insufficient, High Income Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=461,462,463,464,465,466,467,468,469,470,471,
      DEMAND=_DMD,
      ODEMANDMW=661,662,663,664,665,666,667,668,668,670,671,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=104,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=114,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0  walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike

IF(@MARKETS@==4) GOTO next

; Car-sufficient, Low Income Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=481,482,483,484,485,486,487,488,489,490,491,
      DEMAND=_DMD,
      ODEMANDMW=681,682,683,684,685,686,687,688,689,690,691,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=105,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=115,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0  walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike
   
; Car-sufficient, Medium Income Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=501,502,503,504,505,506,507,508,509,510,511,
      DEMAND=_DMD,
      ODEMANDMW=701,702,703,704,705,706,707,708,709,710,711,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=106,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=116,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0  walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike
   
; Car-sufficient, High Income Households
      _DMD=1
      XCHOICE ALTERNATIVES=da,sr2,sr3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,walk,bike,
      UTILITIESMW=521,522,523,524,525,526,527,528,529,530,531,
      DEMAND=_DMD,
      ODEMANDMW=721,722,723,724,725,726,727,728,729,730,731,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT = Total NC_1 auto NC_1 transit NC_1 nonmot, 
   SPLITCOMP=107,
;     Auto nest
      SPLIT = auto NC_2 da NC_2 sr, 
   SPLITCOMP=117,
;     Shared-ride nest
      SPLIT = sr 1.0 sr2 1.0 sr3,
;     Transit nest
      SPLIT = transit NC_2 wlktrn NC_2 pnrtrn NC_2 knrtrn,
;     Walk to Transit nest
      SPLIT = wlktrn 1.0 walkbus 1.0  walkprj,
;     PNR to Transit nest
      SPLIT = pnrtrn 1.0 pnrbus 1.0 pnrprj,
;     KNR to Transit nest
      SPLIT = knrtrn 1.0 knrbus 1.0 knrprj,
;     Non-Motorized nest
      SPLIT= nonmot NC_2 walk NC_2 bike

:next

; Exponentiated composite utilities

     LOOP _m=1,@MARKETS@
   
       MW[155+_m]=exp(NC_2 * MW[110+_m])   ; exponentiated auto utility -- for user benefits
       MW[120+_m]=exp(NC_1 * MW[100+_m])   ; exponentiated total utility --
    
     ENDLOOP

; Store probabilities for each transit access category

      IF (ACC == 1)
          LOOP _m=1,@MARKETS@
              LOOP _c=1,11
                  _n=320+_c+(_m-1)*11
                  _d=600+_c + (_m-1)*20
                  MW[_n]=MW[_d]         ; MW[_n] --> MW(321 to 397)
              ENDLOOP
          ENDLOOP
      ELSEIF (ACC == 2)
          LOOP _m=1,@MARKETS@
              LOOP _c=1,11
;                 _n=320+_c+(_m-1)*11
                  _n=740+_c+(_m-1)*11
                  _d=600+_c + (_m-1)*20
                  MW[_n]=MW[_d]         ; MW[_n] --> MW(741 to 817)
              ENDLOOP
          ENDLOOP
      ENDIF


; DON'T THINK WE NEED TO KEEP THESE MATRICES
; Store total composite utility for each transit access market

;      IF (ACC == 1)
;          LOOP _m=1,@MARKETS@
;             ;Total composite utility
;              MW[230+_m] = MW[100+_m]
;             ;Exponentiated total composite utility
;              MW[240+_m] = MW[120+_m]
;         ENDLOOP
;      ELSEIF (ACC == 2)
;         LOOP _m=1,@MARKETS@
;             ;Total composite utility
;             MW[250+_m] = MW[100+_m]
;             ;Exponentiated total composite utility
;             MW[260+_m] = MW[120+_m]
;         ENDLOOP
;   ELSEIF (ACC == 3)
;         LOOP _m=1,@MARKETS@
;             ;Total composite utility
;             MW[270+_m] = MW[100+_m]
;             ;Exponentiated total composite utility
;             MW[280+_m] = MW[120+_m]
;         ENDLOOP
;      ENDIF
 
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
        MW[290+_m] = MW[290+_m] + EXP(MW[100+_m]) * ACCShare[I][J][ACC]
        IF(ACC==3) MW[290+_m] = LN(MW[290+_m])
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

ENDRUN
