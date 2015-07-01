; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TDMAT00O.PRN" MSG='UB'

FILEI MATI[18] = "{SCENARIO_DIR}\output\expautoutil_tmp_@_PERIOD@.mat"

FILEI MATI[7] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT7@_Acc_{alt}{year}.mat"
FILEI MATI[6] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT6@_Acc_{alt}{year}.mat"
FILEI MATI[5] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT5@_Acc_{alt}{year}.mat"
FILEI MATI[4] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT4@_Acc_{alt}{year}.mat"
FILEI MATI[3] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT3@_Acc_{alt}{year}.mat"
FILEI MATI[2] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT2@_Acc_{alt}{year}.mat"
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\PsnTrips_@_PURP@_@_PERIOD@_@MKT1@_Acc_{alt}{year}.mat"

  
FILEO MATO[2] = "{SCENARIO_DIR}\OUTPUT\@_PURP@_@_PERIOD@UTIL_{alt}{year}.MAT",
    MO=401-407,411-417,421-427,431-437,441-447,451-457,461-467, DEC=49*S,
    NAME=PerTrip1,AutoTrnTrip1,AutoPrice1,WalkFrac1,WalkShare1,DriveFrac1,DriveShare1,
         PerTrip2,AutoTrnTrip2,AutoPrice2,WalkFrac2,WalkShare2,DriveFrac2,DriveShare2,
         PerTrip3,AutoTrnTrip3,AutoPrice3,WalkFrac3,WalkShare3,DriveFrac3,DriveShare3,
         PerTrip4,AutoTrnTrip4,AutoPrice4,WalkFrac4,WalkShare4,DriveFrac4,DriveShare4,
         PerTrip5,AutoTrnTrip5,AutoPrice5,WalkFrac5,WalkShare5,DriveFrac5,DriveShare5,
         PerTrip6,AutoTrnTrip6,AutoPrice6,WalkFrac6,WalkShare6,DriveFrac6,DriveShare6,
         PerTrip7,AutoTrnTrip7,AutoPrice7,WalkFrac7,WalkShare7,DriveFrac7,DriveShare7
     

zonemsg=10

DistributeINTRASTEP ProcessID="TMUDemoDist", ProcessList=1-%NUMBER_OF_PROCESSORS%

   

FILLMW MW[1]  = MI.1.1,2,3,4,5,6,7,8,9,10,11             ; Market 1 CW trips by 11 Modes
FILLMW MW[12] = MI.1.12,13,14,15,16,17,18,19,20,21,22    ; Market 1 MD trips by 11 Modes
FILLMW MW[23] = MI.1.23,24,25,26,27,28,29,30,31,32,33    ; Market 1 NT trips by 11 Modes

FILLMW MW[34] = MI.2.1,2,3,4,5,6,7,8,9,10,11             ; Market 2 CW trips by 11 Modes
FILLMW MW[45] = MI.2.12,13,14,15,16,17,18,19,20,21,22    ; Market 2 MD trips by 11 Modes
FILLMW MW[56] = MI.2.23,24,25,26,27,28,29,30,31,32,33    ; Market 2 NT trips by 11 Modes

FILLMW MW[67] = MI.3.1,2,3,4,5,6,7,8,9,10,11             ; Market 3 CW trips by 11 Modes
FILLMW MW[78] = MI.3.12,13,14,15,16,17,18,19,20,21,22    ; Market 3 MD trips by 11 Modes
FILLMW MW[89] = MI.3.23,24,25,26,27,28,29,30,31,32,33    ; Market 3 NT trips by 11 Modes

FILLMW MW[100] = MI.4.1,2,3,4,5,6,7,8,9,10,11             ; Market 4 CW trips by 11 Modes
FILLMW MW[111] = MI.4.12,13,14,15,16,17,18,19,20,21,22    ; Market 4 MD trips by 11 Modes
FILLMW MW[122] = MI.4.23,24,25,26,27,28,29,30,31,32,33    ; Market 4 NT trips by 11 Modes

FILLMW MW[133] = MI.5.1,2,3,4,5,6,7,8,9,10,11             ; Market 5 CW trips by 11 Modes
FILLMW MW[144] = MI.5.12,13,14,15,16,17,18,19,20,21,22    ; Market 5 MD trips by 11 Modes
FILLMW MW[155] = MI.5.23,24,25,26,27,28,29,30,31,32,33    ; Market 5 NT trips by 11 Modes

FILLMW MW[166] = MI.6.1,2,3,4,5,6,7,8,9,10,11             ; Market 6 CW trips by 11 Modes
FILLMW MW[177] = MI.6.12,13,14,15,16,17,18,19,20,21,22    ; Market 6 MD trips by 11 Modes
FILLMW MW[188] = MI.6.23,24,25,26,27,28,29,30,31,32,33    ; Market 6 NT trips by 11 Modes

FILLMW MW[199] = MI.7.1,2,3,4,5,6,7,8,9,10,11             ; Market 7 CW trips by 11 Modes
FILLMW MW[210] = MI.7.12,13,14,15,16,17,18,19,20,21,22    ; Market 7 MD trips by 11 Modes
FILLMW MW[221] = MI.7.23,24,25,26,27,28,29,30,31,32,33    ; Market 7 NT trips by 11 Modes

FILLMW MW[251] = MI.18.1,2,3,4,5,6,7                      ; exponentiated auto utility





; Aggregate trips for all access categories (can walk, must drive and no transit)
LOOP MARKET=1,7
       LOOP CHOICE=1,11
        LOOP ACC=1,3
               _idx12 = CHOICE+(MARKET-1)*33+(ACC-1)*11      ;Read from MW(1-231)
               _idx13 = 300+MARKET                           ;Write to MW(301-307)
               COMP total = ROWADD(_idx13,_idx13,_idx12)
           ENDLOOP
       ENDLOOP
ENDLOOP
   

 
; ********************************* BEGIN USER BENEFIT ********************************************
LOOP MARKET=1,7                    ; UB data generated for each market segment separately
  
  IF (MARKET=1) MARKET_NAME='@Mkt1@'
  IF (MARKET=2) MARKET_NAME='@Mkt2@'
  IF (MARKET=3) MARKET_NAME='@Mkt3@'
  IF (MARKET=4) MARKET_NAME='@Mkt4@'
  IF (MARKET=5) MARKET_NAME='@Mkt5@'
  IF (MARKET=6) MARKET_NAME='@Mkt6@'
  IF (MARKET=7) MARKET_NAME='@Mkt7@'

 ;_idx1 = (900 + 11*(MARKET-1))
 ;_idx2 = 33*(MARKET-1)

 JLOOP

  ; User benefit calculations are done for each market segment
  ; Determine can walk & must drive percentages for matrix for Summit for each market segment (1 for auto0, 2 for auto1 and 3 for auto2)
  ; person trips
  IF ({RunUB}==1)

 _idx22 = 10*(MARKET-1)
  T1=401+_idx22, T2=402+_idx22, T3=403+_idx22, T4=404+_idx22, T5=405+_idx22, T6=406+_idx22, T7=407+_idx22

  if (MW[300+MARKET]>0)
    MW[T1] = MW[300+MARKET]                                                                     ; person trips in market segment
    MW[T2] = MW[T1]                                                                             ; motorized trips in market segment
    MW[T3] = MW[250+MARKET]                                                                     ; expotentied auto utility
    MW[601] = MW[1+_idx22] + MW[2+_idx22] + MW[3+_idx22] + MW[4+_idx22] + MW[5+_idx22] +
              MW[6+_idx22] + MW[7+_idx22] + MW[8+_idx22] + MW[9+_idx22] + MW[10+_idx22] + MW[11+_idx22]
                                                                                                 ; total trips that can walk in MS
    MW[602] = MW[4+_idx22] + MW[5+_idx22] + MW[6+_idx22] + MW[7+_idx22] + MW[8+_idx22] +
              MW[9+_idx22]                                                                       ; transit trips that can walk in MS
    MW[T4] = MW[601] / MW[T1]
    if (MW[601]>0)
        MW[T5] = MW[602] / MW[601]
    else
        MW[T5] = 0.00                                                                            ; transit share of trips that can walk
    endif

    MW[603] = MW[12+_idx22] + MW[13+_idx22] + MW[14+_idx22] + MW[15+_idx22] + MW[16+_idx22] + MW[17+_idx22] + 
              MW[18+_idx22] + MW[19+_idx22] + MW[20+_idx22] + MW[19+_idx22] + MW[20+_idx22]          ; total trips that must drive in MS
    MW[604] = MW[15+_idx22] + MW[16+_idx22] + MW[17+_idx22] + MW[18+_idx22] + MW[19+_idx22] +
              MW[20+_idx22]                                                                      ; transit trips that must drive in MS
    MW[T6] = MW[603] / MW[T1]                                                                    ; fraction of person trips that must drive
    if (MW[603]>0)
        MW[T7] = MW[604] / MW[603]                                                               ; transit share of trips that must drive
    else
        MW[T7] = 0.00
    endif
  else
    MW[T1] = 0.00
    MW[T2] = 0.00
    MW[T3] = 0.00
    MW[T4] = 0.00
    MW[T5] = 0.00
    MW[T6] = 0.00
    MW[T7] = 0.00
  endif
if (i=125)
if (j=751)
print list="questioned matrices",MW[601], MW[T1], MW[1+_idx22], MW[2+_idx22] , MW[3+_idx22] , MW[4+_idx22],MW[5+_idx22], MW[6+_idx22],MW[7+_idx22],MW[8+_idx22],MW[9+_idx22],MW[10+_idx22],MW[11+_idx22]
 ENDIF
ENDIF

 if (I={SelOrigin} && J={SelDest})
    print list="*UB Rec* ",i(5.0),j(5.0),MARKET(5.0),mw[T1](10.1),mw[T2](10.1),mw[T3](10.7),mw[T4](10.5),mw[T5](10.5),mw[T6](10.5),mw[T7](10.5)
  endif

  ENDIF

 ENDJLOOP

ENDLOOP
; ********************************* END USER BENEFIT ********************************************

ENDRUN
