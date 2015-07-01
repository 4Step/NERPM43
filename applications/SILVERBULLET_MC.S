; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


*echo Date: %date% >"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Time: %time% >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo NERPM Model Run - {DESCR}>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Input Directory {SCENARIO_DIR}\input >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo ======================================================================================>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

*del "{SCENARIO_DIR}\output\ModeDebugsb.TXT"
*del "{SCENARIO_DIR}\output\ModeSumsb.TXT"
*del "{SCENARIO_DIR}\output\modesharessb.csv"
*del "{SCENARIO_DIR}\output\CBDSHARESsb.CSV"

IF ({RunSilverBulletMC}==1)
; End of PILOT Script

; Script for program MATRIX in file "D:\JTA RTS Model\APPLICATIONS\SBMAT01C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='store time and date'
FILEI RECI = "{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

zones={ZONESA}

s1=strpos('Date:',reci)
s2=strpos('Time:',reci)

; get the date and time
if (s1 > 0)
 rundate=substr(reci,s1,80)
 log prefix=date var=rundate
endif
if (s2 > 0) 
 runtime=substr(reci,s2,80)
 log prefix=time var=runtime
endif

ENDRUN


RUN PGM="C:\Program Files\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{CATALOG_DIR}\parameters\MC_CONSTANTS.DBF" "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF" '
ENDRUN

RUN PGM="C:\Program Files\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF" "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF" '
ENDRUN

LOOP PURPOSE = 1, 3, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

IF (PURPOSE=1) ; HBW purpose - requres peak skims
PERIOD='PK'
PURP='HBW'
PURPNO=2
SKIMFILE='PRELSKIMS'
STATPRKCOST='STPKCS1'
OCC3={oc3vhbw}
RUNDATE='@DATE.RUNDATE@'
RUNTIME=@TIME.RUNTIME@
PRK='LTPKCST'
STATION_TABLE='1,2,3,4,5,6,7'
isNHB=';'
noNHB=' '

copy, FILE = "{SCENARIO_DIR}\OUTPUT\HBWHEADSB.VAR"
UBTRNCOEF=-0.0250
UBAUTOCOEF=-0.0250
UBPURPOSE='HBW'
UBTOD='ALL'
UBALTNAME='{SCENARIO_FULLNAME}'
endcopy

ELSEIF (PURPOSE=2) ; HBO purpose - requres off-peak skims
PERIOD='OP'
PURP='HBNW'
PURPNO=3
SKIMFILE='FHSKIMS1'
STATPRKCOST='STPKCS2'
OCC3={oc3vhbnw}
PRK='STPKCST'
STATION_TABLE='8,9,10,11,12,13,14'
isNHB=';'
noNHB=' '

copy, FILE = "{SCENARIO_DIR}\OUTPUT\HBNWHEADSB.VAR"
UBTRNCOEF=-0.0125
UBAUTOCOEF=-0.0125
UBPURPOSE='HBNW'
UBTOD='ALL'
UBALTNAME='{SCENARIO_FULLNAME}'
endcopy

ELSEIF (PURPOSE=3) ; NHB purpose - requres off-peak skims
PERIOD='OP'
PURP='NHB'
PURPNO=4
SKIMFILE='FHSKIMS1'
STATPRKCOST='STPKCS2'
OCC3={oc3vnhb}
PRK='STPKCST'
STATION_TABLE='8,9,10,11,12,13,14'
isNHB=' '
noNHB=';'

copy, FILE = "{SCENARIO_DIR}\OUTPUT\NHBHEADSB.VAR"
UBTRNCOEF=-0.0250
UBAUTOCOEF=-0.0250
UBPURPOSE='NHB'
UBTOD='ALL'
UBALTNAME='{SCENARIO_FULLNAME}'
endcopy

ENDIF
; End of PILOT Script

; Script for program MATRIX in file "D:\JTA RTS Model\APPLICATIONS\SBMAT01A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00Dsb.PRN" MSG='Compute additional benefits'
FILEI MATI[12] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
FILEI MATI[11] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"
FILEI ZDATI[2] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@SKIMFILE@.MAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
FILEO MATO[10] = "{SCENARIO_DIR}\output\@PURP@AddedBenefits.MAT",
  MO=607-612,NAME=AddedUBPerTrip0,AddedUBPerTrip1,AddedUBPerTrip2,AddedUB0,AddedUB1,AddedUB2,FORMAT=MINUTP,DEC=X*S
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSumsb.TXT",
append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebugsb.TXT",
append=t

FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"

FILEI MATI[14] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT"
        ; Tables
FILEI MATI[13] = "{SCENARIO_DIR}\output\PTRIPSMC.MAT"
; Table 1-14: PKStationTAZ_pnrb,PKStationTAZ_knrb,PKStationTAZ_cbdknrb,PKStationTAZ_frg,PKStationTAZ_pnrp,PKStationTAZ_knrp,PKStationTAZ_cbdknrp,
;             OPStationTAZ_pnrb,OPStationTAZ_knrb,OPStationTAZ_cbdknrb,OPStationTAZ_frg,OPStationTAZ_pnrp,OPStationTAZ_knrp,OPStationTAZ_cbdknrp
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
           ; Tables 1-4 for SOV: 1-Toll, 2-Distance, 3-Time, 4-Weighted Time
           ; Tables 5-8 for HOV: 5-Toll, 6-Distance, 7-Time, 8-Weighted Time
           ; Table 9 is terminal time

zonemsg=100
ARRAY PARK={ZONESA}

DistributeINTRASTEP ProcessID="JTADist", ProcessList=1-3


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
 LOOP xx=1,{ZONESA}
  IF (PARK[xx] > 0) LIST=xx(7.0)," = ",PARK[xx](7.0)
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


; Assign mode-specific constant bonuses
C1   = {MSC_C1}
C2   = {MSC_C2}
IVTF = 1 - {MSC_IVTFac}
MSC1 = C1 * COEFF_IVTT * -1.0
MSC2 = C2 * COEFF_IVTT * -1.0
_lkon = 0.01

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


;LOOP ACC=1,3

; ===================================================================================
; @PURP@ (@PERIOD@) TRIP PURPOSE
; ===================================================================================

;   if (ACC==1) then
;    ACC_NAME='CAN WALK TO TRANSIT'
;    walk_acc_dum = 0.0            ; added to the utility
;    auto_acc_dum = 0.0            ; added to the utility
;   elseif (ACC==2)
;    ACC_NAME='MUST DRIVE TO TRANSIT'
;    walk_acc_dum = -9999.99
;    auto_acc_dum = 0.0
;   elseif (ACC==3)
;    ACC_NAME='NO TRANSIT'
;    walk_acc_dum = -9999.99
;    auto_acc_dum = -9999.99
;   endif

JLOOP
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
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==1)
        ProjTime = MW[24]
        ElseTime = MW[25] + MW[26] + MW[27] + MW[28] + MW[29] + MW[30]
        IVTB = ProjTime
        IF (MW[16]>0)
          MSC = MSC2
          IVTB = (ProjTime-MW[16]) + (MW[16]*IVTF)
        ENDIF
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='Walk-Bus     MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[304]=COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[34]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[624]=COEFF_OVT * (MW[21] + MW[23]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[32] + MW[33]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[31]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[34]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                       ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                             ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   WALK ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==2)
        ProjTime = MW[45]
        ElseTime = MW[44] + MW[46] + MW[47] + MW[48] + MW[49] + MW[50]
        IVTB = MW[45] * IVTF
        MSC = MSC2
      ELSEIF ({ProjectModeFlag}==3)
        ProjTime = MW[47]
        ElseTime = MW[44] + MW[45] + MW[46] + MW[48] + MW[49] + MW[50]
        IVTB = MW[47] * IVTF
        MSC = MSC2
      ELSEIF ({ProjectModeFlag}==4)
        ProjTime = MW[48]
        ElseTime = MW[44] + MW[45] + MW[46] + MW[47] + MW[49] + MW[50]
        IVTB = MW[48] * IVTF
        MSC = MSC2
      ELSEIF ({ProjectModeFlag}==5)
        ProjTime = MW[50]
        ElseTime = MW[44] + MW[45] + MW[46] + MW[47] + MW[48] + MW[49]
        IVTB = MW[50] * IVTF
        MSC = MSC2
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='Walk-Proj    MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[305]=COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[54]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[625]=COEFF_OVT * (MW[41] + MW[43]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[52] + MW[53]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[51]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[54]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_WALK * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_WALK * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   PNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==1)
        ProjTime = MW[64]
        ElseTime = MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70]
        IVTB = ProjTime
        IF ((MW[17]>0) && (abs(MW[64]-MW[17])<=_lkon) && (ElseTime==0))
          MSC = MSC1
          IVTB = MW[17] * IVTF
        ELSEIF (MW[17]>0)
          MSC = MSC2
          IVTB = (MW[64]-MW[17]) + (MW[17]*IVTF)
        ENDIF
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='PNR-Bus      MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[306]=COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[62]) +                                                           ; Auto access time
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[74]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[626]=COEFF_OVT * (MW[61] + MW[63]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[72] + MW[73]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[62]) +                                                           ; Auto access time
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[71]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[74]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   PNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==2)
        ProjTime = MW[85]
        ElseTime = MW[84] + MW[86] + MW[87] + MW[88] + MW[89] + MW[90]
        IVTB = MW[85] * IVTF
        MSC = MSC2
        IF ((MW[85]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==3)
        ProjTime = MW[87]
        ElseTime = MW[84] + MW[85] + MW[86] + MW[88] + MW[89] + MW[90]
        IVTB = MW[87] * IVTF
        MSC = MSC2
        IF ((MW[87]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==4)
        ProjTime = MW[88]
        ElseTime = MW[84] + MW[85] + MW[86] + MW[87] + MW[89] + MW[90]
        IVTB = MW[88] * IVTF
        MSC = MSC2
        IF ((MW[88]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==5)
        ProjTime = MW[90]
        ElseTime = MW[84] + MW[85] + MW[86] + MW[87] + MW[88] + MW[89]
        IVTB = MW[90] * IVTF
        MSC = MSC2
        IF ((MW[90]>0) && (ElseTime==0)) MSC = MSC1
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='PNR-Proj     MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[307]=COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[82]) +                                                           ; Auto access time
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[94]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[627]=COEFF_OVT * (MW[81] + MW[83]) +                                                   ; Walk & transfer time
              COEFF_OVT * (MW[92] + MW[93]) +                                                   ; Initial & transfer wait
              COEFF_IVTT * (MW[82]) +                                                           ; Auto access time
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[91]) +                                                           ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[94]) +                                         ; Transit fare
@isNHB@       COEFF_DCBD_PNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_PNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   KNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==1)
        ProjTime = MW[104]
        ElseTime = MW[105] + MW[106] + MW[107] + MW[108] + MW[109] + MW[110]
        IVTB = ProjTime
        IF ((MW[18]>0) && (abs(MW[104]-MW[18])<=_lkon) && (ElseTime==0))
          MSC = MSC1
          IVTB = MW[18] * IVTF
        ELSEIF (MW[18]>0)
          MSC = MSC2
          IVTB = (MW[104]-MW[18]) + (MW[18]*IVTF)
        ENDIF
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='KNR-Bus      MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[308]=COEFF_OVT * (MW[101] + MW[103]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[112] + MW[113]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[102]) +                                                          ; Auto access time
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[111]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[114]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[628]=COEFF_OVT * (MW[101] + MW[103]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[112] + MW[113]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[102]) +                                                          ; Auto access time
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[111]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[114]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   KNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==2)
        ProjTime = MW[125]
        ElseTime = MW[124] + MW[126] + MW[127] + MW[128] + MW[129] + MW[130]
        IVTB = MW[125] * IVTF
        MSC = MSC2
        IF ((MW[125]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==3)
        ProjTime = MW[127]
        ElseTime = MW[124] + MW[125] + MW[126] + MW[128] + MW[129] + MW[130]
        IVTB = MW[127] * IVTF
        MSC = MSC2
        IF ((MW[127]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==4)
        ProjTime = MW[128]
        ElseTime = MW[124] + MW[125] + MW[126] + MW[127] + MW[129] + MW[130]
        IVTB = MW[128] * IVTF
        MSC = MSC2
        IF ((MW[128]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==5)
        ProjTime = MW[130]
        ElseTime = MW[124] + MW[125] + MW[126] + MW[127] + MW[128] + MW[129]
        IVTB = MW[130] * IVTF
        MSC = MSC2
        IF ((MW[130]>0) && (ElseTime==0)) MSC = MSC1
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='KNR-Proj     MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[309]=COEFF_OVT * (MW[121] + MW[123]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[132] + MW[133]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[122]) +                                                          ; Auto access time
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[131]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[134]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[629]=COEFF_OVT * (MW[121] + MW[123]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[132] + MW[133]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[122]) +                                                          ; Auto access time
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[131]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[134]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_KNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_KNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   CBD KNR ACCESS - BUS ELEMENTS OF UTILITY ARE:
      MSC = 0
      IVTB = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==1)
        ProjTime = MW[144]
        ElseTime = MW[145] + MW[146] + MW[147] + MW[148] + MW[149] + MW[150]
        IVTB = ProjTime
        IF ((MW[19]>0) && (abs(MW[144]-MW[19])<=_lkon) && (ElseTime==0))
          MSC = MSC1
          IVTB = MW[19] * IVTF
        ELSEIF (MW[19]>0)
          MSC = MSC2
          IVTB = (MW[144]-MW[19]) + (MW[19]*IVTF)
        ENDIF
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='CBDKNR-Bus   MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[310]=COEFF_OVT * (MW[141] + MW[143]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[152] + MW[153]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[142]) +                                                          ; Auto access time
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[151]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[154]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_CBDKNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_CBDKNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[630]=COEFF_OVT * (MW[141] + MW[143]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[152] + MW[153]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[142]) +                                                          ; Auto access time
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[151]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[154]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_CBDKNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_CBDKNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   CBD KNR ACCESS - PROJECT ELEMENTS OF UTILITY ARE:
      MSC = 0
      ProjTime = 0
      ElseTime = 0
      IF ({ProjectModeFlag}==2)
        ProjTime = MW[165]
        ElseTime = MW[164] + MW[166] + MW[167] + MW[168] + MW[169] + MW[170]
        IVTB = MW[165] * IVTF
        MSC = MSC2
        IF ((MW[165]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==3)
        ProjTime = MW[167]
        ElseTime = MW[164] + MW[165] + MW[166] + MW[168] + MW[169] + MW[170]
        IVTB = MW[167] * IVTF
        MSC = MSC2
        IF ((MW[167]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==4)
        ProjTime = MW[168]
        ElseTime = MW[164] + MW[165] + MW[166] + MW[167] + MW[169] + MW[170]
        IVTB = MW[168] * IVTF
        MSC = MSC2
        IF ((MW[168]>0) && (ElseTime==0)) MSC = MSC1
      ELSEIF ({ProjectModeFlag}==5)
        ProjTime = MW[170]
        ElseTime = MW[164] + MW[165] + MW[166] + MW[167] + MW[168] + MW[169]
        IVTB = MW[170] * IVTF
        MSC = MSC2
        IF ((MW[170]>0) && (ElseTime==0)) MSC = MSC1
      ENDIF
      IF (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest})) print list='CBDKNR-Proj  MSC=",MSC(5.2),", IVTB=",IVTB(7.2),printo=1
      MW[311]=COEFF_OVT * (MW[161] + MW[163]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[172] + MW[173]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[162]) +                                                          ; Auto access time
              COEFF_IVTT * (ProjTime + ElseTime) +                                              ; IVTT
              COEFF_XFER * (MW[171]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[174]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_CBDKNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_CBDKNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy
      MW[631]=COEFF_OVT * (MW[161] + MW[163]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[172] + MW[173]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[162]) +                                                          ; Auto access time
              COEFF_IVTT * (IVTB + ElseTime) +                                                  ; IVTT
              COEFF_XFER * (MW[171]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[174]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD_CBDKNR * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD_CBDKNR * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J] +                                                 ; Exurban attraction dummy
              MSC

  ;   FRINGE PNR ACCESS TO CIRCULATORS:
      MW[312]=COEFF_OVT * (MW[181] + MW[183]) +                                                 ; Walk & transfer time
              COEFF_OVT * (MW[192] + MW[193]) +                                                 ; Initial & transfer wait
              COEFF_IVTT * (MW[182]) +                                                          ; Auto access time
              COEFF_IVTT * (MW[184] + MW[185] + MW[186] + MW[187] + MW[188] + MW[189] + MW[190]) +   ; IVTT
              COEFF_XFER * (MW[191]) +                                                          ; Number of transfers
              COEFF_COST * {InflationFare} * (MW[194]) +                                        ; Transit fare
@isNHB@       COEFF_DCBD * (ZI.1.CBD_DUMMY[I] + ZI.1.CBD_DUMMY[J]) +                              ; CBD dummy (NHB)
@noNHB@       COEFF_DCBD * ZI.1.CBD_DUMMY[J] +                                                  ; CBD dummy
              COEFF_DEXUP * ZI.1.EXU_DUMMY[I] +                                                 ; Exurban production dummy
              COEFF_DEXUA * ZI.1.EXU_DUMMY[J]                                                   ; Exurban attraction dummy

;******************************** END UTILITY CALCULATIONS ************************************

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

@isNHB@ IF (I==794) LIST=I(5.0),"-",J(5.0)," -- ",_parkzonePNR(7.0),_parkcostPNR(7.2),_parkzoneFRG(7.0),_parkcostFRG(7.2)

; Check if the IVT times on the transit path exist (this avoids having a jloop in the utility calculations)
        IF ((MW[24] + MW[26]) == 0) MW[304]=-9999.99                                                                       ; walk-bus path
        IF ((MW[24] + MW[26]) == 0) MW[624]=-9999.99                                                                       ; walk-bus path
        IF ((MW[45] + MW[47] + MW[48] + MW[49] + MW[50]) == 0) MW[305]=-9999.99                                            ; walk-proj path
        IF ((MW[45] + MW[47] + MW[48] + MW[49] + MW[50]) == 0) MW[625]=-9999.99                                            ; walk-proj path
        IF ((MW[64] + MW[66]) == 0) MW[306]=-9999.99                                                                       ; pnr-bus path
        IF ((MW[64] + MW[66]) == 0) MW[626]=-9999.99                                                                       ; pnr-bus path
        IF ((MW[85] + MW[87] + MW[88] + MW[89] + MW[90]) == 0) MW[307]=-9999.99                                            ; pnr proj path
        IF ((MW[85] + MW[87] + MW[88] + MW[89] + MW[90]) == 0) MW[627]=-9999.99                                            ; pnr proj path
        IF ((MW[104] + MW[106]) == 0) MW[308]=-9999.99                                                                     ; knr bus path
        IF ((MW[104] + MW[106]) == 0) MW[628]=-9999.99                                                                     ; knr bus path
        IF ((MW[125] + MW[127] + MW[128] + MW[129] + MW[130]) == 0) MW[309]=-9999.99                                       ; knr proj path
        IF ((MW[125] + MW[127] + MW[128] + MW[129] + MW[130]) == 0) MW[629]=-9999.99                                       ; knr proj path
        IF ((MW[144] + MW[146]) == 0) MW[310]=-9999.99                                                                     ; CBDknr bus path
        IF ((MW[144] + MW[146]) == 0) MW[630]=-9999.99                                                                     ; CBDknr bus path
        IF ((MW[165] + MW[167] + MW[168] + MW[169] + MW[170]) == 0) MW[311]=-9999.99                                       ; CBDknr proj path
        IF ((MW[165] + MW[167] + MW[168] + MW[169] + MW[170]) == 0) MW[631]=-9999.99                                       ; CBDknr proj path

 ; Minimum distance criteria on paths
        IF (MW[2] < {MinDistWalkAcc})
                MW[304]=-9999.99,  MW[305]=-9999.99
                MW[624]=-9999.99,  MW[625]=-9999.99
        ENDIF
        IF (MW[2] < {MinDistAutoAcc})
                MW[306]=-9999.99,  MW[626]=-9999.99
                MW[307]=-9999.99,  MW[627]=-9999.99
                MW[308]=-9999.99,  MW[628]=-9999.99
                MW[309]=-9999.99,  MW[629]=-9999.99
                MW[310]=-9999.99,  MW[630]=-9999.99
                MW[311]=-9999.99,  MW[631]=-9999.99
        ENDIF
        ; NOTE: no min distance criteria for fringe parking

 ; debug report
        if (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
         print list='\n',printo=1
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

  ;         Baseline                                            With Mode-Specific Constant
  ;   COMPOSITE UTILITY for walk to bus                         COMPOSITE UTILITY for walk to bus
      MW[404]=((MW[304]+K_WALKBUS_AUTO0)/NC_WALKBUS),           MW[704]=((MW[624]+K_WALKBUS_AUTO0)/NC_WALKBUS),
      MW[424]=((MW[304]+K_WALKBUS_AUTO1)/NC_WALKBUS),           MW[724]=((MW[624]+K_WALKBUS_AUTO1)/NC_WALKBUS),
      MW[444]=((MW[304]+K_WALKBUS_AUTO2)/NC_WALKBUS),           MW[744]=((MW[624]+K_WALKBUS_AUTO2)/NC_WALKBUS),
  ;   COMPOSITE UTILITY for walk to project                     COMPOSITE UTILITY for walk to project
      MW[405]=((MW[305]+K_WALKPRJ_AUTO0)/NC_WALKPRJ),           MW[705]=((MW[625]+K_WALKPRJ_AUTO0)/NC_WALKPRJ)
      MW[425]=((MW[305]+K_WALKPRJ_AUTO1)/NC_WALKPRJ),           MW[725]=((MW[625]+K_WALKPRJ_AUTO1)/NC_WALKPRJ)
      MW[445]=((MW[305]+K_WALKPRJ_AUTO2)/NC_WALKPRJ),           MW[745]=((MW[625]+K_WALKPRJ_AUTO2)/NC_WALKPRJ)
  ;   COMPOSITE UTILITY for PNR to bus                          COMPOSITE UTILITY for PNR to bus
      MW[406]=((MW[306]+K_PNRBUS_AUTO0)/NC_PNRBus),             MW[706]=((MW[626]+K_PNRBUS_AUTO0)/NC_PNRBus)
      MW[426]=((MW[306]+K_PNRBUS_AUTO1)/NC_PNRBus),             MW[726]=((MW[626]+K_PNRBUS_AUTO1)/NC_PNRBus)
      MW[446]=((MW[306]+K_PNRBUS_AUTO2)/NC_PNRBus),             MW[746]=((MW[626]+K_PNRBUS_AUTO2)/NC_PNRBus)
  ;   COMPOSITE UTILITY for PNR to project                      COMPOSITE UTILITY for PNR to project
      MW[407]=((MW[307]+K_PNRPRJ_AUTO0)/NC_PNRPrj),             MW[707]=((MW[627]+K_PNRPRJ_AUTO0)/NC_PNRPrj)
      MW[427]=((MW[307]+K_PNRPRJ_AUTO1)/NC_PNRPrj),             MW[727]=((MW[627]+K_PNRPRJ_AUTO1)/NC_PNRPrj)
      MW[447]=((MW[307]+K_PNRPRJ_AUTO2)/NC_PNRPrj),             MW[747]=((MW[627]+K_PNRPRJ_AUTO2)/NC_PNRPrj)
  ;   COMPOSITE UTILITY for KNR to bus                          COMPOSITE UTILITY for KNR to bus
      MW[408]=((MW[308]+K_KNRBUS_AUTO0)/NC_KNRBus),             MW[708]=((MW[628]+K_KNRBUS_AUTO0)/NC_KNRBus)
      MW[428]=((MW[308]+K_KNRBUS_AUTO1)/NC_KNRBus),             MW[728]=((MW[628]+K_KNRBUS_AUTO1)/NC_KNRBus)
      MW[448]=((MW[308]+K_KNRBUS_AUTO2)/NC_KNRBus),             MW[748]=((MW[628]+K_KNRBUS_AUTO2)/NC_KNRBus)
  ;   COMPOSITE UTILITY for KNR to project                      COMPOSITE UTILITY for KNR to project
      MW[409]=((MW[309]+K_KNRPRJ_AUTO0)/NC_KNRPrj),             MW[709]=((MW[629]+K_KNRPRJ_AUTO0)/NC_KNRPrj)
      MW[429]=((MW[309]+K_KNRPRJ_AUTO1)/NC_KNRPrj),             MW[729]=((MW[629]+K_KNRPRJ_AUTO1)/NC_KNRPrj)
      MW[449]=((MW[309]+K_KNRPRJ_AUTO2)/NC_KNRPrj),             MW[749]=((MW[629]+K_KNRPRJ_AUTO2)/NC_KNRPrj)
  ;   COMPOSITE UTILITY for CBD KNR to bus                      COMPOSITE UTILITY for CBD KNR to bus
      MW[410]=((MW[310]+K_CBDKNRBUS_AUTO0)/NC_KNRBus),          MW[710]=((MW[630]+K_CBDKNRBUS_AUTO0)/NC_KNRBus)
      MW[430]=((MW[310]+K_CBDKNRBUS_AUTO1)/NC_KNRBus),          MW[730]=((MW[630]+K_CBDKNRBUS_AUTO1)/NC_KNRBus)
      MW[450]=((MW[310]+K_CBDKNRBUS_AUTO2)/NC_KNRBus),          MW[750]=((MW[630]+K_CBDKNRBUS_AUTO2)/NC_KNRBus)
  ;   COMPOSITE UTILITY for CBD KNR to project                  COMPOSITE UTILITY for CBD KNR to project
      MW[411]=((MW[311]+K_CBDKNRPRJ_AUTO0)/NC_KNRPrj),          MW[711]=((MW[631]+K_CBDKNRPRJ_AUTO0)/NC_KNRPrj)
      MW[431]=((MW[311]+K_CBDKNRPRJ_AUTO1)/NC_KNRPrj),          MW[731]=((MW[631]+K_CBDKNRPRJ_AUTO1)/NC_KNRPrj)
      MW[451]=((MW[311]+K_CBDKNRPRJ_AUTO2)/NC_KNRPrj),          MW[751]=((MW[631]+K_CBDKNRPRJ_AUTO2)/NC_KNRPrj)

  ;   COMPOSITE UTILITY for Fringe PNR to Cirulators
      MW[412]=((MW[312]+K_FRGPNRCIR_AUTO0)/NC_FringePark)
      MW[432]=((MW[312]+K_FRGPNRCIR_AUTO1)/NC_FringePark)
      MW[452]=((MW[312]+K_FRGPNRCIR_AUTO2)/NC_FringePark)

; use ZAPZERO here to zero out the drive alone and PNR access trips for zero-car households
      if ( ({ZAPZERO} = 1) && (('@PURP@'=='HBW') || ('@PURP@'=='HBNW')) )
        MW[401] = -9999.99     ; drive alone for 0car households
        MW[406] = -9999.99     ; PNR-bus trips for 0car households
        MW[407] = -9999.99     ; PNR-prj trips for 0car households
        MW[412] = -9999.99     ; Fringe PNR-cir trips for 0car households
        MW[706] = -9999.99     ; PNR-bus trips for 0car households
        MW[707] = -9999.99     ; PNR-prj trips for 0car households
      endif

JLOOP
; if (ACC=1-3)
  if (({DebugMC} > 0) && (I={SelOrigin}) && (J={SelDest}))
   print list='\n\n********************************************************************************************', printo=1
;   print list=' Access Type: ',ACC(1.0),'. ',ACC_NAME, printo=1
;   print list='********************************************************************************************','\n' printo=1
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
   print list='In-Vehicle time on BRT guideway                                   ',MW[16][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[21][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[23][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[32][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[33][J],printo=1
   print list='Number of transfers                                               ',MW[31][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[34][J],printo=1
   print list='\nWalk Bus disutility                                             ',MW[304][J](12.4),printo=1
   print list='Walk Bus disutility with mode-specific constant                 ',MW[624][J](12.4),printo=1
;   print list='Walk access dummy (added to the utility)                          ',walk_acc_dum,printo=1
   print list='\nWalk Bus composite disutility (0 car)                           ',MW[404][J](12.4),printo=1
   print list='Walk Bus composite disutility (1 car)                           ',MW[424][J](12.4),printo=1
   print list='Walk Bus composite disutility (2+ car)                          ',MW[444][J](12.4),printo=1
   print list='\nWalk Bus composite disutility (0 car) with MSC                  ',MW[704][J](12.4),printo=1
   print list='Walk Bus composite disutility (1 car) with MSC                  ',MW[724][J](12.4),printo=1
   print list='Walk Bus composite disutility (2+ car) with MSC                 ',MW[744][J](12.4),printo=1
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
   print list='Walk Prj disutility with mode-specific constant                 ',MW[625][J](12.4),printo=1
;   print list='Walk access dummy (added to the utility)                          ',walk_acc_dum,printo=1
   print list='\nWalk Prj composite disutility (0 car)                           ',MW[405][J](12.4),printo=1
   print list='Walk Prj composite disutility (1 car)                           ',MW[425][J](12.4),printo=1
   print list='Walk Prj composite disutility (2 car)                           ',MW[445][J](12.4),printo=1
   print list='\nExponentiated walk prj composite disutility (0 car)           ',exp(MW[405][J])(14.12),printo=1
   print list='Exponentiated walk prj composite disutility (1 car)           ',exp(MW[425][J])(14.12),printo=1
   print list='Exponentiated walk prj composite disutility (2 car)           ',exp(MW[445][J])(14.12),printo=1

   print list='\n\n\nElements used in PNR Bus disutility calculations: ***************************', printo=1
   print list='In-Vehicle time (Bus)                                             ',MW[64][J](12.6),printo=1
   print list='In-Vehicle time (PRJ Bus)                                         ',MW[65][J](12.6),printo=1
   print list='In-Vehicle time (Circulator)                                      ',MW[66][J](12.6),printo=1
   print list='In-Vehicle time (Rail)                                            ',(MW[67][J]+MW[68][J])(12.6),printo=1
   print list='In-Vehicle time (Project Mode)                                    ',MW[70][J](12.6),printo=1
   print list='In-Vehicle time on BRT guideway                                   ',MW[17][J](12.6),printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[61][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min - weighted)      ',MW[62][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[63][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[72][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[73][J],printo=1
   print list='Number of transfers                                               ',MW[71][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[74][J],printo=1
   print list='\nPNR Bus disutility                                              ',MW[306][J](12.4),printo=1
   print list='PNR Bus disutility with mode-specific constant                  ',MW[626][J](12.4),printo=1
;   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nPNR Bus composite disutility (0 car)                            ',MW[406][J](12.4),printo=1
   print list='PNR Bus composite disutility (1 car)                            ',MW[426][J](12.4),printo=1
   print list='PNR Bus composite disutility (2 car)                            ',MW[446][J](12.4),printo=1
   print list='\nPNR Bus composite disutility (0 car) with MSC                  ',MW[706][J](12.4),printo=1
   print list='PNR Bus composite disutility (1 car) with MSC                  ',MW[726][J](12.4),printo=1
   print list='PNR Bus composite disutility (2+ car) with MSC                 ',MW[746][J](12.4),printo=1
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
   print list='PNR Prj disutility with mode-specific constant                  ',MW[627][J](12.4),printo=1
;   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
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
   print list='In-Vehicle time on BRT guideway                                   ',MW[18][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[101][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[102][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[103][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[112][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[113][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[114][J],printo=1
   print list='\nKNR Bus disutility                                              ',MW[308][J](12.4),printo=1
   print list='KNR Bus disutility with mode-specific constant                  ',MW[628][J](12.4),printo=1
;   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\nKNR Bus composite disutility (0 car)                            ',MW[408][J](12.4),printo=1
   print list='KNR Bus composite disutility (1 car)                            ',MW[428][J](12.4),printo=1
   print list='KNR Bus composite disutility (2 car)                            ',MW[448][J](12.4),printo=1
   print list='\nKNR Bus composite disutility (0 car) with MSC                  ',MW[708][J](12.4),printo=1
   print list='KNR Bus composite disutility (1 car) with MSC                  ',MW[728][J](12.4),printo=1
   print list='KNR Bus composite disutility (2+ car) with MSC                 ',MW[748][J](12.4),printo=1
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
   print list='KNR Prj disutility with mode-specific constant                  ',MW[629][J](12.4),printo=1
;   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
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
   print list='In-Vehicle time on BRT guideway                                   ',MW[19][J],printo=1
   print list='Out of Vehicle time (Walk)                                        ',MW[141][J],printo=1
   print list='Out of Vehicle time (Auto access time in IVT min)                 ',MW[142][J],printo=1
   print list='Out of Vehicle time (Transfer Walk)                               ',MW[143][J],printo=1
   print list='Out of Vehicle time (IWAIT)                                       ',MW[152][J],printo=1
   print list='Out of Vehicle time (XWAIT)                                       ',MW[153][J],printo=1
   print list='Number of transfers                                               ',MW[151][J],printo=1
   print list='Transit Fare (in cents)                                           ',MW[154][J],printo=1
   print list='\n'
   print list='CBD KNR Bus disutility                                          ',MW[310][J](12.4),printo=1
   print list='CBD KNR Bus disutility with mode-specific constant              ',MW[630][J](12.4),printo=1
;   print list='Auto access dummy (added to the utility)                          ',auto_acc_dum,printo=1
   print list='\n'
   print list='CBD KNR Bus composite disutility (0 car)                        ',MW[410][J](12.4),printo=1
   print list='CBD KNR Bus composite disutility (1 car)                        ',MW[430][J](12.4),printo=1
   print list='CBD KNR Bus composite disutility (2 car)                        ',MW[450][J](12.4),printo=1
   print list='CBD KNR Bus composite disutility (0 car) with MSC               ',MW[710][J](12.4),printo=1
   print list='CBD KNR Bus composite disutility (1 car) with MSC               ',MW[730][J](12.4),printo=1
   print list='CBD KNR Bus composite disutility (2 car) with MSC               ',MW[750][J](12.4),printo=1
   print list='\n'
   print list='Exponentiated CBD KNR Bus composite disutility (0 car)        ',exp(MW[410][J])(14.12),printo=1
   print list='Exponentiated CBD KNR Bus composite disutility (1 car)        ',exp(MW[430][J])(14.12),printo=1
   print list='Exponentiated CBD KNR Bus composite disutility (2 car)        ',exp(MW[450][J])(14.12),printo=1

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
   print list='\n'
   print list='CBD KNR Prj disutility                                          ',MW[311][J](12.4),printo=1
   print list='CBD KNR Bus disutility with mode-specific constant              ',MW[631][J](12.4),printo=1
;   print list='Auto access dummy (added to the utility)                         ',auto_acc_dum,printo=1
   print list='\n'
   print list='CBD KNR Prj composite disutility (0 car)                        ',MW[411][J](12.4),printo=1
   print list='CBD KNR Prj composite disutility (1 car)                        ',MW[431][J](12.4),printo=1
   print list='CBD KNR Prj composite disutility (2 car)                        ',MW[451][J](12.4),printo=1
   print list='\n'
   print list='Exponentiated CBD KNR prj composite disutility (0 car)        ',exp(MW[411][J])(14.12),printo=1
   print list='Exponentiated CBD KNR prj composite disutility (1 car)        ',exp(MW[431][J])(14.12),printo=1
   print list='Exponentiated CBD KNR prj composite disutility (2 car)        ',exp(MW[451][J])(14.12),printo=1

 endif
ENDJLOOP

; ############################# XCHOICE SETUP ###################################

; Baseline
; Zero Car
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=401,402,403,404,405,406,407,408,409,410,411,412,
      DEMANDMW=252,
      ODEMANDMW=501,502,503,504,505,506,507,508,509,510,511,512,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe, SPLITCOMP=601,
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

; One Car
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=421,422,423,424,425,426,427,428,429,430,431,432,
      DEMANDMW=253,
      ODEMANDMW=521,522,523,524,525,526,527,528,529,530,531,532,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe, SPLITCOMP=602,
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

; Two Car
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=441,442,443,444,445,446,447,448,449,450,451,452,
      DEMANDMW=254,
      ODEMANDMW=541,542,543,544,545,546,547,548,549,550,551,552,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe, SPLITCOMP=603,
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

; With Mode-Specific Constants
; Zero Car
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=401,402,403,704,705,706,707,708,709,710,711,412,
      DEMANDMW=252,
      ODEMANDMW=501,502,503,504,505,506,507,508,509,510,511,512,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe, SPLITCOMP=604,
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

; One Car
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=421,422,423,724,725,726,727,728,729,730,731,432,
      DEMANDMW=253,
      ODEMANDMW=521,522,523,524,525,526,527,528,529,530,531,532,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe, SPLITCOMP=605,
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

; Two Car
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,cbdknrbus,cbdknrprj,Fringe,
      UTILITIESMW=441,442,443,744,745,746,747,748,749,750,751,452,
      DEMANDMW=254,
      ODEMANDMW=541,542,543,544,545,546,547,548,549,550,551,552,
      STARTMW=900,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit NC_FRINGE Fringe, SPLITCOMP=606,
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

; compute additional user benefits
   MW[601] = (MW[601] / COEFF_IVTT)
   MW[602] = (MW[602] / COEFF_IVTT)
   MW[603] = (MW[603] / COEFF_IVTT)
   MW[604] = (MW[604] / COEFF_IVTT)
   MW[605] = (MW[605] / COEFF_IVTT)
   MW[606] = (MW[606] / COEFF_IVTT)
   MW[607] = MW[601] - MW[604]
   MW[608] = MW[602] - MW[605]
   MW[609] = MW[603] - MW[606]
   MW[610] = MW[607] * MW[252]
   MW[611] = MW[608] * MW[253]
   MW[612] = MW[609] * MW[254]
; Multiply by 100 for Minutp format
   MW[607] = MW[607] * 100.0
   MW[608] = MW[608] * 100.0
   MW[609] = MW[609] * 100.0
   MW[610] = MW[610] * 100.0
   MW[611] = MW[611] * 100.0
   MW[612] = MW[612] * 100.0

; ############################################ END XCHOICE #################################

    JLOOP
      if ((I=={SelOrigin}) && (J=={SelDest}))
        print list="\n\n",printo=1
        print list="Additional benefits in hours",printo=1
        print list="Zero car households          ",MW[610](20.10),printo=1
        print list="One car households           ",MW[611](20.10),printo=1
        print list="Two+ car households          ",MW[612](20.10),printo=1
        print list="\n",printo=1
        print list="Additional benefits per trip in minutes",printo=1
        print list="Zero car households          ",MW[607](20.10),printo=1
        print list="One car households           ",MW[608](20.10),printo=1
        print list="Two+ car households          ",MW[609](20.10),printo=1
        print list="\n",printo=1
        print list="Transit price (baseline)               ",printo=1
        print list="Zero car households          ",MW[601](20.10),printo=1
        print list="One car households           ",MW[602](20.10),printo=1
        print list="Two+ car households          ",MW[603](20.10),printo=1
        print list="\n",printo=1
        print list="Transit price (mode-specific constant) ",printo=1
        print list="Zero car households          ",MW[604](20.10),printo=1
        print list="One car households           ",MW[605](20.10),printo=1
        print list="Two+ car households          ",MW[606](20.10),printo=1
        print list="\n\n",printo=1
      endif
    ENDJLOOP

; ###############################################################################

ENDRUN


ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


ENDIF
; End of PILOT Script

