; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\PFMAT00A.PRN" MSG='Create PK-OP PA Tables'
FILEI ZDATI[1] = "{SCENARIO_DIR}\OUTPUT\PANDA_{ALT}{Year}.DBF"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\Parameters\PeakFac.dbf"

FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\PEAKFAC_REPORT.TXT"
FILEO RECO[1] = "{SCENARIO_DIR}\OUTPUT\PANDA_{ALT}{Year}_PK.DBF",
    FIELDS=TAZ(4.0), 
  HBWP1(10.3), HBWP2(10.3), HBWP3(10.3), HBWP4(10.3), HBWP5(10.3), 
  HBSHP1(10.3), HBSHP2(10.3), HBSHP3(10.3), HBSHP4(10.3), HBSHP5(10.3),
    HBSRP1(10.3), HBSRP2(10.3), HBSRP3(10.3), HBSRP4(10.3), HBSRP5(10.3), 
    HBOP1(10.3), HBOP2(10.3), HBOP3(10.3), HBOP4(10.3), HBOP5(10.3),
    HBSCP1(10.3), HBSCP2(10.3), HBSCP3(10.3), HBSCP4(10.3),
    HBCUP1(10.3), HBCUP2(10.3), HBCUP3(10.3), HBCUP4(10.3),  
  NHBWP(10.3), NHBOP(10.3), 
    HBWA1(10.3), HBWA2(10.3), HBWA3(10.3), HBWA4(10.3), HBWA5(10.3), HBWA6(10.3), HBWA7(10.3),
  HBSHA(10.3), HBSRA(10.3), HBOA(10.3),  HBSCA(10.3), HBCUA(10.3),  
    NHBWA(10.3), NHBOA(10.3)

FILEO RECO[2] = "{SCENARIO_DIR}\OUTPUT\PANDA_{ALT}{Year}_OP.DBF",
    FIELDS=TAZ(4.0), 
  HBWP1(10.3), HBWP2(10.3), HBWP3(10.3), HBWP4(10.3), HBWP5(10.3), 
  HBSHP1(10.3), HBSHP2(10.3), HBSHP3(10.3), HBSHP4(10.3), HBSHP5(10.3), 
    HBSRP1(10.3), HBSRP2(10.3), HBSRP3(10.3), HBSRP4(10.3), HBSRP5(10.3), 
    HBOP1(10.3), HBOP2(10.3), HBOP3(10.3), HBOP4(10.3), HBOP5(10.3),
    HBSCP1(10.3), HBSCP2(10.3), HBSCP3(10.3), HBSCP4(10.3),
    HBCUP1(10.3), HBCUP2(10.3), HBCUP3(10.3), HBCUP4(10.3),  
  NHBWP(10.3), NHBOP(10.3), 
    HBWA1(10.3), HBWA2(10.3), HBWA3(10.3), HBWA4(10.3), HBWA5(10.3), 
  HBSHA(10.3), HBSRA(10.3), HBOA(10.3),  HBSCA(10.3), HBCUA(10.3),  
    NHBWA(10.3), NHBOA(10.3)

PAR ZONES={ZONESA} ZONEMSG=100

LOOKUP LOOKUPI=1,
       NAME=PeakFac,
         LOOKUP[1]=PID, RESULT=HBW,
         LOOKUP[2]=PID, RESULT=HBU,
         LOOKUP[3]=PID, RESULT=HBSC,
         LOOKUP[4]=PID, RESULT=HBSH,
         LOOKUP[5]=PID, RESULT=HBSR,
         LOOKUP[6]=PID, RESULT=HBO,
         LOOKUP[7]=PID, RESULT=NHBW,
         LOOKUP[8]=PID, RESULT=NHBO,
       FAIL=0,0,0,INTERPOLATE=N
; example of use: v=PeakFac(8,2)
; look for 2 in the PID field and returns the NHB value

ARRAY TYPE=D TOTHBWP  = 5,2
ARRAY TYPE=D TOTHBSHP = 5,2
ARRAY TYPE=D TOTHBSRP = 5,2
ARRAY TYPE=D TOTHBOP  = 5,2
ARRAY TYPE=D TOTHBSCP = 4,2
ARRAY TYPE=D TOTHBCUP = 4,2
ARRAY TYPE=D TOTNHBWP = 2
ARRAY TYPE=D TOTNHBOP = 2

ARRAY TYPE=D TOTHBWA  = 5,2
ARRAY TYPE=D TOTHBSHA = 2
ARRAY TYPE=D TOTHBSRA = 2
ARRAY TYPE=D TOTHBOA  = 2
ARRAY TYPE=D TOTHBSCA = 2
ARRAY TYPE=D TOTHBCUA = 2
ARRAY TYPE=D TOTNHBWA = 2
ARRAY TYPE=D TOTNHBOA = 2

ARRAY TYPE=C8 PERIOD=2
PERIOD[1] = 'PEAK'
PERIOD[2] = 'OFF-PEAK'

; Split daily productions and attractions into peak/off-peak Ps and As

 RO.TAZ=ZI.1.TAZ
  
 LOOP _tt = 1,2                           ; loop over two time periods (1=PK, 2=OP)

      ; Set output record values
   
      RO.HBWP1 = ZI.1.HBWP1 * PeakFac(1,_tt)
      RO.HBWP2 = ZI.1.HBWP2 * PeakFac(1,_tt)
      RO.HBWP3 = ZI.1.HBWP3 * PeakFac(1,_tt)
      RO.HBWP4 = ZI.1.HBWP4 * PeakFac(1,_tt)
      RO.HBWP5 = ZI.1.HBWP5 * PeakFac(1,_tt)
   
      RO.HBSHP1 = ZI.1.HBSHP1 * PeakFac(4,_tt)
      RO.HBSHP2 = ZI.1.HBSHP2 * PeakFac(4,_tt)
      RO.HBSHP3 = ZI.1.HBSHP3 * PeakFac(4,_tt)
      RO.HBSHP4 = ZI.1.HBSHP4 * PeakFac(4,_tt)
      RO.HBSHP5 = ZI.1.HBSHP5 * PeakFac(4,_tt)

      RO.HBSRP1 = ZI.1.HBSRP1 * PeakFac(5,_tt)
      RO.HBSRP2 = ZI.1.HBSRP2 * PeakFac(5,_tt)
      RO.HBSRP3 = ZI.1.HBSRP3 * PeakFac(5,_tt)
      RO.HBSRP4 = ZI.1.HBSRP4 * PeakFac(5,_tt)
      RO.HBSRP5 = ZI.1.HBSRP5 * PeakFac(5,_tt)

      RO.HBOP1 = ZI.1.HBOP1 * PeakFac(6,_tt)
      RO.HBOP2 = ZI.1.HBOP2 * PeakFac(6,_tt)
      RO.HBOP3 = ZI.1.HBOP3 * PeakFac(6,_tt)
      RO.HBOP4 = ZI.1.HBOP4 * PeakFac(6,_tt)
      RO.HBOP5 = ZI.1.HBOP5 * PeakFac(6,_tt)

      RO.HBSCP1 = ZI.1.HBSCP1 * PeakFac(3,_tt)
      RO.HBSCP2 = ZI.1.HBSCP2 * PeakFac(3,_tt)
      RO.HBSCP3 = ZI.1.HBSCP3 * PeakFac(3,_tt)
      RO.HBSCP4 = ZI.1.HBSCP4 * PeakFac(3,_tt)

      RO.HBCUP1 = ZI.1.HBCUP1 * PeakFac(2,_tt)
      RO.HBCUP2 = ZI.1.HBCUP2 * PeakFac(2,_tt)
      RO.HBCUP3 = ZI.1.HBCUP3 * PeakFac(2,_tt)
      RO.HBCUP4 = ZI.1.HBCUP4 * PeakFac(2,_tt)

      RO.NHBWP  = ZI.1.NHBWP * PeakFac(7,_tt)
      RO.NHBOP  = ZI.1.NHBOP * PeakFac(8,_tt)

      RO.HBWA1 = ZI.1.HBWA1 * PeakFac(1,_tt)
      RO.HBWA2 = ZI.1.HBWA2 * PeakFac(1,_tt)
      RO.HBWA3 = ZI.1.HBWA3 * PeakFac(1,_tt)
      RO.HBWA4 = ZI.1.HBWA4 * PeakFac(1,_tt)
      RO.HBWA5 = ZI.1.HBWA5 * PeakFac(1,_tt)

      RO.HBSHA = ZI.1.HBSHA * PeakFac(4,_tt)
      RO.HBSRA = ZI.1.HBSRA * PeakFac(5,_tt)
      RO.HBOA  = ZI.1.HBOA  * PeakFac(6,_tt)
      RO.NHBWA = ZI.1.NHBWA * PeakFac(7,_tt)
      RO.NHBOA = ZI.1.NHBOA * PeakFac(8,_tt)
      RO.HBCUA = ZI.1.HBCUA * PeakFac(2,_tt)
      RO.HBSCA = ZI.1.HBSCA * PeakFac(3,_tt)
   
   ; Track totals for reporting

   TOTHBWP[1][_tt] = TOTHBWP[1][_tt] +  ZI.1.HBWP1 * PeakFac(1,_tt)
   TOTHBWP[2][_tt] = TOTHBWP[2][_tt] +  ZI.1.HBWP2 * PeakFac(1,_tt)
   TOTHBWP[3][_tt] = TOTHBWP[3][_tt] +  ZI.1.HBWP3 * PeakFac(1,_tt)
   TOTHBWP[4][_tt] = TOTHBWP[4][_tt] +  ZI.1.HBWP4 * PeakFac(1,_tt)
   TOTHBWP[5][_tt] = TOTHBWP[5][_tt] +  ZI.1.HBWP5 * PeakFac(1,_tt)

   TOTHBSHP[1][_tt] = TOTHBSHP[1][_tt] +  ZI.1.HBSHP1 * PeakFac(4,_tt)
   TOTHBSHP[2][_tt] = TOTHBSHP[2][_tt] +  ZI.1.HBSHP2 * PeakFac(4,_tt)
   TOTHBSHP[3][_tt] = TOTHBSHP[3][_tt] +  ZI.1.HBSHP3 * PeakFac(4,_tt)
   TOTHBSHP[4][_tt] = TOTHBSHP[4][_tt] +  ZI.1.HBSHP4 * PeakFac(4,_tt)
   TOTHBSHP[5][_tt] = TOTHBSHP[5][_tt] +  ZI.1.HBSHP5 * PeakFac(4,_tt)

   TOTHBSRP[1][_tt] = TOTHBSRP[1][_tt] +  ZI.1.HBSRP1 * PeakFac(5,_tt)
   TOTHBSRP[2][_tt] = TOTHBSRP[2][_tt] +  ZI.1.HBSRP2 * PeakFac(5,_tt)
   TOTHBSRP[3][_tt] = TOTHBSRP[3][_tt] +  ZI.1.HBSRP3 * PeakFac(5,_tt)
   TOTHBSRP[4][_tt] = TOTHBSRP[4][_tt] +  ZI.1.HBSRP4 * PeakFac(5,_tt)
   TOTHBSRP[5][_tt] = TOTHBSRP[5][_tt] +  ZI.1.HBSRP5 * PeakFac(5,_tt)

   TOTHBOP[1][_tt] = TOTHBOP[1][_tt] +  ZI.1.HBOP1 * PeakFac(6,_tt)
   TOTHBOP[2][_tt] = TOTHBOP[2][_tt] +  ZI.1.HBOP2 * PeakFac(6,_tt)
   TOTHBOP[3][_tt] = TOTHBOP[3][_tt] +  ZI.1.HBOP3 * PeakFac(6,_tt)
   TOTHBOP[4][_tt] = TOTHBOP[4][_tt] +  ZI.1.HBOP4 * PeakFac(6,_tt)
   TOTHBOP[5][_tt] = TOTHBOP[5][_tt] +  ZI.1.HBOP5 * PeakFac(6,_tt)

   TOTHBSCP[1][_tt] = TOTHBSCP[1][_tt] +  ZI.1.HBSCP1 * PeakFac(3,_tt)
   TOTHBSCP[2][_tt] = TOTHBSCP[2][_tt] +  ZI.1.HBSCP2 * PeakFac(3,_tt)
   TOTHBSCP[3][_tt] = TOTHBSCP[3][_tt] +  ZI.1.HBSCP3 * PeakFac(3,_tt)
   TOTHBSCP[4][_tt] = TOTHBSCP[4][_tt] +  ZI.1.HBSCP4 * PeakFac(3,_tt)

   TOTHBCUP[1][_tt] = TOTHBCUP[1][_tt] +  ZI.1.HBCUP1 * PeakFac(2,_tt)
   TOTHBCUP[2][_tt] = TOTHBCUP[2][_tt] +  ZI.1.HBCUP2 * PeakFac(2,_tt)
   TOTHBCUP[3][_tt] = TOTHBCUP[3][_tt] +  ZI.1.HBCUP3 * PeakFac(2,_tt)
   TOTHBCUP[4][_tt] = TOTHBCUP[4][_tt] +  ZI.1.HBCUP4 * PeakFac(2,_tt)

   TOTNHBWP[_tt] = TOTNHBWP[_tt] +  ZI.1.NHBWP * PeakFac(7,_tt)
   TOTNHBOP[_tt] = TOTNHBOP[_tt]  +  ZI.1.NHBOP  * PeakFac(8,_tt)

   TOTHBWA[1][_tt] = TOTHBWA[1][_tt] +  ZI.1.HBWA1 * PeakFac(1,_tt)
   TOTHBWA[2][_tt] = TOTHBWA[2][_tt] +  ZI.1.HBWA2 * PeakFac(1,_tt)
   TOTHBWA[3][_tt] = TOTHBWA[3][_tt] +  ZI.1.HBWA3 * PeakFac(1,_tt)
   TOTHBWA[4][_tt] = TOTHBWA[4][_tt] +  ZI.1.HBWA4 * PeakFac(1,_tt)
   TOTHBWA[5][_tt] = TOTHBWA[5][_tt] +  ZI.1.HBWA5 * PeakFac(1,_tt)

   TOTHBSHA[_tt] = TOTHBSHA[_tt] +  ZI.1.HBSHA * PeakFac(4,_tt)
   TOTHBSRA[_tt] = TOTHBSRA[_tt] +  ZI.1.HBSRA * PeakFac(5,_tt)
   TOTHBOA[_tt]  = TOTHBOA[_tt]  +  ZI.1.HBOA  * PeakFac(6,_tt)
   TOTHBSCA[_tt] = TOTHBSCA[_tt] +  ZI.1.HBSCA * PeakFac(3,_tt)
   TOTHBCUA[_tt] = TOTHBCUA[_tt] +  ZI.1.HBCUA * PeakFac(2,_tt)
   TOTNHBWA[_tt] = TOTNHBWA[_tt] +  ZI.1.NHBWA * PeakFac(7,_tt)
   TOTNHBOA[_tt] = TOTNHBOA[_tt] +  ZI.1.NHBOA * PeakFac(8,_tt)
   
   
/*      RO.HBSHC0P=ZI.1.HBSHC0P*PeakFac(4_tt)
      RO.HBSHCLPLIP=ZI.1.HBSHCLPLIP*PeakFac(4_tt)
      RO.HBSHCLPMIP=ZI.1.HBSHCLPMIP*PeakFac(4_tt)
      RO.HBSHCLPHIP=ZI.1.HBSHCLPHIP*PeakFac(4_tt)
      RO.HBSHCGPLIP=ZI.1.HBSHCGPLIP*PeakFac(4_tt)
      RO.HBSHCGPMIP=ZI.1.HBSHCGPMIP*PeakFac(4_tt)
      RO.HBSHCGPHIP=ZI.1.HBSHCGPHIP*PeakFac(4_tt)
      RO.HBSRC0P=ZI.1.HBSRC0P*PeakFac(5_tt)
      RO.HBSRCLPLIP=ZI.1.HBSRCLPLIP*PeakFac(5_tt)
      RO.HBSRCLPMIP=ZI.1.HBSRCLPMIP*PeakFac(5_tt)
      RO.HBSRCLPHIP=ZI.1.HBSRCLPHIP*PeakFac(5_tt)
      RO.HBSRCGPLIP=ZI.1.HBSRCGPLIP*PeakFac(5_tt)
      RO.HBSRCGPMIP=ZI.1.HBSRCGPMIP*PeakFac(5_tt)
      RO.HBSRCGPHIP=ZI.1.HBSRCGPHIP*PeakFac(5_tt)
      RO.HBOC0P=ZI.1.HBOC0P*PeakFac(6_tt)
      RO.HBOCLPLIP=ZI.1.HBOCLPLIP*PeakFac(6_tt)
      RO.HBOCLPMIP=ZI.1.HBOCLPMIP*PeakFac(6_tt)
      RO.HBOCLPHIP=ZI.1.HBOCLPHIP*PeakFac(6_tt)
      RO.HBOCGPLIP=ZI.1.HBOCGPLIP*PeakFac(6_tt)
      RO.HBOCGPMIP=ZI.1.HBOCGPMIP*PeakFac(6_tt)
      RO.HBOCGPHIP=ZI.1.HBOCGPHIP*PeakFac(6_tt)
      RO.NHBOC0P=ZI.1.NHBOC0P*PeakFac(8_tt)
      RO.NHBOCLPLIP=ZI.1.NHBOCLPLIP*PeakFac(8_tt)
      RO.NHBOCLPMIP=ZI.1.NHBOCLPMIP*PeakFac(8_tt)
      RO.NHBOCLPHIP=ZI.1.NHBOCLPHIP*PeakFac(8_tt)
      RO.NHBOCGPLIP=ZI.1.NHBOCGPLIP*PeakFac(8_tt)
      RO.NHBOCGPMIP=ZI.1.NHBOCGPMIP*PeakFac(8_tt)
      RO.NHBOCGPHIP=ZI.1.NHBOCGPHIP*PeakFac(8_tt)
      RO.HBCUP1P=ZI.1.HBCUP1P*PeakFac(2_tt)
      RO.HBCUP2P=ZI.1.HBCUP2P*PeakFac(2_tt)
      RO.HBCUP3P=ZI.1.HBCUP3P*PeakFac(2_tt)
      RO.HBCUP4P=ZI.1.HBCUP4P*PeakFac(2_tt)
      RO.HBSCP1P=ZI.1.HBSCP1P*PeakFac(3_tt)
      RO.HBSCP2P=ZI.1.HBSCP2P*PeakFac(3_tt)
      RO.HBSCP3P=ZI.1.HBSCP3P*PeakFac(3_tt)
      RO.HBSCP4P=ZI.1.HBSCP4P*PeakFac(3_tt)
      RO.TRKTAXIP=ZI.1.TRKTAXIP*PeakFac(8_tt)
      RO.IEP=ZI.1.IEP*PeakFac(8_tt)
      
      RO.HBWI1A=ZI.1.HBWI1A*PeakFac(1_tt)
      RO.HBWI2A=ZI.1.HBWI2A*PeakFac(1_tt)
      RO.HBWI3A=ZI.1.HBWI3A*PeakFac(1_tt)
      RO.HBWI4A=ZI.1.HBWI4A*PeakFac(1_tt)
      RO.NHBWA=ZI.1.NHBWA*PeakFac(7_tt)
      RO.HBSHA=ZI.1.HBSHA*PeakFac(4_tt)
      RO.HBSRA=ZI.1.HBSRA*PeakFac(5_tt)
      RO.HBOA=ZI.1.HBOA*PeakFac(6_tt)
      RO.NHBOA=ZI.1.NHBOA*PeakFac(8_tt)
      RO.HBCUA=ZI.1.HBCUA*PeakFac(2_tt)
      RO.HBSCA=ZI.1.HBSCA*PeakFac(3_tt)
      RO.TRKTAXIA=ZI.1.TRKTAXIA*PeakFac(8_tt)
      RO.IEA=ZI.1.IEA*PeakFac(8_tt)
  */    
   IF(_tt == 1) WRITE RECO=1
   IF(_tt == 2) WRITE RECO=2

 ENDLOOP

 ; Report regional peak and off-peak trips by purpose and household market

 
 IF(I==ZONES)  ; end of record processing

  PRINT LIST = "PEAK FACTORING REPORT", PRINTO=1
 
 LOOP _tt = 1,2

  PRINT LIST = "\n\nREGIONAL ", PERIOD[_tt], " TRIP PRODUCTIONS", PRINTO=1
  PRINT LIST = "\n\n HHLD MKT     HBWP     HBSHP     HBSRP      HBOP     HBSCP     HBCUP     NHBWP     NHBOP", PRINTO=1
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm][_tt](10.0), TOTHBSHP[_mm][_tt](10.0), TOTHBSRP[_mm][_tt](10.0), TOTHBOP[_mm][_tt](10.0), TOTHBSCP[_mm][_tt](10.0), 
                    TOTHBCUP[_mm][_tt](10.0), TOTNHBWP[_tt](10.0), TOTNHBP[_tt](10.0),  PRINTO=1
    ELSEIF(_mm < 5)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm][_tt](10.0), TOTHBSHP[_mm][_tt](10.0), TOTHBSRP[_mm][_tt](10.0), TOTHBOP[_mm][_tt](10.0), TOTHBSCP[_mm][_tt](10.0), 
                    TOTHBCUP[_mm][_tt](10.0), PRINTO=1
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm][_tt](10.0), TOTHBSHP[_mm][_tt](10.0), TOTHBSRP[_mm][_tt](10.0), TOTHBOP[_mm][_tt](10.0), PRINTO=1
  ENDIF
  ENDLOOP    ; end hhld market loop

  PRINT LIST = "\n\nREGIONAL ", PERIOD[_tt], " TRIP ATTRACTIONS", PRINTO=1
  PRINT LIST = "\n\n HHLD MKT     HBWA     HBSHA     HBSRA      HBOA     HBSCA     HBCUA     NHBWA     NHBOA", PRINTO=1
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm][_tt](10.0), TOTHBSHA[_tt](10.0), TOTHBSRA[_tt](10.0), TOTHBOA[_tt](10.0), TOTHBSCA[_tt](10.0), 
                    TOTHBCUA[_tt](10.0), TOTNHBWA[_tt](10.0), TOTNHBA[_tt](10.0), PRINTO=1
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm][_tt](10.0), PRINTO=1
  ENDIF
  ENDLOOP    ; end hhld market loop

 ENDLOOP   ; end time period loop

 ENDIF

ENDRUN
