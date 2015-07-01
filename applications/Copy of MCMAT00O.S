; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{OUTDIR}\MCMAT00D.PRN" MSG='Calculate sub-modal utilities'
FILEI MATI[11] = "{OUTDIR}\SELLINKOP3_TMP.MAT"
FILEI MATI[10] = "{OUTDIR}\SELLINKOP1_TMP.MAT"
FILEI MATI[9] = "{OUTDIR}\SELLINKPK3_TMP.MAT"
FILEI MATI[8] = "{OUTDIR}\SELLINKPK1_TMP.MAT"
FILEO MATO[10] = "{OUTDIR}\temfiles\@PURP@REVXFER.MAT",
MO=151-158,NAME=FareWB,FareWP,FareAB,FareAP,XferWB,XferWP,XferAB,XferAP
FILEO PRINTO[2] = "{OUTDIR}\ModeSum.TXT",
append=t
FILEI MATI[7] = "{OUTDIR}\ST2ST_{alt}{year}.MAT"
        ; Tables 1-5 for peak auto-bus: 1-FromStation, 2-StationTAZ, 3-PNRTerminalTime, 4-KNRTerminalTime, 5-ParkingCost,
        ; Tables 6-10 for peak auto-project: 6-FromStation, 7-StationTAZ, 8-PNRTerminalTime, 9-KNRTerminalTime, 10-ParkingCost,
        ; Tables 11-15 for off-peak auto-bus: 11-FromStation, 12-StationTAZ, 13-PNRTerminalTime, 14-KNRTerminalTime, 15-ParkingCost,
        ; Tables 16-20 for peak auto-project: 16-FromStation, 17-StationTAZ, 18-PNRTerminalTime, 19-KNRTerminalTime, 20-ParkingCost
FILEO MATO[9] = "{OUTDIR}\temfiles\@PURP@UTIL_NT_2CAR.MAT",
MO=481-489,DEC=9*d,NAME=DANT2CAR,SR2NT2CAR,SR3NT2CAR,WBNT2CAR,WPNT2CAR,PBNT2CAR,PPNT2CAR,KBNT2CAR,KPNT2CAR
FILEO MATO[8] = "{OUTDIR}\temfiles\@PURP@UTIL_NT_1CAR.MAT",
MO=471-479,DEC=9*d,NAME=DANT1CAR,SR2NT1CAR,SR3NT1CAR,WBNT1CAR,WPNT1CAR,PBNT1CAR,PPNT1CAR,KBNT1CAR,KPNT1CAR
FILEO MATO[7] = "{OUTDIR}\temfiles\@PURP@UTIL_NT_0CAR.MAT",
MO=461-469,DEC=9*d,NAME=DANT0CAR,SR2NT0CAR,SR3NT0CAR,WBNT0CAR,WPNT0CAR,PBNT0CAR,PPNT0CAR,KBNT0CAR,KPNT0CAR
FILEO MATO[6] = "{OUTDIR}\temfiles\@PURP@UTIL_MD_2CAR.MAT",
MO=451-459,DEC=9*d,NAME=DAMD2CAR,SR2MD2CAR,SR3MD2CAR,WBMD2CAR,WPMD2CAR,PBMD2CAR,PPMD2CAR,KBMD2CAR,KPMD2CAR
FILEO MATO[5] = "{OUTDIR}\temfiles\@PURP@UTIL_MD_1CAR.MAT",
MO=441-449,DEC=9*d,NAME=DAMD1CAR,SR2MD1CAR,SR3MD1CAR,WBMD1CAR,WPMD1CAR,PBMD1CAR,PPMD1CAR,KBMD1CAR,KPMD1CAR
FILEO MATO[4] = "{OUTDIR}\temfiles\@PURP@UTIL_MD_0CAR.MAT",
MO=431-439,DEC=9*d,NAME=DAMD0CAR,SR2MD0CAR,SR3MD0CAR,WBMD0CAR,WPMD0CAR,PBMD0CAR,PPMD0CAR,KBMD0CAR,KPMD0CAR
FILEO MATO[3] = "{OUTDIR}\temfiles\@PURP@UTIL_CW_2CAR.MAT",
MO=421-429,DEC=9*d,NAME=DACW2CAR,SR2CW2CAR,SR3CW2CAR,WBCW2CAR,WPCW2CAR,PBCW2CAR,PPCW2CAR,KBCW2CAR,KPCW2CAR
FILEO MATO[2] = "{OUTDIR}\temfiles\@PURP@UTIL_CW_1CAR.MAT",
MO=411-419,DEC=9*d,NAME=DACW1CAR,SR2CW1CAR,SR3CW1CAR,WBCW1CAR,WPCW1CAR,PBCW1CAR,PPCW1CAR,KBCW1CAR,KPCW1CAR
FILEO MATO[1] = "{OUTDIR}\temfiles\@PURP@UTIL_CW_0CAR.MAT",
MO=401-409,DEC=9*d,NAME=DACW0CAR,SR2CW0CAR,SR3CW0CAR,WBCW0CAR,WPCW0CAR,PBCW0CAR,PPCW0CAR,KBCW0CAR,KPCW0CAR
FILEI ZDATI[2] = "{OUTDIR}\STATDATA_{alt}{year}.DBF"
FILEI LOOKUPI[2] = "{PARAMS}\TRN_COEFFICIENTS.DBF"
FILEI ZDATI[1] = "{OUTDIR}\TAZDATA_{alt}{year}.DBF"
FILEI LOOKUPI[1] = "{OUTDIR}\MC_CONSTANTS.CSV"
FILEO PRINTO[1] = "{OUTDIR}\ModeDebug.TXT",
append=t
FILEI MATI[6] = "{OUTDIR}\HOVSavings_{ALT}{YEAR}.MAT"
           ; Table 1 - HOV time savings for peak period
           ; Table 2 - HOV time savings for off-peak period
FILEI MATI[5] = "{OUTDIR}\TSKIM@PERIOD@4_{Alt}{year}.MAT"
FILEI MATI[4] = "{OUTDIR}\TSKIM@PERIOD@3_{Alt}{year}.MAT"
FILEI MATI[3] = "{OUTDIR}\TSKIM@PERIOD@2_{Alt}{year}.MAT"
FILEI MATI[2] = "{OUTDIR}\TSKIM@PERIOD@1_{Alt}{year}.MAT"
           ; Tables 1-6: 1-WalkTime, 2-AutoTime, 3-XferTime, 4-BusTime, 5-PremBusTime, 6-CircTime
           ; Tables 7-10: 7-HeavyRailTime, 8-CommuterRailTime, 9-OtherModeTime, 10-ProjectModeTime
           ; Tables 11-15: 11-NumXfers, 12-InitialWaitTime, 13-XferWaitTime, 14-Fare, 15-Total time
FILEI MATI[1] = "{OUTDIR}\@SKIMFILE@.MAT"
           ; Tables 1-4 for SOV: 1-Toll, 2-Distance, 3-Time, 4-Weighted Time
           ; Tables 5-8 for HOV: 5-Toll, 6-Distance, 7-Time, 8-Weighted Time
           ; Table 9 is terminal time

zonemsg=100

;Constants
LOOKUP, NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, , LIST=Y, LOOKUPI=1
;K=CONSTANT
if (i=1)
 K_DA_AUTO0=CONSTANTS(1,1), K_DA_AUTO1=CONSTANTS(1,10), K_DA_AUTO2=CONSTANTS(1,19)
 K_SR1PASS_AUTO0=CONSTANTS(1,2), K_SR1PASS_AUTO1=CONSTANTS(1,11), K_SR1PASS_AUTO2=CONSTANTS(1,20)
 K_SR2PASS_AUTO0=CONSTANTS(1,3), K_SR2PASS_AUTO1=CONSTANTS(1,12), K_SR2PASS_AUTO2=CONSTANTS(1,21)
 K_WALKBUS_AUTO0=CONSTANTS(1,4), K_WALKBUS_AUTO1=CONSTANTS(1,13), K_WALKBUS_AUTO2=CONSTANTS(1,22)
 K_WLKPREM_AUTO0=CONSTANTS(1,5), K_WLKPREM_AUTO1=CONSTANTS(1,14), K_WLKPREM_AUTO2=CONSTANTS(1,23)
 K_PNRBUS_AUTO0=CONSTANTS(1,6), K_PNRBUS_AUTO1=CONSTANTS(1,15), K_PNRBUS_AUTO2=CONSTANTS(1,24)
 K_PNRPREM_AUTO0=CONSTANTS(1,7), K_PNRPREM_AUTO1=CONSTANTS(1,16), K_PNRPREM_AUTO2=CONSTANTS(1,25)
 K_KNRBUS_AUTO0=CONSTANTS(1,8), K_KNRBUS_AUTO1=CONSTANTS(1,17), K_KNRBUS_AUTO2=CONSTANTS(1,26)
 K_KNRPREM_AUTO0=CONSTANTS(1,9), K_KNRPREM_AUTO1=CONSTANTS(1,18), K_KNRPREM_AUTO2=CONSTANTS(1,27)
endif

;Coefficients
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=2
;Coefficients
if (i=1)
; Transit Coefficients
 COEFF_IVTT   = COEFF(1,1)
 COEFF_IVTTCR = COEFF(1,2)
 COEFF_OVT    = COEFF(1,3)
 COEFF_COST   = COEFF(1,4)
 COEFF_AAT    = COEFF(1,5)
 COEFF_XFER   = COEFF(1,6)
 COEFF_DCBD   = COEFF(1,7)
 COEFF_DEXUP  = COEFF(1,8)
 COEFF_DEXUA  = COEFF(1,9)
 NC_TRNAC     = COEFF(1,10)
 NC_TRN       = COEFF(1,11)
 NC_AUTO      = COEFF(1,12)
 NC_AUTOSR    = COEFF(1,13)

; Nesting Coefficients
 NC_DriveAlone = NC_AUTO
 NC_SharedRide = NC_AUTO * NC_AUTOSR
 NC_WlkBus = NC_TRN * NC_TRNAC
 NC_WlkPrj = NC_TRN * NC_TRNAC
 NC_PNRBus = NC_TRN * NC_TRNAC
 NC_PNRPrj = NC_TRN * NC_TRNAC
 NC_KNRBus = NC_TRN * NC_TRNAC
 NC_KNRPrj = NC_TRN * NC_TRNAC
endif

FILLMW MW[1]=MI.1.1,2,3,4,5,6,7,8,9
FILLMW MW[11]=MI.6.HOVsave@PERIOD@         ; HOVsavePK for peak period (HBW) and HOVsaveOP for off-peak period (HBNW and NHB)
FILLMW MW[12]=MI.7.@STATION_TABLE@         ; 6 tables - 3 (pnr term time, knr term time, and prk cost) for auto-bus and 3 for auto-prj
FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[61]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[81]=MI.5.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
if ('@PURP@'='HBW')
 FILLMW MW[18]=MI.8.1  ; PK walk-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[19]=MI.9.1  ; PK auto-bus/BRT selectlink matrix for silver bullet
else
 FILLMW MW[18]=MI.10.1  ; OP walk-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[19]=MI.11.1  ; OP auto-bus/BRT selectlink matrix for silver bullet
endif

FILLMW MW[151]=MI.2.14
FILLMW MW[152]=MI.3.14
FILLMW MW[153]=MI.4.14
FILLMW MW[154]=MI.5.14
FILLMW MW[155]=MI.2.11
FILLMW MW[156]=MI.3.11
FILLMW MW[157]=MI.4.11
FILLMW MW[158]=MI.5.11

if (I=1)
; DEBUG MODE CHOICE
 IF ({DebugMC}>0)
   print list='MODE CHOICE TRACE @PURP@-@PERIOD@','\n\n',printo=1
   print list='-- @DATE.RUNDATE@     ',printo=1
   print list='-- @TIME.RUNTIME@     ','\n\n',printo=1
   print list='NERPM \n\nSelected Interchange for Tracing:    ',{SelOrigin}(4.0),'-',{SelDest}(4.0),'\n\n',printo=1
   print list='PURPOSE -           @PURP@  ',printo=1
   print list='SKIMS/PERIOD        @PERIOD@',printo=1
   print list='\nCoefficients                ',printo=1
   print list='       IVTT                 ',COEFF_IVTT(7.4),printo=1
   print list='       CR IVTT              ',COEFF_IVTTCR(7.4),printo=1
   print list='       OVT                  ',COEFF_OVT(7.4),printo=1
   print list='       AAT                  ',COEFF_AAT(7.4),printo=1
   print list='       XFER                 ',COEFF_XFER(7.4),printo=1
   print list='       COST                 ',COEFF_COST(7.4),printo=1
   print list='       DUM_CBD              ',COEFF_DCBD(7.4),printo=1
   print list='       DUM_EXURBAN PROD     ',COEFF_DEXUP(7.4),printo=1
   print list='       DUM_EXURBAN ATTR     ',COEFF_DEXUA(7.4),printo=1
   print list='\n\nNesting Coeffcient      ',printo=1
   print list='        NC_TRNAC            ',NC_TRNAC(7.4),printo=1
   print list='        NC_TRN              ',NC_TRN(7.4),printo=1
   print list='        NC_AUTOSR           ',NC_AUTOSR(7.4),printo=1
   print list='        NC_AUTO             ',NC_AUTO(7.4),printo=1
   print list='\n\nConstants               ',printo=1
   print list='        Drive alone (0 car) ',K_da_auto0(8.4),printo=1
   print list='        Drive alone (1 car) ',K_da_auto1(8.4),printo=1
   print list='        Drive alone (2 car) ',K_da_auto2(8.4),printo=1
   print list='        HOV2 (0 car)        ',K_sr1pass_auto0(8.4),printo=1
   print list='        HOV2 (1 car)        ',K_sr1pass_auto1(8.4),printo=1
   print list='        HOV2 (2 car)        ',K_sr1pass_auto2(8.4),printo=1
   print list='        HOV3+ (0 car)       ',K_sr2pass_auto0(8.4),printo=1
   print list='        HOV3+ (1 car)       ',K_sr2pass_auto1(8.4),printo=1
   print list='        HOV3+ (2 car)       ',K_sr2pass_auto2(8.4),printo=1
   print list='        Walk Bus (0 car)    ',K_walkbus_auto0(8.4),printo=1
   print list='        Walk Bus (1 car)    ',K_walkbus_auto1(8.4),printo=1
   print list='        Walk Bus (2 car)    ',K_walkbus_auto2(8.4),printo=1
   print list='        Walk Prj (0 car)    ',K_wlkprem_auto0(8.4),printo=1
   print list='        Walk Prj (1 car)    ',K_wlkprem_auto1(8.4),printo=1
   print list='        Walk Prj (2 car)    ',K_wlkprem_auto2(8.4),printo=1
   print list='        PNR Bus (0 car)     ',K_PNRBUS_auto0(8.4),printo=1
   print list='        PNR Bus (1 car)     ',K_PNRBUS_auto1(8.4),printo=1
   print list='        PNR Bus (2 car)     ',K_PNRBUS_auto2(8.4),printo=1
   print list='        PNR Prj (0 car)     ',K_PNRPREM_auto0(8.4),printo=1
   print list='        PNR Prj (1 car)     ',K_PNRPREM_auto1(8.4),printo=1
   print list='        PNR Prj (2 car)     ',K_PNRPREM_auto2(8.4),printo=1
   print list='        KNR Bus (0 car)     ',K_KNRBUS_auto0(8.4),printo=1
   print list='        KNR Bus (1 car)     ',K_KNRBUS_auto1(8.4),printo=1
   print list='        KNR Bus (2 car)     ',K_KNRBUS_auto2(8.4),printo=1
   print list='        KNR Prj (0 car)     ',K_KNRPREM_auto0(8.4),printo=1
   print list='        KNR Prj (1 car)     ',K_KNRPREM_auto1(8.4),printo=1
   print list='        KNR Prj (2 car)     ',K_KNRPREM_auto2(8.4),printo=1
   print list='\n\nParameters used in disutility calculations:', printo=1
   print list='Highway Operating Cost (cents/mi)   ',{hwyopcost}(5.3),printo=1
   print list='CTOLL Multiplier (toll to time)     ',{CTOLL}(5.3),printo=1
   print list='Value of ZAPZERO                    ',{ZAPZERO}(5.3),printo=1
   print list='Auto Occupancy 3+ (HBW)             ',{oc3vhbw}(5.3),printo=1
   print list='Auto Occupancy 3+ (HBNW)            ',{oc3vhbnw}(5.3),printo=1
   print list='Auto Occupancy 3+ (NHB)             ',{oc3vnhb}(5.3),printo=1
   print list='Inflation factor - Tolls            ',{InflationToll}(5.3),printo=1
   print list='Inflation factor - Auto Op Cost     ',{InflationAOC}(5.3),printo=1
   print list='Inflation factor - Parking Cost     ',{InflationParkCost}(5.3),printo=1
   print list='Inflation factor - Transit Fare     ',{InflationFare}(5.3),printo=1
   print list='Auto Access Auto Occupancy Factor   ',{OCCPNRAccess}(5.3),printo=1
   print list='Auto Access Speed                   ',{AutoAccSpeed}(5.1),printo=1
   print list='Times are in minutes. Costs are in cents.        ',printo=1
 endif

 ; Echo to Mode Choice summary file
 PRINT LIST="+++++ MODE XCHOICE SUMMARY +++++\n" PRINTO=2
 PRINT LIST='-- @DATE.RUNDATE@     ','-- @TIME.RUNTIME@     ','\n',PRINTO=2
 PRINT LIST="{DESCR}" PRINTO=2
 PRINT LIST="{SCENARIO_SHORTNAME}\n" PRINTO=2
 PRINT LIST='PURPOSE -           @PURP@  ',printo=2
 PRINT LIST='SKIMS/PERIOD        @PERIOD@',printo=2
 PRINT LIST='\nCoefficients                ',printo=2
 PRINT LIST='       IVTT                 ',COEFF_IVTT(7.4),printo=2
 PRINT LIST='       CR IVTT              ',COEFF_IVTTCR(7.4),printo=2
 PRINT LIST='       OVT                  ',COEFF_OVT(7.4),printo=2
 PRINT LIST='       AAT                  ',COEFF_AAT(7.4),printo=2
 PRINT LIST='       XFER                 ',COEFF_XFER(7.4),printo=2
 PRINT LIST='       COST                 ',COEFF_COST(7.4),printo=2
 PRINT LIST='       DUM_CBD              ',COEFF_DCBD(7.4),printo=2
 PRINT LIST='       DUM_EXURBAN PROD     ',COEFF_DEXUP(7.4),printo=2
 PRINT LIST='       DUM_EXURBAN ATTR     ',COEFF_DEXUA(7.4),printo=2
 PRINT LIST='\n\nNesting Coeffcient      ',printo=2
 PRINT LIST='        NC_TRNAC            ',NC_TRNAC(7.4),printo=2
 PRINT LIST='        NC_TRN              ',NC_TRN(7.4),printo=2
 PRINT LIST='        NC_AUTOSR           ',NC_AUTOSR(7.4),printo=2
 PRINT LIST='        NC_AUTO             ',NC_AUTO(7.4),printo=2
 PRINT LIST='\n\nConstants               ',printo=2
 PRINT LIST='        Drive alone (0 car) ',K_da_auto0(8.4),printo=2
 PRINT LIST='        Drive alone (1 car) ',K_da_auto1(8.4),printo=2
 PRINT LIST='        Drive alone (2 car) ',K_da_auto2(8.4),printo=2
 PRINT LIST='        HOV2 (0 car)        ',K_sr1pass_auto0(8.4),printo=2
 PRINT LIST='        HOV2 (1 car)        ',K_sr1pass_auto1(8.4),printo=2
 PRINT LIST='        HOV2 (2 car)        ',K_sr1pass_auto2(8.4),printo=2
 PRINT LIST='        HOV3+ (0 car)       ',K_sr2pass_auto0(8.4),printo=2
 PRINT LIST='        HOV3+ (1 car)       ',K_sr2pass_auto1(8.4),printo=2
 PRINT LIST='        HOV3+ (2 car)       ',K_sr2pass_auto2(8.4),printo=2
 PRINT LIST='        Walk Bus (0 car)    ',K_walkbus_auto0(8.4),printo=2
 PRINT LIST='        Walk Bus (1 car)    ',K_walkbus_auto1(8.4),printo=2
 PRINT LIST='        Walk Bus (2 car)    ',K_walkbus_auto2(8.4),printo=2
 PRINT LIST='        Walk Prj (0 car)    ',K_wlkprem_auto0(8.4),printo=2
 PRINT LIST='        Walk Prj (1 car)    ',K_wlkprem_auto1(8.4),printo=2
 PRINT LIST='        Walk Prj (2 car)    ',K_wlkprem_auto2(8.4),printo=2
 PRINT LIST='        PNR Bus (0 car)     ',K_PNRBUS_auto0(8.4),printo=2
 PRINT LIST='        PNR Bus (1 car)     ',K_PNRBUS_auto1(8.4),printo=2
 PRINT LIST='        PNR Bus (2 car)     ',K_PNRBUS_auto2(8.4),printo=2
 PRINT LIST='        PNR Prj (0 car)     ',K_PNRPREM_auto0(8.4),printo=2
 PRINT LIST='        PNR Prj (1 car)     ',K_PNRPREM_auto1(8.4),printo=2
 PRINT LIST='        PNR Prj (2 car)     ',K_PNRPREM_auto2(8.4),printo=2
 PRINT LIST='        KNR Bus (0 car)     ',K_KNRBUS_auto0(8.4),printo=2
 PRINT LIST='        KNR Bus (1 car)     ',K_KNRBUS_auto1(8.4),printo=2
 PRINT LIST='        KNR Bus (2 car)     ',K_KNRBUS_auto2(8.4),printo=2
 PRINT LIST='        KNR Prj (0 car)     ',K_KNRPREM_auto0(8.4),printo=2
 PRINT LIST='        KNR Prj (1 car)     ',K_KNRPREM_auto1(8.4),printo=2
 PRINT LIST='        KNR Prj (2 car)     ',K_KNRPREM_auto2(8.4),printo=2
 PRINT LIST='\n\nParameters used in disutility calculations:', printo=2
 PRINT LIST='Highway Operating Cost (cents/mi)   ',{hwyopcost}(5.3),printo=2
 PRINT LIST='CTOLL Multiplier (toll to time)     ',{CTOLL}(5.3),printo=2
 PRINT LIST='Value of ZAPZERO                    ',{ZAPZERO}(5.3),printo=2
 PRINT LIST='Auto Occupancy 3+ (HBW)             ',{oc3vhbw}(5.3),printo=2
 PRINT LIST='Auto Occupancy 3+ (HBNW)            ',{oc3vhbnw}(5.3),printo=2
 PRINT LIST='Auto Occupancy 3+ (NHB)             ',{oc3vnhb}(5.3),printo=2
 PRINT LIST='Inflation factor - Tolls            ',{InflationToll}(5.3),printo=2
 PRINT LIST='Inflation factor - Auto Op Cost     ',{InflationAOC}(5.3),printo=2
 PRINT LIST='Inflation factor - Parking Cost     ',{InflationParkCost}(5.3),printo=2
 PRINT LIST='Inflation factor - Transit Fare     ',{InflationFare}(5.3),printo=2
 PRINT LIST='Auto Access Auto Occupancy Factor   ',{OCCPNRAccess}(5.3),printo=2
 PRINT LIST='Auto Access Speed                   ',{AutoAccSpeed}(5.1),printo=2
 PRINT LIST='Times reflected in minutes.         ',printo=2
 PRINT LIST='Costs are in cents.                 ',printo=2

endif

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

   if (ACC==1) then
    ACC_NAME='CAN WALK TO TRANSIT'
    walk_acc_dum = 0.0            ; added to the utility
    auto_acc_dum = 0.0            ; added to the utility
   elseif (ACC==2)
    ACC_NAME='MUST DRIVE TO TRANSIT'
    walk_acc_dum = -999.99
    auto_acc_dum = 0.0
   elseif (ACC==3)
    ACC_NAME='NO TRANSIT'
    walk_acc_dum = -999.99
    auto_acc_dum = -999.99
   endif

  _idx=(ACC-1)*30
  ;   DRIVE ALONE ELEMENTS OF UTILITY ARE:
      MW[201]=COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                                       ; Terminal time
              COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[1] * {CTOLL} * 60))) +                       ; IVTT
              COEFF_IVTT * {InflationToll} * (MW[1] * {CTOLL} * 60) +                                   ; Toll converted to equivalent minutes
@noNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +                      ; Auto parking cost
@isNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +                      ; Auto parking cost (NHB)
              COEFF_COST * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) +                             ; Auto operating cost
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                                      ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                          ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                         ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                           ; Exurban attraction dummy
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[401]=(MW[201]+K_DA_AUTO0)/NC_DriveAlone
      MW[411]=(MW[201]+K_DA_AUTO1)/NC_DriveAlone
      MW[421]=(MW[201]+K_DA_AUTO2)/NC_DriveAlone
     elseif (ACC=2)
      MW[431]=(MW[201]+K_DA_AUTO0)/NC_DriveAlone
      MW[441]=(MW[201]+K_DA_AUTO1)/NC_DriveAlone
      MW[451]=(MW[201]+K_DA_AUTO2)/NC_DriveAlone
     elseif (ACC=3)
      MW[461]=(MW[201]+K_DA_AUTO0)/NC_DriveAlone
      MW[471]=(MW[201]+K_DA_AUTO1)/NC_DriveAlone
      MW[481]=(MW[201]+K_DA_AUTO2)/NC_DriveAlone
     endif

  ;   SHARED RIDE PERSONS/SHARE RIDE - ONE PASSENGER ELEMENTS OF UTILITY ARE:
      MW[202]=COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                                       ; Terminal time
              COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) +                       ; IVTT
              COEFF_IVTT * {InflationToll} * (MW[5] * {CTOLL} * 60) -                                   ; Toll converted to equivalent minutes
              COEFF_IVTT * (MAX (MW[11], 0)) +                                                          ; HOV time savings
@noNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 2.0) +                      ; Auto parking cost
@isNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 1.0) +                      ; Auto parking cost (NHB)
              COEFF_COST * (({InflationAOC} * MW[2] * {hwyopcost}) / 2.0) +                             ; Auto operating cost
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                                      ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                          ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                         ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                           ; Exurban attraction dummy
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[402]=(MW[202]+K_SR1PASS_AUTO0)/NC_SharedRide
      MW[412]=(MW[202]+K_SR1PASS_AUTO1)/NC_SharedRide
      MW[422]=(MW[202]+K_SR1PASS_AUTO2)/NC_SharedRide
     elseif (ACC=2)
      MW[432]=(MW[202]+K_SR1PASS_AUTO0)/NC_SharedRide
      MW[442]=(MW[202]+K_SR1PASS_AUTO1)/NC_SharedRide
      MW[452]=(MW[202]+K_SR1PASS_AUTO2)/NC_SharedRide
     elseif (ACC=3)
      MW[462]=(MW[202]+K_SR1PASS_AUTO0)/NC_SharedRide
      MW[472]=(MW[202]+K_SR1PASS_AUTO1)/NC_SharedRide
      MW[482]=(MW[202]+K_SR1PASS_AUTO2)/NC_SharedRide
     endif

  ;   SHARED RIDE - 2+ PASSENGER ELEMENTS OF UTILITY ARE:
      MW[203]=COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                                       ; Terminal time
              COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) +                       ; IVTT
              COEFF_IVTT * {InflationToll} * (MW[5] * {CTOLL} * 60) -                                   ; Toll converted to equivalent minutes
              COEFF_IVTT * (MAX (MW[11], 0)) +                                                          ; HOV time savings
@noNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 2.0) +                   ; Auto parking cost
@isNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 1.0) +                   ; Auto parking cost (NHB)
              COEFF_COST * (({InflationAOC} * MW[2] * {hwyopcost}) / @OCC3@) +                          ; Auto operating cost
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                                      ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                          ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                         ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                           ; Exurban attraction dummy
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[403]=(MW[203]+K_SR2PASS_AUTO0)/NC_SharedRide
      MW[413]=(MW[203]+K_SR2PASS_AUTO1)/NC_SharedRide
      MW[423]=(MW[203]+K_SR2PASS_AUTO2)/NC_SharedRide
     elseif (ACC=2)
      MW[433]=(MW[203]+K_SR2PASS_AUTO0)/NC_SharedRide
      MW[443]=(MW[203]+K_SR2PASS_AUTO1)/NC_SharedRide
      MW[453]=(MW[203]+K_SR2PASS_AUTO2)/NC_SharedRide
     elseif (ACC=3)
      MW[463]=(MW[203]+K_SR2PASS_AUTO0)/NC_SharedRide
      MW[473]=(MW[203]+K_SR2PASS_AUTO1)/NC_SharedRide
      MW[483]=(MW[203]+K_SR2PASS_AUTO2)/NC_SharedRide
     endif

  ;   WALK ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[204]=COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[24] + MW[25] + MW[26] + MW[27] + MW[29] + MW[30]) -              ; IVTT
              COEFF_IVTT * MW[18] * {WalkBRTSilverBullet} +                                        ; IVTT for silver bullet
              COEFF_IVTTCR * (MW[28]) +                                                         ; IVTT for commuter rail
              COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[34]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      JLOOP
        IF ((MW[24] + MW[25] + MW[26] + MW[27] + MW[28] + MW[29] + MW[30])==0) MW[205]=-999.99
        IF (MW[2]<{MinDistWalkAcc}) MW[205]=-999.99
      ENDJLOOP
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[404]=((MW[204]+MW[205]+K_WALKBUS_AUTO0)/NC_WlkBus + walk_acc_dum)
      MW[414]=((MW[204]+MW[205]+K_WALKBUS_AUTO1)/NC_WlkBus + walk_acc_dum)
      MW[424]=((MW[204]+MW[205]+K_WALKBUS_AUTO2)/NC_WlkBus + walk_acc_dum)
     elseif (ACC=2)
      MW[434]=((MW[204]+MW[205]+K_WALKBUS_AUTO0)/NC_WlkBus + walk_acc_dum)
      MW[444]=((MW[204]+MW[205]+K_WALKBUS_AUTO1)/NC_WlkBus + walk_acc_dum)
      MW[454]=((MW[204]+MW[205]+K_WALKBUS_AUTO2)/NC_WlkBus + walk_acc_dum)
     elseif (ACC=3)
      MW[464]=((MW[204]+MW[205]+K_WALKBUS_AUTO0)/NC_WlkBus + walk_acc_dum)
      MW[474]=((MW[204]+MW[205]+K_WALKBUS_AUTO1)/NC_WlkBus + walk_acc_dum)
      MW[484]=((MW[204]+MW[205]+K_WALKBUS_AUTO2)/NC_WlkBus + walk_acc_dum)
     endif

  ;   WALK ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[206]=COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[49] + MW[50]) +              ; IVTT
              COEFF_IVTTCR * (MW[48]) -                                                         ; IVTT for commuter rail
              COEFF_IVTTCR * 1.00 * {WalkCRLSilverBullet} +                                        ; IVTT for sivler bullet
              COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[54]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

      JLOOP
        IF (MW[50]=0) MW[207]=-999.99
        IF (MW[2]<{MinDistWalkAcc}) MW[207]=-999.99
      ENDJLOOP
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[405]=((MW[206]+MW[207]+K_WLKPREM_AUTO0)/NC_WlkPrj + walk_acc_dum)
      MW[415]=((MW[206]+MW[207]+K_WLKPREM_AUTO1)/NC_WlkPrj + walk_acc_dum)
      MW[425]=((MW[206]+MW[207]+K_WLKPREM_AUTO2)/NC_WlkPrj + walk_acc_dum)
     elseif (ACC=2)
      MW[435]=((MW[206]+MW[207]+K_WLKPREM_AUTO0)/NC_WlkPrj + walk_acc_dum)
      MW[445]=((MW[206]+MW[207]+K_WLKPREM_AUTO1)/NC_WlkPrj + walk_acc_dum)
      MW[455]=((MW[206]+MW[207]+K_WLKPREM_AUTO2)/NC_WlkPrj + walk_acc_dum)
     elseif (ACC=3)
      MW[465]=((MW[206]+MW[207]+K_WLKPREM_AUTO0)/NC_WlkPrj + walk_acc_dum)
      MW[475]=((MW[206]+MW[207]+K_WLKPREM_AUTO1)/NC_WlkPrj + walk_acc_dum)
      MW[485]=((MW[206]+MW[207]+K_WLKPREM_AUTO2)/NC_WlkPrj + walk_acc_dum)
     endif

  ;   PNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[208]=COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[62]) +                                                           ; Auto access time
              COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[69] + MW[70]) -              ; IVTT
              COEFF_IVTT * MW[19] * {AutoBRTSilverBullet} +                                        ; IVTT for silver bullet
              COEFF_IVTTCR * (MW[68]) +                                                         ; IVTT for commuter rail
              COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[74]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      JLOOP
        IF ((MW[64] + MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70])=0) MW[209]=-999.99
        IF (MW[2]<{MinDistAutoAcc}) MW[209]=-999.99
      ENDJLOOP
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[406]=((MW[208]+MW[209]+K_PNRBUS_AUTO0)/NC_PNRBus + auto_acc_dum)
      MW[416]=((MW[208]+MW[209]+K_PNRBUS_AUTO1)/NC_PNRBus + auto_acc_dum)
      MW[426]=((MW[208]+MW[209]+K_PNRBUS_AUTO2)/NC_PNRBus + auto_acc_dum)
     elseif (ACC=2)
      MW[436]=((MW[208]+MW[209]+K_PNRBUS_AUTO0)/NC_PNRBus + auto_acc_dum)
      MW[446]=((MW[208]+MW[209]+K_PNRBUS_AUTO1)/NC_PNRBus + auto_acc_dum)
      MW[456]=((MW[208]+MW[209]+K_PNRBUS_AUTO2)/NC_PNRBus + auto_acc_dum)
     elseif (ACC=3)
      MW[466]=((MW[208]+MW[209]+K_PNRBUS_AUTO0)/NC_PNRBus + auto_acc_dum)
      MW[476]=((MW[208]+MW[209]+K_PNRBUS_AUTO1)/NC_PNRBus + auto_acc_dum)
      MW[486]=((MW[208]+MW[209]+K_PNRBUS_AUTO2)/NC_PNRBus + auto_acc_dum)
     endif

  ;   PNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[210]=COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[82]) +                                                           ; Auto access time
              COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[89] + MW[90]) +              ; IVTT
              COEFF_IVTTCR * (MW[88]) -                                                         ; IVTT for commuter rail
              COEFF_IVTTCR * 1.00 * {AutoCRLSilverBullet} +                                        ; IVTT for silver bullet
              COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[94]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      JLOOP
        IF ((MW[90])=0) MW[211]=-999.99
        IF (MW[2]<{MinDistAutoAcc}) MW[211]=-999.99
      ENDJLOOP
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[407]=((MW[210]+MW[211]+K_PNRPREM_AUTO0)/NC_PNRPrj + auto_acc_dum)
      MW[417]=((MW[210]+MW[211]+K_PNRPREM_AUTO1)/NC_PNRPrj + auto_acc_dum)
      MW[427]=((MW[210]+MW[211]+K_PNRPREM_AUTO2)/NC_PNRPrj + auto_acc_dum)
     elseif (ACC=2)
      MW[437]=((MW[210]+MW[211]+K_PNRPREM_AUTO0)/NC_PNRPrj + auto_acc_dum)
      MW[447]=((MW[210]+MW[211]+K_PNRPREM_AUTO1)/NC_PNRPrj + auto_acc_dum)
      MW[457]=((MW[210]+MW[211]+K_PNRPREM_AUTO2)/NC_PNRPrj + auto_acc_dum)
     elseif (ACC=3)
      MW[467]=((MW[210]+MW[211]+K_PNRPREM_AUTO0)/NC_PNRPrj + auto_acc_dum)
      MW[477]=((MW[210]+MW[211]+K_PNRPREM_AUTO1)/NC_PNRPrj + auto_acc_dum)
      MW[487]=((MW[210]+MW[211]+K_PNRPREM_AUTO2)/NC_PNRPrj + auto_acc_dum)
     endif

  ;   KNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[212]=COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
              COEFF_OVT * (MW[13] - MW[12]) +                                                   ; Delta of knr term time and pnr term time for auto-bus - pnr term time on auto connector)
              COEFF_IVTT * (MW[62]) +                                                           ; Auto access time
              COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[69] + MW[70]) -              ; IVTT
              COEFF_IVTT * MW[19] * {AutoBRTSilverBullet} +                                        ; IVTT for silver bullet
              COEFF_IVTTCR * (MW[68]) +                                                         ; IVTT for commuter rail
              COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[74]) -                                         ; Transit fare
              COEFF_COST * {InflationParkCost} * (MW[14]/{OCCPNRAccess}) +                      ; Removes parking cost from knr path
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      JLOOP
        IF ((MW[64] + MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70])=0) MW[213]=-999.99
        IF (MW[2]<{MinDistAutoAcc}) MW[213]=-999.99
      ENDJLOOP
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[408]=((MW[212]+MW[213]+K_KNRBUS_AUTO0)/NC_KNRBus + auto_acc_dum)
      MW[418]=((MW[212]+MW[213]+K_KNRBUS_AUTO1)/NC_KNRBus + auto_acc_dum)
      MW[428]=((MW[212]+MW[213]+K_KNRBUS_AUTO2)/NC_KNRBus + auto_acc_dum)
     elseif (ACC=2)
      MW[438]=((MW[212]+MW[213]+K_KNRBUS_AUTO0)/NC_KNRBus + auto_acc_dum)
      MW[448]=((MW[212]+MW[213]+K_KNRBUS_AUTO1)/NC_KNRBus + auto_acc_dum)
      MW[458]=((MW[212]+MW[213]+K_KNRBUS_AUTO2)/NC_KNRBus + auto_acc_dum)
     elseif (ACC=3)
      MW[468]=((MW[212]+MW[213]+K_KNRBUS_AUTO0)/NC_KNRBus + auto_acc_dum)
      MW[478]=((MW[212]+MW[213]+K_KNRBUS_AUTO1)/NC_KNRBus + auto_acc_dum)
      MW[488]=((MW[212]+MW[213]+K_KNRBUS_AUTO2)/NC_KNRBus + auto_acc_dum)
     endif

  ;   KNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[214]=COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
              COEFF_OVT * (MW[16] - MW[15]) +                                                   ; Delta of knr term time and pnr term time for auto-bus - pnr term time on auto connector)
              COEFF_IVTT * (MW[82]) +                                                           ; Auto access time
              COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[89] + MW[90]) +              ; IVTT
              COEFF_IVTTCR * (MW[88]) -                                                         ; IVTT for commuter rail
              COEFF_IVTTCR * 1.00 * {AutoCRLSilverBullet} +                                        ; IVTT for silver bullet
              COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[94]) -                                         ; Transit fare
              COEFF_COST * {InflationParkCost} * (MW[17]/{OCCPNRAccess}) +                      ; Removes parking cost from knr path
@isNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J] +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      JLOOP
        IF ((MW[90])=0) MW[215]=-999.99
        IF (MW[2]<{MinDistAutoAcc}) MW[215]=-999.99
      ENDJLOOP
  ;   COMPOSITE UTILITY
     if (ACC=1)
      MW[409]=((MW[214]+MW[215]+K_KNRPREM_AUTO0)/NC_KNRPrj + auto_acc_dum)
      MW[419]=((MW[214]+MW[215]+K_KNRPREM_AUTO1)/NC_KNRPrj + auto_acc_dum)
      MW[429]=((MW[214]+MW[215]+K_KNRPREM_AUTO2)/NC_KNRPrj + auto_acc_dum)
     elseif (ACC=2)
      MW[439]=((MW[214]+MW[215]+K_KNRPREM_AUTO0)/NC_KNRPrj + auto_acc_dum)
      MW[449]=((MW[214]+MW[215]+K_KNRPREM_AUTO1)/NC_KNRPrj + auto_acc_dum)
      MW[459]=((MW[214]+MW[215]+K_KNRPREM_AUTO2)/NC_KNRPrj + auto_acc_dum)
     elseif (ACC=3)
      MW[469]=((MW[214]+MW[215]+K_KNRPREM_AUTO0)/NC_KNRPrj + auto_acc_dum)
      MW[479]=((MW[214]+MW[215]+K_KNRPREM_AUTO1)/NC_KNRPrj + auto_acc_dum)
      MW[489]=((MW[214]+MW[215]+K_KNRPREM_AUTO2)/NC_KNRPrj + auto_acc_dum)
     endif

; use ZAPZERO here to zero out the drive alone and PNR access trips for zero-car households
      if ( ({ZAPZERO} = 1) && (('@PURP@'=='HBW') || ('@PURP@'=='HBNW')) )
        MW[401] = -999.99        ; drive alone for 0car households - can walk to transit trips
        MW[431] = -999.99        ; drive alone for 0car households - must drive to transit trips
        MW[461] = -999.99        ; drive alone for 0car households - no transit trips
        MW[406] = -999.99        ; PNR-bus trips for 0car households - can walk to transit trips
        MW[436] = -999.99        ; PNR-bus trips for 0car households - must drive to transit trips
        MW[466] = -999.99        ; PNR-bus trips for 0car households - no transit trips
        MW[407] = -999.99        ; PNR-prj trips for 0car households - can walk to transit trips
        MW[437] = -999.99        ; PNR-prj trips for 0car households - must drive to transit trips
        MW[467] = -999.99        ; PNR-prj trips for 0car households - no transit trips
      endif

JLOOP
if (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
   print list='\n\n********************************************************************************************', printo=1
   print list=' Access Type: ',ACC(1.0),'. ',ACC_NAME, printo=1
   print list='********************************************************************************************','\n' printo=1
   print list='Value of CBD dummy at production-end (1 or 0)                     ',ZI.1.CBD_DUMMY[I],printo=1
   print list='Value of CBD dummy at attraction-end (1 or 0)                     ',ZI.1.CBD_DUMMY[J],printo=1
   print list='Value of EXURBAN dummy at production-end (1 or 0)                 ',ZI.1.EXU_DUMMY[I],printo=1
   print list='Value of EXURBAN dummy at attraction-end (1 or 0)                 ',ZI.1.EXU_DUMMY[J],printo=1

   print list='\n\n\nElements used in Drive Alone disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                   ',MW[3][J],printo=1
   print list='Out of Vehicle time (Terminal time at production-end)             ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)             ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                      ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                       ',MW[2][J],printo=1
   print list='Highway Toll (in $)                                               ',MW[1][J],printo=1
   print list='\nDrive alone disutility                                            ',MW[201][J](10.4),printo=1
   print list='\nDrive alone composite disutility (0 car)                          ',MW[401+_idx][J](10.4),printo=1
   print list='Drive alone composite disutility (1 car)                          ',MW[411+_idx][J](10.4),printo=1
   print list='Drive alone composite disutility (2 car)                          ',MW[421+_idx][J](10.4),printo=1
   print list='\nExponentiated drive alone composite disutility (0 car)        ',exp(MW[401+_idx][J])(14.12),printo=1
   print list='Exponentiated drive alone composite disutility (1 car)        ',exp(MW[411+_idx][J])(14.12),printo=1
   print list='Exponentiated drive alone composite disutility (2 car)        ',exp(MW[421+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in Shared Ride 2 disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                   ',MW[3][J],printo=1
   print list='In-Vehicle time savings by using HOV lanes                        ',MAX((MW[7][J]-MW[3][J]), 0),printo=1
   print list='Out of Vehicle time (Terminal time at production-end)             ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)             ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                      ',ZI.1.@PRK@[J],printo=1
   print list='Highway Toll (in $)                                               ',MW[1][J],printo=1
   print list='\nShared ride 2 disutility                                          ',MW[202][J](10.4),printo=1
   print list='\nShared ride 2 composite disutility (0 car)                        ',MW[402+_idx][J](10.4),printo=1
   print list='Shared ride 2 composite disutility (1 car)                        ',MW[412+_idx][J](10.4),printo=1
   print list='Shared ride 2 composite disutility (2 car)                        ',MW[422+_idx][J](10.4),printo=1
   print list='\nExponentiated shared ride composite disutility (0 car)        ',exp(MW[402+_idx][J])(14.12),printo=1
   print list='Exponentiated shared ride 2 composite disutility (1 car)      ',exp(MW[412+_idx][J])(14.12),printo=1
   print list='Exponentiated shared ride 2 composite disutility (2 car)      ',exp(MW[422+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in Shared Ride 2+ disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                   ',MW[3][J],printo=1
   print list='In-Vehicle time savings by using HOV lanes                        ',MAX((MW[7][J]-MW[3][J]), 0),printo=1
   print list='Out of Vehicle time (Terminal time at production-end)             ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)             ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                      ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                       ',MW[6][J],printo=1
   print list='Occupancy rate for this purpose                                   ',@OCC3@,printo=1
   print list='Highway Toll (in $)                                               ',MW[1][J],printo=1
   print list='\nShared ride 2+ disutility                                         ',MW[203][J](10.4),printo=1
   print list='\nShared ride 2+ composite disutility (0 car)                       ',MW[403+_idx][J](10.4),printo=1
   print list='Shared ride 2+ composite disutility (1 car)                       ',MW[413+_idx][J](10.4),printo=1
   print list='Shared ride 2+ composite disutility (2 car)                       ',MW[423+_idx][J](10.4),printo=1
   print list='\nExponentiated shared ride 2+ composite disutility (0 car)     ',exp(MW[403+_idx][J])(14.12),printo=1
   print list='Exponentiated shared ride 2+ composite disutility (1 car)     ',exp(MW[413+_idx][J])(14.12),printo=1
   print list='Exponentiated shared ride 2+ composite disutility (2 car)     ',exp(MW[423+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in Walk Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[24][J],printo=1
   print list='In-Vehicle time (Prem Bus)                                        ',MW[25][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[26][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[27][J]+MW[28][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[30][J],printo=1
   print list='Silver bullet in IVT minutes                                      ',(MW[18][J]*{WalkSilverBullet}),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[21][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[23][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[32][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[33][J],printo=1
   print list='Number of transfers                                               ',MW[31][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[34][J],printo=1
   print list='\nWalk Bus disutility                                               ',(MW[204][J]+MW[205][J])(10.4),printo=1
   print list='Walk access dummy (added to the utility)                          ',walk_acc_dum,printo=1
   print list='\nWalk Bus composite disutility (0 car)                             ',MW[404+_idx][J](10.4),printo=1
   print list='Walk Bus composite disutility (1 car)                             ',MW[414+_idx][J](10.4),printo=1
   print list='Walk Bus composite disutility (2+ car)                            ',MW[424+_idx][J](10.4),printo=1
   print list='\nExponentiated walk bus composite disutility (0 car)           ',exp(MW[404+_idx][J])(14.12),printo=1
   print list='Exponentiated walk bus composite disutility (1 car)           ',exp(MW[414+_idx][J])(14.12),printo=1
   print list='Exponentiated walk bus composite disutility (2 car)           ',exp(MW[424+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in Walk Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[44][J],printo=1
   print list='In-Vehicle time (Prem Bus)                                        ',MW[45][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[46][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[47][J]+MW[48][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[50][J],printo=1
   print list='Silver bullet in IVT minutes                                      ',(1.00*{WalkSilverBullet}),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[41][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[43][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[52][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[53][J],printo=1
   print list='Number of transfers                                               ',MW[51][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[54][J],printo=1
   print list='\nWalk Bus disutility                                               ',(MW[206][J]+MW[207][J])(10.4),printo=1
   print list='Walk access dummy (added to the utility)                          ',walk_acc_dum,printo=1
   print list='\nWalk Prj composite disutility (0 car)                             ',MW[405+_idx][J](10.4),printo=1
   print list='Walk Prj composite disutility (1 car)                             ',MW[415+_idx][J](10.4),printo=1
   print list='Walk Prj composite disutility (2 car)                             ',MW[425+_idx][J](10.4),printo=1
   print list='\nExponentiated walk prj composite disutility (0 car)           ',exp(MW[405+_idx][J])(14.12),printo=1
   print list='Exponentiated walk prj composite disutility (1 car)           ',exp(MW[415+_idx][J])(14.12),printo=1
   print list='Exponentiated walk prj composite disutility (2 car)           ',exp(MW[425+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in PNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[64][J],printo=1
   print list='In-Vehicle time (Prem Bus)                                        ',MW[65][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[66][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[67][J]+MW[68][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[70][J],printo=1
   print list='Silver bullet in IVT minutes                                      ',(MW[19][J]*{AutoSilverBullet}),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[61][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min - all costs)     ',MW[62][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[63][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[72][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[73][J],printo=1
   print list='Number of transfers                                               ',MW[71][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[74][J],printo=1
   print list='\nPNR Bus disutility                                                ',(MW[208][J]+MW[209][J])(10.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nPNR Bus composite disutility (0 car)                              ',MW[406+_idx][J](10.4),printo=1
   print list='PNR Bus composite disutility (1 car)                              ',MW[416+_idx][J](10.4),printo=1
   print list='PNR Bus composite disutility (2 car)                              ',MW[426+_idx][J](10.4),printo=1
   print list='\nExponentiated PNR Bus composite disutility (0 car)            ',exp(MW[406+_idx][J])(14.12),printo=1
   print list='Exponentiated PNR Bus composite disutility (1 car)            ',exp(MW[416+_idx][J])(14.12),printo=1
   print list='Exponentiated PNR Bus composite disutility (2 car)            ',exp(MW[426+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in PNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[84][J],printo=1
   print list='In-Vehicle time (Prem Bus)                                        ',MW[85][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[86][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[87][J]+MW[88][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[90][J],printo=1
   print list='Silver bullet in IVT minutes                                      ',(1.00*{AutoSilverBullet}),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[81][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[82][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[83][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[92][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[93][J],printo=1
   print list='Number of transfers                                               ',MW[91][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[94][J],printo=1
   print list='\nPNR Prj disutility                                                ',(MW[210][J]+MW[211][J])(10.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nPNR Prj composite disutility (0 car)                              ',MW[407+_idx][J](10.4),printo=1
   print list='PNR Prj composite disutility (1 car)                              ',MW[417+_idx][J](10.4),printo=1
   print list='PNR Prj composite disutility (2 car)                              ',MW[427+_idx][J](10.4),printo=1
   print list='\nExponentiated PNR prj composite disutility (0 car)            ',exp(MW[407+_idx][J])(14.12),printo=1
   print list='Exponentiated PNR prj composite disutility (1 car)            ',exp(MW[417+_idx][J])(14.12),printo=1
   print list='Exponentiated PNR prj composite disutility (2 car)            ',exp(MW[427+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in KNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[64][J],printo=1
   print list='In-Vehicle time (Prem Bus)                                        ',MW[65][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[66][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[67][J]+MW[68][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[70][J],printo=1
   print list='Silver bullet in IVT minutes                                      ',(MW[19][J]*{AutoSilverBullet}),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[61][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)-includes PKCST  ',MW[62][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[63][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[72][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[73][J],printo=1
   print list='Out of Vehicle time (KNR terminal time at parking station)        ',MW[13][J],printo=1
   print list='Out of Vehicle time (PNR terminal time at parking station)        ',MW[12][J],printo=1
   print list='Parking cost (in cents - taken out of the utility equation)       ',MW[14][J],printo=1
   print list='Number of transfers                                               ',MW[71][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[74][J],printo=1
   print list='\nKNR Bus disutility                                                ',(MW[212][J]+MW[213][J])(10.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Bus composite disutility (0 car)                              ',MW[408+_idx][J](10.4),printo=1
   print list='KNR Bus composite disutility (1 car)                              ',MW[418+_idx][J](10.4),printo=1
   print list='KNR Bus composite disutility (2 car)                              ',MW[428+_idx][J](10.4),printo=1
   print list='\nExponentiated KNR Bus composite disutility (0 car)            ',exp(MW[408+_idx][J])(14.12),printo=1
   print list='Exponentiated KNR Bus composite disutility (1 car)            ',exp(MW[418+_idx][J])(14.12),printo=1
   print list='Exponentiated KNR Bus composite disutility (2 car)            ',exp(MW[428+_idx][J])(14.12),printo=1

   print list='\n\n\nElements used in KNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[84][J],printo=1
   print list='In-Vehicle time (Prem Bus)                                        ',MW[85][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[86][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[87][J]+MW[88][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[90][J],printo=1
   print list='Silver bullet in IVT minutes                                      ',(1.00*{AutoSilverBullet}),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[81][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[82][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[83][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[92][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[93][J],printo=1
   print list='Out of Vehicle time (KNR terminal time at parking station)        ',MW[16][J],printo=1
   print list='Out of Vehicle time (PNR terminal time at parking station)        ',MW[15][J],printo=1
   print list='Parking cost (in cents - taken out of the utility equation)       ',MW[17][J],printo=1
   print list='Number of transfers                                               ',MW[91][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[94][J],printo=1
   print list='\nKNR Prj disutility                                                ',(MW[214][J]+MW[215][J])(10.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Prj composite disutility (0 car)                              ',MW[409+_idx][J](10.4),printo=1
   print list='KNR Prj composite disutility (1 car)                              ',MW[419+_idx][J](10.4),printo=1
   print list='KNR Prj composite disutility (2 car)                              ',MW[429+_idx][J](10.4),printo=1
   print list='\nExponentiated KNR prj composite disutility (0 car)            ',exp(MW[409+_idx][J])(14.12),printo=1
   print list='Exponentiated KNR prj composite disutility (1 car)            ',exp(MW[419+_idx][J])(14.12),printo=1
   print list='Exponentiated KNR prj composite disutility (2 car)            ',exp(MW[429+_idx][J])(14.12),printo=1
   print list='\n\n',printo=1
   print list='\n\n\nCALCULATED SHARES USING UTILITIES (CHECK IT AGAINST THE XCHOICE RESULTS):',printo=1
   print list='*******************************************************************************',printo=1
endif

ENDJLOOP

; loop for market segments - 0 car, 1 car and 2+ cars
  LOOP MARKET=1,3
  JLOOP
  if (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
   _konn = 0.0000000000000001
   _idx=(ACC-1)*30
   _cnt = (_idx + (MARKET-1)*10)
   if (MARKET=1) MARKET_NAME='Zero Car HHs'
   if (MARKET=2) MARKET_NAME='One Car HHs '
   if (MARKET=3) MARKET_NAME='Two+ Car HHs'

   print list='\n\nMARKET:           ',MARKET_NAME,printo=1
   print list='***************************************************',printo=1
   ; walk mode nest
   if ((exp(MW[404+_cnt][J])+exp(MW[405+_cnt][J]))>_konn)
     shrwkb=exp(MW[404+_cnt][J])/(exp(MW[404+_cnt][J])+exp(MW[405+_cnt][J]))
     shrwkp=exp(MW[405+_cnt][J])/(exp(MW[404+_cnt][J])+exp(MW[405+_cnt][J]))
     eutilwk=exp(NC_TRNAC*ln(exp(MW[404+_cnt][J])+exp(MW[405+_cnt][J])))
   else
     shrwkb=0
     shrwkp=0
     eutilwk=0
   endif
   print list='\n\nExponentiated Walk mode nest disutility   ',eutilwk(14.12),printo=1
   ; PNR mode nest
   if ((exp(MW[406+_cnt][J])+exp(MW[407+_cnt][J]))>_konn)
     shrpnrb=exp(MW[406+_cnt][J])/(exp(MW[406+_cnt][J])+exp(MW[407+_cnt][J]))
     shrpnrp=exp(MW[407+_cnt][J])/(exp(MW[406+_cnt][J])+exp(MW[407+_cnt][J]))
     eutilpnr=exp(NC_TRNAC*ln(exp(MW[406+_cnt][J])+exp(MW[407+_cnt][J])))
   else
     shrpnrb=0
     shrpnrp=0
     eutilpnr=0
   endif
   print list='\nExponentiated PNR mode nest disutility    ',eutilpnr(14.12),printo=1
   ; KNR mode nest
   if ((exp(MW[408+_cnt][J])+exp(MW[409+_cnt][J]))>_konn)
     shrknrb=exp(MW[408+_cnt][J])/(exp(MW[408+_cnt][J])+exp(MW[409+_cnt][J]))
     shrknrp=exp(MW[409+_cnt][J])/(exp(MW[408+_cnt][J])+exp(MW[409+_cnt][J]))
     eutilknr=exp(NC_TRNAC*ln(exp(MW[408+_cnt][J])+exp(MW[409+_cnt][J])))
   else
     shrknrb=0
     shrknrp=0
     eutilknr=0
   endif
   print list='\nExponentiated KNR mode nest disutility    ',eutilknr(14.12),printo=1
   ; transit nest
   if ((exp(MW[404+_cnt][J])+exp(MW[405+_cnt][J])+exp(MW[406+_cnt][J])+exp(MW[407+_cnt][J])+exp(MW[408+_cnt][J])+exp(MW[409+_cnt][J]))>_konn)
     shrwkt=eutilwk/(eutilwk+eutilpnr+eutilknr)
     shrpnrt=eutilpnr/(eutilwk+eutilpnr+eutilknr)
     shrknrt=eutilknr/(eutilwk+eutilpnr+eutilknr)
     eutilt=exp(NC_TRN*ln(eutilwk+eutilpnr+eutilknr))
   else
     shrwkt=0
     shrpnrt=0
     shrknrt=0
     eutilt=0
   endif
   print list='\nExponentiated Transit disutility          ',eutilt(14.12),printo=1
   ; hov nest
   if ((exp(MW[402+_cnt][J])+exp(MW[403+_cnt][J]))>_konn)
     shrhov2sr=exp(MW[402+_cnt][J])/(exp(MW[402+_cnt][J])+exp(MW[403+_cnt][J]))
     shrhov3sr=exp(MW[403+_cnt][J])/(exp(MW[402+_cnt][J])+exp(MW[403+_cnt][J]))
     eutilsr=exp(NC_AUTOSR*ln(exp(MW[402+_cnt][J])+exp(MW[403+_cnt][J])))
   else
     shrhov2sr=0
     shrhov3sr=0
     eutilsr=0
   endif
   print list='\nExponentiated HOV nest disutility         ',eutilsr(14.12),printo=1
   ; auto nest
   if ((exp(MW[401+_cnt][J])+eutilsr)>_konn)
     shrdaa=exp(MW[401+_cnt][J])/(exp(MW[401+_cnt][J])+eutilsr)
     shrsra=eutilsr/(exp(MW[401+_cnt][J])+eutilsr)
     eutila=exp(NC_AUTO*ln(exp(MW[401+_cnt][J])+eutilsr))
   else
     shrdaa=0
     shrsra=0
     eutila=0
   endif
   print list='\nExponentiated Auto disutility             ',eutila(14.12),printo=1
   ; top nest
   if ((eutila+eutilt)>_konn)
     shra=eutila/(eutila+eutilt)
     shrt=eutilt/(eutila+eutilt)
     eutil=(eutila+eutilt)
   else
     shra=0
     shrt=0
     eutil=0
   endif
   print list='\nExponentiated total disutility            ',eutil(14.12),printo=1
   ; individual shares
   shrda=shrdaa*shra
   shrhov2=shrhov2sr*shrsra*shra
   shrhov3=shrhov3sr*shrsra*shra
   shrwalkbus=shrwkb*shrwkt*shrt
   shrwalkprj=shrwkp*shrwkt*shrt
   shrpnrbus=shrpnrb*shrpnrt*shrt
   shrpnrprj=shrpnrp*shrpnrt*shrt
   shrknrbus=shrknrb*shrknrt*shrt
   shrknrprj=shrknrp*shrknrt*shrt
   ; print shares
   print list='\n\nTrips by mode:                       Share',printo=1
   print list='    Drive Alone                    ',shrda(7.4),printo=1
   print list='    HOV2                           ',shrhov2(7.4),printo=1
   print list='    HOV3                           ',shrhov3(7.4),printo=1
   print list='    Walk Bus                       ',shrwalkbus(7.4),printo=1
   print list='    Walk Prj                       ',shrwalkprj(7.4),printo=1
   print list='    PNR Bus                        ',shrpnrbus(7.4),printo=1
   print list='    PNR Prj                        ',shrpnrprj(7.4),printo=1
   print list='    KNR Bus                        ',shrknrbus(7.4),printo=1
   print list='    KNR Prj                        ',shrknrprj(7.4),printo=1
   print list='\n\nCalculated shares using the utility equations:       ', printo=1
   print list='   Top Nest:                                         ', printo=1
   print list='        Auto Share               ',shra(6.4), printo=1
   print list='        Transit Share            ',shrt(6.4), printo=1
   print list='\n\n   Auto Nest:                                    ', printo=1
   print list='        Drive Alone Share        ',shrdaa(6.4), printo=1
   print list='        Shared Ride Share        ',shrsra(6.4), printo=1
   print list='\n\n   Shared Ride Nest:                             ', printo=1
   print list='        HOV2 Share               ',shrhov2sr(6.4), printo=1
   print list='        HOV3 Share               ',shrhov3sr(6.4), printo=1
   print list='\n\n   Transit Nest:                                 ', printo=1
   print list='        Walk Transit Share       ',shrwkt(6.4), printo=1
   print list='        PNR Transit Share        ',shrpnrt(6.4), printo=1
   print list='        KNR Transit Share        ',shrknrt(6.4), printo=1
   print list='\n\n   Walk Nest:                                 ', printo=1
   print list='        Walk Bus Share           ',shrwkb(6.4), printo=1
   print list='        Walk Prj Share           ',shrwkp(6.4), printo=1
   print list='\n\n   PNR Nest:                                 ', printo=1
   print list='        PNR Bus Share            ',shrpnrb(6.4), printo=1
   print list='        PNR Prj Share            ',shrpnrp(6.4), printo=1
   print list='\n\n   KNR Nest:                                 ', printo=1
   print list='        KNR Bus Share            ',shrknrb(6.4), printo=1
   print list='        KNR Prj Share            ',shrknrp(6.4), printo=1
  endif
  ENDJLOOP
  ENDLOOP


ENDLOOP

ENDRUN
