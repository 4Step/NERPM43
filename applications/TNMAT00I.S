; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00B.PRN" MSG='Off-peak path conditioning'
FILEO MATO[6] = "{SCENARIO_DIR}\output\TSKIMOP6_{alt}{year}.MAT",
 MO=251-265,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[5] = "{SCENARIO_DIR}\output\TSKIMOP5_{alt}{year}.MAT",
 MO=231-245,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[4] = "{SCENARIO_DIR}\output\TSKIMOP4_{alt}{year}.MAT",
 MO=211-225,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[3] = "{SCENARIO_DIR}\output\TSKIMOP3_{alt}{year}.MAT",
 MO=191-205,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIMOP2_{Alt}{year}.MAT",
 MO=171-185,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIMOP1_{Alt}{year}.MAT",
 MO=151-165,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI MATI[7] = "{SCENARIO_DIR}\output\AllWalk_{alt}{year}.MAT"

zonemsg=100

FILLMW MW[1]=MI.1.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[21]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[41]=MI.3.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[61]=MI.4.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[81]=MI.5.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[101]=MI.6.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
FILLMW MW[121]=MI.7.1   ; all walk skim


; LOOKUP for coefficient file
LOOKUP NAME=COEFF, LOOKUP[1]=1, RESULT=3,
FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=1

ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4) ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor
xferfactor=COEFF(1,6)/COEFF(1,1)     ; transfer penalty
brdpen = 2.0

JLOOP

; compare the all walk time against the transit time
; if all walk is better zero-out the transit skims

  ; All-walk time
  _walkcost = ovtfactor*MW[121]
  if (_walkcost == 0) _walkcost = 20000

  ; Walk-Bus
  _optrncost1 = 0
  if (MW[4] + MW[5] + MW[6] + MW[7] + MW[8] + MW[9] + MW[10]>0)
   _optrncost1 = ovtfactor*(MW[1] + MW[3] + MW[12] + MW[13]) + MW[4] + MW[5] + MW[6] + MW[7] + MW[8] + MW[9] + MW[10] +
                 brdpen*(MW[11]+1) +
                 xferfactor*MW[11]
  endif
  ; Walk-Project
  _optrncost2 = 0
  if (MW[24] + MW[25] + MW[26] + MW[27] + MW[28] + MW[29] + MW[30]>0)
   _optrncost2 = ovtfactor*(MW[21] + MW[23] + MW[32] + MW[33]) + 1.3*MW[24] + MW[25] + 1.3*MW[26] + MW[27] + MW[28] + MW[29] + MW[30] +
                 brdpen*(MW[31]+1) +
                 xferfactor*MW[31]
  endif
  ; PNR-Bus
  _optrncost3 = 0
  if (MW[44] + MW[45] + MW[46] + MW[47] + MW[48] + MW[49] + MW[50]>0)
   _optrncost3 = ovtfactor*(MW[41] + MW[43] + MW[52] + MW[53]) + MW[44] + MW[45] + MW[46] + MW[47] + MW[48] + MW[49] + MW[50] +
                 brdpen*(MW[51]+1) +
                 xferfactor*MW[51]
  endif
  ; PNR-Project
  _optrncost4 = 0
  if (MW[64] + MW[65] + MW[66] + MW[67] + MW[68] + MW[69] + MW[70]>0)
   _optrncost4 = ovtfactor*(MW[61] + MW[63] + MW[72] + MW[73]) + 1.3*MW[64] + MW[65] + 1.3*MW[66] + MW[67] + MW[68] + MW[69] + MW[70] +
                 brdpen*(MW[71]+1) +
                 xferfactor*MW[71]
  endif
  ; KNR-Bus
  _optrncost5 = 0
  if (MW[84] + MW[85] + MW[86] + MW[87] + MW[88] + MW[89] + MW[90]>0)
   _optrncost5 = ovtfactor*(MW[81] + MW[83] + MW[92] + MW[93]) + MW[84] + MW[85] + MW[86] + MW[87] + MW[88] + MW[89] + MW[90] +
                 brdpen*(MW[91]+1) +
                 xferfactor*MW[91]
  endif
  ; KNR-Project
  _optrncost6 = 0
  if (MW[104] + MW[105] + MW[106] + MW[107] + MW[108] + MW[109] + MW[110]>0)
   _optrncost6 = ovtfactor*(MW[101] + MW[103] + MW[112] + MW[113]) + 1.3*MW[104] + MW[105] + 1.3*MW[106] + MW[107] + MW[108] + MW[109] + MW[110] +
                 brdpen*(MW[111]+1) +
                 xferfactor*MW[111]
  endif

  if (_optrncost1 > 0.0) ; make sure there is a transit path and divide by zero error won't occur
   if (_walkcost/_optrncost1 < 1.0)
      MW[151]=0,         MW[152]=0,         MW[153]=0,          MW[154]=0,         MW[155]=0,
      MW[156]=0,         MW[157]=0,         MW[158]=0,          MW[159]=0,         MW[160]=0,
      MW[161]=0,         MW[162]=0,         MW[163]=0,          MW[164]=0,         MW[165]=0
   else
      MW[151]=MW[1],     MW[152]=MW[2],     MW[153]=MW[3],      MW[154]=MW[4],     MW[155]=MW[5],
      MW[156]=MW[6],     MW[157]=MW[7],     MW[158]=MW[8],      MW[159]=MW[9],     MW[160]=MW[10],
      MW[161]=MW[11],    MW[162]=MW[12],    MW[163]=MW[13],     MW[164]=MW[14],    MW[165]=MW[15]
   endif
  endif

  if (_optrncost2 > 0.0)
   if (_walkcost/_optrncost2 < 1.0)
      MW[171]=0,         MW[172]=0,         MW[173]=0,          MW[174]=0,         MW[175]=0,
      MW[176]=0,         MW[177]=0,         MW[178]=0,          MW[179]=0,         MW[180]=0,
      MW[181]=0,         MW[182]=0,         MW[183]=0,          MW[184]=0,         MW[185]=0
   else
      MW[171]=MW[21],    MW[172]=MW[22],    MW[173]=MW[23],     MW[174]=MW[24],    MW[175]=MW[25],
      MW[176]=MW[26],    MW[177]=MW[27],    MW[178]=MW[28],     MW[179]=MW[29],    MW[180]=MW[30],
      MW[181]=MW[31],    MW[182]=MW[32],    MW[183]=MW[33],     MW[184]=MW[34],    MW[185]=MW[35]
   endif
  endif

  if (_optrncost3 > 0.0)
   if (_walkcost/_optrncost3 < 1.0)
      MW[191]=0,         MW[192]=0,         MW[193]=0,          MW[194]=0,         MW[195]=0,
      MW[196]=0,         MW[197]=0,         MW[198]=0,          MW[199]=0,         MW[200]=0,
      MW[201]=0,         MW[202]=0,         MW[203]=0,          MW[204]=0,         MW[205]=0
   else
      MW[191]=MW[41],    MW[192]=MW[42],    MW[193]=MW[43],     MW[194]=MW[44],    MW[195]=MW[45],
      MW[196]=MW[46],    MW[197]=MW[47],    MW[198]=MW[48],     MW[199]=MW[49],    MW[200]=MW[50],
      MW[201]=MW[51],    MW[202]=MW[52],    MW[203]=MW[53],     MW[204]=MW[54],    MW[205]=MW[55]
   endif
  endif

  if (_optrncost4 > 0.0)
   if (_walkcost/_optrncost4 < 1.0)
      MW[211]=0,         MW[212]=0,         MW[213]=0,          MW[214]=0,         MW[215]=0,
      MW[216]=0,         MW[217]=0,         MW[218]=0,          MW[219]=0,         MW[220]=0,
      MW[221]=0,         MW[222]=0,         MW[223]=0,          MW[224]=0,         MW[225]=0
   else
      MW[211]=MW[61],    MW[212]=MW[62],    MW[213]=MW[63],     MW[214]=MW[64],    MW[215]=MW[65],
      MW[216]=MW[66],    MW[217]=MW[67],    MW[218]=MW[68],     MW[219]=MW[69],    MW[220]=MW[70],
      MW[221]=MW[71],    MW[222]=MW[72],    MW[223]=MW[73],     MW[224]=MW[74],    MW[225]=MW[75]
   endif
  endif

  if (_optrncost5 > 0.0)
   if (_walkcost/_optrncost5 < 1.0)
      MW[231]=0,         MW[232]=0,         MW[233]=0,          MW[234]=0,         MW[235]=0,
      MW[236]=0,         MW[237]=0,         MW[238]=0,          MW[239]=0,         MW[240]=0,
      MW[241]=0,         MW[242]=0,         MW[243]=0,          MW[244]=0,         MW[245]=0
   else
      MW[231]=MW[81],    MW[232]=MW[82],    MW[233]=MW[83],     MW[234]=MW[84],    MW[235]=MW[85],
      MW[236]=MW[86],    MW[237]=MW[87],    MW[238]=MW[88],     MW[239]=MW[89],    MW[240]=MW[90],
      MW[241]=MW[91],    MW[242]=MW[92],    MW[243]=MW[93],     MW[244]=MW[94],    MW[245]=MW[95]
   endif
  endif

  if (_optrncost6 > 0.0)
   if (_walkcost/_optrncost6 < 1.0)
      MW[251]=0,         MW[252]=0,         MW[253]=0,          MW[254]=0,         MW[255]=0,
      MW[256]=0,         MW[257]=0,         MW[258]=0,          MW[259]=0,         MW[260]=0,
      MW[261]=0,         MW[262]=0,         MW[263]=0,          MW[264]=0,         MW[265]=0
   else
      MW[251]=MW[101],   MW[252]=MW[102],   MW[253]=MW[103],    MW[254]=MW[104],   MW[255]=MW[105],
      MW[256]=MW[106],   MW[257]=MW[107],   MW[258]=MW[108],    MW[259]=MW[109],   MW[260]=MW[110],
      MW[261]=MW[111],   MW[262]=MW[112],   MW[263]=MW[113],    MW[264]=MW[114],   MW[265]=MW[115]
   endif
  endif

  if (I={REPI} & J={REPJ})
    list=  I(5.0),
           J(5.0),
           _walkcost(15.4),
           _optrncost1(15.4),
           MW[1](15.4),
           MW[151](15.4),
           _optrncost2(15.4),
           MW[21](15.4),
           MW[171](15.4)
  endif

ENDJLOOP

ENDRUN
