; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00N.PRN" MSG='New TMU Trip Generation'
FILEI DBI[1] = "C:\NERPM43\Base\INPUT\jaxemp_taz_level.dbf"
FILEI DBI[2] = "C:\NERPM43\Parameters\HBW_Arates.csv"
FILEI LOOKUPI[1] = "C:\NERPM43\Parameters\Work_Prates.csv"
FILEI LOOKUPI[2] = "C:\NERPM43\Parameters\NonWork_PRates.csv"
; header "IAP_CLASS	IAP	INCOME	AUTO	PERSON	HBSH_PRATE	HBSR_PRATE	HBO_PRATE	NHB_PRATE	HBCU_PRATE	HBSC_PRATE"
FILEI LOOKUPI[5] = "{SCENARIO_DIR}\OUTPUT\AUTOOWN_MODEL.DBF"
FILEI LOOKUPI[6] = "C:\NERPM43\Parameters\OBO_ARates.csv"
; header #1 Purpose, #2 PurposeNo, #3 Retail Trade, #4 Arts, Entertainment, and Recreation, #5 Accommodation and Food Services, #6 Educational Services, #7	Health Care and Social Assistance, #8	enrlsc - enrollment pk-12, #9	enrluniv - university, #10 TotalHH

FILEI LOOKUPI[7] = "C:\NERPM43\Base\INPUT\school_enroll.dbf"
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\TG_REPORT.TXT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\TRIPGEN_DEBUG.TXT"

FILEO RECO[1] = "{SCENARIO_DIR}\OUTPUT\PANDA_{ALT}{Year}.DBF",
    FIELDS = TAZ(4.0), 
  HBWP1(10.3), HBWP2(10.3), HBWP3(10.3), HBWP4(10.3), HBWP5(10.3),  
  HBSHP1(10.3), HBSHP2(10.3), HBSHP3(10.3), HBSHP4(10.3), HBSHP5(10.3), 
    HBSRP1(10.3), HBSRP2(10.3), HBSRP3(10.3), HBSRP4(10.3), HBSRP5(10.3),  
    HBOP1(10.3), HBOP2(10.3), HBOP3(10.3), HBOP4(10.3), HBOP5(10.3), 
    HBSCP1(10.3), HBSCP2(10.3), HBSCP3(10.3), HBSCP4(10.3),
    HBCUP1(10.3), HBCUP2(10.3), HBCUP3(10.3), HBCUP4(10.3),  
  NHBWP(10.3), NHBP(10.3), 
    HBWA1(10.3), HBWA2(10.3), HBWA3(10.3), HBWA4(10.3), HBWA5(10.3), 
  HBSHA(10.3), HBSRA(10.3), HBOA(10.3),  HBSCA(10.3), HBCUA(10.3),  
    NHBWA(10.3), NHBA(10.3)
 
PAR ZONES={zonesa}, ZONEMSG=100


; Read in lookup Work Production Rates
LOOKUP LOOKUPI=1,
       NAME=Work_PRates,
         LOOKUP[1]=1, RESULT=6,    ; Home-Based Work
         LOOKUP[2]=1, RESULT=7,    ; Non-Home-Based Work
       FAIL=0,0,0,INTERPOLATE=N


; Read in lookup Non-Work Production Rates
LOOKUP LOOKUPI=2,
       NAME=NonWork_PRates,
         LOOKUP[1]=1, RESULT=6,    ; Home-Based Shopping
         LOOKUP[2]=1, RESULT=7,    ; Home-Based Social/Recreation
         LOOKUP[3]=1, RESULT=8,    ; Home-Based Other
         LOOKUP[4]=1, RESULT=9,    ; Non-Home-Based
         LOOKUP[5]=1, RESULT=10,   ; Home-Based College/University
         LOOKUP[6]=1, RESULT=11,   ; Home-Based School
       FAIL=0,0,0,INTERPOLATE=N

; Read in lookup for employment at TAZ level
LOOKUP LOOKUPI=3,
       NAME=TAZ_Emp,
         LOOKUP[1]=TAZ, RESULT=ACCOMMODAT,
         LOOKUP[2]=TAZ, RESULT=ADMINISTRA,
         LOOKUP[3]=TAZ, RESULT=AGRICULTUR,
         LOOKUP[4]=TAZ, RESULT=ARTS,
         LOOKUP[5]=TAZ, RESULT=CONSTRUCTI,
         LOOKUP[6]=TAZ, RESULT=EDUCATIONA,
         LOOKUP[7]=TAZ, RESULT=FINANCE_AN,
         LOOKUP[8]=TAZ, RESULT=HEALTH_CAR,
         LOOKUP[9]=TAZ, RESULT=INFORMATIO,
         LOOKUP[10]=TAZ, RESULT=MANAGEMENT,
         LOOKUP[11]=TAZ, RESULT=MANUFACTUR,
         LOOKUP[12]=TAZ, RESULT=MINING,
         LOOKUP[13]=TAZ, RESULT=OTHER_SERV,
         LOOKUP[14]=TAZ, RESULT=PROFESSION,
         LOOKUP[15]=TAZ, RESULT=PUBLIC_ADM,
         LOOKUP[16]=TAZ, RESULT=REAL_ESTAT,
         LOOKUP[17]=TAZ, RESULT=RETAIL_TRA,
         LOOKUP[18]=TAZ, RESULT=TRANSPORTA,
         LOOKUP[19]=TAZ, RESULT=UTILITIES,
         LOOKUP[20]=TAZ, RESULT=WHOLESALE_,
        FAIL=0,0,0,INTERPOLATE=N


LOOKUP LOOKUPI=4,
       NAME=HBW_ARates,                 ; Home-based work trip attraction rates
         LOOKUP[1]=1, RESULT=2,         ; Accommodation and Food Services
         LOOKUP[2]=1, RESULT=3,         ; Administrative and Support and Waste Management and Remediation Services
         LOOKUP[3]=1, RESULT=4,         ; Agriculture, Forestry, Fishing and Hunting
         LOOKUP[4]=1, RESULT=5,         ; Arts, Entertainment, and Recreation
         LOOKUP[5]=1, RESULT=6,         ; Construction
         LOOKUP[6]=1, RESULT=7,         ; Educational Services
         LOOKUP[7]=1, RESULT=8,         ; Finance and Insurance
         LOOKUP[8]=1, RESULT=10,        ; Health Care and Social Assistance
         LOOKUP[9]=1, RESULT=11,        ; Information
         LOOKUP[10]=1, RESULT=12,       ; Management of Companies and Enterprises
         LOOKUP[11]=1, RESULT=9,        ; Food Manufacturing
         LOOKUP[12]=1, RESULT=13,       ; Mining, Quarrying, and Oil and Gas Extraction
         LOOKUP[13]=1, RESULT=14,       ; Other Services (except Public Administration)
         LOOKUP[14]=1, RESULT=17,       ; Professional, Scientific, and Technical Services
         LOOKUP[15]=1, RESULT=18,       ; Public Administration
         LOOKUP[16]=1, RESULT=19,       ; Real Estate and Rental and Leasing
         LOOKUP[17]=1, RESULT=20,       ; Retail Trade
         LOOKUP[18]=1, RESULT=22,       ; Transportation and Warehousing
         LOOKUP[19]=1, RESULT=23,       ; Utilities
         LOOKUP[20]=1, RESULT=24,       ; Wholesale Trade
        FAIL=0,0,0,INTERPOLATE=N
        
LOOKUP, NAME = RETAILA, LOOKUP[1]=2, RESULT=3, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = ARTSA, LOOKUP[1]=2, RESULT=4, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = ACCOMA, LOOKUP[1]=2, RESULT=5, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = EDUA, LOOKUP[1]=2, RESULT=6, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = HEALTHA, LOOKUP[1]=2, RESULT=7, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = ENRLSCA, LOOKUP[1]=2, RESULT=8, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = ENRLUNIVA, LOOKUP[1]=2, RESULT=9, INTERPOLATE=N, LIST=Y, LOOKUPI=6
LOOKUP, NAME = TOTALHHA, LOOKUP[1]=2, RESULT=10, INTERPOLATE=N, LIST=Y, LOOKUPI=6

HBSHA[1] = RETAILA(1,1)
HBSHA[2] = ARTSA(1,1)
HBSHA[3] = ACCOMA(1,1)
HBSHA[4] = EDUA(1,1)
HBSHA[5] = HEALTHA(1,1)
HBSHA[6] = ENRLSCA(1,1)
HBSHA[7] = ENRLUNIVA(1,1)
HBSHA[8] = TOTALHHA(1,1)

HBSRA[1] = RETAILA(1,2)
HBSRA[2] = ARTSA(1,2)
HBSRA[3] = ACCOMA(1,2)
HBSRA[4] = EDUA(1,2)
HBSRA[5] = HEALTHA(1,2)
HBSRA[6] = ENRLSCA(1,2)
HBSRA[7] = ENRLUNIVA(1,2)
HBSRA[8] = TOTALHHA(1,2)

HBSCA[1] = RETAILA(1,3)
HBSCA[2] = ARTSA(1,3)
HBSCA[3] = ACCOMA(1,3)
HBSCA[4] = EDUA(1,3)
HBSCA[5] = HEALTHA(1,3)
HBSCA[6] = ENRLSCA(1,3)
HBSCA[7] = ENRLUNIVA(1,3)
HBSCA[8] = TOTALHHA(1,3)

HBCUA[1] = RETAILA(1,4)
HBCUA[2] = ARTSA(1,4)
HBCUA[3] = ACCOMA(1,4)
HBCUA[4] = EDUA(1,4)
HBCUA[5] = HEALTHA(1,4)
HBCUA[6] = ENRLSCA(1,4)
HBCUA[7] = ENRLUNIVA(1,4)
HBCUA[8] = TOTALHHA(1,4)

HBOA[1] = RETAILA(1,5)
HBOA[2] = ARTSA(1,5)
HBOA[3] = ACCOMA(1,5)
HBOA[4] = EDUA(1,5)
HBOA[5] = HEALTHA(1,5)
HBOA[6] = ENRLSCA(1,5)
HBOA[7] = ENRLUNIVA(1,5)
HBOA[8] = TOTALHHA(1,5)

NHBWA[1] = RETAILA(1,6)
NHBWA[2] = ARTSA(1,6)
NHBWA[3] = ACCOMA(1,6)
NHBWA[4] = EDUA(1,6)
NHBWA[5] = HEALTHA(1,6)
NHBWA[6] = ENRLSCA(1,6)
NHBWA[7] = ENRLUNIVA(1,6)
NHBWA[8] = TOTALHHA(1,6)

NHBA[1] = RETAILA(1,7)
NHBA[2] = ARTSA(1,7)
NHBA[3] = ACCOMA(1,7)
NHBA[4] = EDUA(1,7)
NHBA[5] = HEALTHA(1,7)
NHBA[6] = ENRLSCA(1,7)
NHBA[7] = ENRLUNIVA(1,7)
NHBA[8] = TOTALHHA(1,7)

; Read in household classification

LOOKUP LOOKUPI=5, NAME=HHCLASS, LOOKUP[1]=1, RESULT=7, 
       FAIL=0,0,0,INTERPOLATE=N, LIST=N

; Read in School Enrollment

LOOKUP LOOKUPI=7, NAME=SCHOOL_ENROLL, LOOKUP[1]=TAZ, RESULT=SCHOOL,
                                      LOOKUP[2]=TAZ, RESULT=UNIVERSITY,
       FAIL=0,0,0, INTERPOLATE=N

; Define arrays

ARRAY TYPE=D HHLDS=ZONES
ARRAY TYPE=D HBWP_SPM=ZONES, HBSHP_SPM=ZONES, HBSRP_SPM=ZONES, HBOP_SPM=ZONES, NHBP_SPM=ZONES
ARRAY TYPE=D HBWA_SPM=ZONES, HBSHA=ZONES, HBSRA=ZONES, HBSCA=ZONES, HBCUA=ZONES, HBOA=ZONES, NHBA=ZONES,NHBWA=ZONES
ARRAY TYPE=D HBWTRIPS=ZONES,4,4,4
ARRAY TYPE=D HBSHTRIPS=ZONES,4,4,4
ARRAY TYPE=D HBSRTRIPS=ZONES,4,4,4
ARRAY TYPE=D HBOTRIPS=ZONES,4,4,4

ARRAY TYPE=D HBWPRODS=ZONES,5
ARRAY TYPE=D HBSHPRODS=ZONES,5
ARRAY TYPE=D HBSRPRODS=ZONES,5
ARRAY TYPE=D HBOPRODS=ZONES,5
ARRAY TYPE=D NHBWPRODS=ZONES
ARRAY TYPE=D NHBPRODS=ZONES
ARRAY TYPE=D HBSCPRODS=ZONES,4
ARRAY TYPE=D HBCUPRODS=ZONES,4

ARRAY TYPE=D HBWATTS=ZONES,5
ARRAY TYPE=D HBSHATTS=ZONES
ARRAY TYPE=D HBSRATTS=ZONES
ARRAY TYPE=D HBOATTS=ZONES
ARRAY TYPE=D NHBWATTS=ZONES
ARRAY TYPE=D NHBATTS=ZONES
ARRAY TYPE=D HBSCATTS=ZONES
ARRAY TYPE=D HBCUATTS=ZONES

ARRAY TYPE=D TOTHBWP=6, TOTHBSHP=5, TOTHBSRP=5, TOTHBOP=5, TOTHBSCP=5, TOTHBCUP=5, TOTHBWA=6


; Read Zonal data
  
    HHLDS[I]    = ZI.1.RESDHHLD


; Description of household markets
    ;  HBW
        ; 1 - C0               ;Zero Cars available in household
        ; 2 - CLWLI            ;Cars less than workers (Low Income Household)
        ; 3 - CLWHI            ;Cars less than workers (High Income Household)
        ; 4 - CGWLI            ;Cars greater than or equal to workers (Low Income Household)
        ; 5 - CGWHI            ;Cars greater than or equal to workers (High Income Household)
        
    ;  HBNW except HBCU and HBSC
        ; 1 - C0               ;Zero Cars available in household
        ; 2 - CLPLI            ;Two person, one car households (Low Income)
        ; 3 - CLPHI            ;Two person, one car households (High Income)
        ; 4 - CGPLI            ;One person one car, or two+ car household (Low Income)
        ; 5 - CGPHI            ;One person one car, or two+ car household  (High Income Household) 
        
    ;  HBCU and HBSC 
        ; 1                ; 1 Person household
        ; 2                ; 2 Person household
        ; 3                ; 3 Person household
        ; 4                ; 4+ Person household

  ;  NHBW  -- productions based on same markets as HBW
  ;  NHB   -- productions based on same markets as HBO

  ; Notes on Household Income   
    ; Low Income Household     = Income category 1, 2
    ; High Income Household    = Income category 3, 4

    

IF (I == ZONES)   ;  Start calculations at end of MATRIX implicit IZONE loop
    
   LOOP ZN=1,ZONES  
       
     ; Compute trip productions for each household class 
    
   LOOP _ii = 1,4
   
    LOOP _aa = 1,4
      
     LOOP _ww = 1,4

     IAW = (100*_ii) + (10*_aa) + _ww                ; index for work trip rate lookup functions
          
     LOOP _ss = 1,4
          
     IAP = (100*_ii) + (10*_aa) + _ss              ; index for non-work trip rate lookup functions
                    
     _recid = (_ii*1000 + _aa*100 + _ww*10 + _ss)*10000 + ZN  ; index for household classification lookup
          
     HHS = HHCLASS(1,_recid)                                  ; total households for this class
            
     HBWTRIPS[ZN][_ii][_aa][_ww]  = HBWTRIPS[ZN][_ii][_aa][_ww]  + Work_PRates(1,IAW) * HHS

     HBSHTRIPS[ZN][_ii][_aa][_ss] = HBSHTRIPS[ZN][_ii][_aa][_ss] + NonWork_PRates(1,IAP) * HHS
     HBSRTRIPS[ZN][_ii][_aa][_ss] = HBSRTRIPS[ZN][_ii][_aa][_ss] + NonWork_PRates(2,IAP) * HHS
     HBOTRIPS[ZN][_ii][_aa][_ss]  = HBOTRIPS[ZN][_ii][_aa][_ss]  + NonWork_PRates(3,IAP) * HHS

     NHBWPRODS[ZN]                = NHBWPRODS[ZN] + Work_PRates(2,IAW) * HHS
     NHBPRODS[ZN]                 = NHBPRODS[ZN] + NonWork_PRates(4,IAP) * HHS

     HBSCPRODS[ZN][_ss] = HBSCPRODS[ZN][_ss] + NonWork_PRates(6,IAP) * HHS
     HBCUPRODS[ZN][_ss] = HBCUPRODS[ZN][_ss] + NonWork_PRates(5,IAP) * HHS
          
     ; Aggregate into the household markets used in destination and mode choice (see list above);
          
          ; First for HBW
          
          IF(_aa == 1) 
              _mm = 1                                    ; zero car households
          ELSEIF(_ww > _aa)
             _mm = 1 + MIN(_ii,2)                        ; car insufficient households, by 3 income levels
          ELSE
             _mm = 3 + MIN(_ii,2)                        ; car sufficient households, by 3 income levels
          ENDIF
                    
          HBWPRODS[ZN][_mm] = HBWPRODS[ZN][_mm] + Work_PRates(1,IAW) * HHS
          
          ; Then for HBNW
          
          IF(_aa == 1) 
            _mm = 1                                     ; zero car households
          ELSEIF(_ss == 2 && _aa == 2)
             _mm = 1 + MIN(_ii,2)                        ; car insufficient households, by 3 income levels
          ELSE
              _mm = 3 + MIN(_ii,2)                        ; car sufficient households, by 3 income levels
          ENDIF

          HBSHPRODS[ZN][_mm] = HBSHPRODS[ZN][_mm] + NonWork_PRates(1,IAP) * HHS
          HBSRPRODS[ZN][_mm] = HBSRPRODS[ZN][_mm] + NonWork_PRates(2,IAP) * HHS
          HBOPRODS[ZN][_mm]  = HBOPRODS[ZN][_mm]  + NonWork_PRates(3,IAP) * HHS
          
          
          ; Now some debugging
            
          IF(ZN == {SelOrigin})
            
           IF(_ii == 1 && _ww == 1 && _aa == 1 && _ss == 1)
           PRINT LIST = "TRIP PRODUCTIONS FOR ZONE = ", ZN(5), PRINTO=1
           PRINT LIST = "------------------------------------------------------", PRINTO=1
           PRINT LIST = "INC     AUT     WRK     SIZ      HBWTRIPS  HBSHTRIPS  HBSRTRIPS   HBOTRIPS", PRINTO=1
           ENDIF
           IF(_ss == 4) PRINT LIST = " ",_ii(2), "      ", _aa(2), "      ", _ww(2), "      ",   " -", "    ", HBWTRIPS[ZN][_ii][_aa][_ww](10.4), PRINTO=1
           IF(_ww == 4) PRINT LIST = " ",_ii(2), "      ", _aa(2), "      ", " -"  , "      ", _ss(2), "    ", "           ", 
                                     HBSHTRIPS[ZN][_ii][_aa][_ss](10.4), " ", HBSRTRIPS[ZN][_ii][_aa][_ss](10.4), " ", HBOTRIPS[ZN][_ii][_aa][_ss](10.4), PRINTO=1

          ENDIF

                   ENDLOOP ; PERSONS
                ENDLOOP ; WORKERS
            ENDLOOP ;AUTOS
        ENDLOOP ; INCM  

    ; Report total productions by household market for select zone
    
    IF(ZN == {SelOrigin})

      PRINT LIST = "\n\nSUMMARY OF TRIP PRODUCTIONS FOR ZONE = ", ZN(5), PRINTO=1
      PRINT LIST = "------------------------------------------------------", PRINTO=1
      PRINT LIST = "HHLD MARKET    HBW       HBSH      HBSR       HBO      HBSC      HBCU      NHBW      NHB", PRINTO=1
        LOOP _mm = 1, 5
     IF(_mm == 1) 
     PRINT LIST = "    ",_mm(2), "    ", HBWPRODS[ZN][_mm](10.4), HBSHPRODS[ZN][_mm](10.4), HBSRPRODS[ZN][_mm](10.4),
                          HBOPRODS[ZN][_mm](10.4), HBSCPRODS[ZN][_mm](10.4), HBCUPRODS[ZN][_mm](10.4),
                          NHBWPRODS[ZN](10.4), NHBPRODS[ZN](10.4), PRINTO=1
     ELSEIF(_mm < 4)
     PRINT LIST = "    ",_mm(2), "    ", HBWPRODS[ZN][_mm](10.4), HBSHPRODS[ZN][_mm](10.4), HBSRPRODS[ZN][_mm](10.4),
                          HBOPRODS[ZN][_mm](10.4), HBSCPRODS[ZN][_mm](10.4), HBCUPRODS[ZN][_mm](10.4),
                          PRINTO=1
     ELSE
     PRINT LIST = "    ",_mm(2), "    ", HBWPRODS[ZN][_mm](10.4), HBSHPRODS[ZN][_mm](10.4), HBSRPRODS[ZN][_mm](10.4),
                          HBOPRODS[ZN][_mm](10.4), PRINTO=1
     ENDIF
        ENDLOOP
     
    ENDIF
  
  ; DONE CALCULATING RESIDENT TRIP PRODUCTIONS
  
    
        
  ; CALCULATE TRIP ATTRACTIONS
    
        LOOP _empc = 1,20
          HBWATTS[ZN][1] = HBWATTS[ZN][1] + TAZ_Emp(_empc,ZN)*HBW_ARates(_empc,1)
          HBWATTS[ZN][2] = HBWATTS[ZN][2] + TAZ_Emp(_empc,ZN)*HBW_ARates(_empc,2)
          HBWATTS[ZN][3] = HBWATTS[ZN][3] + TAZ_Emp(_empc,ZN)*HBW_ARates(_empc,3)
          HBWATTS[ZN][4] = HBWATTS[ZN][4] + TAZ_Emp(_empc,ZN)*HBW_ARates(_empc,4)
          HBWATTS[ZN][5] = HBWATTS[ZN][5] + TAZ_Emp(_empc,ZN)*HBW_ARates(_empc,5)
        ENDLOOP
        

          HBSHATTS[ZN] = HBSHATTS[ZN]+ TAZ_Emp(17,ZN)* HBSHA[1]+ TAZ_Emp(4,ZN)* HBSHA[2] + TAZ_Emp(1,ZN)* HBSHA[3]+ TAZ_Emp(6,ZN)* HBSHA[4]+ TAZ_Emp(8,ZN)* HBSHA[5]+ School_Enroll(1,ZN)* HBSHA[6]+ School_Enroll(2,ZN)* HBSHA[7] + HHLDS[ZN]* HBSHA[8]
          HBSRATTS[ZN] = HBSRATTS[ZN]+ TAZ_Emp(17,ZN)* HBSRA[1]+ TAZ_Emp(4,ZN)* HBSRA[2] + TAZ_Emp(1,ZN)* HBSRA[3]+ TAZ_Emp(6,ZN)* HBSRA[4]+ TAZ_Emp(8,ZN)* HBSRA[5]+ School_Enroll(1,ZN)* HBSRA[6]+ School_Enroll(2,ZN)* HBSRA[7] + HHLDS[ZN]* HBSRA[8]
          HBOATTS[ZN]  = HBOATTS[ZN] + TAZ_Emp(17,ZN)* HBOA[1]+ TAZ_Emp(4,ZN)* HBOA[2] + TAZ_Emp(1,ZN)* HBOA[3]+ TAZ_Emp(6,ZN)* HBOA[4]+ TAZ_Emp(8,ZN)* HBOA[5] + School_Enroll(1,ZN)* HBOA[6]+ School_Enroll(2,ZN)* HBOA[7] + HHLDS[ZN]* HBOA[8]
          HBCUATTS[ZN] = HBCUATTS[ZN]+ TAZ_Emp(17,ZN)* HBCUA[1]+ TAZ_Emp(4,ZN)* HBCUA[2] + TAZ_Emp(1,ZN)* HBCUA[3]+ TAZ_Emp(6,ZN)* HBCUA[4]+ TAZ_Emp(8,ZN)* HBCUA[5]+ School_Enroll(1,ZN)* HBCUA[6]+ School_Enroll(2,ZN)* HBCUA[7] + HHLDS[ZN]* HBCUA[8]
          HBSCATTS[ZN] = HBSCATTS[ZN]+ TAZ_Emp(17,ZN)* HBSCA[1]+ TAZ_Emp(4,ZN)* HBSCA[2] + TAZ_Emp(1,ZN)* HBSCA[3]+ TAZ_Emp(6,ZN)* HBSCA[4]+ TAZ_Emp(8,ZN)* HBSCA[5] + School_Enroll(1,ZN)* HBSCA[6]+ School_Enroll(2,ZN)* HBSCA[7] + HHLDS[ZN]* HBSCA[8]
          NHBWATTS[ZN] = NHBWATTS[ZN]+ TAZ_Emp(17,ZN)* NHBWA[1]+ TAZ_Emp(4,ZN)* NHBWA[2] + TAZ_Emp(1,ZN)* NHBWA[3]+ TAZ_Emp(6,ZN)* NHBWA[4]+ TAZ_Emp(8,ZN)* NHBWA[5] + School_Enroll(1,ZN)* NHBWA[6]+ School_Enroll(2,ZN)* NHBWA[7] + HHLDS[ZN]* NHBWA[8] 
          NHBATTS[ZN] = NHBATTS[ZN] + TAZ_Emp(17,ZN)* NHBA[1]+ TAZ_Emp(4,ZN)* NHBA[2] + TAZ_Emp(1,ZN)* NHBA[3]+ TAZ_Emp(6,ZN)* NHBA[4]+ TAZ_Emp(8,ZN)* NHBA[5]+ School_Enroll(1,ZN)* NHBA[6]+ School_Enroll(2,ZN)* NHBA[7] + HHLDS[ZN]* NHBA[8]


        

    ; COMPUTE TOTAL PRODUCTIONS AND ATTRACTIONS BY PURPOSE/MARKET
    
    LOOP _mm = 1,5
    
     TOTHBWP[_mm]  = TOTHBWP[_mm]  + HBWPRODS[ZN][_mm]
     TOTHBWP[6]    = TOTHBWP[6]    + HBWPRODS[ZN][_mm]    ; sum productions over all markets 
     TOTHBSHP[_mm] = TOTHBSHP[_mm] + HBSHPRODS[ZN][_mm]
     TOTHBSRP[_mm] = TOTHBSRP[_mm] + HBSRPRODS[ZN][_mm]
     TOTHBOP[_mm]  = TOTHBOP[_mm]  + HBOPRODS[ZN][_mm]
     TOTHBWA[_mm]  = TOTHBWA[_mm]  + HBWATTS[ZN][_mm]
     TOTHBWA[6]    = TOTHBWA[6]    + HBWATTS[ZN][_mm]     ; sum attractions over all markets
     
     IF(_mm < 5)
     TOTHBSCP[_mm] = TOTHBSCP[_mm] + HBSCPRODS[ZN][_mm]
     TOTHBSCP[5]   = TOTHBSCP[5]   + HBSCPRODS[ZN][_mm]   ; sum productions over all markets
     TOTHBCUP[_mm] = TOTHBCUP[_mm] + HBCUPRODS[ZN][_mm]
     TOTHBCUP[5]   = TOTHBCUP[5]   + HBCUPRODS[ZN][_mm]   ; sum productions over all markets
     ENDIF
     
     IF(_mm == 1)
     TOTNHBWP  = TOTNHBWP  + NHBWPRODS[ZN]
     TOTNHBP   = TOTNHBP   + NHBPRODS[ZN]
     TOTHBSHA  = TOTHBSHA  + HBSHATTS[ZN]
     TOTHBSRA  = TOTHBSRA  + HBSRATTS[ZN]
     TOTHBOA   = TOTHBOA   + HBOATTS[ZN]
     TOTHBSCA  = TOTHBSCA  + HBSCATTS[ZN]
     TOTHBCUA  = TOTHBCUA  + HBCUATTS[ZN]
     TOTNHBWA  = TOTNHBWA  + NHBWATTS[ZN]
     TOTNHBA   = TOTNHBA   + NHBATTS[ZN]

     ENDIF
     
    ENDLOOP
    
    ENDLOOP   ; (ZN=1,ZONES,  loop on zones)
  

  ; REPORT PRODUCTIONS AND ATTRACTIONS PRIOR TO TRIP BALANCING
    
  PRINT LIST = "TRIP GENERATION REPORT", PRINTO=2
  PRINT LIST = "\n\nREGIONAL TRIP PRODUCTION TOTALS PRIOR TO BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWP     HBSHP     HBSRP      HBOP     HBSCP     HBCUP     NHBWP     NHBP", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), 
                    TOTHBCUP[_mm](10.0), TOTNHBWP(10.0), TOTNHBP(10.0), PRINTO=2
    ELSEIF(_mm < 4)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), 
                    TOTHBCUP[_mm](10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP

  PRINT LIST = "\n\nREGIONAL TRIP ATTRACTION TOTALS PRIOR TO BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWA     HBSHA     HBSRA      HBOA     HBSCA     HBCUA     NHBWA     NHBA", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), TOTHBSHA(10.0), TOTHBSRA(10.0), TOTHBOA(10.0), TOTHBSCA(10.0), 
                    TOTHBCUA(10.0), TOTNHBWA(10.0), TOTNHBA(10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP

 
 ; TRIP BALANCING
 
 ; Here we balance school to attractions, and HBW, IE, and truck trips to productions
 ; Note balancing is not required when applying destination choice models, but it helps to
 ; speed convergence of the shadow price used for doubly-constraining the HBW models
 
 
 ; Calculate trip balancing factors
  
 HBWR  = TOTHBWP[6] / TOTHBWA[6]
 HBSCR = TOTHBSCA / TOTHBSCP[5]
 HBCUR = TOTHBCUA / TOTHBCUP[5]
  
 ; Apply trip balancing factors and recalculate regional totals
 
 ; first initialize region totals to zero

 LOOP _mm = 1,5
  TOTHBWA[_mm] = 0.0
  IF(_mm < 5)
   TOTHBSCP[_mm] = 0.0
   TOTHBCUP[_mm] = 0.0
  ENDIF
 ENDLOOP
 
 
 LOOP ZN = 1,ZONES

  ; Now apply and compute totals

  LOOP _mm = 1,5
  
   HBWATTS[ZN][_mm] = HBWATTS[ZN][_mm] * HBWR
   TOTHBWA[_mm] = TOTHBWA[_mm] + HBWATTS[ZN][_mm]
   
   IF(_mm < 5) 
   HBSCPRODS[ZN][_mm] = HBSCPRODS[ZN][_mm] * HBSCR
   TOTHBSCP[_mm] = TOTHBSCP[_mm] + HBSCPRODS[ZN][_mm]
   HBCUPRODS[ZN][_mm] = HBCUPRODS[ZN][_mm] * HBCUR
   TOTHBCUP[_mm] = TOTHBCUP[_mm] + HBCUPRODS[ZN][_mm]
   ENDIF
   
  ENDLOOP
  
  /*PRINT LIST = "DEBUG", PRINTO=2
  PRINT LIST = "\n\n MARKET  HBSCPRODS  HBSR  TOTHBSCA  TOTHBSCP[5] ", PRINTO=2
  LOOP _mm = 1, 3
  PRINT LIST = "    ", _mm(1), HBSCPRODS[1][_mm](10.0), HBSCR(10.0), TOTHBSCA(10.0), TOTHBSCP[5](10.0), PRINTO=2
  ENDLOOP */
  
  ; Write out the daily P&A file
  
  RO.TAZ    = ZN
  RO.HBWP1  = HBWPRODS[ZN][1]
  RO.HBWP2  = HBWPRODS[ZN][2]
  RO.HBWP3  = HBWPRODS[ZN][3]
  RO.HBWP4  = HBWPRODS[ZN][4]
  RO.HBWP5  = HBWPRODS[ZN][5]
  RO.HBSHP1 = HBSHPRODS[ZN][1]
  RO.HBSHP2 = HBSHPRODS[ZN][2]
  RO.HBSHP3 = HBSHPRODS[ZN][3]
  RO.HBSHP4 = HBSHPRODS[ZN][4]
  RO.HBSHP5 = HBSHPRODS[ZN][5]
  RO.HBSRP1 = HBSRPRODS[ZN][1]
  RO.HBSRP2 = HBSRPRODS[ZN][2]
  RO.HBSRP3 = HBSRPRODS[ZN][3]
  RO.HBSRP4 = HBSRPRODS[ZN][4]
  RO.HBSRP5 = HBSRPRODS[ZN][5]
  RO.HBOP1  = HBOPRODS[ZN][1]
  RO.HBOP2  = HBOPRODS[ZN][2]
  RO.HBOP3  = HBOPRODS[ZN][3]
  RO.HBOP4  = HBOPRODS[ZN][4]
  RO.HBOP5  = HBOPRODS[ZN][5]
  RO.HBSCP1 = HBSCPRODS[ZN][1]
  RO.HBSCP2 = HBSCPRODS[ZN][2]
  RO.HBSCP3 = HBSCPRODS[ZN][3]
  RO.HBSCP4 = HBSCPRODS[ZN][4]
  RO.HBCUP1 = HBCUPRODS[ZN][1]
  RO.HBCUP2 = HBCUPRODS[ZN][2]
  RO.HBCUP3 = HBCUPRODS[ZN][3]
  RO.HBCUP4 = HBCUPRODS[ZN][4]
  RO.NHBWP  = NHBWPRODS[ZN]
  RO.NHBP   = NHBPRODS[ZN]
  RO.HBWA1  = HBWATTS[ZN][1]
  RO.HBWA2  = HBWATTS[ZN][2]
  RO.HBWA3  = HBWATTS[ZN][3]
  RO.HBWA4  = HBWATTS[ZN][4]
  RO.HBWA5  = HBWATTS[ZN][5]
  RO.HBSHA  = HBSHATTS[ZN]
  RO.HBSRA  = HBSRATTS[ZN]
  RO.HBOA   = HBOATTS[ZN]
  RO.HBSCA  = HBSCATTS[ZN]
  RO.HBCUA  = HBCUATTS[ZN]
  RO.NHBWA  = NHBWATTS[ZN]
  RO.NHBA  = NHBATTS[ZN]
  WRITE RECO=1
 ENDLOOP         ; end ZN loop

  ; REPORT PRODUCTIONS AND ATTRACTIONS AFTER TRIP BALANCING
    
  PRINT LIST = "\n\n\nREGIONAL TRIP PRODUCTION TOTALS AFTER BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWP     HBSHP     HBSRP      HBOP     HBSCP     HBCUP     NHBWP     NHBP", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), 
                    TOTHBCUP[_mm](10.0), TOTNHBWP(10.0), TOTNHBP(10.0), PRINTO=2
    ELSEIF(_mm < 5)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), TOTHBCUP[_mm](10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP

  PRINT LIST = "\n\nREGIONAL TRIP ATTRACTION TOTALS AFTER BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWA     HBSHA     HBSRA      HBOA     HBSCA     HBCUA     NHBWA     NHBA", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), TOTHBSHA(10.0), TOTHBSRA(10.0), TOTHBOA(10.0), TOTHBSCA(10.0), 
                    TOTHBCUA(10.0), TOTNHBWA(10.0), TOTNHBA(10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP
 
ENDIF   ;(i=zones) 

ENDRUN
