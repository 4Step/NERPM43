; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00F1.PRN" MSG='HBNW check mode choice results'
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\hbnwmodechoicesummary.txt"
FILEI MATI[10] = "{SCENARIO_DIR}\output\HBNWTrip.MAT"
FILEI MATI[9] = "{SCENARIO_DIR}\output\HBNWTrip_NT_2CAR.MAT"
FILEI MATI[8] = "{SCENARIO_DIR}\output\HBNWTrip_NT_1CAR.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\HBNWTrip_NT_0CAR.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\HBNWTrip_MD_2CAR.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\HBNWTrip_MD_1CAR.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\HBNWTrip_MD_0CAR.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\HBNWTrip_CW_2CAR.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HBNWTrip_CW_1CAR.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HBNWTrip_CW_0CAR.MAT"

DistributeINTRASTEP ProcessID="JTADist", ProcessList=1-3

zonemsg=100
zones={ZONESA}

FILLMW MW[1]  =MI.1.1,2,3,4,5,6,7,8,9,10     ; can walk 0 car
FILLMW MW[21] =MI.2.1,2,3,4,5,6,7,8,9,10     ; can walk 1 car
FILLMW MW[41] =MI.3.1,2,3,4,5,6,7,8,9,10     ; can walk 2 car
FILLMW MW[61] =MI.4.1,2,3,4,5,6,7,8,9,10
FILLMW MW[81] =MI.5.1,2,3,4,5,6,7,8,9,10
FILLMW MW[101]=MI.6.1,2,3,4,5,6,7,8,9,10
FILLMW MW[121]=MI.7.1,2,3,4,5,6,7,8,9,10
FILLMW MW[141]=MI.8.1,2,3,4,5,6,7,8,9,10
FILLMW MW[161]=MI.9.1,2,3,4,5,6,7,8,9,10
FILLMW MW[201]=MI.10.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30   ; 0 car, 1 car, 2 car households

JLOOP
 _cw0car1=_cw0car1+MW[1]
 _cw0car2=_cw0car2+MW[2]
 _cw0car3=_cw0car3+MW[3]
 _cw0car4=_cw0car4+MW[4]
 _cw0car5=_cw0car5+MW[5]
 _cw0car6=_cw0car6+MW[6]
 _cw0car7=_cw0car7+MW[7]
 _cw0car8=_cw0car8+MW[8]
 _cw0car9=_cw0car9+MW[9]
 _cw0car10=_cw0car10+MW[10]
 _cw0car11=_cw0car11+MW[11]
 _cw0car12=_cw0car12+MW[12]

 _cw1car1=_cw1car1+MW[21]
 _cw1car2=_cw1car2+MW[22]
 _cw1car3=_cw1car3+MW[23]
 _cw1car4=_cw1car4+MW[24]
 _cw1car5=_cw1car5+MW[25]
 _cw1car6=_cw1car6+MW[26]
 _cw1car7=_cw1car7+MW[27]
 _cw1car8=_cw1car8+MW[28]
 _cw1car9=_cw1car9+MW[29]
 _cw1car10=_cw1car10+MW[30]
 _cw1car11=_cw1car10+MW[31]
 _cw1car12=_cw1car10+MW[32]

 _cw2car1=_cw2car1+MW[41]
 _cw2car2=_cw2car2+MW[42]
 _cw2car3=_cw2car3+MW[43]
 _cw2car4=_cw2car4+MW[44]
 _cw2car5=_cw2car5+MW[45]
 _cw2car6=_cw2car6+MW[46]
 _cw2car7=_cw2car7+MW[47]
 _cw2car8=_cw2car8+MW[48]
 _cw2car9=_cw2car9+MW[49]
 _cw2car10=_cw2car10+MW[50]
 _cw2car11=_cw2car10+MW[51]
 _cw2car12=_cw2car10+MW[52]

 _md0car1=_md0car1+MW[61]
 _md0car2=_md0car2+MW[62]
 _md0car3=_md0car3+MW[63]
 _md0car4=_md0car4+MW[64]
 _md0car5=_md0car5+MW[65]
 _md0car6=_md0car6+MW[66]
 _md0car7=_md0car7+MW[67]
 _md0car8=_md0car8+MW[68]
 _md0car9=_md0car9+MW[69]
 _md0car10=_md0car10+MW[70]
 _md0car11=_md0car10+MW[71]
 _md0car12=_md0car10+MW[72]

 _md1car1=_md1car1+MW[81]
 _md1car2=_md1car2+MW[82]
 _md1car3=_md1car3+MW[83]
 _md1car4=_md1car4+MW[84]
 _md1car5=_md1car5+MW[85]
 _md1car6=_md1car6+MW[86]
 _md1car7=_md1car7+MW[87]
 _md1car8=_md1car8+MW[88]
 _md1car9=_md1car9+MW[89]
 _md1car10=_md1car10+MW[90]
 _md1car11=_md1car10+MW[91]
 _md1car12=_md1car10+MW[92]

 _md2car1=_md2car1+MW[101]
 _md2car2=_md2car2+MW[102]
 _md2car3=_md2car3+MW[103]
 _md2car4=_md2car4+MW[104]
 _md2car5=_md2car5+MW[105]
 _md2car6=_md2car6+MW[106]
 _md2car7=_md2car7+MW[107]
 _md2car8=_md2car8+MW[108]
 _md2car9=_md2car9+MW[109]
 _md2car10=_md2car10+MW[110]
 _md2car11=_md2car11+MW[111]
 _md2car12=_md2car12+MW[112]

 _nt0car1=_nt0car1+MW[121]
 _nt0car2=_nt0car2+MW[122]
 _nt0car3=_nt0car3+MW[123]
 _nt0car4=_nt0car4+MW[124]
 _nt0car5=_nt0car5+MW[125]
 _nt0car6=_nt0car6+MW[126]
 _nt0car7=_nt0car7+MW[127]
 _nt0car8=_nt0car8+MW[128]
 _nt0car9=_nt0car9+MW[129]
 _nt0car10=_nt0car10+MW[130]
 _nt0car11=_nt0car11+MW[131]
 _nt0car12=_nt0car12+MW[132]

 _nt1car1=_nt1car1+MW[141]
 _nt1car2=_nt1car2+MW[142]
 _nt1car3=_nt1car3+MW[143]
 _nt1car4=_nt1car4+MW[144]
 _nt1car5=_nt1car5+MW[145]
 _nt1car6=_nt1car6+MW[146]
 _nt1car7=_nt1car7+MW[147]
 _nt1car8=_nt1car8+MW[148]
 _nt1car9=_nt1car9+MW[149]
 _nt1car10=_nt1car10+MW[150]
 _nt1car11=_nt1car11+MW[151]
 _nt1car12=_nt1car12+MW[152]

 _nt2car1=_nt2car1+MW[161]
 _nt2car2=_nt2car2+MW[162]
 _nt2car3=_nt2car3+MW[163]
 _nt2car4=_nt2car4+MW[164]
 _nt2car5=_nt2car5+MW[165]
 _nt2car6=_nt2car6+MW[166]
 _nt2car7=_nt2car7+MW[167]
 _nt2car8=_nt2car8+MW[168]
 _nt2car9=_nt2car9+MW[169]
 _nt2car10=_nt2car10+MW[170]
 _nt2car11=_nt2car11+MW[171]
 _nt2car12=_nt2car12+MW[172]
ENDJLOOP

if(i=_zones)
 print list=_cw0car1,printo=1
 print list=_cw0car2,printo=1
 print list=_cw0car3,printo=1
 print list=_cw0car4,printo=1
 print list=_cw0car5,printo=1
 print list=_cw0car6,printo=1
 print list=_cw0car7,printo=1
 print list=_cw0car8,printo=1
 print list=_cw0car9,printo=1
 print list=_cw0car10,printo=1
 print list=_cw0car11,printo=1
 print list=_cw0car12,printo=1

 print list=_cw1car1,printo=1
 print list=_cw1car2,printo=1
 print list=_cw1car3,printo=1
 print list=_cw1car4,printo=1
 print list=_cw1car5,printo=1
 print list=_cw1car6,printo=1
 print list=_cw1car7,printo=1
 print list=_cw1car8,printo=1
 print list=_cw1car9,printo=1
 print list=_cw1car10,printo=1
 print list=_cw1car11,printo=1
 print list=_cw1car12,printo=1

 print list=_cw2car1,printo=1
 print list=_cw2car2,printo=1
 print list=_cw2car3,printo=1
 print list=_cw2car4,printo=1
 print list=_cw2car5,printo=1
 print list=_cw2car6,printo=1
 print list=_cw2car7,printo=1
 print list=_cw2car8,printo=1
 print list=_cw2car9,printo=1
 print list=_cw2car10,printo=1
 print list=_cw2car11,printo=1
 print list=_cw2car12,printo=1

 print list=_md0car1,printo=1
 print list=_md0car2,printo=1
 print list=_md0car3,printo=1
 print list=_md0car4,printo=1
 print list=_md0car5,printo=1
 print list=_md0car6,printo=1
 print list=_md0car7,printo=1
 print list=_md0car8,printo=1
 print list=_md0car9,printo=1
 print list=_md0car10,printo=1
 print list=_md0car11,printo=1
 print list=_md0car12,printo=1

 print list=_md1car1,printo=1
 print list=_md1car2,printo=1
 print list=_md1car3,printo=1
 print list=_md1car4,printo=1
 print list=_md1car5,printo=1
 print list=_md1car6,printo=1
 print list=_md1car7,printo=1
 print list=_md1car8,printo=1
 print list=_md1car9,printo=1
 print list=_md1car10,printo=1
 print list=_md1car11,printo=1
 print list=_md1car12,printo=1

 print list=_md2car1,printo=1
 print list=_md2car2,printo=1
 print list=_md2car3,printo=1
 print list=_md2car4,printo=1
 print list=_md2car5,printo=1
 print list=_md2car6,printo=1
 print list=_md2car7,printo=1
 print list=_md2car8,printo=1
 print list=_md2car9,printo=1
 print list=_md2car10,printo=1
 print list=_md2car11,printo=1
 print list=_md2car12,printo=1

 print list=_nt0car1,printo=1
 print list=_nt0car2,printo=1
 print list=_nt0car3,printo=1
 print list=_nt0car4,printo=1
 print list=_nt0car5,printo=1
 print list=_nt0car6,printo=1
 print list=_nt0car7,printo=1
 print list=_nt0car8,printo=1
 print list=_nt0car9,printo=1
 print list=_nt0car10,printo=1
 print list=_nt0car11,printo=1
 print list=_nt0car12,printo=1

 print list=_nt1car1,printo=1
 print list=_nt1car2,printo=1
 print list=_nt1car3,printo=1
 print list=_nt1car4,printo=1
 print list=_nt1car5,printo=1
 print list=_nt1car6,printo=1
 print list=_nt1car7,printo=1
 print list=_nt1car8,printo=1
 print list=_nt1car9,printo=1
 print list=_nt1car10,printo=1
 print list=_nt1car11,printo=1
 print list=_nt1car12,printo=1

 print list=_nt2car1,printo=1
 print list=_nt2car2,printo=1
 print list=_nt2car3,printo=1
 print list=_nt2car4,printo=1
 print list=_nt2car5,printo=1
 print list=_nt2car6,printo=1
 print list=_nt2car7,printo=1
 print list=_nt2car8,printo=1
 print list=_nt2car9,printo=1
 print list=_nt2car10,printo=1
 print list=_nt2car11,printo=1
 print list=_nt2car12,printo=1
endif

ENDRUN
