; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\PSMAT00A.PRN" MSG='Path-Conditioning Walk - PK'
FILEI LOOKUPI[1] = "C:\NERPM43\applications\Warmstart\TRN_COEFFICIENTS.DBF"
FILEI MATI[3] = "{SCENARIO_DIR}\output\TSKIMAM2_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIMAM1_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{year}.MAT"

FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIMPK2.{alt}{year}",
  MO=41-55,  NAME=WalkTime,AutoTime,SideWalkTime,BusTime,PBusTime,CircTime,RailTime,CommRailTime,OthTime,PRJTime,XFERs,IWAIT,XWAIT,FARE,TOTTIME
FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIMPK1.{alt}{year}",
  MO=21-35, NAME=WalkTime,AutoTime,SideWalkTime,BusTime,PBusTime,CircTime,RailTime,CommRailTime,OthTime,PRJTime,XFERs,IWAIT,XWAIT,FARE,TOTTIME

DistributeINTRAStep ProcessID="FSUTMSDist" ProcessList=1-4

ZONEMSG=100

; Check skims to see if they are better than the all-walk path & if they have required IVT

LOOKUP NAME=COEFF,
   LOOKUP[1]=1,
   RESULT=3,
   FAIL=0,0,0,
   LIST=Y,
   INTERPOLATE=N,
   LOOKUPI=1

   _ovtam =COEFF(1,3)/COEFF(1,1)         ; out-of-vehicle time factor (OVT time and Wait factor)
   valtime   =0.6*COEFF(1,1)/COEFF(1,4) ; value of time (in $/hr), middle income segment
   aatfactor =COEFF(1,5)/COEFF(1,1)      ; drive access to transit time factor
   _xferpen=COEFF(1,6)/COEFF(1,1)        ; transfer penalty
   _boardingpen = 2.0

   FILLMW MW[11]=MI.1.1
   FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
   FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
   ;FILLMW MW[61]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
   ;FILLMW MW[81]=MI.5.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

   LOOP x=1,6
    LOOP y=1,15
           _idx=20 + 20*(x-1) + y
      IF((_idx%20)=14)
           COMP total = ROWFAC(_idx,100.0)
      ENDIF
    ENDLOOP
  ENDLOOP

   ; Apply OVT factor to all-walk skims
   COMP total = ROWFAC(11,_ovtam)

  JLOOP

  IF (I=={FromNode} && J=={ToNode}) LIST="Trace ",I(5.0),"-",J(5.0)
  IF (I=={FromNode} && J=={ToNode}) LIST="            ","       IVT","      Path","      wOVT","      wTOT"
  IF (I=={FromNode} && J=={ToNode}) LIST="All-Walk    ","          ","          ",MW[11](10.2),MW[11](10.2)

    ; Check skims to see if they are better than the all-walk path & if they have required IVT
    ; Walk-bus - peak (20 series)
    _ivt = MW[24] + MW[25] + MW[26] + MW[27] + MW[28] + MW[29] + MW[30]
    _pth = MW[24] + MW[26]
    _ovt = MW[22] + _ovtam * (MW[21] + MW[23] + MW[32] + MW[33]) + _boardingpen + _xferpen * MW[31]
    _tot = _ivt + _ovt
  IF (I=={FromNode} && J=={ToNode}) LIST="Walk-Bus  pk",_ivt(10.2),_pth(10.2),_ovt(10.2),_tot(10.2)
  IF (((MW[11]>0) && (MW[11]<_tot)) || (_pth==0))
    MW[21]=0, MW[22]=0, MW[23]=0, MW[24]=0, MW[25]=0
    MW[26]=0, MW[27]=0, MW[28]=0, MW[29]=0, MW[30]=0
    MW[31]=0,  MW[32]=0, MW[33]=0, MW[34]=0, MW[35]=0
  ENDIF
  
    _ivt = MW[23] + MW[24] + MW[25] + MW[26] + MW[27]
    _pth = MW[23]
    _ovt = MW[22]+ _ovtam * (MW[21] + MW[29] + MW[30])  + _boardingpen + _xferpen * MW[28]
    _tot = _ivt + _ovt
  IF(I=={FromNode} && J=={ToNode}) LIST="            ",_ivt(10.2),_pth(10.2),_ovt(10.2),_tot(10.2)

   ; Walk-proj - peak (40 series)
   _ivt = MW[44] + MW[45] + MW[46] + MW[47] + MW[48] + MW[49] + MW[50]
   _pth = MW[45] + MW[47] + MW[48] + MW[49] + MW[50]
   _ovt = MW[42] + _ovtam * (MW[41] + MW[43] + MW[52] + MW[53]) + _boardingpen + _xferpen * MW[51]
   _tot = _ivt + _ovt
  IF (I=={FromNode} && J=={ToNode}) LIST="Walk-Proj pk",_ivt(10.2),_pth(10.2),_ovt(10.2),_tot(10.2)
  IF (((MW[11]>0) && (MW[11]<_tot)) || (_pth==0))
    MW[41]=0, MW[42]=0, MW[43]=0, MW[44]=0, MW[45]=0
    MW[46]=0, MW[47]=0, MW[48]=0, MW[49]=0, MW[50]=0
    MW[51]=0, MW[52]=0, MW[53]=0, MW[54]=0, MW[55]=0
  ENDIF
   
   _ivt = MW[43] + MW[44] + MW[45] + MW[46] + MW[47]
   _pth = MW[44] + MW[45] + MW[46]
   _ovt = MW[42] + _ovtam * (MW[41] + MW[49] + MW[50])  + _boardingpen + _xferpen * MW[48]
   _tot = _ivt + _ovt
  IF(I=={FromNode} && J=={ToNode}) LIST="            ",_ivt(10.2),_pth(10.2),_ovt(10.2),_tot(10.2)

  ENDJLOOP

ENDRUN
