; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{OUTDIR}\MCMAT00E.PRN" MSG='Nested logit model'
FILEI MATI[11] = "{OUTDIR}\temfiles\@PURP@REVXFER.MAT"
FILEI MATI[10] = "{OUTDIR}\temfiles\@PURP@UTIL_NT_2CAR.MAT"
FILEI MATI[9] = "{OUTDIR}\temfiles\@PURP@UTIL_NT_1CAR.MAT"
FILEI MATI[8] = "{OUTDIR}\temfiles\@PURP@UTIL_NT_0CAR.MAT"
FILEI MATI[7] = "{OUTDIR}\temfiles\@PURP@UTIL_MD_2CAR.MAT"
FILEI MATI[6] = "{OUTDIR}\temfiles\@PURP@UTIL_MD_1CAR.MAT"
FILEI MATI[5] = "{OUTDIR}\temfiles\@PURP@UTIL_MD_0CAR.MAT"
FILEI MATI[4] = "{OUTDIR}\temfiles\@PURP@UTIL_CW_2CAR.MAT"
FILEI MATI[3] = "{OUTDIR}\temfiles\@PURP@UTIL_CW_1CAR.MAT"
FILEI MATI[2] = "{OUTDIR}\temfiles\@PURP@UTIL_CW_0CAR.MAT"
FILEI MATI[1] = "{OUTDIR}\PTRIPSMC.MAT"
FILEI LOOKUPI[1] = "{PARAMS}\TRN_COEFFICIENTS.DBF"
FILEI ZDATI[1] = "{OUTDIR}\TAZDATA_{alt}{year}.DBF"
FILEO PRINTO[3] = "{OUTDIR}\MODESHARES.CSV",
append=t
FILEO PRINTO[2] = "{OUTDIR}\ModeSum.TXT",
append=t
FILEO PRINTO[1] = "{OUTDIR}\ModeDebug.TXT",
append=t
FILEO MATO[3] = "{OUTDIR}\@PURP@demand_{alt}{year}.MAT",
MO=311-313,321-323,331-333,dec=9*D,name=cw0car,md0car,nt0car,cw1car,md1car,nt1car,cw2car,md2car,nt2car
FILEO MATO[2] = "{OUTDIR}\@PURP@UTIL_{alt}{year}.MAT",
MO=201-207,211-217,221-227, DEC=21*D,
NAME=PerTrip1,AutoTrnTrip1,AutoPrice1,WalkFrac1,WalkShare1,DriveFrac1,DriveShare1,
     PerTrip2,AutoTrnTrip2,AutoPrice2,WalkFrac2,WalkShare2,DriveFrac2,DriveShare2,
     PerTrip3,AutoTrnTrip3,AutoPrice3,WalkFrac3,WalkShare3,DriveFrac3,DriveShare3
FILEO MATO[1] = "{OUTDIR}\@PURP@_{alt}{year}.MAT",
MO=141-149,DEC=9*D,NAME=DA,SR2,SR3,WALKBUS,WALKPRJ,PNRBUS,PNRPRJ,KNRBUS,KNRPRJ

zonemsg=100

FILLMW MW[1]=MI.1.@PURP@
FILLMW MW[11]=MI.2.1,2,3,4,5,6,7,8,9
FILLMW MW[21]=MI.3.1,2,3,4,5,6,7,8,9
FILLMW MW[31]=MI.4.1,2,3,4,5,6,7,8,9
FILLMW MW[41]=MI.5.1,2,3,4,5,6,7,8,9
FILLMW MW[51]=MI.6.1,2,3,4,5,6,7,8,9
FILLMW MW[61]=MI.7.1,2,3,4,5,6,7,8,9
FILLMW MW[71]=MI.8.1,2,3,4,5,6,7,8,9
FILLMW MW[81]=MI.9.1,2,3,4,5,6,7,8,9
FILLMW MW[91]=MI.10.1,2,3,4,5,6,7,8,9
FILLMW MW[101]=MI.11.1,2,3,4,5,6,7,8

array _tripsDA=3, _tripsHOV2=3, _tripsHOV3=3, _tripsWalkbus=3, _tripsWalkprj=3, _tripsPNRbus=3,
      _tripsPNRprj=3, _tripsKNRbus=3, _tripsKNRprj=3, _SUMtrips=3,
      _cw=12, _md=12, _na=12, _totacc=12,
      _exup=12, _exua=12, _cbdp=12, _cbda=12, _othp=12, _otha=12,
      _frev=7, _avef=7, _xfer0=7, _xfer1=7, _xfer2=7, _xfer3=7

if (i==1)
  loop xx=1,3
    _tripsDA[xx]=0
    _tripsHOV2[xx]=0
    _tripsHOV3[xx]=0
    _tripsWalkBus[xx]=0
    _tripsWalkPrj[xx]=0
    _tripsPNRBus[xx]=0
    _tripsPNRPrj[xx]=0
    _tripsKNRBus[xx]=0
    _tripsKNRPrj[xx]=0
    _SUMtrips[xx]=0
  endloop
endif

;Coefficients
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=1
;Coefficients
if (i==1)
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
endif

; Market segmentation
  MW[301]=MW[1] * ZI.1.PERCAUTO0[I]                                                                     ; Zero car HHs
  MW[311] = MW[301] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
  MW[312] = MW[301] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
  MW[313] = MW[301] - MW[311] - MW[312]                                                                 ; No Access

  MW[302]=MW[1] * ZI.1.PERCAUTO1[I]                  ; Auto 1                                           ; One car HHs
  MW[321] = MW[302] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
  MW[322] = MW[302] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
  MW[323] = MW[302] - MW[321] - MW[322]                                                                 ; No Access

  MW[303]=MW[1] * ZI.1.PERCAUTO2[I]                  ; Auto 2                                           ; Two+ car HHs
  MW[331] = MW[303] * (ZI.1.PCWPRD@PERIOD@[I] * 0.01) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)                 ; Can Walk
  MW[332] = MW[303] * (1 - (ZI.1.PCWPRD@PERIOD@[I] * 0.01)) * (ZI.1.PCWATT@PERIOD@[J] * 0.01)           ; Must Drive
  MW[333] = MW[303] - MW[331] - MW[332]                                                                 ; No Access

LOOP ACC=1,3
      _idx=(ACC-1)*30
      if (ACC==1) ACC_NAME='CAN WALK TO TRANSIT'
      if (ACC==2) ACC_NAME='MUST DRIVE TO TRANSIT'
      if (ACC==3) ACC_NAME='NO TRANSIT'

; AUTO0
      M1=401+_idx,M2=402+_idx,M3=403+_idx,M4=404+_idx,M5=405+_idx,M6=406+_idx,M7=407+_idx,M8=408+_idx,M9=409+_idx
      MU1=11+_idx,MU2=12+_idx,MU3=13+_idx,MU4=14+_idx,MU5=15+_idx,MU6=16+_idx,MU7=17+_idx,MU8=18+_idx,MU9=19+_idx
      DMD=ACC+310
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,
      UTILITIESMW=MU1,MU2,MU3,MU4,MU5,MU6,MU7,MU8,MU9,
      DEMANDMW=DMD,
      ODEMANDMW=M1,M2,M3,M4,M5,M6,M7,M8,M9,
      STARTMW=520,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit,
;     Auto nest
      SPLIT=Auto 1.0 da NC_AUTOSR hov, SPLITCOMP=501,
;     HOV nest
      SPLIT=hov 1.0 hov2 1.0 hov3,
;     Transit nest
      SPLIT= Transit NC_TRNAC Walk NC_TRNAC PNR NC_TRNAC KNR,
;     Walk nest
      SPLIT= Walk 1.0 walkbus 1.0 walkprj,
;     PNR nest
      SPLIT= PNR 1.0 pnrbus 1.0 pnrprj,
;     KNR nest
      SPLIT= KNR 1.0 knrbus 1.0 knrprj

; AUTO1
      M1=411+_idx,M2=412+_idx,M3=413+_idx,M4=414+_idx,M5=415+_idx,M6=416+_idx,M7=417+_idx,M8=418+_idx,M9=419+_idx
      MU1=21+_idx,MU2=22+_idx,MU3=23+_idx,MU4=24+_idx,MU5=25+_idx,MU6=26+_idx,MU7=27+_idx,MU8=28+_idx,MU9=29+_idx
      DMD=ACC+320
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,
      DEMANDMW=DMD,
      UTILITIESMW=MU1,MU2,MU3,MU4,MU5,MU6,MU7,MU8,MU9,
      ODEMANDMW=M1,M2,M3,M4,M5,M6,M7,M8,M9,
      STARTMW=520,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit,
;     Auto nest
      SPLIT=Auto 1.0 da NC_AUTOSR hov, SPLITCOMP=502,
;     HOV nest
      SPLIT=hov 1.0 hov2 1.0 hov3,
;     Transit nest
      SPLIT= Transit NC_TRNAC Walk NC_TRNAC PNR NC_TRNAC KNR,
;     Walk nest
      SPLIT= Walk 1.0 walkbus 1.0 walkprj,
;     PNR nest
      SPLIT= PNR 1.0 pnrbus 1.0 pnrprj,
;     KNR nest
      SPLIT= KNR 1.0 knrbus 1.0 knrprj


; AUTO2
      M1=421+_idx,M2=422+_idx,M3=423+_idx,M4=424+_idx,M5=425+_idx,M6=426+_idx,M7=427+_idx,M8=428+_idx,M9=429+_idx
      MU1=31+_idx,MU2=32+_idx,MU3=33+_idx,MU4=34+_idx,MU5=35+_idx,MU6=36+_idx,MU7=37+_idx,MU8=38+_idx,MU9=39+_idx
      DMD=ACC+330
      XCHOICE ALTERNATIVES=da,hov2,hov3,walkbus,walkprj,pnrbus,pnrprj,knrbus,knrprj,
      DEMANDMW=DMD,
      UTILITIESMW=MU1,MU2,MU3,MU4,MU5,MU6,MU7,MU8,MU9,
      ODEMANDMW=M1,M2,M3,M4,M5,M6,M7,M8,M9,
      STARTMW=520,
;     Model Structure
;     Top level nest
      SPLIT=Total NC_AUTO Auto NC_TRN Transit,
;     Auto nest
      SPLIT=Auto 1.0 da NC_AUTOSR hov, SPLITCOMP=503,
;     HOV nest
      SPLIT=hov 1.0 hov2 1.0 hov3,
;     Transit nest
      SPLIT= Transit NC_TRNAC Walk NC_TRNAC PNR NC_TRNAC KNR,
;     Walk nest
      SPLIT= Walk 1.0 walkbus 1.0 walkprj,
;     PNR nest
      SPLIT= PNR 1.0 pnrbus 1.0 pnrprj,
;     KNR nest
      SPLIT= KNR 1.0 knrbus 1.0 knrprj

; now some debuging
LOOP MARKET=1,3
   if (MARKET=1) MARKET_NAME='Zero Car HHs     '
   if (MARKET=2) MARKET_NAME='One Car HHs      '
   if (MARKET=3) MARKET_NAME='Two+ Car HHs     '
 _idx=(ACC-1)*30
 _cnt=_idx+(MARKET-1)*10
 _cnt1=310+ACC+(MARKET-1)*10
 M1=401+_cnt,M2=402+_cnt,M3=403+_cnt,M4=404+_cnt,M5=405+_cnt,M6=406+_cnt,M7=407+_cnt,M8=408+_cnt,M9=409+_cnt
 ; DEBUG MODE CHOICE
 IF ({DebugMC}>0)
  JLOOP
  IF (I={SelOrigin} && J={SelDest})
; debugging
  if (MARKET=1)
  print list='\n\n\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ',printo=1
  print list='^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ',printo=1
  print list='\n\nCUBE UTILITY BASED XCHOICE MODEL\n',printo=1
  print list='\n\n\nPercent walk at Production zone               ',(ZI.1.PCWPRD@PERIOD@[I] * 0.01),printo=1
  print list='Percent walk at Attraction zone               ',(ZI.1.PCWPRD@PERIOD@[J] * 0.01),printo=1
  print list='Percent 0 car household at Production zone    ',ZI.1.PERCAUTO0[I],printo=1
  print list='Percent 1 car household at Production zone    ',ZI.1.PERCAUTO1[I],printo=1
  print list='Percent 2 car household at Production zone    ',ZI.1.PERCAUTO2[I],printo=1
  print list='\n\nAccess Type:      ',ACC_NAME,printo=1
  print list='*******************************************************************',printo=1
  endif
   print list='**************************************************',printo=1
   print list='\nMARKET:    ',MARKET_NAME,printo=1
   print list='**************************************************',printo=1
   print list='\nTotal demand between the interchange: ',MW[1][J](10.2),printo=1
   print list='Total                          ',MW[_cnt1][J](10.2),printo=1
  IF ((MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J])>0)
   shrda  =(MW[M1][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrhov2=(MW[M2][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrhov3=(MW[M3][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrwkb =(MW[M4][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrwkp =(MW[M5][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrpnrb=(MW[M6][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrpnrp=(MW[M7][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrknrb=(MW[M8][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrknrp=(MW[M9][J]/(MW[M1][J]+MW[M2][J]+MW[M3][J]+MW[M4][J]+MW[M5][J]+MW[M6][J]+MW[M7][J]+MW[M8][J]+MW[M9][J]))
   shrtot=shrda+shrhov2+shrhov3+shrwkb+shrwkp+shrpnrb+shrpnrp+shrknrb+shrknrp
   print list='\n\nTrips by mode:                          Trips      Share',printo=1
   print list='    Drive Alone                    ',MW[M1][J](10.2),'    ',shrda(7.4),printo=1
   print list='    HOV2                           ',MW[M2][J](10.2),'    ',shrhov2(7.4),printo=1
   print list='    HOV3                           ',MW[M3][J](10.2),'    ',shrhov3(7.4),printo=1
   print list='    Walk Bus                       ',MW[M4][J](10.2),'    ',shrwkb(7.4),printo=1
   print list='    Walk Prj                       ',MW[M5][J](10.2),'    ',shrwkp(7.4),printo=1
   print list='    PNR Bus                        ',MW[M6][J](10.2),'    ',shrpnrb(7.4),printo=1
   print list='    PNR Prj                        ',MW[M7][J](10.2),'    ',shrpnrp(7.4),printo=1
   print list='    KNR Bus                        ',MW[M8][J](10.2),'    ',shrknrb(7.4),printo=1
   print list='    KNR Prj                        ',MW[M9][J](10.2),'    ',shrknrp(7.4),printo=1
   print list='\n\n\nOutput shares by XCHOICE:                             ', printo=1
   print list='   Top Nest:                                         ', printo=1
   print list='        Auto Share               ',(shrda+shrhov2+shrhov3)(7.4), printo=1
   print list='        Transit Share            ',(shrwkb+shrwkp+shrpnrb+shrpnrp+shrknrb+shrknrp)(7.4), printo=1
   print list='\n\n   Auto Nest:                                    ', printo=1
   print list='        Drive Alone Share        ',(shrda/(shrda+shrhov2+shrhov3))(7.4), printo=1
   print list='        Shared Ride Share        ',((shrhov2+shrhov3)/(shrda+shrhov2+shrhov3))(7.4), printo=1
   print list='\n\n   Shared Ride Nest:                             ', printo=1
   print list='        HOV2 Share               ',(shrhov2/(shrhov2+shrhov3))(7.4), printo=1
   print list='        HOV3 Share               ',(shrhov3/(shrhov2+shrhov3))(7.4), printo=1
   print list='\n\n   Transit Nest:                                 ', printo=1
   print list='        Walk Transit Share       ',((shrwkb+shrwkp)/(shrwkb+shrwkp+shrpnrb+shrpnrp+shrknrb+shrknrp))(7.4), printo=1
   print list='        PNR Transit Share        ',((shrpnrb+shrpnrp)/(shrwkb+shrwkp+shrpnrb+shrpnrp+shrknrb+shrknrp))(7.4), printo=1
   print list='        KNR Transit Share        ',((shrknrb+shrpnrp)/(shrwkb+shrwkp+shrpnrb+shrpnrp+shrknrb+shrknrp))(7.4), printo=1
   print list='\n\n   Walk Nest:                                 ', printo=1
   print list='        Walk Bus Share           ',(shrwkb/(shrwkb+shrwkp))(7.4), printo=1
   print list='        Walk Prj Share           ',(shrwkp/(shrwkb+shrwkp))(7.4), printo=1
   print list='\n\n   PNR Nest:                                 ', printo=1
   print list='        PNR Bus Share            ',(shrpnrb/(shrpnrb+shrpnrp))(7.4), printo=1
   print list='        PNR Prj Share            ',(shrpnrp/(shrpnrb+shrpnrp))(7.4), printo=1
   print list='\n\n   KNR Nest:                                 ', printo=1
   print list='        KNR Bus Share            ',(shrknrb/(shrknrb+shrknrp))(7.4), printo=1
   print list='        KNR Prj Share            ',(shrknrp/(shrknrb+shrknrp))(7.4), printo=1
   print list='\n\n',printo=1

   IF (MARKET=3)
    print list='\n\n\n','END TRACE @PURP@-@PERIOD@','\n',printo=1
    print list='========================================================================================',printo=1
   ENDIF

  ELSE
   print list='No demand (input trips) for this access type and market segment............... ',printo=1
   print list='\n\n',printo=1

  ENDIF

  ENDIF
  ENDJLOOP
 ENDIF

ENDLOOP ; end market loop created for reporting purposes

ENDLOOP ; end access loop
; *************************** END XCHOICE ****************************************************

LOOP MARKET=1,3
 LOOP CHOICE=1,9
  _idx1 = 10*(MARKET-1)+(140 + CHOICE)
  _idx2 = (400 + 10*(MARKET-1) + CHOICE)
  _idx3 = (_idx2 + 30)
  _idx4 = (_idx2 + 60)
  COMP total = ROWADD(_idx1,_idx1,_idx2,_idx3,_idx4)     ; refer to xchoice.prn for MW listing
 ENDLOOP
ENDLOOP

 ; Total person trips for each market segment
 COMP total = ROWADD(251,141,142,143,144,145,146,147,148,149)    ; Person trips Market Segment 1
 COMP total = ROWADD(252,151,152,153,154,165,156,157,158,159)    ; Person trips Market Segment 2
 COMP total = ROWADD(253,161,162,163,164,165,166,167,168,169)    ; Person trips Market Segment 3

; ********************************* BEGIN USER BENEFIT AND MODE CHOICE SUMMARY ********************************************
LOOP MARKET=1,3                    ; SUMMIT is done for each market segment separately

 if (MARKET=1) MARKET_NAME='Zero Car HHs       '
 if (MARKET=2) MARKET_NAME='One Car HHs        '
 if (MARKET=3) MARKET_NAME='Two+ Car HHs       '

 _idx1 = (140 + 10*(MARKET-1))
 _idx2 = 10*(MARKET-1)

 JLOOP
  _tripsDA[MARKET] = _tripsDA[MARKET] + MW[_idx1+1]
  _tripsHOV2[MARKET] = _tripsHOV2[MARKET] + MW[_idx1+2]
  _tripsHOV3[MARKET] = _tripsHOV3[MARKET] + MW[_idx1+3]
  _tripsWalkBus[MARKET] = _tripsWalkBus[MARKET] + MW[_idx1+4]
  _tripsWalkPrj[MARKET] = _tripsWalkPrj[MARKET] + MW[_idx1+5]
  _tripsPNRBus[MARKET] = _tripsPNRBus[MARKET] + MW[_idx1+6]
  _tripsPNRPrj[MARKET] = _tripsPNRPrj[MARKET] + MW[_idx1+7]
  _tripsKNRBus[MARKET] = _tripsKNRBus[MARKET] + MW[_idx1+8]
  _tripsKNRPrj[MARKET] = _tripsKNRPrj[MARKET] + MW[_idx1+9]

  ; For reporting access categories
  _cw[1] = _cw[1] + MW[401+_idx2]
  _cw[2] = _cw[2] + MW[402+_idx2]
  _cw[3] = _cw[3] + MW[403+_idx2]
  _cw[4] = _cw[1] + _cw[2] + _cw[3]
  _cw[5] = _cw[5] + MW[404+_idx2]
  _cw[6] = _cw[6] + MW[405+_idx2]
  _cw[7] = _cw[7] + MW[406+_idx2]
  _cw[8] = _cw[8] + MW[407+_idx2]
  _cw[9] = _cw[9] + MW[408+_idx2]
  _cw[10]= _cw[10]+ MW[409+_idx2]
  _cw[11]= _cw[5] + _cw[6] + _cw[7] + _cw[8] + _cw[9] + _cw[10]
  _cw[12]= _cw[4]+ _cw[11]
  _md[1] = _md[1] + MW[431+_idx2]
  _md[2] = _md[2] + MW[432+_idx2]
  _md[3] = _md[3] + MW[433+_idx2]
  _md[4] = _md[1] + _md[2] + _md[3]
  _md[5] = _md[5] + MW[434+_idx2]
  _md[6] = _md[6] + MW[435+_idx2]
  _md[7] = _md[7] + MW[436+_idx2]
  _md[8] = _md[8] + MW[437+_idx2]
  _md[9] = _md[9] + MW[438+_idx2]
  _md[10]= _md[10]+ MW[439+_idx2]
  _md[11]= _md[5] + _md[6] + _md[7] + _md[8] + _md[9] + _md[10]
  _md[12]= _md[4]+ _md[11]
  _na[1] = _na[1] + MW[461+_idx2]
  _na[2] = _na[2] + MW[462+_idx2]
  _na[3] = _na[3] + MW[463+_idx2]
  _na[4] = _na[1] + _na[2] + _na[3]
  _na[5] = _na[5] + MW[464+_idx2]
  _na[6] = _na[6] + MW[465+_idx2]
  _na[7] = _na[7] + MW[466+_idx2]
  _na[8] = _na[8] + MW[467+_idx2]
  _na[9] = _na[9] + MW[468+_idx2]
  _na[10]= _na[10]+ MW[469+_idx2]
  _na[11]= _na[5] + _na[6] + _na[7] + _na[8] + _na[9] + _na[10]
  _na[12]= _na[4]+ _na[11]
  _totacc[1] = _cw[1] + _md[1] + _na[1]
  _totacc[2] = _cw[2] + _md[2] + _na[2]
  _totacc[3] = _cw[3] + _md[3] + _na[3]
  _totacc[4] = _cw[4] + _md[4] + _na[4]
  _totacc[5] = _cw[5] + _md[5] + _na[5]
  _totacc[6] = _cw[6] + _md[6] + _na[6]
  _totacc[7] = _cw[7] + _md[7] + _na[7]
  _totacc[8] = _cw[8] + _md[8] + _na[8]
  _totacc[9] = _cw[9] + _md[9] + _na[9]
  _totacc[10] = _cw[10] + _md[10] + _na[10]
  _totacc[11] = _cw[11] + _md[11] + _na[11]
  _totacc[12] = _cw[12] + _md[12] + _na[12]

  ; For reporting prods/attrs
  if (ZI.1.CBD_DUMMY[i]==1)
    _cbdp[1] = _cbdp[1] + MW[_idx1+1]
    _cbdp[2] = _cbdp[2] + MW[_idx1+2]
    _cbdp[3] = _cbdp[3] + MW[_idx1+3]
    _cbdp[4] = _cbdp[1] + _cbdp[2] + _cbdp[3]
    _cbdp[5] = _cbdp[5] + MW[_idx1+4]
    _cbdp[6] = _cbdp[6] + MW[_idx1+5]
    _cbdp[7] = _cbdp[7] + MW[_idx1+6]
    _cbdp[8] = _cbdp[8] + MW[_idx1+7]
    _cbdp[9] = _cbdp[9] + MW[_idx1+8]
    _cbdp[10]= _cbdp[10]+ MW[_idx1+9]
    _cbdp[11]= _cbdp[5] + _cbdp[6] + _cbdp[7] + _cbdp[8] + _cbdp[9]
    _cbdp[12]= _cbdp[4] + _cbdp[11]
  elseif (ZI.1.EXU_DUMMY[i]==1)
    _exup[1] = _exup[1] + MW[_idx1+1]
    _exup[2] = _exup[2] + MW[_idx1+2]
    _exup[3] = _exup[3] + MW[_idx1+3]
    _exup[4] = _exup[1] + _exup[2] + _exup[3]
    _exup[5] = _exup[5] + MW[_idx1+4]
    _exup[6] = _exup[6] + MW[_idx1+5]
    _exup[7] = _exup[7] + MW[_idx1+6]
    _exup[8] = _exup[8] + MW[_idx1+7]
    _exup[9] = _exup[9] + MW[_idx1+8]
    _exup[10]= _exup[10]+ MW[_idx1+9]
    _exup[11]= _exup[5] + _exup[6] + _exup[7] + _exup[8] + _exup[9]
    _exup[12]= _exup[4] + _exup[11]
  else
    _othp[1] = _othp[1] + MW[_idx1+1]
    _othp[2] = _othp[2] + MW[_idx1+2]
    _othp[3] = _othp[3] + MW[_idx1+3]
    _othp[4] = _othp[1] + _othp[2] + _othp[3]
    _othp[5] = _othp[5] + MW[_idx1+4]
    _othp[6] = _othp[6] + MW[_idx1+5]
    _othp[7] = _othp[7] + MW[_idx1+6]
    _othp[8] = _othp[8] + MW[_idx1+7]
    _othp[9] = _othp[9] + MW[_idx1+8]
    _othp[10]= _othp[10]+ MW[_idx1+9]
    _othp[11]= _othp[5] + _othp[6] + _othp[7] + _othp[8] + _othp[9]
    _othp[12]= _othp[4] + _othp[11]
  endif
  if (ZI.1.CBD_DUMMY[j]==1)
    _cbda[1] = _cbda[1] + MW[_idx1+1]
    _cbda[2] = _cbda[2] + MW[_idx1+2]
    _cbda[3] = _cbda[3] + MW[_idx1+3]
    _cbda[4] = _cbda[1] + _cbda[2] + _cbda[3]
    _cbda[5] = _cbda[5] + MW[_idx1+4]
    _cbda[6] = _cbda[6] + MW[_idx1+5]
    _cbda[7] = _cbda[7] + MW[_idx1+6]
    _cbda[8] = _cbda[8] + MW[_idx1+7]
    _cbda[9] = _cbda[9] + MW[_idx1+8]
    _cbda[10]= _cbda[10]+ MW[_idx1+9]
    _cbda[11]= _cbda[5] + _cbda[6] + _cbda[7] + _cbda[8] + _cbda[9]
    _cbda[12]= _cbda[4] + _cbda[11]
  elseif (ZI.1.EXU_DUMMY[j]==1)
    _exua[1] = _exua[1] + MW[_idx1+1]
    _exua[2] = _exua[2] + MW[_idx1+2]
    _exua[3] = _exua[3] + MW[_idx1+3]
    _exua[4] = _exua[1] + _exua[2] + _exua[3]
    _exua[5] = _exua[5] + MW[_idx1+4]
    _exua[6] = _exua[6] + MW[_idx1+5]
    _exua[7] = _exua[7] + MW[_idx1+6]
    _exua[8] = _exua[8] + MW[_idx1+7]
    _exua[9] = _exua[9] + MW[_idx1+8]
    _exua[10]= _exua[10]+ MW[_idx1+9]
    _exua[11]= _exua[5] + _exua[6] + _exua[7] + _exua[8] + _exua[9]
    _exua[12]= _exua[4] + _exua[11]
  else
    _otha[1] = _otha[1] + MW[_idx1+1]
    _otha[2] = _otha[2] + MW[_idx1+2]
    _otha[3] = _otha[3] + MW[_idx1+3]
    _otha[4] = _otha[1] + _otha[2] + _otha[3]
    _otha[5] = _otha[5] + MW[_idx1+4]
    _otha[6] = _otha[6] + MW[_idx1+5]
    _otha[7] = _otha[7] + MW[_idx1+6]
    _otha[8] = _otha[8] + MW[_idx1+7]
    _otha[9] = _otha[9] + MW[_idx1+8]
    _otha[10]= _otha[10]+ MW[_idx1+9]
    _otha[11]= _otha[5] + _otha[6] + _otha[7] + _otha[8] + _otha[9]
    _otha[12]= _otha[4] + _otha[11]
  endif

  ; For reporting fare revenue
  _frev[1] = _frev[1] + ((MI.11.FareWB * MW[_idx1+4]) / 100.0)
  _frev[2] = _frev[2] + ((MI.11.FareWP * MW[_idx1+5]) / 100.0)
  _frev[3] = _frev[3] + ((MI.11.FareAB * MW[_idx1+6]) / 100.0)
  _frev[4] = _frev[4] + ((MI.11.FareAP * MW[_idx1+7]) / 100.0)
  _frev[5] = _frev[5] + ((MI.11.FareAB * MW[_idx1+8]) / 100.0)
  _frev[6] = _frev[6] + ((MI.11.FareAP * MW[_idx1+9]) / 100.0)
  _frev[7] = _frev[1] + _frev[2] + _frev[3] + _frev[4] + _frev[5] + _frev[6]
  _avef[1] = 0
  if (_totacc[5]>0) _avef[1] = _frev[1] / _totacc[5]
    _avef[2] = 0
  if (_totacc[6]>0) _avef[2] = _frev[2] / _totacc[6]
    _avef[3] = 0
  if (_totacc[7]>0) _avef[3] = _frev[3] / _totacc[7]
    _avef[4] = 0
  if (_totacc[8]>0) _avef[4] = _frev[4] / _totacc[8]
    _avef[5] = 0
  if (_totacc[9]>0) _avef[5] = _frev[5] / _totacc[9]
    _avef[6] = 0
  if (_totacc[10]>0) _avef[6] = _frev[6] / _totacc[10]
    _avef[7] = 0
  if (_totacc[11]>0) _avef[7] = _frev[7] / _totacc[11]

  ; For reporting transfers
  if (MW[105]==0)
    _xfer0[1] = _xfer0[1] + MW[_idx1+4]
  elseif (MW[105]==1)
    _xfer1[1] = _xfer1[1] + MW[_idx1+4]
  elseif (MW[105]==2)
    _xfer2[1] = _xfer2[1] + MW[_idx1+4]
  else
    _xfer3[1] = _xfer3[1] + MW[_idx1+4]
  endif
  if (MW[106]==0)
    _xfer0[2] = _xfer0[2] + MW[_idx1+5]
  elseif (MW[106]==1)
    _xfer1[2] = _xfer1[2] + MW[_idx1+5]
  elseif (MW[106]==2)
    _xfer2[2] = _xfer2[2] + MW[_idx1+5]
  else
    _xfer3[2] = _xfer3[2] + MW[_idx1+5]
  endif
  if (MW[107]==0)
    _xfer0[3] = _xfer0[3] + MW[_idx1+6]
    _xfer0[5] = _xfer0[5] + MW[_idx1+8]
  elseif (MW[107]==1)
    _xfer1[3] = _xfer1[3] + MW[_idx1+6]
    _xfer1[5] = _xfer1[5] + MW[_idx1+8]
  elseif (MW[107]==2)
    _xfer2[3] = _xfer2[3] + MW[_idx1+6]
    _xfer2[5] = _xfer2[5] + MW[_idx1+8]
  else
    _xfer3[3] = _xfer3[3] + MW[_idx1+6]
    _xfer3[5] = _xfer3[5] + MW[_idx1+8]
  endif
  if (MW[108]==0)
    _xfer0[4] = _xfer0[4] + MW[_idx1+7]
    _xfer0[6] = _xfer0[6] + MW[_idx1+9]
  elseif (MW[108]==1)
    _xfer1[4] = _xfer1[4] + MW[_idx1+7]
    _xfer1[6] = _xfer1[6] + MW[_idx1+9]
  elseif (MW[108]==2)
    _xfer2[4] = _xfer2[4] + MW[_idx1+7]
    _xfer2[6] = _xfer2[6] + MW[_idx1+9]
  else
    _xfer3[4] = _xfer3[4] + MW[_idx1+7]
    _xfer3[6] = _xfer3[6] + MW[_idx1+9]
  endif
  _xfer0[7] = _xfer0[1] + _xfer0[2] + _xfer0[3] + _xfer0[4] + _xfer0[5] + _xfer0[6]
  _xfer1[7] = _xfer1[1] + _xfer1[2] + _xfer1[3] + _xfer1[4] + _xfer1[5] + _xfer1[6]
  _xfer2[7] = _xfer2[1] + _xfer2[2] + _xfer2[3] + _xfer2[4] + _xfer2[5] + _xfer2[6]
  _xfer3[7] = _xfer3[1] + _xfer3[2] + _xfer3[3] + _xfer3[4] + _xfer3[5] + _xfer3[6]

  ; User benefit calculations are done for each market segment
  ; Determine can walk & must drive percentages for matrix for Summit for each market segment (1 for auto0, 2 for auto1 and 3 for auto2)
  ; person trips
  IF ({RunUB}==1)

  T1=201+_idx2, T2=202+_idx2, T3=203+_idx2, T4=204+_idx2, T5=205+_idx2, T6=206+_idx2, T7=207+_idx2

  if (MW[250+MARKET]>0)
    MW[T1] = MW[250+MARKET]                                                                     ; person trips in market segment
    MW[T2] = MW[T1]                                                                             ; motorized trips in market segment
    MW[T3] = EXP(NC_AUTOSR * MW[500+MARKET])                                                    ; expotentied auto utility
    MW[254] = MW[401+_idx2] + MW[402+_idx2] + MW[403+_idx2] + MW[404+_idx2] + MW[405+_idx2] +
              MW[406+_idx2] + MW[407+_idx2] + MW[408+_idx2] + MW[409+_idx2]                     ; total trips that can walk in MS
    MW[255] = MW[404+_idx2] + MW[405+_idx2] + MW[406+_idx2] + MW[407+_idx2] + MW[408+_idx2] +
              MW[409+_idx2]                                                                     ; transit trips that can walk in MS
    MW[T4] = MW[254] / MW[T1]                                                                   ; fraction of person trips that can walk
    if (MW[254]>0)
        MW[T5] = MW[255] / MW[254]
    else
        MW[T5] = 0.00                                                                           ; transit share of trips that can walk
    endif

    MW[256] = MW[431+_idx2] + MW[432+_idx2] + MW[433+_idx2] + MW[434+_idx2] + MW[435+_idx2] +
              MW[436+_idx2] + MW[437+_idx2] + MW[438+_idx2] + MW[439+_idx2]                     ; total trips that must drive in MS
    MW[257] = MW[434+_idx2] + MW[435+_idx2] + MW[436+_idx2] + MW[437+_idx2] + MW[438+_idx2] +
              MW[439+_idx2]                                                                     ; transit trips that must drive in MS
    MW[T6] = MW[256] / MW[T1]                                                                   ; fraction of person trips that must drive
    if (MW[256]>0)
        MW[T7] = MW[257] / MW[256]                                                              ; transit share of trips that must drive
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

  if (I={SelOrigin} && J={SelDest})
    print list="*UB Rec* ",i(5.0),j(5.0),MARKET(5.0),mw[T1](10.1),mw[T2](10.1),mw[T3](10.7),mw[T4](10.5),mw[T5](10.5),mw[T6](10.5),mw[T7](10.5)
  endif

  ENDIF

  ; MODE CHOICE SUMMARY
  IF (i=_zones & j=_zones)

   _SUMtrips[MARKET] = _tripsDA[MARKET] + _tripsHOV2[MARKET] + _tripsHOV3[MARKET] + _tripsWalkBus[MARKET] + _tripsWalkPrj[MARKET] + _tripsPNRBus[MARKET] + _tripsPNRPrj[MARKET] + _tripsKNRBus[MARKET] + _tripsKNRPrj[MARKET]
   ; Total trips by purpose
   if (_SUMtrips[MARKET]=0) _SUMtrips[MARKET]=1

   if (MARKET==1)
     PRINT FORM=8.OC, LIST='\n\n\n@PURP@ - @PERIOD@ MODE XCHOICE RESULTS',
     '\n**************************************************************',
     '\n','                 ','     Total','     Drive','       One','      Two+','     Total','      Walk','      Walk','       PNR','       PNR','       KNR','       KNR','     Total',
     '\n','MARKET SEGMENT   ','    Person','     Alone','       Pax','       Pax','      Auto','       Bus','   Project','       Bus','   Project','       Bus','   Project','   Transit',
     '\n','--------------   ','   -------','    ------','    ------','    ------','    ------','    ------','   -------','    ------','   -------','    ------','   -------','   -------',PRINTO=2
   endif

   _aocp = _aocp + (_tripsDA[MARKET]+_tripsHOV2[MARKET]+_tripsHOV3[MARKET])
   _aocv = _aocv + (_tripsDA[MARKET]+_tripsHOV2[MARKET]/2.0+_tripsHOV3[MARKET]/@OCC3@)

   _temp = (_SUMtrips[MARKET]-(_tripsHOV3[MARKET]+_tripsDA[MARKET]+_tripsHOV2[MARKET]))
   PRINT LIST='\n',MARKET_NAME(17),_SUMtrips[MARKET](10.1),
                   _tripsDA[MARKET](10.1),_tripsHOV2[MARKET](10.1),_tripsHOV3[MARKET](10.1),_tripsDA[MARKET]+_tripsHOV2[MARKET]+_tripsHOV3[MARKET](10.1),
                   _tripsWalkBus[MARKET](10.1),_tripsWalkPrj[MARKET](10.1),
                   _tripsPNRBus[MARKET](10.1),_tripsPNRPrj[MARKET](10.1),
                   _tripsKNRBus[MARKET](10.1),_tripsKNRPrj[MARKET](10.1),
                   _temp(10.1),PRINTO=2

   if (MARKET==3)
     PRINT LIST =  '\n\n',
                   'TOTAL            ',_totacc[12](10.1),_totacc[1](10.1),_totacc[2](10.1),_totacc[3](10.1),_totacc[4](10.1),_totacc[5](10.1),_totacc[6](10.1),
                   _totacc[7](10.1),_totacc[8](10.1),_totacc[9](10.1),_totacc[10](10.1),_totacc[11](10.1),
                   '\n\n',
                   'Can Walk         ',_cw[12](10.1),_cw[1](10.1),_cw[2](10.1),_cw[3](10.1),_cw[4](10.1),_cw[5](10.1),_cw[6](10.1),
                   _cw[7](10.1),_cw[8](10.1),_cw[9](10.1),_cw[10](10.1),_cw[11](10.1),'\n',
                   'Must Drive       ',_md[12](10.1),_md[1](10.1),_md[2](10.1),_md[3](10.1),_md[4](10.1),_md[5](10.1),_md[6](10.1),
                   _md[7](10.1),_md[8](10.1),_md[9](10.1),_md[10](10.1),_md[11](10.1),'\n',
                   'No Access        ',_na[12](10.1),_na[1](10.1),_na[2](10.1),_na[3](10.1),_na[4](10.1),_na[5](10.1),_na[6](10.1),
                   _na[7](10.1),_na[8](10.1),_na[9](10.1),_na[10](10.1),_na[11](10.1),'\n\n',
                   'TOTAL            ',_totacc[12](10.1),_totacc[1](10.1),_totacc[2](10.1),_totacc[3](10.1),_totacc[4](10.1),_totacc[5](10.1),_totacc[6](10.1),
                   _totacc[7](10.1),_totacc[8](10.1),_totacc[9](10.1),_totacc[10](10.1),_totacc[11](10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Productions:     ','\n',
                   'CBD              ',_cbdp[12](10.1),_cbdp[1](10.1),_cbdp[2](10.1),_cbdp[3](10.1),_cbdp[4](10.1),_cbdp[5](10.1),_cbdp[6](10.1),
                   _cbdp[7](10.1),_cbdp[8](10.1),_cbdp[9](10.1),_cbdp[10](10.1),_cbdp[11](10.1),'\n',
                   'Exurban          ',_exup[12](10.1),_exup[1](10.1),_exup[2](10.1),_exup[3](10.1),_exup[4](10.1),_exup[5](10.1),_exup[6](10.1),
                   _exup[7](10.1),_exup[8](10.1),_exup[9](10.1),_exup[10](10.1),_exup[11](10.1),'\n',
                   'Other            ',_othp[12](10.1),_othp[1](10.1),_othp[2](10.1),_othp[3](10.1),_othp[4](10.1),_othp[5](10.1),_othp[6](10.1),
                   _othp[7](10.1),_othp[8](10.1),_othp[9](10.1),_othp[10](10.1),_othp[11](10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Attractions:     ','\n',
                   'CBD              ',_cbda[12](10.1),_cbda[1](10.1),_cbda[2](10.1),_cbda[3](10.1),_cbda[4](10.1),_cbda[5](10.1),_cbda[6](10.1),
                   _cbda[7](10.1),_cbda[8](10.1),_cbda[9](10.1),_cbda[10](10.1),_cbda[11](10.1),'\n',
                   'Exurban          ',_exua[12](10.1),_exua[1](10.1),_exua[2](10.1),_exua[3](10.1),_exua[4](10.1),_exua[5](10.1),_exua[6](10.1),
                   _exua[7](10.1),_exua[8](10.1),_exua[9](10.1),_exua[10](10.1),_exua[11](10.1),'\n',
                   'Other            ',_otha[12](10.1),_otha[1](10.1),_otha[2](10.1),_otha[3](10.1),_otha[4](10.1),_otha[5](10.1),_otha[6](10.1),
                   _otha[7](10.1),_otha[8](10.1),_otha[9](10.1),_otha[10](10.1),_otha[11](10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Fare Revenue ($) '," "(50),_frev[1](10.2),_frev[2](10.2),_frev[3](10.2),_frev[4](10.2),_frev[5](10.2),
                                               _frev[6](10.2),_frev[7](10.2)," "(10),'\n',
                   'Average Fare ($) '," "(50),_avef[1](10.2),_avef[2](10.2),_avef[3](10.2),_avef[4](10.2),_avef[5](10.2),
                                               _avef[6](10.2),_avef[7](10.2)," "(10),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Transfers:       ','\n',
                   'NONE             '," "(50),_xfer0[1](10.1),_xfer0[2](10.1),_xfer0[3](10.1),_xfer0[4](10.1),_xfer0[5](10.1),
                                               _xfer0[6](10.1),_xfer0[7](10.1)," "(10),'\n',
                   'ONE              '," "(50),_xfer1[1](10.1),_xfer1[2](10.1),_xfer1[3](10.1),_xfer1[4](10.1),_xfer1[5](10.1),
                                               _xfer1[6](10.1),_xfer1[7](10.1)," "(10),'\n',
                   'TWO              '," "(50),_xfer2[1](10.1),_xfer2[2](10.1),_xfer2[3](10.1),_xfer2[4](10.1),_xfer2[5](10.1),
                                               _xfer2[6](10.1),_xfer2[7](10.1)," "(10),'\n',
                   'THREE +          '," "(50),_xfer3[1](10.1),_xfer3[2](10.1),_xfer3[3](10.1),_xfer3[4](10.1),_xfer3[5](10.1),
                                               _xfer3[6](10.1),_xfer3[7](10.1)," "(10),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Average Auto Occupancy      =',_aocp/_aocv(8.3),
                   '\n\n**************************************************************',PRINTO=2
   endif

   ; OUTPUT MODEL SHARES TO A CSV FILE FOR CALIBRATION
   if ({MC_Calib}>0)
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+1),@PURPOSE@,MARKET,_tripsDA[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+2),@PURPOSE@,MARKET,_tripsHOV2[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+3),@PURPOSE@,MARKET,_tripsHOV3[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+4),@PURPOSE@,MARKET,_tripsWalkBus[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+5),@PURPOSE@,MARKET,_tripsWalkPrj[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+6),@PURPOSE@,MARKET,_tripsPNRBus[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+7),@PURPOSE@,MARKET,_tripsPNRPrj[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+8),@PURPOSE@,MARKET,_tripsKNRBus[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
    PRINT CSV=T, LIST= (27*(@PURPNO@-2)+9*(MARKET-1)+9),@PURPOSE@,MARKET,_tripsKNRPrj[MARKET]/_SUMtrips[MARKET](12.5), PRINTO=3
   endif

  ENDIF

 ENDJLOOP

ENDLOOP
; ********************************* END USER BENEFIT AND MODE CHOICE SUMMARY ********************************************

ENDRUN
