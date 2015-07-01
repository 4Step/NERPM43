; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00Asb.PRN" MSG='Mode Choice Reporting'
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_0CARsb.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_1CARsb.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\@PURP@Trip_CW_2CARsb.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_0CARsb.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_1CARsb.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\@PURP@Trip_MD_2CARsb.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_0CARsb.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_1CARsb.MAT"
FILEI MATI[9] = "{SCENARIO_DIR}\output\@PURP@Trip_NT_2CARsb.MAT"
FILEI MATI[10] = "{SCENARIO_DIR}\output\@PURP@Tripsb.MAT"
FILEI MATI[12] = "{SCENARIO_DIR}\output\farexfer_tmpsb.mat"
FILEI MATI[13] = "{SCENARIO_DIR}\output\ST2ST_{alt}{year}.MAT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"

FILEO PRINTO[4] = "{SCENARIO_DIR}\output\CBDSHARESsb.CSV",
append=t
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\MODESHARESsb.CSV",
append=t
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ModeSumsb.TXT",
append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ModeDebugsb.TXT",
append=t
FILEO MATO[2] = "{SCENARIO_DIR}\output\@PURP@UTIL_{alt}{year}sb.MAT",
MO=401-407,421-427,441-447, DEC=21*D,
NAME=PerTrip1,AutoTrnTrip1,AutoPrice1,WalkFrac1,WalkShare1,DriveFrac1,DriveShare1,
     PerTrip2,AutoTrnTrip2,AutoPrice2,WalkFrac2,WalkShare2,DriveFrac2,DriveShare2,
     PerTrip3,AutoTrnTrip3,AutoPrice3,WalkFrac3,WalkShare3,DriveFrac3,DriveShare3
FILEO MATO[1] = "{SCENARIO_DIR}\output\@PURP@_{alt}{year}sb.MAT",
MO=501-512,DEC=12*D,NAME=DA,SR2,SR3,WALKBUS,WALKPRJ,PNRBUS,PNRPRJ,KNRBUS,KNRPRJ,CBDKNRBUS,CBDKNRPRJ,FRGPNR

zonemsg=100

FILLMW MW[1]  =MI.1.1,2,3,4,5,6,7,8,9,10,11,12     ; can walk 0 car
FILLMW MW[21] =MI.2.1,2,3,4,5,6,7,8,9,10,11,12     ; can walk 1 car
FILLMW MW[41] =MI.3.1,2,3,4,5,6,7,8,9,10,11,12     ; can walk 2 car
FILLMW MW[61] =MI.4.1,2,3,4,5,6,7,8,9,10,11,12     ; must drive 0 car
FILLMW MW[81] =MI.5.1,2,3,4,5,6,7,8,9,10,11,12     ; must drive 1 car
FILLMW MW[101]=MI.6.1,2,3,4,5,6,7,8,9,10,11,12     ; must drive 2 car
FILLMW MW[121]=MI.7.1,2,3,4,5,6,7,8,9,10,11,12     ; no transit 0 car
FILLMW MW[141]=MI.8.1,2,3,4,5,6,7,8,9,10,11,12     ; no transit 1 car
FILLMW MW[161]=MI.9.1,2,3,4,5,6,7,8,9,10,11,12     ; no transit 2 car
FILLMW MW[201]=MI.10.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36   ; 0 car, 1 car, 2 car households
FILLMW MW[251]=MI.11.1,2,3
FILLMW MW[261]=MI.12.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18   ; fare and xfer matrix for the nine paths
FILLMW MW[281]=MI.13.@STATION_TABLE@         ; 2 tables - knr zone for knr-bus path and knr-prj paths

array _tripsDA=3, _tripsHOV2=3, _tripsHOV3=3, _tripsWalkbus=3, _tripsWalkprj=3, _tripsPNRbus=3,
      _tripsPNRprj=3, _tripsKNRbus=3, _tripsKNRprj=3, _tripsFrgPNR=3, _tripsFrgKNR=3, _tripsCBDKNRBus=3, _tripsCBDKNRPrj=3, _SUMtrips=3,
      CBDA=4,TOTACC=4

if (i=FirstZone)
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
    _tripsCBDKNRBus[xx]=0
    _tripsCBDKNRPrj[xx]=0
    _tripsFrgPNR[xx]=0
    _SUMtrips[xx]=0
  endloop
endif

 ; Total person trips for each market segment
 COMP total = ROWADD(301,201,202,203,204,205,206,207,208,209,210,211,212)    ; Person trips Market Segment 1
 COMP total = ROWADD(302,213,214,215,216,217,218,219,220,221,222,223,224)    ; Person trips Market Segment 2
 COMP total = ROWADD(303,225,226,227,228,229,230,231,232,233,234,235,236)    ; Person trips Market Segment 3

 ; Person trip for assignment
 COMP total = ROWADD(501,1,21,41,61,81,101,121,141,161)              ; DA Person trips
 COMP total = ROWADD(502,2,22,42,62,82,102,122,142,162)              ; HOV2 Person trips
 COMP total = ROWADD(503,3,23,43,63,83,103,123,143,163)              ; HOV3 Person trips
 COMP total = ROWADD(504,4,24,44,64,84,104,124,144,164)              ; walk-bus Person trips
 COMP total = ROWADD(505,5,25,45,65,85,105,125,145,165)              ; walk-prj Person trips
 COMP total = ROWADD(506,6,26,46,66,86,106,126,146,166)              ; pnr-bus Person trips
 COMP total = ROWADD(507,7,27,47,67,87,107,127,147,167)              ; pnr-prj Person trips
 COMP total = ROWADD(508,8,28,48,68,88,108,128,148,168)              ; knr-bus Person trips
 COMP total = ROWADD(509,9,29,49,69,89,109,129,149,169)              ; knr-prj Person trips
 COMP total = ROWADD(510,10,30,50,70,90,110,130,150,170)             ; cbdknr-prj Person trips
 COMP total = ROWADD(511,11,31,51,71,91,111,131,151,171)             ; cbdknr-prj Person trips
 COMP total = ROWADD(512,12,32,52,72,92,112,132,152,172)             ; fringe pnr Person trips

; ********************************* BEGIN USER BENEFIT AND MODE CHOICE SUMMARY ********************************************
LOOP MARKET=1,3                    ; SUMMIT is done for each market segment separately

 if (MARKET=1) MARKET_NAME='Zero Car HHs       '
 if (MARKET=2) MARKET_NAME='One Car HHs        '
 if (MARKET=3) MARKET_NAME='Two+ Car HHs       '

 _idx1 = (200 + 12*(MARKET-1))
 _idx2 = 20*(MARKET-1)

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
  _tripsCBDKNRBus[MARKET] = _tripsCBDKNRBus[MARKET] + MW[_idx1+10]
  _tripsCBDKNRPrj[MARKET] = _tripsCBDKNRPrj[MARKET] + MW[_idx1+11]
  _tripsFrgPNR[MARKET] = _tripsFrgPNR[MARKET] + MW[_idx1+12]

  ; For reporting access categories
  _cw1 = _cw1 + MW[_idx2+1]     ;da
  _cw2 = _cw2 + MW[_idx2+2]     ;hov2
  _cw3 = _cw3 + MW[_idx2+3]     ;hov3
  _cw4 = _cw1 + _cw2 + _cw3                          ;auto
  _cw5 = _cw5 + MW[_idx2+4]
  _cw6 = _cw6 + MW[_idx2+5]
  _cw7 = _cw7 + MW[_idx2+6]
  _cw8 = _cw8 + MW[_idx2+7]
  _cw9 = _cw9 + MW[_idx2+8]
  _cw10= _cw10+ MW[_idx2+9]
  _cw11= _cw11+ MW[_idx2+10]
  _cw12= _cw12+ MW[_idx2+11]
  _cw13= _cw5 + _cw6 + _cw7 + _cw8 + _cw9 + _cw10 + _cw11 + _cw12    ;transit
  _cw14= _cw14+ MW[_idx2+12]             ; fringe
  _cw15= _cw4+ _cw13 + _cw14                         ;total
  _md1 = _md1 + MW[_idx2+61]
  _md2 = _md2 + MW[_idx2+62]
  _md3 = _md3 + MW[_idx2+63]
  _md4 = _md1 + _md2 + _md3
  _md5 = _md5 + MW[_idx2+64]
  _md6 = _md6 + MW[_idx2+65]
  _md7 = _md7 + MW[_idx2+66]
  _md8 = _md8 + MW[_idx2+67]
  _md9 = _md9 + MW[_idx2+68]
  _md10= _md10+ MW[_idx2+69]
  _md11= _md11+ MW[_idx2+70]
  _md12= _md12+ MW[_idx2+71]
  _md13= _md5 + _md6 + _md7 + _md8 + _md9 + _md10 + _md11 + _md12
  _md14= _md14+ MW[_idx2+72]
  _md15= _md4+ _md13 + _md14
  _na1 = _na1 + MW[_idx2+121]
  _na2 = _na2 + MW[_idx2+122]
  _na3 = _na3 + MW[_idx2+123]
  _na4 = _na1 + _na2 + _na3
  _na5 = _na5 + MW[_idx2+124]
  _na6 = _na6 + MW[_idx2+125]
  _na7 = _na7 + MW[_idx2+126]
  _na8 = _na8 + MW[_idx2+127]
  _na9 = _na9 + MW[_idx2+128]
  _na10= _na10+ MW[_idx2+129]
  _na11= _na11+ MW[_idx2+130]
  _na12= _na12+ MW[_idx2+131]
  _na13= _na5 + _na6 + _na7 + _na8 + _na9 + _na10 + _na11 + _na12
  _na14= _na14+ MW[_idx2+132]
  _na15= _na4 + _na13 + _na14
  _totacc1 = _cw1 + _md1 + _na1
  _totacc2 = _cw2 + _md2 + _na2
  _totacc3 = _cw3 + _md3 + _na3
  _totacc4 = _cw4 + _md4 + _na4    ;total auto
  _totacc5 = _cw5 + _md5 + _na5      ;wb
  _totacc6 = _cw6 + _md6 + _na6      ;wp
  _totacc7 = _cw7 + _md7 + _na7      ;pb
  _totacc8 = _cw8 + _md8 + _na8      ;pp
  _totacc9 = _cw9 + _md9 + _na9      ;kb
  _totacc10 = _cw10 + _md10 + _na10  ;kp
  _totacc11 = _cw11 + _md11 + _na11  ;ckb
  _totacc12 = _cw12 + _md12 + _na12  ;ckp
  _totacc13 = _cw13 + _md13 + _na13    ;total transit
  _totacc14 = _cw14 + _md14 + _na14    ;fringe
  _totacc15 = _cw15 + _md15 + _na15    ;total trip

  ; For reporting prods/attrs
  if (ZI.1.CBD_DUMMY[i]==1)
    _cbdp1 = _cbdp1 + MW[_idx1+1]
    _cbdp2 = _cbdp2 + MW[_idx1+2]
    _cbdp3 = _cbdp3 + MW[_idx1+3]
    _cbdp4 = _cbdp1 + _cbdp2 + _cbdp3
    _cbdp5 = _cbdp5 + MW[_idx1+4]
    _cbdp6 = _cbdp6 + MW[_idx1+5]
    _cbdp7 = _cbdp7 + MW[_idx1+6]
    _cbdp8 = _cbdp8 + MW[_idx1+7]
    _cbdp9 = _cbdp9 + MW[_idx1+8]
    _cbdp10= _cbdp10+ MW[_idx1+9]
    _cbdp11= _cbdp11+ MW[_idx1+10]
    _cbdp12= _cbdp12+ MW[_idx1+11]
    _cbdp13= _cbdp5 + _cbdp6 + _cbdp7 + _cbdp8 + _cbdp9 + _cbdp10 + _cbdp11
    _cbdp14= _cbdp14+ MW[_idx1+12]
    _cbdp15= _cbdp4 + _cbdp13 + _cbdp14
  elseif (ZI.1.EXU_DUMMY[i]==1)
    _exup1 = _exup1 + MW[_idx1+1]
    _exup2 = _exup2 + MW[_idx1+2]
    _exup3 = _exup3 + MW[_idx1+3]
    _exup4 = _exup1 + _exup2 + _exup3
    _exup5 = _exup5 + MW[_idx1+4]
    _exup6 = _exup6 + MW[_idx1+5]
    _exup7 = _exup7 + MW[_idx1+6]
    _exup8 = _exup8 + MW[_idx1+7]
    _exup9 = _exup9 + MW[_idx1+8]
    _exup10= _exup10+ MW[_idx1+9]
    _exup11= _exup11+ MW[_idx1+10]
    _exup12= _exup12+ MW[_idx1+11]
    _exup13= _exup5 + _exup6 + _exup7 + _exup8 + _exup9 + _exup10 + _exup11
    _exup14= _exup14+ MW[_idx1+12]
    _exup15= _exup4 + _exup13 + _exup14
  else
    _othp1 = _othp1 + MW[_idx1+1]
    _othp2 = _othp2 + MW[_idx1+2]
    _othp3 = _othp3 + MW[_idx1+3]
    _othp4 = _othp1 + _othp2 + _othp3
    _othp5 = _othp5 + MW[_idx1+4]
    _othp6 = _othp6 + MW[_idx1+5]
    _othp7 = _othp7 + MW[_idx1+6]
    _othp8 = _othp8 + MW[_idx1+7]
    _othp9 = _othp9 + MW[_idx1+8]
    _othp10= _othp10+ MW[_idx1+9]
    _othp11= _othp11+ MW[_idx1+10]
    _othp12= _othp12+ MW[_idx1+11]
    _othp13= _othp5 + _othp6 + _othp7 + _othp8 + _othp9 + _othp10 + _othp11
    _othp14= _othp14+ MW[_idx1+12]
    _othp15= _othp4 + _othp13 + _othp14
  endif
  if (ZI.1.CBD_DUMMY[j]==1)
    _cbda1 = _cbda1 + MW[_idx1+1]
    _cbda2 = _cbda2 + MW[_idx1+2]
    _cbda3 = _cbda3 + MW[_idx1+3]
    _cbda4 = _cbda1 + _cbda2 + _cbda3
    _cbda5 = _cbda5 + MW[_idx1+4]
    _cbda6 = _cbda6 + MW[_idx1+5]
    _cbda7 = _cbda7 + MW[_idx1+6]
    _cbda8 = _cbda8 + MW[_idx1+7]
    _cbda9 = _cbda9 + MW[_idx1+8]
    _cbda10= _cbda10+ MW[_idx1+9]
    _cbda11= _cbda11+ MW[_idx1+10]
    _cbda12= _cbda12+ MW[_idx1+11]
    _cbda13= _cbda5 + _cbda6 + _cbda7 + _cbda8 + _cbda9 + _cbda10 + _cbda11
    _cbda14= _cbda14+ MW[_idx1+12]
    _cbda15= _cbda4 + _cbda13 + _cbda14
  elseif (ZI.1.EXU_DUMMY[j]==1)
    _exua1 = _exua1 + MW[_idx1+1]
    _exua2 = _exua2 + MW[_idx1+2]
    _exua3 = _exua3 + MW[_idx1+3]
    _exua4 = _exua1 + _exua2 + _exua3
    _exua5 = _exua5 + MW[_idx1+4]
    _exua6 = _exua6 + MW[_idx1+5]
    _exua7 = _exua7 + MW[_idx1+6]
    _exua8 = _exua8 + MW[_idx1+7]
    _exua9 = _exua9 + MW[_idx1+8]
    _exua10= _exua10+ MW[_idx1+9]
    _exua11= _exua11+ MW[_idx1+10]
    _exua12= _exua12+ MW[_idx1+11]
    _exua13= _exua5 + _exua6 + _exua7 + _exua8 + _exua9
    _exua14= _exua14+ MW[_idx1+12]
    _exua15= _exua4 + _exua13 + _exua14
  else
    _otha1 = _otha1 + MW[_idx1+1]
    _otha2 = _otha2 + MW[_idx1+2]
    _otha3 = _otha3 + MW[_idx1+3]
    _otha4 = _otha1 + _otha2 + _otha3
    _otha5 = _otha5 + MW[_idx1+4]
    _otha6 = _otha6 + MW[_idx1+5]
    _otha7 = _otha7 + MW[_idx1+6]
    _otha8 = _otha8 + MW[_idx1+7]
    _otha9 = _otha9 + MW[_idx1+8]
    _otha10= _otha10+ MW[_idx1+9]
    _otha11= _otha11+ MW[_idx1+10]
    _otha12= _otha12+ MW[_idx1+11]
    _otha13= _otha5 + _otha6 + _otha7 + _otha8 + _otha9 + _otha10 + _otha11
    _otha14= _otha14+ MW[_idx1+12]
    _otha15= _otha4 + _otha13 + _otha14
  endif
/*
  ; For reporting fare revenue
  _frev1 = _frev1 + ((MI.11.FareWB * MW[_idx1+4]) / 100.0)
  _frev2 = _frev2 + ((MI.11.FareWP * MW[_idx1+5]) / 100.0)
  _frev3 = _frev3 + ((MI.11.FareAB * MW[_idx1+6]) / 100.0)
  _frev4 = _frev4 + ((MI.11.FareAP * MW[_idx1+7]) / 100.0)
  _frev5 = _frev5 + ((MI.11.FareAB * MW[_idx1+8]) / 100.0)
  _frev6 = _frev6 + ((MI.11.FareAP * MW[_idx1+9]) / 100.0)
  _frev7 = _frev1 + _frev2 + _frev3 + _frev4 + _frev5 + _frev6
  _avef1 = 0
  if (_totacc5>0) _avef1 = _frev1 / _totacc5
    _avef2 = 0
  if (_totacc6>0) _avef2 = _frev2 / _totacc6
    _avef3 = 0
  if (_totacc7>0) _avef3 = _frev3 / _totacc7
    _avef4 = 0
  if (_totacc8>0) _avef4 = _frev4 / _totacc8
    _avef5 = 0
  if (_totacc9>0) _avef5 = _frev5 / _totacc9
    _avef6 = 0
  if (_totacc10>0) _avef6 = _frev6 / _totacc10
    _avef7 = 0
  if (_totacc11>0) _avef7 = _frev7 / _totacc11
*/
 if (MARKET=3)
  ; For reporting transfers
  if (MW[270]==0)                          ;walk bus
    _xfer0_1 = _xfer0_1 + MW[504]
  elseif (MW[270]==1)
    _xfer1_1 = _xfer1_1 + MW[504]
  elseif (MW[270]==2)
    _xfer2_1 = _xfer2_1 + MW[504]
  else
    _xfer3_1 = _xfer3_1+ MW[504]
  endif
  if (MW[271]==0)                          ;walk prj
    _xfer0_2 = _xfer0_2 + MW[505]
  elseif (MW[271]==1)
    _xfer1_2 = _xfer1_2 + MW[505]
  elseif (MW[271]==2)
    _xfer2_2 = _xfer2_2 + MW[505]
  else
    _xfer3_2 = _xfer3_2 + MW[505]
  endif
  if (MW[272]==0)                          ;pnr bus
    _xfer0_3 = _xfer0_3 + MW[506]
  elseif (MW[272]==1)
    _xfer1_3 = _xfer1_3 + MW[506]
  elseif (MW[272]==2)
    _xfer2_3 = _xfer2_3 + MW[506]
  else
    _xfer3_3 = _xfer3_3 + MW[506]
  endif
  if (MW[273]==0)                          ;pnr prj
    _xfer0_4 = _xfer0_4 + MW[507]
  elseif (MW[273]==1)
    _xfer1_4 = _xfer1_4 + MW[507]
  elseif (MW[273]==2)
    _xfer2_4 = _xfer2_4 + MW[507]
  else
    _xfer3_4 = _xfer3_4 + MW[507]
  endif
  if (MW[274]==0)                          ;knr bus
    _xfer0_5 = _xfer0_5 + MW[508]
  elseif (MW[274]==1)
    _xfer1_5 = _xfer1_5 + MW[508]
  elseif (MW[274]==2)
    _xfer2_5 = _xfer2_5 + MW[508]
  else
    _xfer3_5 = _xfer3_5 + MW[508]
  endif
  if (MW[275]==0)                          ;knr prj
    _xfer0_6 = _xfer0_6 + MW[509]
  elseif (MW[275]==1)
    _xfer1_6 = _xfer1_6 + MW[509]
  elseif (MW[275]==2)
    _xfer2_6 = _xfer2_6 + MW[509]
  else
    _xfer3_6 = _xfer3_6 + MW[509]
  endif
  if (MW[276]==0)                          ;cbdknr bus
    _xfer0_7 = _xfer0_7 + MW[510]
  elseif (MW[276]==1)
    _xfer1_7 = _xfer1_7 + MW[510]
  elseif (MW[276]==2)
    _xfer2_7 = _xfer2_7 + MW[510]
  else
    _xfer3_7 = _xfer3_7 + MW[510]
  endif
  if (MW[277]==0)                          ;cbdknr prj
    _xfer0_8 = _xfer0_8 + MW[511]
  elseif (MW[277]==1)
    _xfer1_8 = _xfer1_8 + MW[511]
  elseif (MW[277]==2)
    _xfer2_8 = _xfer2_8 + MW[511]
  else
    _xfer3_8 = _xfer3_8 + MW[511]
  endif
  if (MW[278]==0)                          ;frg pnr
    _xfer0_9 = _xfer0_9 + MW[512]
  elseif (MW[278]==1)
    _xfer1_9 = _xfer1_9 + MW[512]
  elseif (MW[278]==2)
    _xfer2_9 = _xfer2_9 + MW[512]
  else
    _xfer3_9 = _xfer3_9 + MW[512]
  endif

  _xfer0_10 = _xfer0_1 + _xfer0_2 + _xfer0_3 + _xfer0_4 + _xfer0_5 + _xfer0_6 + _xfer0_7 + _xfer0_8 + _xfer0_9
  _xfer1_10 = _xfer1_1 + _xfer1_2 + _xfer1_3 + _xfer1_4 + _xfer1_5 + _xfer1_6 + _xfer1_7 + _xfer1_8 + _xfer1_9
  _xfer2_10 = _xfer2_1 + _xfer2_2 + _xfer2_3 + _xfer2_4 + _xfer2_5 + _xfer2_6 + _xfer2_7 + _xfer2_8 + _xfer2_9
  _xfer3_10 = _xfer3_1 + _xfer3_2 + _xfer3_3 + _xfer3_4 + _xfer3_5 + _xfer3_6 + _xfer3_7 + _xfer3_8 + _xfer3_9

 endif

  ; User benefit calculations are done for each market segment
  ; Determine can walk & must drive percentages for matrix for Summit for each market segment (1 for auto0, 2 for auto1 and 3 for auto2)
  ; person trips
  IF ({RunUB}==1)

  T1=401+_idx2, T2=402+_idx2, T3=403+_idx2, T4=404+_idx2, T5=405+_idx2, T6=406+_idx2, T7=407+_idx2

  if (MW[300+MARKET]>0)
    MW[T1] = MW[300+MARKET]                                                                     ; person trips in market segment
    MW[T2] = MW[T1]                                                                             ; motorized trips in market segment
    MW[T3] = MW[250+MARKET]                                                                     ; expotentied auto utility
    MW[601] = MW[1+_idx2] + MW[2+_idx2] + MW[3+_idx2] + MW[4+_idx2] + MW[5+_idx2] +
              MW[6+_idx2] + MW[7+_idx2] + MW[8+_idx2] + MW[9+_idx2] + MW[10+_idx2]+
              MW[11+_idx2]+ MW[12+_idx2]                                                        ; total trips that can walk in MS
    MW[602] = MW[4+_idx2] + MW[5+_idx2] + MW[6+_idx2] + MW[7+_idx2] + MW[8+_idx2] +
              MW[9+_idx2] + MW[10+_idx2]+ MW[11+_idx2]                                          ; transit trips that can walk in MS
    MW[T4] = MW[601] / MW[T1]
    if (MW[601]>0)
        MW[T5] = MW[602] / MW[601]
    else
        MW[T5] = 0.00                                                                           ; transit share of trips that can walk
    endif

    MW[603] = MW[61+_idx2] + MW[62+_idx2] + MW[63+_idx2] + MW[64+_idx2] + MW[65+_idx2] +
              MW[66+_idx2] + MW[67+_idx2] + MW[68+_idx2] + MW[69+_idx2] + MW[70+_idx2] + MW[71+_idx2] + MW[72+_idx2]   ; total trips that must drive in MS
    MW[604] = MW[64+_idx2] + MW[65+_idx2] + MW[66+_idx2] + MW[67+_idx2] + MW[68+_idx2] +
              MW[69+_idx2] + MW[70+_idx2] + MW[71+_idx2]                                       ; transit trips that must drive in MS
    MW[T6] = MW[603] / MW[T1]                                                                   ; fraction of person trips that must drive
    if (MW[603]>0)
        MW[T7] = MW[604] / MW[603]                                                              ; transit share of trips that must drive
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

   _SUMtrips[MARKET] = _tripsDA[MARKET] + _tripsHOV2[MARKET] + _tripsHOV3[MARKET] +
                       _tripsWalkBus[MARKET] + _tripsWalkPrj[MARKET] +
                       _tripsPNRBus[MARKET] + _tripsPNRPrj[MARKET] +
                       _tripsKNRBus[MARKET] + _tripsKNRPrj[MARKET] + _tripsCBDKNRBus[MARKET] + _tripsCBDKNRPrj[MARKET] + _tripsFrgPNR[MARKET]
   ; Total trips by purpose
   if (_SUMtrips[MARKET]=0) _SUMtrips[MARKET]=1

   if (MARKET==1)
     PRINT FORM=8.OC, LIST='\f\n\n@PURP@ - @PERIOD@ MODE XCHOICE RESULTS',
     '\n**************************************************************',
     '\n','                 ','     Total','     Drive','       One','      Two+','     Total','      Walk','      Walk','       PNR','       PNR','       KNR','       KNR','    CBDKNR','    CBDKNR','     Total','    Fringe',
     '\n','MARKET SEGMENT   ','    Person','     Alone','       Pax','       Pax','      Auto','       Bus','   Project','       Bus','   Project','       Bus','   Project','       Bus','   Project','   Transit','       PNR',
     '\n','--------------   ','   -------','    ------','    ------','    ------','    ------','    ------','   -------','    ------','   -------','    ------','   -------','    ------','   -------','   -------','    ------',PRINTO=2
   endif

   _aocp = _aocp + (_tripsDA[MARKET]+_tripsHOV2[MARKET]+_tripsHOV3[MARKET])
   _aocv = _aocv + (_tripsDA[MARKET]+_tripsHOV2[MARKET]/2.0+_tripsHOV3[MARKET]/@OCC3@)

   _trntemp = (_tripsWalkBus[MARKET]+_tripsWalkPrj[MARKET]+_tripsPNRBus[MARKET]+_tripsPNRPrj[MARKET]+_tripsKNRBus[MARKET]+_tripsKNRPrj[MARKET]+_tripsCBDKNRBus[MARKET]+_tripsCBDKNRPrj[MARKET])
   _frgtemp = (_tripsFrgPNR[MARKET]+_tripsFrgKNR[MARKET])
   PRINT LIST='\n',MARKET_NAME(17),_SUMtrips[MARKET](10.1),
                   _tripsDA[MARKET](10.1),_tripsHOV2[MARKET](10.1),_tripsHOV3[MARKET](10.1),_tripsDA[MARKET]+_tripsHOV2[MARKET]+_tripsHOV3[MARKET](10.1),
                   _tripsWalkBus[MARKET](10.1),_tripsWalkPrj[MARKET](10.1),
                   _tripsPNRBus[MARKET](10.1),_tripsPNRPrj[MARKET](10.1),
                   _tripsKNRBus[MARKET](10.1),_tripsKNRPrj[MARKET](10.1),_tripsCBDKNRBus[MARKET](10.1),_tripsCBDKNRPrj[MARKET](10.1),_trntemp(10.1),
                   _tripsFrgPNR[MARKET](10.1),PRINTO=2

   if (MARKET==3)
     PRINT LIST =  '\n\n',
                   'TOTAL            ',_totacc15(10.1),_totacc1(10.1),_totacc2(10.1),_totacc3(10.1),_totacc4(10.1),_totacc5(10.1),_totacc6(10.1),
                   _totacc7(10.1),_totacc8(10.1),_totacc9(10.1),_totacc10(10.1),_totacc11(10.1),_totacc12(10.1),_totacc13(10.1),_totacc14(10.1),
                   '\n\n',
                   'Can Walk         ',_cw15(10.1),_cw1(10.1),_cw2(10.1),_cw3(10.1),_cw4(10.1),_cw5(10.1),_cw6(10.1),
                   _cw7(10.1),_cw8(10.1),_cw9(10.1),_cw10(10.1),_cw11(10.1),_cw12(10.1),_cw13(10.1),_cw14(10.1),'\n',
                   'Must Drive       ',_md15(10.1),_md1(10.1),_md2(10.1),_md3(10.1),_md4(10.1),_md5(10.1),_md6(10.1),
                   _md7(10.1),_md8(10.1),_md9(10.1),_md10(10.1),_md11(10.1),_md12(10.1),_md13(10.1),_md14(10.1),'\n',
                   'No Access        ',_na15(10.1),_na1(10.1),_na2(10.1),_na3(10.1),_na4(10.1),_na5(10.1),_na6(10.1),
                   _na7(10.1),_na8(10.1),_na9(10.1),_na10(10.1),_na11(10.1),_na12(10.1),_na13(10.1),_na14(10.1),'\n\n',
                   'TOTAL            ',_totacc15(10.1),_totacc1(10.1),_totacc2(10.1),_totacc3(10.1),_totacc4(10.1),_totacc5(10.1),_totacc6(10.1),
                   _totacc7(10.1),_totacc8(10.1),_totacc9(10.1),_totacc10(10.1),_totacc11(10.1),_totacc12(10.1),_totacc13(10.1),_totacc14(10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Productions:     ','\n',
                   'CBD              ',_cbdp15(10.1),_cbdp1(10.1),_cbdp2(10.1),_cbdp3(10.1),_cbdp4(10.1),_cbdp5(10.1),_cbdp6(10.1),
                   _cbdp7(10.1),_cbdp8(10.1),_cbdp9(10.1),_cbdp10(10.1),_cbdp11(10.1),_cbdp12(10.1),_cbdp13(10.1),_cbdp14(10.1),'\n',
                   'Exurban          ',_exup15(10.1),_exup1(10.1),_exup2(10.1),_exup3(10.1),_exup4(10.1),_exup5(10.1),_exup6(10.1),
                   _exup7(10.1),_exup8(10.1),_exup9(10.1),_exup10(10.1),_exup11(10.1),_exup12(10.1),_exup13(10.1),_exup14(10.1),'\n',
                   'Other            ',_othp15(10.1),_othp1(10.1),_othp2(10.1),_othp3(10.1),_othp4(10.1),_othp5(10.1),_othp6(10.1),
                   _othp7(10.1),_othp8(10.1),_othp9(10.1),_othp10(10.1),_othp11(10.1),_othp12(10.1),_othp13(10.1),_othp14(10.1),PRINTO=2
     PRINT LIST =  '\n\n',
                   'Attractions:     ','\n',
                   'CBD              ',_cbda15(10.1),_cbda1(10.1),_cbda2(10.1),_cbda3(10.1),_cbda4(10.1),_cbda5(10.1),_cbda6(10.1),
                   _cbda7(10.1),_cbda8(10.1),_cbda9(10.1),_cbda10(10.1),_cbda11(10.1),_cbda12(10.1),_cbda13(10.1),_cbda14(10.1),'\n',
                   'Exurban          ',_exua15(10.1),_exua1(10.1),_exua2(10.1),_exua3(10.1),_exua4(10.1),_exua5(10.1),_exua6(10.1),
                   _exua7(10.1),_exua8(10.1),_exua9(10.1),_exua10(10.1),_exua11(10.1),_exua12(10.1),_exua13(10.1),_exua14(10.1),'\n',
                   'Other            ',_otha15(10.1),_otha1(10.1),_otha2(10.1),_otha3(10.1),_otha4(10.1),_otha5(10.1),_otha6(10.1),
                   _otha7(10.1),_otha8(10.1),_otha9(10.1),_otha10(10.1),_otha11(10.1),_otha12(10.1),_otha13(10.1),_otha14(10.1),PRINTO=2

     CBDA[1] = CBDA[1] + _cbda5
     CBDA[2] = CBDA[2] + _cbda7
     CBDA[3] = CBDA[3] + _cbda9
     CBDA[4] = CBDA[4] + _cbda11
     TOTACC[1] = TOTACC[1] + _totacc5
     TOTACC[2] = TOTACC[2] + _totacc7
     TOTACC[3] = TOTACC[3] + _totacc9
     TOTACC[4] = TOTACC[4] + _totacc11

/*
     PRINT LIST =  '\n\n',
                   'Fare Revenue ($) '," "(50),_frev1(10.2),_frev2(10.2),_frev3(10.2),_frev4(10.2),_frev5(10.2),
                                               _frev6(10.2),_frev7(10.2)," "(10),'\n',
                   'Average Fare ($) '," "(50),_avef1(10.2),_avef2(10.2),_avef3(10.2),_avef4(10.2),_avef5(10.2),
                                               _avef6(10.2),_avef7(10.2)," "(10),PRINTO=2
*/
     PRINT LIST =  '\n\n',
                   'Transfers:       ','\n',
                   'NONE             '," "(50),_xfer0_1(10.1),_xfer0_2(10.1),_xfer0_3(10.1),_xfer0_4(10.1),_xfer0_5(10.1),
                                               _xfer0_6(10.1),_xfer0_7(10.1),_xfer0_8(10.1),_xfer0_9(10.1),_xfer0_10(10.1),'\n',
                   'ONE              '," "(50),_xfer1_1(10.1),_xfer1_2(10.1),_xfer1_3(10.1),_xfer1_4(10.1),_xfer1_5(10.1),
                                               _xfer1_6(10.1),_xfer1_7(10.1),_xfer1_8(10.1),_xfer1_9(10.1),_xfer1_10(10.1),'\n',
                   'TWO              '," "(50),_xfer2_1(10.1),_xfer2_2(10.1),_xfer2_3(10.1),_xfer2_4(10.1),_xfer2_5(10.1),
                                               _xfer2_6(10.1),_xfer2_7(10.1),_xfer2_8(10.1),_xfer2_9(10.1),_xfer2_10(10.1),'\n',
                   'THREE +          '," "(50),_xfer3_1(10.1),_xfer3_2(10.1),_xfer3_3(10.1),_xfer3_4(10.1),_xfer3_5(10.1),
                                               _xfer3_6(10.1),_xfer3_7(10.1),_xfer3_8(10.1),_xfer3_9(10.1),_xfer3_10(10.1),PRINTO=2

     PRINT LIST =  '\n\n',
                   'Average Auto Occupancy      =',_aocp/_aocv(8.3),
                   '\n\n**************************************************************',PRINTO=2
   endif

   ; OUTPUT MODEL SHARES TO A CSV FILE FOR CALIBRATION
   if ({MC_Calib}>0)
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+1),@PURPOSE@,MARKET,_tripsDA[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+2),@PURPOSE@,MARKET,_tripsHOV2[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+3),@PURPOSE@,MARKET,_tripsHOV3[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+4),@PURPOSE@,MARKET,_tripsWalkBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+5),@PURPOSE@,MARKET,_tripsWalkPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+6),@PURPOSE@,MARKET,_tripsPNRBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+7),@PURPOSE@,MARKET,_tripsPNRPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+8),@PURPOSE@,MARKET,_tripsKNRBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+9),@PURPOSE@,MARKET,_tripsKNRPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+10),@PURPOSE@,MARKET,_tripsCBDKNRBus[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+11),@PURPOSE@,MARKET,_tripsCBDKNRPrj[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
    PRINT CSV=T, LIST= (36*(@PURPNO@-2)+12*(MARKET-1)+12),@PURPOSE@,MARKET,_tripsFrgPNR[MARKET]/_SUMtrips[MARKET](12.6), PRINTO=3
   endif

  ENDIF

 ENDJLOOP


ENDLOOP

IF (I == _ZONES)
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+1),(@PURPNO@-1),(cbda[1]/totacc[1])(10.6), printo=4
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+2),(@PURPNO@-1),(cbda[2]/totacc[2])(10.6), printo=4
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+3),(@PURPNO@-1),(cbda[3]/totacc[3])(10.6), printo=4
  PRINT CSV=T, LIST=((@PURPNO@-2)*4+4),(@PURPNO@-1),(cbda[4]/totacc[4])(10.6), printo=4
ENDIF
; ********************************* END USER BENEFIT AND MODE CHOICE SUMMARY ********************************************

ENDRUN
