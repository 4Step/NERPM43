; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00D.PRN" MSG='Utilities and XCHOICE'
DistributeINTRASTEP ProcessID='NERPM3', ProcessList=1-4
FILEO MATO[12] = "{SCENARIO_DIR}\output\farexfer_tmp.mat",
MO=211-228,DEC=18*2,NAME=farewb,farewp,farepb,farepp,farekb,farekp,fareckb,fareckp,farefp,xferwb,xferwp,xferpb,xferpp,xferkb,xferkp,xferckb,xferckp,xferfp
FILEO MATO[11] = "{SCENARIO_DIR}\output\expautoutil_tmp.mat",
MO=56-58,36-38,DEC=6*D,NAME=EXPA_0CAR,EXPA_1CAR,EXPA_2CAR,SPLITCMP_0CAR,SPLITCMP_1CAR,SPLITCMP_2CAR
FILEO MATO[10] = "{SCENARIO_DIR}\output\@PURP@Trip.MAT",
MO=601-612,621-632,641-652,251-254,261-269,DEC=49*S
FILEO MATO[9] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_2CAR.MAT",
MO=797-808,DEC=12*s,NAME=DANT2CAR,SR2NT2CAR,SR3NT2CAR,WBNT2CAR,WPNT2CAR,PBNT2CAR,PPNT2CAR,KBNT2CAR,KPNT2CAR,CKBNT2CAR,CKPNT2CAR,FRGPNRNT2CAR
FILEO MATO[8] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_1CAR.MAT",
MO=785-796,DEC=12*s,NAME=DANT1CAR,SR2NT1CAR,SR3NT1CAR,WBNT1CAR,WPNT1CAR,PBNT1CAR,PPNT1CAR,KBNT1CAR,KPNT1CAR,CKBNT1CAR,CKPNT1CAR,FRGPNRNT1CAR
FILEO MATO[7] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_0CAR.MAT",
MO=773-784,DEC=12*s,NAME=DANT0CAR,SR2NT0CAR,SR3NT0CAR,WBNT0CAR,WPNT0CAR,PBNT0CAR,PPNT0CAR,KBNT0CAR,KPNT0CAR,CKBNT0CAR,CKPNT0CAR,FRGPNRNT0CAR
FILEO MATO[6] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_2CAR.MAT",
MO=761-772,DEC=12*s,NAME=DAMD2CAR,SR2MD2CAR,SR3MD2CAR,WBMD2CAR,WPMD2CAR,PBMD2CAR,PPMD2CAR,KBMD2CAR,KPMD2CAR,CKBMD2CAR,CKPMD2CAR,FRGPNRMD2CAR
FILEO MATO[5] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_1CAR.MAT",
MO=749-760,DEC=12*s,NAME=DAMD1CAR,SR2MD1CAR,SR3MD1CAR,WBMD1CAR,WPMD1CAR,PBMD1CAR,PPMD1CAR,KBMD1CAR,KPMD1CAR,CKBMD1CAR,CKPMD1CAR,FRGPNRMD1CAR
FILEO MATO[4] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_0CAR.MAT",
MO=737-748,DEC=12*s,NAME=DAMD0CAR,SR2MD0CAR,SR3MD0CAR,WBMD0CAR,WPMD0CAR,PBMD0CAR,PPMD0CAR,KBMD0CAR,KPMD0CAR,CKBMD0CAR,CKPMD0CAR,FRGPNRMD0CAR
FILEO MATO[3] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_2CAR.MAT",
MO=725-736,DEC=12*s,NAME=DACW2CAR,SR2CW2CAR,SR3CW2CAR,WBCW2CAR,WPCW2CAR,PBCW2CAR,PPCW2CAR,KBCW2CAR,KPCW2CAR,CKBCW2CAR,CKPCW2CAR,FRGPNRCW2CAR
FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_1CAR.MAT",
MO=713-724,DEC=12*s,NAME=DACW1CAR,SR2CW1CAR,SR3CW1CAR,WBCW1CAR,WPCW1CAR,PBCW1CAR,PPCW1CAR,KBCW1CAR,KPCW1CAR,CKBCW1CAR,CKPCW1CAR,FRGPNRCW1CAR
FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_0CAR.MAT",
MO=701-712,DEC=12*s,NAME=DACW0CAR,SR2CW0CAR,SR3CW0CAR,WBCW0CAR,WPCW0CAR,PBCW0CAR,PPCW0CAR,KBCW0CAR,KPCW0CAR,CKBCW0CAR,CKPCW0CAR,FRGPNRCW0CAR
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSum.TXT",
append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebug.TXT",
append=t

FILEI ZDATI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"

FILEI MATI[14] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT"
        ; Tables
FILEI MATI[13] = "{SCENARIO_DIR}\output\PTRIPSMC.MAT"
FILEI MATI[12] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
; Table 1-14: PKStationTAZ_pnrb,PKStationTAZ_knrb,PKStationTAZ_cbdknrb,PKStationTAZ_frg,PKStationTAZ_pnrp,PKStationTAZ_knrp,PKStationTAZ_cbdknrp,
;             OPStationTAZ_pnrb,OPStationTAZ_knrb,OPStationTAZ_cbdknrb,OPStationTAZ_frg,OPStationTAZ_pnrp,OPStationTAZ_knrp,OPStationTAZ_cbdknrp
FILEI MATI[11] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT"
           ; Table 1 - HOV time savings for peak period
           ; Table 2 - HOV time savings for off-peak period
FILEI MATI[10] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@9_{Alt}{year}.MAT"
FILEI MATI[9] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@8_{Alt}{year}.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@7_{Alt}{year}.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@6_{Alt}{year}.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@5_{Alt}{year}.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@4_{Alt}{year}.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@3_{Alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@2_{Alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM@PERIOD@1_{Alt}{year}.MAT"
           ; Tables 1-6: 1-WalkTime, 2-AutoTime, 3-XferTime, 4-BusTime, 5-PRJBusTime, 6-CircTime
           ; Tables 7-10: 7-RailTime, 8-CommuterRailTime, 9-OtherModeTime, 10-ProjectModeTime
           ; Tables 11-15: 11-NumXfers, 12-InitialWaitTime, 13-XferWaitTime, 14-Fare, 15-Total time
FILEI MATI[1] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"
           ; Tables 1-4 for SOV: 1-Toll, 2-Distance, 3-Time, 4-Weighted Time
           ; Tables 5-8 for HOV: 5-Toll, 6-Distance, 7-Time, 8-Weighted Time
           ; Table 9 is terminal time

zonemsg=100
ARRAY PARK={ZONESA}

;Constants
LOOKUP, NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, , LIST=Y, LOOKUPI=1
;K=CONSTANT
if (i=FirstZone)
 K_DA_AUTO0=CONSTANTS(1,1),         K_DA_AUTO1=CONSTANTS(1,13),        K_DA_AUTO2=CONSTANTS(1,25)
 K_SR1PASS_AUTO0=CONSTANTS(1,2),    K_SR1PASS_AUTO1=CONSTANTS(1,14),   K_SR1PASS_AUTO2=CONSTANTS(1,26)
 K_SR2PASS_AUTO0=CONSTANTS(1,3),    K_SR2PASS_AUTO1=CONSTANTS(1,15),   K_SR2PASS_AUTO2=CONSTANTS(1,27)
 K_WALKBUS_AUTO0=CONSTANTS(1,4),    K_WALKBUS_AUTO1=CONSTANTS(1,16),   K_WALKBUS_AUTO2=CONSTANTS(1,28)
 K_WALKPRJ_AUTO0=CONSTANTS(1,5),    K_WALKPRJ_AUTO1=CONSTANTS(1,17),   K_WALKPRJ_AUTO2=CONSTANTS(1,29)
 K_PNRBUS_AUTO0=CONSTANTS(1,6),     K_PNRBUS_AUTO1=CONSTANTS(1,18),    K_PNRBUS_AUTO2=CONSTANTS(1,30)
 K_PNRPRJ_AUTO0=CONSTANTS(1,7),     K_PNRPRJ_AUTO1=CONSTANTS(1,19),    K_PNRPRJ_AUTO2=CONSTANTS(1,31)
 K_KNRBUS_AUTO0=CONSTANTS(1,8),     K_KNRBUS_AUTO1=CONSTANTS(1,20),    K_KNRBUS_AUTO2=CONSTANTS(1,32)
 K_KNRPRJ_AUTO0=CONSTANTS(1,9),     K_KNRPRJ_AUTO1=CONSTANTS(1,21),    K_KNRPRJ_AUTO2=CONSTANTS(1,33)
 K_CBDKNRBUS_AUTO0=CONSTANTS(1,10), K_CBDKNRBUS_AUTO1=CONSTANTS(1,22), K_CBDKNRBUS_AUTO2=CONSTANTS(1,34)
 K_CBDKNRPRJ_AUTO0=CONSTANTS(1,11), K_CBDKNRPRJ_AUTO1=CONSTANTS(1,23), K_CBDKNRPRJ_AUTO2=CONSTANTS(1,35)
 K_FRGPNRCIR_AUTO0=CONSTANTS(1,12), K_FRGPNRCIR_AUTO1=CONSTANTS(1,24), K_FRGPNRCIR_AUTO2=CONSTANTS(1,36)

 LOOP xx=1,{ZONESA}
  PARK[xx] = ZI.2.STPKCS2[xx]
 ENDLOOP
endif

;Coefficients
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=2
;Coefficients
if (i=FirstZone)
; Transit Coefficients
 COEFF_IVTT   = COEFF(1,1)
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
 NC_FRINGE    = COEFF(1,14)
 COEFF_DCBD_WALK   = COEFF(1,15)
 COEFF_DCBD_PNR    = COEFF(1,16)
 COEFF_DCBD_KNR    = COEFF(1,17)
 COEFF_DCBD_CBDKNR = COEFF(1,18)

; Nesting Coefficients
 NC_DriveAlone = NC_AUTO
 NC_FringePark = NC_FRINGE
 NC_SharedRide = NC_AUTO * NC_AUTOSR
 NC_WALKBUS = NC_TRN * NC_TRNAC
 NC_WALKPRJ = NC_TRN * NC_TRNAC
 NC_PNRBus = NC_TRN * NC_TRNAC
 NC_PNRPrj = NC_TRN * NC_TRNAC
 NC_KNRBus = NC_TRN * NC_TRNAC
 NC_KNRPrj = NC_TRN * NC_TRNAC
endif

; Additional Bias Constants, to be used for non-FTA New Starts 'silver bullet' analyses
_ABC1 =  0.0 * COEFF_IVTT * -1.0
_ABC2 =  0.0 * COEFF_IVTT * -1.0
_ABC3 =  0.0 * COEFF_IVTT * -1.0
_ABC4 =  0.0 * COEFF_IVTT * -1.0
_ABC5 =  0.0 * COEFF_IVTT * -1.0

FILLMW MW[1]=MI.1.1,2,3,4,5,6,7,8,9        ; highway skims
FILLMW MW[11]=MI.11.HOVsave@PERIOD@         ; HOVsavePK for peak period (HBW) and HOVsaveOP for off-peak period (HBNW and NHB)
FILLMW MW[290]=MI.12.@STATION_TABLE@         ; 7 tables - stations zones for pnr-bus,knr-bus,cbdknr-bus,fringe,pnr-prj,knr-prj,cbdknr-prj paths
if ('@PURP@'='HBW')
 FILLMW MW[16]=MI.14.1  ; PK walk-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[17]=MI.14.2  ; PK pnr-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[18]=MI.14.3  ; PK knr-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[19]=MI.14.4  ; PK cbd knr-bus/BRT selectlink matrix for silver bullet
else
 FILLMW MW[16]=MI.14.5  ; OP walk-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[17]=MI.14.6  ; OP pnr-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[18]=MI.14.7  ; OP knr-bus/BRT selectlink matrix for silver bullet
 FILLMW MW[19]=MI.14.8  ; OP cbd knr-bus/BRT selectlink matrix for silver bullet
endif

FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskim1
FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims2
FILLMW MW[61]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims3
FILLMW MW[81]=MI.5.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims4
FILLMW MW[101]=MI.6.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims5
FILLMW MW[121]=MI.7.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims6
FILLMW MW[141]=MI.8.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims7
FILLMW MW[161]=MI.9.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims8
FILLMW MW[181]=MI.10.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;tskims9

FILLMW MW[211]=MI.2.14
FILLMW MW[212]=MI.3.14
FILLMW MW[213]=MI.4.14
FILLMW MW[214]=MI.5.14
FILLMW MW[215]=MI.6.14
FILLMW MW[216]=MI.7.14
FILLMW MW[217]=MI.8.14
FILLMW MW[218]=MI.9.14
FILLMW MW[219]=MI.10.14
FILLMW MW[220]=MI.2.11
FILLMW MW[221]=MI.3.11
FILLMW MW[222]=MI.4.11
FILLMW MW[223]=MI.5.11
FILLMW MW[224]=MI.6.11
FILLMW MW[225]=MI.7.11
FILLMW MW[226]=MI.8.11
FILLMW MW[227]=MI.9.11
FILLMW MW[228]=MI.10.11

FILLMW MW[251]=MI.13.@PURP@    ; person trip table

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
   print list='       OVT                  ',COEFF_OVT(7.4),printo=1
   print list='       AAT                  ',COEFF_AAT(7.4),printo=1
   print list='       XFER                 ',COEFF_XFER(7.4),printo=1
   print list='       COST                 ',COEFF_COST(7.4),printo=1
;  PRINT LIST='       DUM_CBD              ',COEFF_DCBD(7.4),printo=1
;  PRINT LIST='       DUM_EXURBAN PROD     ',COEFF_DEXUP(7.4),printo=1
;  PRINT LIST='       DUM_EXURBAN ATTR     ',COEFF_DEXUA(7.4),printo=1
   PRINT LIST='       DUM_CBD_WALK         ',COEFF_DCBD_WALK(7.4),printo=1
   PRINT LIST='       DUM_CBD_PNR          ',COEFF_DCBD_PNR(7.4),printo=1
   PRINT LIST='       DUM_CBD_KNR          ',COEFF_DCBD_KNR(7.4),printo=1
   PRINT LIST='       DUM_CBD_CBDKNR       ',COEFF_DCBD_CBDKNR(7.4),printo=1
   print list='\n\nNesting Coeffcient      ',printo=1
   print list='        NC_TRNAC            ',NC_TRNAC(7.4),printo=1
   print list='        NC_TRN              ',NC_TRN(7.4),printo=1
   print list='        NC_AUTOSR           ',NC_AUTOSR(7.4),printo=1
   print list='        NC_AUTO             ',NC_AUTO(7.4),printo=1
   print list='        NC_FRINGE           ',NC_FRINGE(7.4),printo=1
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
   print list='        Walk Prj (0 car)    ',K_WALKPRJ_auto0(8.4),printo=1
   print list='        Walk Prj (1 car)    ',K_WALKPRJ_auto1(8.4),printo=1
   print list='        PNR Bus (0 car)     ',K_PNRBUS_auto0(8.4),printo=1
   print list='        PNR Bus (1 car)     ',K_PNRBUS_auto1(8.4),printo=1
   print list='        PNR Bus (2 car)     ',K_PNRBUS_auto2(8.4),printo=1
   print list='        PNR Prj (1 car)     ',K_PNRPRJ_auto1(8.4),printo=1
   print list='        PNR Prj (2 car)     ',K_PNRPRJ_auto2(8.4),printo=1
   print list='        KNR Bus (0 car)     ',K_KNRBUS_auto0(8.4),printo=1
   print list='        KNR Bus (1 car)     ',K_KNRBUS_auto1(8.4),printo=1
   print list='        KNR Bus (2 car)     ',K_KNRBUS_auto2(8.4),printo=1
   print list='        KNR Prj (0 car)     ',K_KNRPRJ_auto0(8.4),printo=1
   print list='        KNR Prj (1 car)     ',K_KNRPRJ_auto1(8.4),printo=1
   print list='        KNR Prj (2 car)     ',K_KNRPRJ_auto2(8.4),printo=1
   print list='        CBDKNR Bus (0 car)  ',K_CBDKNRBUS_auto0(8.4),printo=1
   print list='        CBDKNR Bus (1 car)  ',K_CBDKNRBUS_auto1(8.4),printo=1
   print list='        CBDKNR Bus (2 car)  ',K_CBDKNRBUS_auto2(8.4),printo=1
   print list='        CBDKNR Prj (0 car)  ',K_CBDKNRPRJ_auto0(8.4),printo=1
   print list='        CBDKNR Prj (1 car)  ',K_CBDKNRPRJ_auto1(8.4),printo=1
   print list='        CBDKNR Prj (2 car)  ',K_CBDKNRPRJ_auto2(8.4),printo=1
   print list='        Fringe PNR (0 car)  ',K_FRGPNRCIR_auto0(8.4),printo=1
   print list='        Fringr PNR (1 car)  ',K_FRGPNRCIR_auto1(8.4),printo=1
   print list='        Fringe PNR (2 car)  ',K_FRGPNRCIR_auto2(8.4),printo=1
   print list='        ProjectModeFlag     ',{ProjectModeFlag}(8.0),printo=1
   print list='        Addl Bias Const 1   ',_ABC1(8.4),printo=1
   print list='        Addl Bias Const 2   ',_ABC2(8.4),printo=1
   print list='        Addl Bias Const 3   ',_ABC3(8.4),printo=1
   print list='        Addl Bias Const 4   ',_ABC4(8.4),printo=1
   print list='        Addl Bias Const 5   ',_ABC5(8.4),printo=1
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
   print list='Times are in minutes. Costs are in cents.        ',printo=1
 endif

 ; Echo to Mode Choice summary file
 PRINT LIST="\f+++++ MODE XCHOICE SUMMARY +++++\n" PRINTO=2
 PRINT LIST='-- @DATE.RUNDATE@     ','-- @TIME.RUNTIME@     ','\n',PRINTO=2
 PRINT LIST="{DESCR}" PRINTO=2
 PRINT LIST="{SCENARIO_SHORTNAME}\n" PRINTO=2
 PRINT LIST='PURPOSE -           @PURP@  ',printo=2
 PRINT LIST='SKIMS/PERIOD        @PERIOD@',printo=2
 PRINT LIST='\nCoefficients                ',printo=2
 PRINT LIST='       IVTT                 ',COEFF_IVTT(7.4),printo=2
 PRINT LIST='       OVT                  ',COEFF_OVT(7.4),printo=2
 PRINT LIST='       AAT                  ',COEFF_AAT(7.4),printo=2
 PRINT LIST='       XFER                 ',COEFF_XFER(7.4),printo=2
 PRINT LIST='       COST                 ',COEFF_COST(7.4),printo=2
;PRINT LIST='       DUM_CBD              ',COEFF_DCBD(7.4),printo=2
;PRINT LIST='       DUM_EXURBAN PROD     ',COEFF_DEXUP(7.4),printo=2
;PRINT LIST='       DUM_EXURBAN ATTR     ',COEFF_DEXUA(7.4),printo=2
 PRINT LIST='       DUM_CBD_WALK         ',COEFF_DCBD_WALK(7.4),printo=2
 PRINT LIST='       DUM_CBD_PNR          ',COEFF_DCBD_PNR(7.4),printo=2
 PRINT LIST='       DUM_CBD_KNR          ',COEFF_DCBD_KNR(7.4),printo=2
 PRINT LIST='       DUM_CBD_CBDKNR       ',COEFF_DCBD_CBDKNR(7.4),printo=2
 PRINT LIST='\n\nNesting Coeffcient      ',printo=2
 PRINT LIST='        NC_TRNAC            ',NC_TRNAC(7.4),printo=2
 PRINT LIST='        NC_TRN              ',NC_TRN(7.4),printo=2
 PRINT LIST='        NC_AUTOSR           ',NC_AUTOSR(7.4),printo=2
 PRINT LIST='        NC_AUTO             ',NC_AUTO(7.4),printo=2
 print list='        NC_FRINGE           ',NC_FRINGE(7.4),printo=2
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
 PRINT LIST='        Walk Prj (0 car)    ',K_WALKPRJ_auto0(8.4),printo=2
 PRINT LIST='        Walk Prj (1 car)    ',K_WALKPRJ_auto1(8.4),printo=2
 PRINT LIST='        Walk Prj (2 car)    ',K_WALKPRJ_auto2(8.4),printo=2
 PRINT LIST='        PNR Bus (0 car)     ',K_PNRBUS_auto0(8.4),printo=2
 PRINT LIST='        PNR Bus (1 car)     ',K_PNRBUS_auto1(8.4),printo=2
 PRINT LIST='        PNR Bus (2 car)     ',K_PNRBUS_auto2(8.4),printo=2
 PRINT LIST='        PNR Prj (0 car)     ',K_PNRPRJ_auto0(8.4),printo=2
 PRINT LIST='        PNR Prj (1 car)     ',K_PNRPRJ_auto1(8.4),printo=2
 PRINT LIST='        PNR Prj (2 car)     ',K_PNRPRJ_auto2(8.4),printo=2
 PRINT LIST='        KNR Bus (0 car)     ',K_KNRBUS_auto0(8.4),printo=2
 PRINT LIST='        KNR Bus (1 car)     ',K_KNRBUS_auto1(8.4),printo=2
 PRINT LIST='        KNR Bus (2 car)     ',K_KNRBUS_auto2(8.4),printo=2
 PRINT LIST='        KNR Prj (0 car)     ',K_KNRPRJ_auto0(8.4),printo=2
 PRINT LIST='        KNR Prj (2 car)     ',K_KNRPRJ_auto2(8.4),printo=2
 print list='        CBDKNR Bus (0 car)  ',K_CBDKNRBUS_auto0(8.4),printo=2
 print list='        CBDKNR Bus (1 car)  ',K_CBDKNRBUS_auto1(8.4),printo=2
 print list='        CBDKNR Bus (2 car)  ',K_CBDKNRBUS_auto2(8.4),printo=2
 print list='        CBDKNR Prj (0 car)  ',K_CBDKNRPRJ_auto0(8.4),printo=2
 print list='        CBDKNR Prj (1 car)  ',K_CBDKNRPRJ_auto1(8.4),printo=2
 print list='        CBDKNR Prj (2 car)  ',K_CBDKNRPRJ_auto2(8.4),printo=2
 print list='        Fringe PNR (0 car)  ',K_FRGPNRCIR_auto0(8.4),printo=2
 print list='        Fringr PNR (1 car)  ',K_FRGPNRCIR_auto1(8.4),printo=2
 print list='        Fringe PNR (2 car)  ',K_FRGPNRCIR_auto2(8.4),printo=2
 print list='        ProjectModeFlag     ',{ProjectModeFlag}(8.0),printo=2
 print list='        Addl Bias Const 1   ',_ABC1(8.4),printo=2
 print list='        Addl Bias Const 2   ',_ABC2(8.4),printo=2
 print list='        Addl Bias Const 3   ',_ABC3(8.4),printo=2
 print list='        Addl Bias Const 4   ',_ABC4(8.4),printo=2
 print list='        Addl Bias Const 5   ',_ABC5(8.4),printo=2
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
 PRINT LIST='Times reflected in minutes.         ',printo=2
 PRINT LIST='Costs are in cents.                 ',printo=2

endif

; for debugging
;JLOOP
;  if ({DebugMC}=1)
;    if (I>{SELORIGIN}) EXIT
;    if (I<>{SELDEST}) BREAK
;  endif
;ENDJLOOP

; Divide person trip table into different markets
  MW[252]=MW[251] * ZI.1.PERCAUTO0[I]                                                                   ; Zero car HHs
; for NHB purpose, there is no market segmentation and hence put all trips into zer-car household trip table
  if ('@PURP@'='NHB') MW[252]=MW[251]
  MW[261] = MW[252] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
  MW[262] = MW[252] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
  MW[263] = MW[252] - MW[261] - MW[262]                                                                 ; No Access

  MW[253]=MW[251] * ZI.1.PERCAUTO1[I]                  ; Auto 1                                         ; One car HHs
  if ('@PURP@'='NHB') MW[253]=0
  MW[264] = MW[253] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
  MW[265] = MW[253] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
  MW[266] = MW[253] - MW[264] - MW[265]                                                                 ; No Access

;  MW[254]=MW[251] * ZI.1.PERCAUTO2[I]                  ; Auto 2                                        ; Two+ car HHs
  MW[254]=(MW[251] - MW[252] - MW[253])                 ; Auto 2                                        ; Two+ car HHs
  if ('@PURP@'='NHB') MW[254]=0
  MW[267] = MW[254] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
  MW[268] = MW[254] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
  MW[269] = MW[254] - MW[267] - MW[268]                                                                 ; No Access


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
    walk_acc_dum = -9999.99
    auto_acc_dum = 0.0
   elseif (ACC==3)
    ACC_NAME='NO TRANSIT'
    walk_acc_dum = -9999.99
    auto_acc_dum = -9999.99
   endif


; ******************************** UTILITY CALCULATIONS ************************************
  ;   DRIVE ALONE ELEMENTS OF UTILITY ARE:
      MW[301]=COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                                       ; Terminal time
              COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[1] * {CTOLL} * 60))) +                       ; IVTT
              COEFF_IVTT * {InflationToll} * (MW[1] * {CTOLL} * 60) +                                   ; Toll converted to equivalent minutes
@noNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 2.0) +                      ; Auto parking cost
@isNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 1.0) / 1.0) +                      ; Auto parking cost (NHB)
              COEFF_COST * (({InflationAOC} * MW[2] * {hwyopcost}) / 1.0) +                             ; Auto operating cost
@isNHB@       COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                                      ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                          ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                         ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                           ; Exurban attraction dummy

  ;   SHARED RIDE PERSONS/SHARE RIDE - ONE PASSENGER ELEMENTS OF UTILITY ARE:
      MW[302]=COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                                       ; Terminal time
              COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) +                       ; IVTT
              COEFF_IVTT * ({InflationToll} * (MW[5] * {CTOLL} * 60) / 2.0) -                           ; Toll converted to equivalent minutes
              COEFF_IVTT * (MAX (MW[11], 0)) +                                                          ; HOV time savings
@noNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 2.0) +                      ; Auto parking cost
@isNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / 2.0) / 1.0) +                      ; Auto parking cost (NHB)
              COEFF_COST * (({InflationAOC} * MW[2] * {hwyopcost}) / 2.0) +                             ; Auto operating cost
@isNHB@       COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                                      ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                          ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                         ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                           ; Exurban attraction dummy

  ;   SHARED RIDE - 2+ PASSENGER ELEMENTS OF UTILITY ARE:

      MW[303]=COEFF_OVT * (ZI.1.TERMTIME[I] + ZI.1.TERMTIME[J]) +                                       ; Terminal time
              COEFF_IVTT * (MW[4] - ({InflationToll} * (MW[5] * {CTOLL} * 60))) +                       ; IVTT
              COEFF_IVTT * ({InflationToll} * (MW[5] * {CTOLL} * 60) / @OCC3@) -                        ; Toll converted to equivalent minutes
              COEFF_IVTT * (MAX (MW[11], 0)) +                                                          ; HOV time savings
@noNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 2.0) +                   ; Auto parking cost
@isNHB@       COEFF_COST * ((({InflationParkCost} * ZI.1.@PRK@[J]) / @OCC3@) / 1.0) +                   ; Auto parking cost (NHB)
              COEFF_COST * (({InflationAOC} * MW[2] * {hwyopcost}) / @OCC3@) +                          ; Auto operating cost
@isNHB@       COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                                      ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                          ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                         ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                           ; Exurban attraction dummy

  ;   WALK ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[304]=COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[24] + MW[25] + MW[26] + MW[27] + MW[28] + MW[29] + MW[30]) +     ; IVTT
              COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[34]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   WALK ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[305]=COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[44] + MW[45] + MW[46] + MW[47] + MW[48] + MW[49] + MW[50]) +     ; IVTT
              COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[54]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   PNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[306]=COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[62]) +                                                           ; Auto access time
              COEFF_IVTT * (MW[64] + MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70]) +     ; IVTT
              COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[74]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   PNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[307]=COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[82]) +                                                           ; Auto access time
              COEFF_IVTT * (MW[84] + MW[85] + MW[86] + MW[87] + MW[88] + MW[89] + MW[90]) +     ; IVTT
              COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[94]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   KNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[308]=COEFF_OVT * (MW[101] + MW[103]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[112] + MW[113]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[102]) +                                                          ; Auto access time
              COEFF_IVTT * (MW[104] + MW[105] + MW[106] + MW[107] + MW[108] + MW[109] + MW[110]) +        ; IVTT
              COEFF_XFER * (MW[111]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[114]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   KNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[309]=COEFF_OVT * (MW[121] + MW[123]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[132] + MW[133]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[122]) +                                                          ; Auto access time
              COEFF_IVTT * (MW[124] + MW[125] + MW[126] + MW[127] + MW[128] + MW[129] + MW[130]) +        ; IVTT
              COEFF_XFER * (MW[131]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[134]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                        ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                              ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   CBD KNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MW[310]=COEFF_OVT * (MW[141] + MW[143]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[152] + MW[153]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[142]) +                                                          ; Auto access time
              COEFF_IVTT * (MW[144] + MW[145] + MW[146] + MW[147] + MW[148] + MW[149] + MW[150]) +        ; IVTT
              COEFF_XFER * (MW[151]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[154]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_CBDKNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                     ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_CBDKNR * ZI.1.CBD_DUMMY[J] +                                           ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   CBD KNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MW[311]=COEFF_OVT * (MW[161] + MW[163]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[172] + MW[173]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[162]) +                                                          ; Auto access time
              COEFF_IVTT * (MW[164] + MW[165] + MW[166] + MW[167] + MW[168] + MW[169] + MW[170]) +        ; IVTT
              COEFF_XFER * (MW[171]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[174]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_CBDKNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                     ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_CBDKNR * ZI.1.CBD_DUMMY[J] +                                           ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

  ;   FRINGE PNR ACCESS TO CIRCULATORS:
      MW[312]=COEFF_OVT * (MW[181] + MW[183]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[192] + MW[193]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[182]) +                                                          ; Auto access time
              COEFF_IVTT * (MW[184] + MW[185] + MW[186] + MW[187] + MW[188] + MW[189] + MW[190]) +        ; IVTT
              COEFF_XFER * (MW[191]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[194]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                            ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

;******************************** END UTILITY CALCULATIONS ************************************

      JLOOP

; For PNR paths, determine the parking zone. This is used to get the station parking cost for NHB paths, as
;               we need to add in the other half of station parking costs.
IF (MI.12.8 > 0)                   ; PNR parking zone
  _parkzonePNR = MI.12.8
; _parkcostPNR = ZI.2.STPKCS2[_parkzonePNR]
  _parkcostPNR = PARK[_parkzonePNR]
ELSE
  _parkzonePNR = 0
  _parkcostPNR = 0
ENDIF
IF (MI.12.11 > 0)                  ; FRG parking zone
  _parkzoneFRG = MI.12.11
; _parkcostFRG = ZI.2.STPKCS2[_parkzoneFRG]
  _parkcostFRG = PARK[_parkzoneFRG]
ELSE
  _parkzoneFRG = 0
  _parkcostFRG = 0
ENDIF

; Check if the IVT times on the transit path exist (this avoids having a jloop in the utility calculations)
        IF ((MW[24] + MW[26]) == 0) MW[304]=-9999.99                                                                       ; walk-bus path
        IF ((MW[45] + MW[47] + MW[48] + MW[49] + MW[50]) == 0) MW[305]=-9999.99                                            ; walk-proj path
        IF ((MW[64] + MW[66]) == 0)                                                                                        ; pnr-bus path
          MW[306]=-9999.99
        ELSE
@isNHB@   MW[306]=MW[306] + COEFF_COST * ((({InflationFare}*_parkcostPNR)/{OCCPNRAccess})/2.0)                             ; add in other half of NHB PNR parking cost
        ENDIF
        IF ((MW[85] + MW[87] + MW[88] + MW[89] + MW[90]) == 0)                                                             ; pnr proj path
          MW[307]=-9999.99
        ELSE
@isNHB@   MW[307]=MW[307] + COEFF_COST * ((({InflationFARE}*_parkcostPNR)/{OCCPNRAccess})/2.0)                             ; add in other half of NHB PNR parking cost
        ENDIF
        IF ((MW[104] + MW[106]) == 0) MW[308]=-9999.99                                                                     ; knr bus path
        IF ((MW[125] + MW[127] + MW[128] + MW[129] + MW[130]) == 0) MW[309]=-9999.99                                       ; knr proj path
        IF ((MW[144] + MW[146]) == 0) MW[310]=-9999.99                                                                     ; CBDknr bus path
        IF ((MW[165] + MW[167] + MW[168] + MW[169] + MW[170]) == 0) MW[311]=-9999.99                                       ; CBDknr proj path
@isNHB@ MW[312]=MW[312] + COEFF_COST * ((({InflationFare}*_parkcostFRG)/{OCCPNRAccess})/2.0)                               ; add in other half of NHB FRG parking cost
        IF (MW[186] == 0) MW[312]=-9999.99                                                                                 ; fringe pnr cir path

 ; Minimum distance criteria on paths
        IF (MW[2] < {MinDistWalkAcc})
                MW[304]=-9999.99
                MW[305]=-9999.99
        ENDIF
        IF (MW[2] < {MinDistAutoAcc})
                MW[306]=-9999.99
                MW[307]=-9999.99
                MW[308]=-9999.99
                MW[309]=-9999.99
                MW[310]=-9999.99
                MW[311]=-9999.99
        ENDIF
        ; NOTE: no min distance criteria for fringe parking

 ; Apply additional bias constants
        ; Walk-bus
        _ABC = 0
        IF (MW[16]>0) _ABC = _ABC1
        MW[304] = MW[304] + _ABC
        ; PNR-bus
        _ABC = 0
        IF (MW[17]>0) _ABC = _ABC1
        MW[306] = MW[306] + _ABC
        ; KNR-bus
        _ABC = 0
        IF (MW[18]>0) _ABC = _ABC1
        MW[308] = MW[308] + _ABC
        ; CBD KNR-bus
        _ABC = 0
        IF (MW[19]>0) _ABC = _ABC1
        MW[310] = MW[310] + _ABC
        ; Walk-project/premium
        _ABC = 0
        IF (MW[45]>0) _ABC = _ABC + _ABC2
        IF (MW[47]>0) _ABC = _ABC + _ABC3
        IF (MW[48]>0) _ABC = _ABC + _ABC4
        IF (MW[50]>0) _ABC = _ABC + _ABC5
        MW[305] = MW[305] + _ABC
        ; PNR-project/premium
        _ABC = 0
        IF (MW[85]>0) _ABC = _ABC + _ABC2
        IF (MW[87]>0) _ABC = _ABC + _ABC3
        IF (MW[88]>0) _ABC = _ABC + _ABC4
        IF (MW[90]>0) _ABC = _ABC + _ABC5
        MW[307] = MW[307] + _ABC
        ; KNR-project/premium
        _ABC = 0
        IF (MW[125]>0) _ABC = _ABC + _ABC2
        IF (MW[127]>0) _ABC = _ABC + _ABC3
        IF (MW[128]>0) _ABC = _ABC + _ABC4
        IF (MW[130]>0) _ABC = _ABC + _ABC5
        MW[309] = MW[309] + _ABC
        ; CBD KNR-project/premium
        _ABC = 0
        IF (MW[165]>0) _ABC = _ABC + _ABC2
        IF (MW[167]>0) _ABC = _ABC + _ABC3
        IF (MW[168]>0) _ABC = _ABC + _ABC4
        IF (MW[170]>0) _ABC = _ABC + _ABC5
        MW[311] = MW[311] + _ABC

 ; debug report
        if (ACC=1 & ({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
         print list='\n\nPercent walk at Production zone               ',(ZI.1.PCWPRD@PERIOD@[I] * 0.01),printo=1
         print list='Percent walk at Attraction zone               ',(ZI.1.PCWPRD@PERIOD@[J] * 0.01),printo=1
         print list='Percent 0 car household at Production zone    ',ZI.1.PERCAUTO0[I],printo=1
         print list='Percent 1 car household at Production zone    ',ZI.1.PERCAUTO1[I],printo=1
         print list='Percent 2 car household at Production zone    ',ZI.1.PERCAUTO2[I],printo=1
       endif
      ENDJLOOP

;******************************** FINAL UTILITY CALCULATIONS ************************************
  ;   COMPOSITE UTILITY for drive alone
      MW[401]=(MW[301]+K_DA_AUTO0)/NC_DriveAlone
      MW[421]=(MW[301]+K_DA_AUTO1)/NC_DriveAlone
      MW[441]=(MW[301]+K_DA_AUTO2)/NC_DriveAlone
  ;   COMPOSITE UTILITY for shared ride 2
      MW[402]=(MW[302]+K_SR1PASS_AUTO0)/NC_SharedRide
      MW[422]=(MW[302]+K_SR1PASS_AUTO1)/NC_SharedRide
      MW[442]=(MW[302]+K_SR1PASS_AUTO2)/NC_SharedRide
  ;   COMPOSITE UTILITY for shared ride 2+
      MW[403]=(MW[303]+K_SR2PASS_AUTO0)/NC_SharedRide
      MW[423]=(MW[303]+K_SR2PASS_AUTO1)/NC_SharedRide
      MW[443]=(MW[303]+K_SR2PASS_AUTO2)/NC_SharedRide
  ;   COMPOSITE UTILITY for walk to bus
      MW[404]=((MW[304]+K_WALKBUS_AUTO0)/NC_WALKBUS + walk_acc_dum)
      MW[424]=((MW[304]+K_WALKBUS_AUTO1)/NC_WALKBUS + walk_acc_dum)
      MW[444]=((MW[304]+K_WALKBUS_AUTO2)/NC_WALKBUS + walk_acc_dum)
  ;   COMPOSITE UTILITY for walk to project
      MW[405]=((MW[305]+K_WALKPRJ_AUTO0)/NC_WALKPRJ + walk_acc_dum)
      MW[425]=((MW[305]+K_WALKPRJ_AUTO1)/NC_WALKPRJ + walk_acc_dum)
      MW[445]=((MW[305]+K_WALKPRJ_AUTO2)/NC_WALKPRJ + walk_acc_dum)
  ;   COMPOSITE UTILITY for PNR to bus
      MW[406]=((MW[306]+K_PNRBUS_AUTO0)/NC_PNRBus + auto_acc_dum)
      MW[426]=((MW[306]+K_PNRBUS_AUTO1)/NC_PNRBus + auto_acc_dum)
      MW[446]=((MW[306]+K_PNRBUS_AUTO2)/NC_PNRBus + auto_acc_dum)
  ;   COMPOSITE UTILITY for PNR to project
      MW[407]=((MW[307]+K_PNRPRJ_AUTO0)/NC_PNRPrj + auto_acc_dum)
      MW[427]=((MW[307]+K_PNRPRJ_AUTO1)/NC_PNRPrj + auto_acc_dum)
      MW[447]=((MW[307]+K_PNRPRJ_AUTO2)/NC_PNRPrj + auto_acc_dum)
  ;   COMPOSITE UTILITY for KNR to bus
      MW[408]=((MW[308]+K_KNRBUS_AUTO0)/NC_KNRBus + auto_acc_dum)
      MW[428]=((MW[308]+K_KNRBUS_AUTO1)/NC_KNRBus + auto_acc_dum)
      MW[448]=((MW[308]+K_KNRBUS_AUTO2)/NC_KNRBus + auto_acc_dum)
  ;   COMPOSITE UTILITY for KNR to project
      MW[409]=((MW[309]+K_KNRPRJ_AUTO0)/NC_KNRPrj + auto_acc_dum)
      MW[429]=((MW[309]+K_KNRPRJ_AUTO1)/NC_KNRPrj + auto_acc_dum)
      MW[449]=((MW[309]+K_KNRPRJ_AUTO2)/NC_KNRPrj + auto_acc_dum)
  ;   COMPOSITE UTILITY for CBD KNR to bus
      MW[410]=((MW[310]+K_CBDKNRBUS_AUTO0)/NC_KNRBus + auto_acc_dum)
      MW[430]=((MW[310]+K_CBDKNRBUS_AUTO1)/NC_KNRBus + auto_acc_dum)
      MW[450]=((MW[310]+K_CBDKNRBUS_AUTO2)/NC_KNRBus + auto_acc_dum)
  ;   COMPOSITE UTILITY for CBD KNR to project
      MW[411]=((MW[311]+K_CBDKNRPRJ_AUTO0)/NC_KNRPrj + auto_acc_dum)
      MW[431]=((MW[311]+K_CBDKNRPRJ_AUTO1)/NC_KNRPrj + auto_acc_dum)
      MW[451]=((MW[311]+K_CBDKNRPRJ_AUTO2)/NC_KNRPrj + auto_acc_dum)
  ;   COMPOSITE UTILITY for Fringe PNR to Cirulators
      MW[412]=((MW[312]+K_FRGPNRCIR_AUTO0)/NC_FringePark + auto_acc_dum)
      MW[432]=((MW[312]+K_FRGPNRCIR_AUTO1)/NC_FringePark + auto_acc_dum)
      MW[452]=((MW[312]+K_FRGPNRCIR_AUTO2)/NC_FringePark + auto_acc_dum)

; use ZAPZERO here to zero out the drive alone and PNR access trips for zero-car households
      if ( ({ZAPZERO} = 1) && (('@PURP@'=='HBW') || ('@PURP@'=='HBNW')) )
        MW[401] = -9999.99     ; drive alone for 0car households
        MW[406] = -9999.99     ; PNR-bus trips for 0car households
        MW[407] = -9999.99     ; PNR-prj trips for 0car households
        MW[412] = -9999.99     ; Fringe PNR-cir trips for 0car households
      endif

 JLOOP
 if (ACC=1-3)
  if (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
   print list='\n\n********************************************************************************************', printo=1
   print list=' Access Type: ',ACC(1.0),'. ',ACC_NAME, printo=1
   print list='********************************************************************************************','\n' printo=1
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
   print list='\nDrive alone disutility                                          ',MW[301][J](12.4),printo=1
   print list='\nDrive alone composite disutility (0 car)                        ',MW[401][J](12.4),printo=1
   print list='Drive alone composite disutility (1 car)                        ',MW[421][J](12.4),printo=1
   print list='Drive alone composite disutility (2 car)                        ',MW[441][J](12.4),printo=1
   print list='\nExponentiated drive alone composite disutility (0 car)        ',exp(MW[401][J])(14.12),printo=1
   print list='Exponentiated drive alone composite disutility (1 car)        ',exp(MW[421][J])(14.12),printo=1
   print list='Exponentiated drive alone composite disutility (2 car)        ',exp(MW[441][J])(14.12),printo=1

   print list='\n\n\nElements used in Shared Ride 2 disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                   ',MW[3][J],printo=1
   print list='In-Vehicle time savings by using HOV lanes                        ',MAX((MW[7][J]-MW[3][J]), 0),printo=1
   print list='Out of Vehicle time (Terminal time at production-end)             ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)             ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                      ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                       ',MW[6][J],printo=1
   print list='Highway Toll (in $)                                               ',MW[1][J],printo=1
   print list='\nShared ride 2 disutility                                        ',MW[302][J](12.4),printo=1
   print list='\nShared ride 2 composite disutility (0 car)                      ',MW[402][J](12.4),printo=1
   print list='Shared ride 2 composite disutility (1 car)                      ',MW[422][J](12.4),printo=1
   print list='Shared ride 2 composite disutility (2 car)                      ',MW[442][J](12.4),printo=1
   print list='\nExponentiated shared ride composite disutility (0 car)        ',exp(MW[402][J])(14.12),printo=1
   print list='Exponentiated shared ride 2 composite disutility (1 car)      ',exp(MW[422][J])(14.12),printo=1
   print list='Exponentiated shared ride 2 composite disutility (2 car)      ',exp(MW[442][J])(14.12),printo=1

   print list='\n\n\nElements used in Shared Ride 2+ disutility calculations: ***************************', printo=1
   print list='In-Vehicle time                                                   ',MW[3][J],printo=1
   print list='In-Vehicle time savings by using HOV lanes                        ',MAX((MW[7][J]-MW[3][J]), 0),printo=1
   print list='Out of Vehicle time (Terminal time at production-end)             ',ZI.1.TERMTIME[I],printo=1
   print list='Out of Vehicle time (Terminal time at attraction-end)             ',ZI.1.TERMTIME[J],printo=1
   print list='Parking Cost                                                      ',ZI.1.@PRK@[J],printo=1
   print list='Highway Distance (in miles)                                       ',MW[6][J],printo=1
   print list='Occupancy rate for 2+ car market                                  ',@OCC3@,printo=1
   print list='Highway Toll (in $)                                               ',MW[1][J],printo=1
   print list='\nShared ride 2+ disutility                                       ',MW[303][J](12.4),printo=1
   print list='\nShared ride 2+ composite disutility (0 car)                     ',MW[403][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility (1 car)                     ',MW[423][J](12.4),printo=1
   print list='Shared ride 2+ composite disutility (2 car)                     ',MW[443][J](12.4),printo=1
   print list='\nExponentiated shared ride 2+ composite disutility (0 car)     ',exp(MW[403][J])(14.12),printo=1
   print list='Exponentiated shared ride 2+ composite disutility (1 car)     ',exp(MW[423][J])(14.12),printo=1
   print list='Exponentiated shared ride 2+ composite disutility (2 car)     ',exp(MW[443][J])(14.12),printo=1

   print list='\n\n\nElements used in Walk Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[24][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[25][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[26][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[27][J]+MW[28][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[30][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[21][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[23][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[32][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[33][J],printo=1
   print list='Number of transfers                                               ',MW[31][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[34][J],printo=1
   print list='\nWalk Bus disutility                                             ',MW[304][J](12.4),printo=1
   print list='Walk access dummy (added to the utility)                          ',walk_acc_dum,printo=1
   print list='\nWalk Bus composite disutility (0 car)                           ',MW[404][J](12.4),printo=1
   print list='Walk Bus composite disutility (1 car)                           ',MW[424][J](12.4),printo=1
   print list='Walk Bus composite disutility (2+ car)                          ',MW[444][J](12.4),printo=1
   print list='\nExponentiated walk bus composite disutility (0 car)           ',exp(MW[404][J])(14.12),printo=1
   print list='Exponentiated walk bus composite disutility (1 car)           ',exp(MW[424][J])(14.12),printo=1
   print list='Exponentiated walk bus composite disutility (2 car)           ',exp(MW[444][J])(14.12),printo=1

   print list='\n\n\nElements used in Walk Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[44][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[45][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[46][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[47][J]+MW[48][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[50][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[41][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[43][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[52][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[53][J],printo=1
   print list='Number of transfers                                               ',MW[51][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[54][J],printo=1
   print list='\nWalk Prj disutility                                             ',MW[305][J](12.4),printo=1
   print list='Walk access dummy (added to the utility)                          ',walk_acc_dum,printo=1
   print list='\nWalk Prj composite disutility (0 car)                           ',MW[405][J](12.4),printo=1
   print list='Walk Prj composite disutility (1 car)                           ',MW[425][J](12.4),printo=1
   print list='Walk Prj composite disutility (2 car)                           ',MW[445][J](12.4),printo=1
   print list='\nExponentiated walk prj composite disutility (0 car)           ',exp(MW[405][J])(14.12),printo=1
   print list='Exponentiated walk prj composite disutility (1 car)           ',exp(MW[425][J])(14.12),printo=1
   print list='Exponentiated walk prj composite disutility (2 car)           ',exp(MW[445][J])(14.12),printo=1

   print list='\n\n\nElements used in PNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[64][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[65][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[66][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[67][J]+MW[68][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[70][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[61][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min - weighted)      ',MW[62][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[63][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[72][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[73][J],printo=1
   print list='Number of transfers                                               ',MW[71][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[74][J],printo=1
   print list='\nPNR Bus disutility                                              ',MW[306][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nPNR Bus composite disutility (0 car)                            ',MW[406][J](12.4),printo=1
   print list='PNR Bus composite disutility (1 car)                            ',MW[426][J](12.4),printo=1
   print list='PNR Bus composite disutility (2 car)                            ',MW[446][J](12.4),printo=1
   print list='\nExponentiated PNR Bus composite disutility (0 car)            ',exp(MW[406][J])(14.12),printo=1
   print list='Exponentiated PNR Bus composite disutility (1 car)            ',exp(MW[426][J])(14.12),printo=1
   print list='Exponentiated PNR Bus composite disutility (2 car)            ',exp(MW[446][J])(14.12),printo=1

   print list='\n\n\nElements used in PNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[84][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[85][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[86][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[87][J]+MW[88][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[90][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[81][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[82][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[83][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[92][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[93][J],printo=1
   print list='Number of transfers                                               ',MW[91][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[94][J],printo=1
   print list='\nPNR Prj disutility                                              ',MW[307][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nPNR Prj composite disutility (0 car)                            ',MW[407][J](12.4),printo=1
   print list='PNR Prj composite disutility (1 car)                            ',MW[427][J](12.4),printo=1
   print list='PNR Prj composite disutility (2 car)                            ',MW[447][J](12.4),printo=1
   print list='\nExponentiated PNR prj composite disutility (0 car)            ',exp(MW[407][J])(14.12),printo=1
   print list='Exponentiated PNR prj composite disutility (1 car)            ',exp(MW[427][J])(14.12),printo=1
   print list='Exponentiated PNR prj composite disutility (2 car)            ',exp(MW[447][J])(14.12),printo=1

   print list='\n\n\nElements used in KNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[104][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[106][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[107][J]+MW[108][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[110][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[101][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[102][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[103][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[112][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[113][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[114][J],printo=1
   print list='\nKNR Bus disutility                                              ',MW[308][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Bus composite disutility (0 car)                            ',MW[408][J](12.4),printo=1
   print list='KNR Bus composite disutility (1 car)                            ',MW[428][J](12.4),printo=1
   print list='KNR Bus composite disutility (2 car)                            ',MW[448][J](12.4),printo=1
   print list='\nExponentiated KNR Bus composite disutility (0 car)            ',exp(MW[408][J])(14.12),printo=1
   print list='Exponentiated KNR Bus composite disutility (1 car)            ',exp(MW[428][J])(14.12),printo=1
   print list='Exponentiated KNR Bus composite disutility (2 car)            ',exp(MW[448][J])(14.12),printo=1

   print list='\n\n\nElements used in KNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[124][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[125][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[126][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[127][J]+MW[128][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[130][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[121][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[122][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[123][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[132][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[133][J],printo=1
   print list='Number of transfers                                               ',MW[131][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[134][J],printo=1
   print list='\nKNR Prj disutility                                              ',MW[309][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Prj composite disutility (0 car)                            ',MW[409][J](12.4),printo=1
   print list='KNR Prj composite disutility (1 car)                            ',MW[429][J](12.4),printo=1
   print list='KNR Prj composite disutility (2 car)                            ',MW[449][J](12.4),printo=1
   print list='\nExponentiated KNR prj composite disutility (0 car)            ',exp(MW[409][J])(14.12),printo=1
   print list='Exponentiated KNR prj composite disutility (1 car)            ',exp(MW[429][J])(14.12),printo=1
   print list='Exponentiated KNR prj composite disutility (2 car)            ',exp(MW[449][J])(14.12),printo=1

   print list='\n\n\nElements used in CBD KNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[144][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[146][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[147][J]+MW[148][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[150][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[141][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[142][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[143][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[152][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[153][J],printo=1
   print list='Number of transfers                                               ',MW[151][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[154][J],printo=1
   print list='\nKNR Bus disutility                                              ',MW[310][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Bus composite disutility (0 car)                            ',MW[410][J](12.4),printo=1
   print list='KNR Bus composite disutility (1 car)                            ',MW[430][J](12.4),printo=1
   print list='KNR Bus composite disutility (2 car)                            ',MW[450][J](12.4),printo=1
   print list='\nExponentiated KNR Bus composite disutility (0 car)            ',exp(MW[410][J])(14.12),printo=1
   print list='Exponentiated KNR Bus composite disutility (1 car)            ',exp(MW[430][J])(14.12),printo=1
   print list='Exponentiated KNR Bus composite disutility (2 car)            ',exp(MW[450][J])(14.12),printo=1

   print list='\n\n\nElements used in CBD KNR Prj disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[164][J],printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[165][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[166][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[167][J]+MW[168][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[170][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[161][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[162][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[163][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[172][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[173][J],printo=1
   print list='Number of transfers                                               ',MW[171][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[174][J],printo=1
   print list='\nKNR Prj disutility                                              ',MW[311][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Prj composite disutility (0 car)                            ',MW[411][J](12.4),printo=1
   print list='KNR Prj composite disutility (1 car)                            ',MW[431][J](12.4),printo=1
   print list='KNR Prj composite disutility (2 car)                            ',MW[451][J](12.4),printo=1
   print list='\nExponentiated KNR prj composite disutility (0 car)            ',exp(MW[411][J])(14.12),printo=1
   print list='Exponentiated KNR prj composite disutility (1 car)            ',exp(MW[431][J])(14.12),printo=1
   print list='Exponentiated KNR prj composite disutility (2 car)            ',exp(MW[451][J])(14.12),printo=1

   print list='\n\n\nElements used in Fringe PNR circulator disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[184][J],printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[186][J],printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[187][J]+MW[188][J]),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[190][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[181][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)-includes PRKCST ',MW[182][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[183][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[192][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[193][J],printo=1
   print list='*** Delta parking cost at PNR station and destination zone  ****  ',printo=1
   print list='Number of transfers                                               ',MW[191][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[194][J],printo=1
   print list='\nFringe PNR Circulator disutility                                ',MW[312][J](12.4),printo=1
   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nFringe PNR Cir composite disutility (0 car)                     ',MW[412][J](12.4),printo=1
   print list='Fringe PNR Cir composite disutility (1 car)                     ',MW[432][J](12.4),printo=1
   print list='Fringe PNR Cir composite disutility (2 car)                     ',MW[452][J](12.4),printo=1
   print list='\nExponentiated Fringe PNR Cir composite disutility (0 car)     ',exp(MW[412][J])(14.12),printo=1
   print list='Exponentiated Fringe PNR Cir composite disutility (1 car)     ',exp(MW[432][J])(14.12),printo=1
   print list='Exponentiated Fringe PNR Cir composite disutility (2 car)     ',exp(MW[452][J])(14.12),printo=1
   print list='\n\n',printo=1
   print list='\n\n\nCALCULATED SHARES USING UTILITIES (CHECK IT AGAINST THE XCHOICE RESULTS):',printo=1
   print list='*******************************************************************************',printo=1
  endif
 endif
 ENDJLOOP

; ############################# XCHOICE SETUP ###################################

; AUTO0
      DMD=260+ACC
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=401,402,403,404,405,406,407,408,409,410,411,412,
      DEMANDMW=DMD,
      ODEMANDMW=501,502,503,504,505,506,507,508,509,510,511,512,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe,
;     Auto nest
      SPLIT=Auto 1.0 da NC_AUTOSR hov, SPLITCOMP=36,
;     HOV nest
      SPLIT=hov 1.0 hov2 1.0 hov3,
;     Transit nest
      SPLIT= Transit NC_TRNAC Walk NC_TRNAC PNR NC_TRNAC KNR, NC_TRNAC CBDKNR,
;     Walk nest
      SPLIT= Walk 1.0 walkbus 1.0 walkprj,
;     PNR nest
      SPLIT= PNR 1.0 pnrbus 1.0 pnrprj,
;     KNR nest
      SPLIT= KNR 1.0 knrbus 1.0 knrprj,
;     CBD KNR nest
      SPLIT= CBDKNR 1.0 cbdknrbus 1.0 cbdknrprj

; AUTO1
      DMD=263+ACC
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=421,422,423,424,425,426,427,428,429,430,431,432,
      DEMANDMW=DMD,
      ODEMANDMW=521,522,523,524,525,526,527,528,529,530,531,532,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe,
;     Auto nest
      SPLIT=Auto 1.0 da NC_AUTOSR hov, SPLITCOMP=37,
;     HOV nest
      SPLIT=hov 1.0 hov2 1.0 hov3,
;     Transit nest
      SPLIT= Transit NC_TRNAC Walk NC_TRNAC PNR NC_TRNAC KNR, NC_TRNAC CBDKNR,
;     Walk nest
      SPLIT= Walk 1.0 walkbus 1.0 walkprj,
;     PNR nest
      SPLIT= PNR 1.0 pnrbus 1.0 pnrprj,
;     KNR nest
      SPLIT= KNR 1.0 knrbus 1.0 knrprj,
;     CBD KNR nest
      SPLIT= CBDKNR 1.0 cbdknrbus 1.0 cbdknrprj


; AUTO2
      DMD=266+ACC
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=441,442,443,444,445,446,447,448,449,450,451,452,
      DEMANDMW=DMD,
      ODEMANDMW=541,542,543,544,545,546,547,548,549,550,551,552,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe,
;     Auto nest
      SPLIT=Auto 1.0 da NC_AUTOSR hov, SPLITCOMP=38,
;     HOV nest
      SPLIT=hov 1.0 hov2 1.0 hov3,
;     Transit nest
      SPLIT= Transit NC_TRNAC Walk NC_TRNAC PNR NC_TRNAC KNR, NC_TRNAC CBDKNR,
;     Walk nest
      SPLIT= Walk 1.0 walkbus 1.0 walkprj,
;     PNR nest
      SPLIT= PNR 1.0 pnrbus 1.0 pnrprj,
;     KNR nest
      SPLIT= KNR 1.0 knrbus 1.0 knrprj,
;     CBD KNR nest
      SPLIT= CBDKNR 1.0 cbdknrbus 1.0 cbdknrprj

; user benefit table - exponentiated auto utility
      MW[56]=exp(NC_AUTOSR * MW[36]) + exp(MW[412])
      MW[57]=exp(NC_AUTOSR * MW[37]) + exp(MW[432])
      MW[58]=exp(NC_AUTOSR * MW[38]) + exp(MW[452])

; Aggregate trips for all access categories (can walk, must drive and no transit)
; MW[601]=MW[601]+MW[501]
; MW[621]=MW[621]+MW[521]
      LOOP MARKET=1,3
       LOOP CHOICE=1,12
        _idx1 = 600+CHOICE+(MARKET-1)*20
        _idx2 = 500+CHOICE+(MARKET-1)*20
        COMP total = ROWADD(_idx1,_idx1,_idx2)     ; refer to xchoice.prn for MW listing
        _idx3 = 700+CHOICE+(MARKET-1)*12+(ACC-1)*36
        COMP total = ROWADD(_idx3,_idx2)
       ENDLOOP
      ENDLOOP

; ############################################ END XCHOICE #################################

 ; now some debuging
   LOOP MARKET=1,3
    if (MARKET=1) MARKET_NAME='Zero Car HHs     '
    if (MARKET=2) MARKET_NAME='One Car HHs      '
    if (MARKET=3) MARKET_NAME='Two+ Car HHs     '

    _cnt=(MARKET-1)*20
    _cnt1=260+ACC+(MARKET-1)*3
    M1=501+_cnt,M2=502+_cnt,M3=503+_cnt,M4=504+_cnt,M5=505+_cnt,M6=506+_cnt,M7=507+_cnt,M8=508+_cnt,M9=509+_cnt,M10=510+_cnt,M11=511+_cnt,M12=512+_cnt

    IF ({DebugMC}>0)
     JLOOP
      if ((I={SelOrigin}) && (J={SelDest}))

; ################### SHARES (HAND CALCULATION - check it against XCHOICE RESULTS) ###########################################
       _konn = 0.0000000000000001

       print list='\n\nMARKET:           ',MARKET_NAME,printo=1
       print list='***************************************************',printo=1
       ; Fringe nest
       if ((exp(MW[412+_cnt][J]))>_konn)
         shrpfr=exp(MW[412+_cnt][J])/(exp(MW[412+_cnt][J]))
         eutilfr=exp(NC_FRINGE*ln(exp(MW[412+_cnt][J])))
       else
         shrpfr=0
         eutilfr=0
       endif
       print list='\n\nExponentiated Fringe mode nest disutility     ',eutilfr(14.12),printo=1
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
       print list='\nExponentiated Walk mode nest disutility       ',eutilwk(14.12),printo=1
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
       print list='\nExponentiated PNR mode nest disutility        ',eutilpnr(14.12),printo=1
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
       print list='\nExponentiated KNR mode nest disutility        ',eutilknr(14.12),printo=1
       ; CBDKNR mode nest
       if ((exp(MW[410+_cnt][J])+exp(MW[411+_cnt][J]))>_konn)
         shrcbdknrb=exp(MW[410+_cnt][J])/(exp(MW[410+_cnt][J])+exp(MW[411+_cnt][J]))
         shrcbdknrp=exp(MW[411+_cnt][J])/(exp(MW[410+_cnt][J])+exp(MW[411+_cnt][J]))
         eutilcbdknr=exp(NC_TRNAC*ln(exp(MW[410+_cnt][J])+exp(MW[411+_cnt][J])))
       else
         shrcbdknrb=0
         shrcbdknrp=0
         eutilcbdknr=0
       endif
       print list='\nExponentiated CBD KNR mode nest disutility    ',eutilcbdknr(14.12),printo=1
       ; transit nest
;       if ((exp(MW[404+_cnt][J])+exp(MW[405+_cnt][J])+exp(MW[406+_cnt][J])+exp(MW[407+_cnt][J])+exp(MW[408+_cnt][J])+exp(MW[409+_cnt][J])+exp(MW[410+_cnt][J])+exp(MW[411+_cnt][J]))>_konn)
       if ((eutilwk+eutilpnr+eutilknr+eutilcbdknr)>_konn)
         shrwkt=eutilwk/(eutilwk+eutilpnr+eutilknr+eutilcbdknr)
         shrpnrt=eutilpnr/(eutilwk+eutilpnr+eutilknr+eutilcbdknr)
         shrknrt=eutilknr/(eutilwk+eutilpnr+eutilknr+eutilcbdknr)
         shrcbdknrt=eutilcbdknr/(eutilwk+eutilpnr+eutilknr+eutilcbdknr)
         eutilt=exp(NC_TRN*ln(eutilwk+eutilpnr+eutilknr+eutilcbdknr))
       else
         shrwkt=0
         shrpnrt=0
         shrknrt=0
         shrcbdknrt=0
         eutilt=0
       endif
       print list='\nExponentiated Transit disutility              ',eutilt(14.12),printo=1
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
       print list='\nExponentiated Auto disutility                 ',eutila(14.12),printo=1
       ; top nest
       if ((eutila+eutilt+eutilfr)>_konn)
         shra=eutila/(eutila+eutilt+eutilfr)
         shrt=eutilt/(eutila+eutilt+eutilfr)
         shrfr=eutilfr/(eutila+eutilt+eutilfr)
         eutil=(eutila+eutilt+eutilfr)
       else
         shra=0
         shrt=0
         shrfr=0
         eutil=0
       endif
       print list='\nExponentiated total disutility                ',eutil(14.12),printo=1
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
       shrcbdknrbus=shrcbdknrb*shrcbdknrt*shrt
       shrcbdknrprj=shrcbdknrp*shrcbdknrt*shrt
       shrpnrfr=shrpfr*shrfr
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
       print list='    CBD KNR Bus                    ',shrcbdknrbus(7.4),printo=1
       print list='    CBD KNR Prj                    ',shrcbdknrprj(7.4),printo=1
       print list='    Fringe PNR Cir                 ',shrpnrfr(7.4),printo=1
       print list='\n\nCalculated shares using the utility equations:       ', printo=1
       print list='   Top Nest:                                         ', printo=1
       print list='        Auto Share               ',shra(6.4), printo=1
       print list='        Transit Share            ',shrt(6.4), printo=1
       print list='        Fringe Share             ',shrfr(6.4), printo=1
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
       print list='        CBDKNR Transit Share     ',shrcbdknrt(6.4), printo=1
       print list='\n\n   Walk Nest:                                 ', printo=1
       print list='        Walk Bus Share           ',shrwkb(6.4), printo=1
       print list='        Walk Prj Share           ',shrwkp(6.4), printo=1
       print list='\n\n   PNR Nest:                                 ', printo=1
       print list='        PNR Bus Share            ',shrpnrb(6.4), printo=1
       print list='        PNR Prj Share            ',shrpnrp(6.4), printo=1
       print list='\n\n   KNR Nest:                                 ', printo=1
       print list='        KNR Bus Share            ',shrknrb(6.4), printo=1
       print list='        KNR Prj Share            ',shrknrp(6.4), printo=1
       print list='\n\n   CBDKNR Nest:                                 ', printo=1
       print list='        CBDKNR Bus Share         ',shrcbdknrb(6.4), printo=1
       print list='        CBDKNR Prj Share         ',shrcbdknrp(6.4), printo=1
       print list='\n\n   Fringe Nest:                                  ', printo=1
       print list='        Fringe PNR Cir Share     ',shrpfr(6.4), printo=1
; ######################### END HAND CALCULATIONS ########################################
; ##################### XCHOICE RESULTS###############################

       print list='\n\n\nCUBE UTILITY BASED XCHOICE MODEL\n',printo=1
       print list='*******************************************************************',printo=1
       print list='\nTotal demand between the interchange:  ',MW[251][J](10.2),printo=1
       print list='Demand from 0-car households           ',MW[_cnt1][J](10.2),printo=1
      IF ((MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J])>0)
       xcshrda  =(MW[M1][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrhov2=(MW[M2][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrhov3=(MW[M3][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrwkb =(MW[M4][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrwkp =(MW[M5][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrpnrb=(MW[M6][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrpnrp=(MW[M7][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrknrb=(MW[M8][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrknrp=(MW[M9][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrcbdknrb=(MW[M10][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrcbdknrp=(MW[M11][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrpnrfr=(MW[M12][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]+MW[M10][J]+MW[M11][J]+MW[M12][J]))
       xcshrtot=xcshrda+xcshrhov2+xcshrhov3+xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrpnrfr
       print list='\n\nTrips by mode:                          Trips      Share',printo=1
       print list='    Drive Alone                    ',MW[M1][J](10.2),'    ',xcshrda(7.4),printo=1
       print list='    HOV2                           ',MW[M2][J](10.2),'    ',xcshrhov2(7.4),printo=1
       print list='    HOV3                           ',MW[M3][J](10.2),'    ',xcshrhov3(7.4),printo=1
       print list='    Walk Bus                       ',MW[M4][J](10.2),'    ',xcshrwkb(7.4),printo=1
       print list='    Walk Prj                       ',MW[M5][J](10.2),'    ',xcshrwkp(7.4),printo=1
       print list='    PNR Bus                        ',MW[M6][J](10.2),'    ',xcshrpnrb(7.4),printo=1
       print list='    KNR Bus                        ',MW[M8][J](10.2),'    ',xcshrknrb(7.4),printo=1
       print list='    KNR Prj                        ',MW[M9][J](10.2),'    ',xcshrknrp(7.4),printo=1
       print list='    CBDKNR Bus                     ',MW[M10][J](10.2),'    ',xcshrcbdknrb(7.4),printo=1
       print list='    CBDKNR Prj                     ',MW[M11][J](10.2),'    ',xcshrcbdknrp(7.4),printo=1
       print list='    Fringe PNR Cir                 ',MW[M12][J](10.2),'    ',xcshrpnrfr(7.4),printo=1
       print list='\n\n\nOutput shares by XCHOICE:                             ', printo=1
       print list='   Top Nest:                                         ', printo=1
       print list='        Auto Share               ',(xcshrda+xcshrhov2+xcshrhov3)(7.4), printo=1
       print list='        Transit Share            ',(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp)(7.4), printo=1
       print list='        Fringe Share             ',(xcshrpnrfr)(7.4), printo=1
       print list='\n\n   Auto Nest:                                    ', printo=1
       print list='        Drive Alone Share        ',(xcshrda/(xcshrda+xcshrhov2+xcshrhov3))(7.4), printo=1
       print list='        Shared Ride Share        ',((xcshrhov2+xcshrhov3)/(xcshrda+xcshrhov2+xcshrhov3))(7.4), printo=1
       print list='\n\n   Shared Ride Nest:                             ', printo=1
       print list='        HOV2 Share               ',(xcshrhov2/(xcshrhov2+xcshrhov3))(7.4), printo=1
       print list='        HOV3 Share               ',(xcshrhov3/(xcshrhov2+xcshrhov3))(7.4), printo=1
       print list='\n\n   Transit Nest:                                 ', printo=1
       print list='        Walk Transit Share       ',((xcshrwkb+xcshrwkp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrcbdknrb+xcshrcbdknrp))(7.4), printo=1
       print list='        PNR Transit Share        ',((xcshrpnrb+xcshrpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrcbdknrb+xcshrcbdknrp))(7.4), printo=1
       print list='        KNR Transit Share        ',((xcshrknrb+xcshrpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrcbdknrb+xcshrcbdknrp))(7.4), printo=1
       print list='        CBDKNR Transit Share     ',((xcshrcbdknrb+xcshrcbdpnrp)/(xcshrwkb+xcshrwkp+xcshrpnrb+xcshrpnrp+xcshrknrb+xcshrknrp+xcshrcbdknrb+xcshrcbdknrp))(7.4), printo=1
       print list='\n\n   Walk Nest:                                 ', printo=1
       print list='        Walk Bus Share           ',(xcshrwkb/(xcshrwkb+xcshrwkp))(7.4), printo=1
       print list='        Walk Prj Share           ',(xcshrwkp/(xcshrwkb+xcshrwkp))(7.4), printo=1
       print list='\n\n   PNR Nest:                                 ', printo=1
       print list='        PNR Bus Share            ',(xcshrpnrb/(xcshrpnrb+xcshrpnrp))(7.4), printo=1
       print list='        PNR Prj Share            ',(xcshrpnrp/(xcshrpnrb+xcshrpnrp))(7.4), printo=1
       print list='\n\n   KNR Nest:                                 ', printo=1
       print list='        KNR Bus Share            ',(xcshrknrb/(xcshrknrb+xcshrknrp))(7.4), printo=1
       print list='        KNR Prj Share            ',(xcshrknrp/(xcshrknrb+xcshrknrp))(7.4), printo=1
       print list='\n\n   CBDKNR Nest:                                 ', printo=1
       print list='        CBDKNR Bus Share         ',(xcshrcbdknrb/(xcshrcbdknrb+xcshrcbdknrp))(7.4), printo=1
       print list='        CBDKNR Prj Share         ',(xcshrcbdknrp/(xcshrcbdknrb+xcshrcbdknrp))(7.4), printo=1
       print list='\n\n   Fringe Nest:                              ', printo=1
       print list='        Fringe PNR Share         ',(xcshrpnrfr/(xcshrpnrfr))(7.4), printo=1
       print list='\n\n',printo=1

       IF (MARKET=3)
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
