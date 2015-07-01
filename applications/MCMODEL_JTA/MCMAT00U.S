; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00A1.PRN" MSG='Calibration'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NEW_TRNCOEFF.CSV",
append=t
FILEI LOOKUPI[5] = "{SCENARIO_DIR}\output\CBDSHARES.DBF"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\CalibSum.TXT",
append=t
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV",
append=t
FILEI LOOKUPI[4] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\MODESHARES.DBF"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\MC_TARGETS.DBF"

zones=1
numchoice=12

 ; LOOKUP for Coefficients
 LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=@PURPNO@, INTERPOLATE=N, LIST=Y, LOOKUPI=4
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
  NC_Wlk = NC_TRN * NC_TRNAC
  NC_PNR = NC_TRN * NC_TRNAC
  NC_KNR = NC_TRN * NC_TRNAC

 LOOP MARKET=1,3  ; 0 car, 1 car, 2+ car household

  ; LOOKUP for previuos run shares
  _idx=numchoice*(MARKET-1)
  LOOKUP NAME=SHARES, LOOKUP[1]=1, RESULT=@PURPNO@,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=3
  Eda=SHARES(1,_idx+1)         ; 1 - drive alone Previous share
  Ehov2=SHARES(1,_idx+2)       ; 2 - HOV2 Previous share
  Ehov3=SHARES(1,_idx+3)       ; 3 - HOV3+ Previous share
  Ewalkbus=SHARES(1,_idx+4)    ; 4 - Walk to bus Previous share
  Ewalkprj=SHARES(1,_idx+5)    ; 5 - Walk to prj Previous share
  Epnrbus=SHARES(1,_idx+6)     ; 6 - PNR to bus Previous share
  Epnrprj=SHARES(1,_idx+7)     ; 7 - PNR to prj Previous share
  Eknrbus=SHARES(1,_idx+8)     ; 8 - KNR to bus Previous share
  Eknrprj=SHARES(1,_idx+9)     ; 9 - KNR to prj Previous share
  Ecbdknrbus=SHARES(1,_idx+10)     ; 10 - KNR to bus Previous share
  Ecbdknrprj=SHARES(1,_idx+11)     ; 11 - KNR to prj Previous share
  EFringe=SHARES(1,_idx+12)    ;12 - Fringe PNR to circulator
  Eshr  = Ehov2 + Ehov3
  Eauto = Eda + Eshr
  Efrg  = EFringe
  Ewalk = Ewalkbus + Ewalkprj
  Epnr  = Epnrbus + Epnrprj
  Eknr  = Eknrbus + Eknrprj
  Ecbdknr = Ecbdknrbus + Ecbdknrprj
  Etran = Ewalk + Epnr + Eknr + Ecbdknr

  ; LOOKUP for previuos run shares of CBD targets
  _idx=numchoice*(MARKET-1)
  LOOKUP NAME=CBDSHARES, LOOKUP[1]=1, RESULT=@PURPNO@,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=5
  Ecbdwalk=CBDSHARES(1,1)
  Ecbdpnr =CBDSHARES(1,2)
  Ecbdknr2 =CBDSHARES(1,3)
  Ecbdcbdknr=CBDSHARES(1,4)

  ; LOOKUP for constants
  LOOKUP NAME=CONSTANTS, LOOKUP[1]=1, RESULT=@PURPNO@,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=2
  Kda=CONSTANTS(1,_idx+1)         ; 1 - drive alone
  Khov2=CONSTANTS(1,_idx+2)       ; 2 - HOV2
  Khov3=CONSTANTS(1,_idx+3)       ; 3 - HOV3+
  Kwalkbus=CONSTANTS(1,_idx+4)    ; 4 - Walk to bus
  Kwalkprj=CONSTANTS(1,_idx+5)    ; 5 - Walk to prj
  Kpnrbus=CONSTANTS(1,_idx+6)     ; 6 - PNR to bus
  Kpnrprj=CONSTANTS(1,_idx+7)     ; 7 - KNR to prj
  Kknrbus=CONSTANTS(1,_idx+8)     ; 8 - PNR to bus
  Kknrprj=CONSTANTS(1,_idx+9)     ; 9 - KNR to prj
  Kcbdknrbus=CONSTANTS(1,_idx+10)     ; 10 - PNR to bus
  Kcbdknrprj=CONSTANTS(1,_idx+11)     ; 11 - KNR to prj
  Kfrgpnr=CONSTANTS(1,_idx+12)    ;12 - Fringe PNR

  ; LOOKUP for targets
  LOOKUP NAME=TARG, LOOKUP[1]=1, RESULT=@PURPNO@, FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=1
  Oda=TARG(1,_idx+1)              ; 1- drive alone target
  Ohov2=TARG(1,_idx+2)            ; 2- hov2 target
  Ohov3=TARG(1,_idx+3)            ; 3- hov3 target
  Owalkbus=TARG(1,_idx+4)         ; 4- walk to bus target
  Owalkprj=TARG(1,_idx+5)         ; 5- walk to prj target
  Opnrbus=TARG(1,_idx+6)          ; 6- PNR to bus target
  Opnrprj=TARG(1,_idx+7)          ; 7- PNR to prj target
  Oknrbus=TARG(1,_idx+8)          ; 8- KNR to bus target
  Oknrprj=TARG(1,_idx+9)          ; 9- KNR to prj target
  Ocbdknrbus=TARG(1,_idx+10)          ; 10- KNR to bus target
  Ocbdknrprj=TARG(1,_idx+11)          ; 11- KNR to prj target
  OFringe=TARG(1,_idx+12)         ;12- Fringe PNR target
; targets for CBD trips
  Ocbdwalk=TARG(1,37)
  Ocbdpnr=TARG(1,38)
  Ocbdknr2=TARG(1,39)
  Ocbdcbdknr=TARG(1,40)

  Oshr  = Ohov2 + Ohov3
  Oauto = Oda + Oshr
  Ofrg  = OFringe
  Owalk = Owalkbus + Owalkprj
  Opnr  = Opnrbus + Opnrprj
  Oknr  = Oknrbus + Oknrprj
  Ocbdknr  = Ocbdknrbus + Ocbdknrprj
  Otran = Owalk + Opnr + Oknr + Ocbdknr

;**************************************************************************************************
; MODE CHOICE CALIBRATION
;**************************************************************************************************
; following symbols used in this script
; E-previous share, K-previuos constant, O-target, L-logsum, R-revised constant

  D=+1.0    ; Dampening factor
  tiny=0.0000000000001

  ; Compute deltas
  dDA = 0
  dH2 = 0
  dH3 = 0
  dWB = 0
  dWP = 0
  dPB = 0
  dPP = 0
  dKB = 0
  dKP = 0
  dCKB = 0
  dCKP = 0
  dFP = 0
  dcbdwalk=0
  dcbdpnr=0
  dcbdknr=0
  dcbdcbdknr=0

_dummy=0.000001
  if (Eda>_dummy)      dDA = LN(Eda / (Oda+tiny)) * NC_Auto
  if (Ehov2>_dummy)    dH2 = LN(Ehov2 / (Ohov2+tiny)) * NC_Auto * NC_AutoSR
  if (Ehov3>_dummy)    dH3 = LN(Ehov3 / (Ohov3+tiny)) * NC_Auto * NC_AutoSR
  if (Ewalkbus>_dummy) dWB = LN(Ewalkbus / (Owalkbus+tiny)) * NC_Trn * NC_TrnAC
  if (Ewalkprj>_dummy)
    dWP = LN(Ewalkprj / (Owalkprj+tiny)) * NC_Trn * NC_TrnAC

  else
    dWP = dWB
  endif
  if (Epnrbus>_dummy)  dPB = LN(Epnrbus  / (Opnrbus+tiny))  * NC_Trn * NC_TrnAC
  if (Epnrprj>_dummy)
    dPP = LN(Epnrprj  / (Opnrprj+tiny))  * NC_Trn * NC_TrnAC
  else
    dPP = dPB
  endif
  if (Eknrbus>_dummy)  dKB = LN(Eknrbus  / (Oknrbus+tiny))  * NC_Trn * NC_TrnAC
  if (Eknrprj>_dummy)
   dKP = LN(Eknrprj  / (Oknrprj+tiny))  * NC_Trn * NC_TrnAC
  else
   dKP = dKB
  endif
  if (Ecbdknrbus>_dummy)  dCKB = LN(Ecbdknrbus  / (Ocbdknrbus+tiny))  * NC_Trn * NC_TrnAC
  if (Ecbdknrprj>_dummy)
   dCKP = LN(Ecbdknrprj  / (Ocbdknrprj+tiny))  * NC_Trn * NC_TrnAC
  else
   dCKP = dCKB
  endif
  if (Efrg>_dummy)     dFP = LN(Efrg / (Ofrg+tiny)) * NC_Fringe

  if (Ecbdwalk>_dummy)    dcbdwalk = LN(Ecbdwalk / (Ocbdwalk+tiny)) * NC_Trn * NC_TrnAC
  if (Ecbdpnr>_dummy)     dcbdpnr = LN(Ecbdpnr / (Ocbdpnr+tiny)) * NC_Trn * NC_TrnAC
  if (Ecbdknr2>_dummy)     dcbdknr = LN(Ecbdknr2 / (Ocbdknr2+tiny)) * NC_Trn * NC_TrnAC
  if (Ecbdcbdknr>_dummy)  dcbdcbdknr = LN(Ecbdcbdknr / (Ocbdcbdknr+tiny)) * NC_Trn * NC_TrnAC

  ; Revise constants
  Rda      = Kda
  Rhov2    = Khov2    + (dDA - dH2)
  Rhov3    = Khov3    + (dDA - dH3)
  Rwalkbus = Kwalkbus + (dDA - dWB)
  Rwalkprj = Kwalkprj + (dDA - dWP)
  if (MARKET==1 & ('@PURP@'<> 'NHB'))
    Rpnrbus  = Kpnrbus
    Rpnrprj  = Kpnrprj
  else
    Rpnrbus  = Kpnrbus  + (dDA - dPB)
    Rpnrprj  = Kpnrprj  + (dDA - dPP)
  endif
  Rknrbus  = Kknrbus  + (dDA - dKB)
  Rknrprj  = Kknrprj  + (dDA - dKP)
  Rcbdknrbus  = Kcbdknrbus  + (dDA - dCKB)
  Rcbdknrprj  = Kcbdknrprj  + (dDA - dCKP)
  Rfrg     = Kfrgpnr  + (dDA - dFP)

  Rcbdwalk     = COEFF_DCBD_WALK + (dDA - dcbdwalk)
  Rcbdpnr      = COEFF_DCBD_PNR + (dDA - dcbdpnr)
  Rcbdknr      = COEFF_DCBD_KNR + (dDA - dcbdknr)
  Rcbdcbdknr   = COEFF_DCBD_CBDKNR + (dDA - dcbdcbdknr)

  if (Oda<_dummy)        Rda=-999.99
  if (Ohov2<_dummy)      Rhov2=-999.99
  if (Ohov3<_dummy)      Rhov3=-999.99
  if (Owalkbus<_dummy)   Rwalkbus=-999.99
                         Rwalkprj=Rwalkbus
  if (Opnrbus<_dummy)    Rpnrbus=-999.99
                         Rpnrprj=Rpnrbus
  if (Oknrbus<_dummy)    Rknrbus=-999.99
                         Rknrprj=Rknrbus
  if (Ocbdknrbus<_dummy) Rcbdknrbus=-999.99
                         Rcbdknrprj=Rcbdknrbus
  if (OFringe<_dummy)    Rfrg=-999.99

  if (Ocbdwalk<_dummy)   Rcbdwalk   =-999.99
  if (Ocbdpnr<_dummy)    Rcbdpnr    =-999.99
  if (Ocbdknr2<_dummy)    Rcbdknr    =-999.99
  if (Ocbdcbdknr<_dummy) Rcbdcbdknr =-999.99

  ; print calibration summary
  if (market==1) print list='\n\n\nIteration ',@AMLoop_1@(2.0),printo=2
  if (market==1) _lab='Zero Car HHs'
  if (market==2) _lab='One Car HHs '
  if (market==3) _lab='Two+ Car HHs'
  print list='\n\n','@PURP@, ',_lab(12),'\n',printo=2
  print list='Category            ','   TargShare'(12),'    EstShare'(12),'   PrevConst'(12),'      Adjust'(12),'    RevConst'(12),printo=2
  print list='--------            ','   ---------'(12),'    --------'(12),'   ---------'(12),'      ------'(12),'    --------'(12),printo=2
  print list='Drive Alone         ',Oda(12.6)      ,Eda(12.6)     ,Kda(12.6)     ,(dDA-dDA)(12.6),Rda(12.6)     ,printo=2
  print list='One Pax             ',Ohov2(12.6)    ,Ehov2(12.6)   ,Khov2(12.6)   ,(dDA-dH2)(12.6),Rhov2(12.6)   ,printo=2
  print list='Two+ Pax            ',Ohov3(12.6)    ,Ehov3(12.6)   ,Khov3(12.6)   ,(dDA-dH3)(12.6),Rhov3(12.6)   ,printo=2
  print list='Walk-Bus            ',Owalkbus(12.6) ,Ewalkbus(12.6),Kwalkbus(12.6),(dDA-dWB)(12.6),Rwalkbus(12.6),printo=2
  print list='Walk-Project        ',Owalkprj(12.6) ,Ewalkprj(12.6),Kwalkprj(12.6),(dDA-dWP)(12.6),Rwalkprj(12.6),printo=2
  print list='PNR-Bus             ',Opnrbus(12.6)  ,Epnrbus(12.6) ,Kpnrbus(12.6) ,(dDA-dPB)(12.6),Rpnrbus(12.6) ,printo=2
  print list='PNR-Project         ',Opnrprj(12.6)  ,Epnrprj(12.6) ,Kpnrprj(12.6) ,(dDA-dPP)(12.6),Rpnrprj(12.6) ,printo=2
  print list='KNR-Bus             ',Oknrbus(12.6)  ,Eknrbus(12.6) ,Kknrbus(12.6) ,(dDA-dKB)(12.6),Rknrbus(12.6) ,printo=2
  print list='KNR-Project         ',Oknrprj(12.6)  ,Eknrprj(12.6) ,Kknrprj(12.6) ,(dDA-dKP)(12.6),Rknrprj(12.6) ,printo=2
  print list='CBDKNR-Bus          ',Ocbdknrbus(12.6)  ,Ecbdknrbus(12.6) ,Kcbdknrbus(12.6) ,(dDA-dCKB)(12.6),Rcbdknrbus(12.6) ,printo=2
  print list='CBDKNR-Project      ',Ocbdknrprj(12.6)  ,Ecbdknrprj(12.6) ,Kcbdknrprj(12.6) ,(dDA-dCKP)(12.6),Rcbdknrprj(12.6) ,printo=2
  print list='Fringe PNR          ',Ofrg(12.6)     ,Efrg(12.6)     ,Kfrgpnr(12.6),(dDA-dFP)(12.6),Rfrg(12.6)     ,printo=2
  print list='Shared Ride         ',Oshr(12.6)     ,Eshr(12.6)    ,printo=2
  print list='Auto                ',Oauto(12.6)    ,Eauto(12.6)   ,printo=2
  print list='Walk                ',Owalk(12.6)    ,Ewalk(12.6)   ,' '(12),       printo=2
  print list='PNR                 ',Opnr(12.6)     ,Epnr(12.6)    ,' '(12),       printo=2
  print list='KNR                 ',Oknr(12.6)     ,Eknr(12.6)    ,' '(12),       printo=2
  print list='CBDKNR              ',Ocbdknr(12.6)  ,Ecbdknr(12.6) ,' '(12),       printo=2
  print list='Transit             ',Otran(12.6)    ,Etran(12.6)   ,' '(12),       printo=2

  ; print REVISED modal constants
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+1),Rda(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+2),Rhov2(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+3),Rhov3(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+4),Rwalkbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+5),Rwalkprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+6),Rpnrbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+7),Rpnrprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+8),Rknrbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+9),Rknrprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+10),Rcbdknrbus(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+11),Rcbdknrprj(12.6),PRINTO=1
  PRINT CSV=T, LIST= (36*((@PURPNO@-1)-1)+12*(MARKET-1)+12),Rfrg(12.6),PRINTO=1

ENDLOOP

  ; print REVISED modal coefficients (only CBD attraction-related ones)
  print list='CBD Attraction Coefficients',printo=2
  print list='CBD Attr Walk       ',Ocbdwalk(12.6) ,Ecbdwalk(12.6),COEFF_DCBD_WALK(12.6),(dDA-dcbdwalk)(12.6),Rcbdwalk(12.6),printo=2
  print list='CBD Attr PNR        ',OcbdPNR(12.6) ,EcbdPNR(12.6),COEFF_DCBD_PNR(12.6),(dDA-dcbdPNR)(12.6),RcbdPNR(12.6),printo=2
  print list='CBD Attr KNR        ',OcbdKNR2(12.6) ,EcbdKNR2(12.6),COEFF_DCBD_KNR(12.6),(dDA-dcbdKNR)(12.6),RcbdKNR(12.6),printo=2
  print list='CBD Attr CBD-KNR    ',OcbdcbdKNR(12.6) ,EcbdcbdKNR(12.6),COEFF_DCBD_CBDKNR(12.6),(dDA-dcbdcbdKNR)(12.6),RcbdcbdKNR(12.6),printo=2
  PRINT CSV=T, LIST=1+(18*(@PURPNO@-2)),  COEFF_IVTT(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=2+(18*(@PURPNO@-2)),  COEFF_IVTT(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=3+(18*(@PURPNO@-2)),  COEFF_OVT(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=4+(18*(@PURPNO@-2)),  COEFF_COST(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=5+(18*(@PURPNO@-2)),  COEFF_AAT(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=6+(18*(@PURPNO@-2)),  COEFF_XFER(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=7+(18*(@PURPNO@-2)),  COEFF_DCBD(10.5)  ,PRINTO=3
  PRINT CSV=T, LIST=8+(18*(@PURPNO@-2)),  COEFF_DEXUP(10.5) ,PRINTO=3
  PRINT CSV=T, LIST=9+(18*(@PURPNO@-2)),  COEFF_DEXUA(10.5) ,PRINTO=3
  PRINT CSV=T, LIST=10+(18*(@PURPNO@-2)), NC_TRNAC(10.5)    ,PRINTO=3
  PRINT CSV=T, LIST=11+(18*(@PURPNO@-2)), NC_TRN(10.5)      ,PRINTO=3
  PRINT CSV=T, LIST=12+(18*(@PURPNO@-2)), NC_AUTO(10.5)     ,PRINTO=3
  PRINT CSV=T, LIST=13+(18*(@PURPNO@-2)), NC_AUTOSR(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=14+(18*(@PURPNO@-2)), NC_FRINGE(10.5)   ,PRINTO=3
  PRINT CSV=T, LIST=15+(18*(@PURPNO@-2)), Rcbdwalk(10.5 )   ,PRINTO=3
  PRINT CSV=T, LIST=16+(18*(@PURPNO@-2)), Rcbdpnr(10.5)     ,PRINTO=3
  PRINT CSV=T, LIST=17+(18*(@PURPNO@-2)), Rcbdknr(10.5)     ,PRINTO=3
  PRINT CSV=T, LIST=18+(18*(@PURPNO@-2)), Rcbdcbdknr(10.5)  ,PRINTO=3
ENDRUN
