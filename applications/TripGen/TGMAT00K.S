; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00K.PRN" MSG='Auto Availability Model'
FILEI LOOKUPI[3] = "{SCENARIO_DIR}\Input\TRIPGEN\nftpo_incomebytaz2.dbf"
FILEI LOOKUPI[2] = "{Scenario_Dir}\Input\TRIPGEN\COEFF_AUTOOWN.csv"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\OUTPUT\HHClass.DBF"
FILEI ZDATI[1] = "{Scenario_Dir}\Input\TRIPGEN\ZDATA_10A.dbf"
FILEI ZDATI[5] = "{Scenario_Dir}\OUTPUT\WalkTranAcc.dbf"
FILEI ZDATI[3] = "{SCENARIO_DIR}\OUTPUT\Float_ZnData.csv",
    Z=#1,TotHhlds=#2,TotEmp=#3,FloatHhld=#4,FloatEmp=#5,MixedDen=#6,CentX=#7,CentY=#8
    ;Z=#1,Households=#2,Tot_Emp=3,Hhld_Density=4,Pop_Density=5,TotEmp_Density=6,IndEmp_Density=7,
    ;CommEmp_Density=8,ServEmp_Density=9,Mixed_Density=10
  
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\AUTOOWN_DEBUG.TXT"
FILEO RECO[1] = "{SCENARIO_DIR}\OUTPUT\AUTOOWN_MODEL.DBF",
  FIELDS = RECIDX(10), TAZ(5), INC(1), AUT(1), WRK(1), SIZE(1), HHLDS(12.4)
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\HHLDS_BY_AUTOS_TOTAL.PRN"

; READ IN THE HOUSEHOLD CLASSIFICATION
;LOOKUP, NAME = TAZID,  LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LIST=N, LOOKUPI=1
;LOOKUP, NAME = HINC,   LOOKUP[1]=1, RESULT=3, INTERPOLATE=N, LIST=N, LOOKUPI=1
;LOOKUP, NAME = HSIZ,   LOOKUP[1]=1, RESULT=4, INTERPOLATE=N, LIST=N, LOOKUPI=1
;LOOKUP, NAME = HWRK,   LOOKUP[1]=1, RESULT=5, INTERPOLATE=N, LIST=N, LOOKUPI=1
;LOOKUP, NAME = HDUT,   LOOKUP[1]=1, RESULT=6, INTERPOLATE=N, LIST=N, LOOKUPI=1
LOOKUP, NAME = HHFRAC, LOOKUP[1]=1, RESULT=7, INTERPOLATE=N, LIST=N, LOOKUPI=1

; READ IN THE MODEL COEFFICIENTS
LOOKUP, NAME = COEFFA0, LOOKUP[1]=2, RESULT=3, INTERPOLATE=N, LIST=Y, LOOKUPI=2
LOOKUP, NAME = COEFFA1, LOOKUP[1]=2, RESULT=4, INTERPOLATE=N, LIST=Y, LOOKUPI=2
LOOKUP, NAME = COEFFA2, LOOKUP[1]=2, RESULT=5, INTERPOLATE=N, LIST=Y, LOOKUPI=2
LOOKUP, NAME = COEFFA3, LOOKUP[1]=2, RESULT=6, INTERPOLATE=N, LIST=Y, LOOKUPI=2

LOOKUP LOOKUPI=3,
        NAME=HHINCOME_Lookup,
          LOOKUP[1]=HHTAZ, RESULT=HHINC_LT15,
          LOOKUP[2]=HHTAZ, RESULT=HHINC_LT25,
          LOOKUP[3]=HHTAZ, RESULT=HHINC_LT50,
          LOOKUP[4]=HHTAZ, RESULT=HHINC_LT75,
          LOOKUP[5]=HHTAZ, RESULT=HHINC_75KP,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0, FAIL[3]=0


ARRAY TYPE=D K=4, CMXD=4, CACC=4, CINC15K=4
ARRAY TYPE=D CINC=4,4
ARRAY TYPE=D CSIZ=4,4
ARRAY TYPE=D CWRK=4,4
ARRAY TYPE=D CDUT=4,2
ARRAY TYPE=4 INC_TOT=ZONES
ARRAY TYPE=D VLOW_INC=ZONES

ARRAY TYPE=D UTIL=4, EXPUTIL=4, HHSHARE=4, PRB_AUTO=4, CLASS_HH=4, TOT_HH=5,7
ARRAY TYPE=C10 CntyName=7

IF(I == 1)

; INITIALIZATION

    LOOP _aa = 1,5
      LOOP _cc = 1, 7
         TOT_HH[_aa][_cc] = 0.0
     ENDLOOP
    ENDLOOP

  CntyName[1] = 'Nasssau   '
  CntyName[2] = 'Duval     '
  CntyName[3] = 'StJones   '
  CntyName[4] = 'Clay      '
  CntyName[5] = 'Baker     '
  CntyName[6] = 'Putnam    '
  
  
  ; MODEL PARAMETERS
  
  ; Constants
    K[1]    = COEFFA0(1,1)
    K[2]    = COEFFA1(1,1)
    K[3]    = COEFFA2(1,1)
    K[4]    = COEFFA3(1,1)
  
  ; Household income coefficients
  ; CINC[auto choice, income class]
 
  CINC[1][1] = COEFFA0(1,2)
  CINC[1][2] = COEFFA0(1,3)
  CINC[1][3] = COEFFA0(1,4)
  CINC[1][4] = COEFFA0(1,5)
    
  CINC[2][1] = COEFFA1(1,2)
  CINC[2][2] = COEFFA1(1,3)
  CINC[2][3] = COEFFA1(1,4)
  CINC[2][4] = COEFFA1(1,5)
  
  CINC[3][1] = COEFFA2(1,2)
  CINC[3][2] = COEFFA2(1,3)
  CINC[3][3] = COEFFA2(1,4)
  CINC[3][4] = COEFFA2(1,5)
  
  CINC[4][1] = COEFFA3(1,2)
  CINC[4][2] = COEFFA3(1,3)
  CINC[4][3] = COEFFA3(1,4)
  CINC[4][4] = COEFFA3(1,5)

 
  ; Household size coefficients
  ; CSIZ[auto choice, household size class]
 
  CSIZ[1][1] = COEFFA0(1,6)
  CSIZ[1][2] = COEFFA0(1,7)
  CSIZ[1][3] = COEFFA0(1,8)
  CSIZ[1][4] = COEFFA0(1,9)
    
  CSIZ[2][1] = COEFFA1(1,6)
  CSIZ[2][2] = COEFFA1(1,7)
  CSIZ[2][3] = COEFFA1(1,8)
  CSIZ[2][4] = COEFFA1(1,9)
  
  CSIZ[3][1] = COEFFA2(1,6)
  CSIZ[3][2] = COEFFA2(1,7)
  CSIZ[3][3] = COEFFA2(1,8)
  CSIZ[3][4] = COEFFA2(1,9)
  
  CSIZ[4][1] = COEFFA3(1,6)
  CSIZ[4][2] = COEFFA3(1,7)
  CSIZ[4][3] = COEFFA3(1,8)
  CSIZ[4][4] = COEFFA3(1,9)


  ; Household workers coefficients
  ; CWRK[auto choice, number of workers class]
 
  CWRK[1][1] = COEFFA0(1,10)
  CWRK[1][2] = COEFFA0(1,11)
  CWRK[1][3] = COEFFA0(1,12)
  CWRK[1][4] = COEFFA0(1,13)
    
  CWRK[2][1] = COEFFA1(1,10)
  CWRK[2][2] = COEFFA1(1,11)
  CWRK[2][3] = COEFFA1(1,12)
  CWRK[2][4] = COEFFA1(1,13)
  
  CWRK[3][1] = COEFFA2(1,10)
  CWRK[3][2] = COEFFA2(1,11)
  CWRK[3][3] = COEFFA2(1,12)
  CWRK[3][4] = COEFFA2(1,13)
  
  CWRK[4][1] = COEFFA3(1,10)
  CWRK[4][2] = COEFFA3(1,11)
  CWRK[4][3] = COEFFA3(1,12)
  CWRK[4][4] = COEFFA3(1,13)


  ; Mixed density coefficients
  ; CMXD[auto choice]
 
  CMXD[1] = COEFFA0(1,14)
  CMXD[2] = COEFFA1(1,14)
  CMXD[3] = COEFFA2(1,14)
  CMXD[4] = COEFFA3(1,14)

  ; Composite accessibility coefficients
  ; CACC[auto choice]
 
  CACC[1] = COEFFA0(1,15)
  CACC[2] = COEFFA1(1,15)
  CACC[3] = COEFFA2(1,15)
  CACC[4] = COEFFA3(1,15)

  ; Very low income households coefficients
  
  CINC15K[1] = COEFFA0(1,16)
  CINC15K[2] = COEFFA1(1,16)
  CINC15K[3] = COEFFA2(1,16)
  CINC15K[4] = COEFFA3(1,16)
  
  
 ; Report coefficient values on debug output file
 
 LOOP _a = 1, 4
   IF(_a == 1) 
    PRINT LIST = '\nCOEFFICIENTS -- AUTO AVAILABILITY MODEL', PRINTO=1
    PRINT LIST = '\nCHOICE    K      INC1    INC2    INC3    INC4    SIZ1    SIZ2    SIZ3    SIZ4    WRK1    WRK2    WRK3    WRK4    DUT1    DUT2  MIXDEN  COMACC', PRINTO=1
    PRINT LIST = '--------------------------------------------------------------------------------------------------------------------------------------------------------', PRINTO=1
    ENDIF   
    PRINT LIST = 'Auto', _a(1.0), K[_a](8.4), 
                                  CINC[_a][1](8.4),CINC[_a][2](8.4),CINC[_a][3](8.4),CINC[_a][4](8.4),
                                  CSIZ[_a][1](8.4),CSIZ[_a][2](8.4),CSIZ[_a][3](8.4),CSIZ[_a][4](8.4),
                                  CWRK[_a][1](8.4),CWRK[_a][2](8.4),CWRK[_a][3](8.4),CWRK[_a][4](8.4),
                                  CDUT[_a][1](8.4),CDUT[_a][2](8.4),
                                  CMXD[_a](8.4),CACC[_a](8.4), PRINTO=1
    IF(_a == 4) PRINT LIST = '---------------------------------------------------------------------------------------------------------------------------------------------', PRINTO=1
 ENDLOOP
 
 ENDIF  ; end initialization statements

PAR ZONES={ZONESI} zonemsg=100

; TAZ 
ZN=ZI.1.ZONE

; County

_cnty = 1; ZI.1.COUNTY
;use single quote here (') not double (")
; IF(CntyFIPS == 12105) _cnty = 1      ;POLK
;IF(CntyFIPS == 12015) _cnty = 1      ;CHARLOTTE
;IF(CntyFIPS == 12021) _cnty = 2      ;COLLIER
;IF(CntyFIPS == 12027) _cnty = 3      ;DESOTO
;IF(CntyFIPS == 12043) _cnty = 4      ;GLADES
;IF(CntyFIPS == 12049) _cnty = 5      ;HARDEE
;IF(CntyFIPS == 12051) _cnty = 6      ;HENDRY
;IF(CntyFIPS == 12055) _cnty = 7      ;HIGHLANDS
;IF(CntyFIPS == 12071) _cnty = 8      ;LEE
;IF(CntyFIPS == 12081) _cnty = 9      ;MANATEE
;IF(CntyFIPS == 12093) _cnty =10      ;OKEECHOBEE
;IF(CntyFIPS == 12105) _cnty =11      ;POLK
;IF(CntyFIPS == 12115) _cnty =12      ;SARASOTA

; Total households for this TAZ
TOTHHLDS=ZI.1.RESDHHLD

; Mixed household & employment density
MIXDEN=ZI.3.MixedDen

; Composite Accessibility
COM_ACC = ZI.5.COMP_ACC

; Very low income households percentage
INC_TOT[I]=HHINCOME_LOOKUP(1,I)+HHINCOME_LOOKUP(2,I)+HHINCOME_LOOKUP(3,I)+HHINCOME_LOOKUP(4,I)+HHINCOME_LOOKUP(5,I)

IF(INC_TOT[I]>0)
  VLOW_INC[I]=HHINCOME_LOOKUP(1,I)/INC_TOT[I]
ELSE
  VLOW_INC[I]=0
ENDIF

; Compute auto availability utilities for each household class, as defined by
; the income group, number of workers, household size, and type of dwelling unit

LOOP _ii=1,4

    LOOP _ss=1,4
 
        LOOP _ww=1,4
 
         ; Initialize households for each trip generation class
         CLASS_HH[1] = 0.0
         CLASS_HH[2] = 0.0
         CLASS_HH[3] = 0.0
         CLASS_HH[4] = 0.0
         ;CLASS_HH[5] = 0.0
                    
            LOOP _dd=1,2

            ; Household classification lookup function index (Income/Persons/Workers/DUType);
                
            IPWD=1000*_ii+100*_ss+10*_ww+_dd
            _recid = IPWD*10000+ZN

            FRAC_HH=HHFRAC(1,_recid)                  ; fraction of households in this inc/size/wrk/du class

            ; Compute utility for each auto choice
    
           LOOP _a = 1,4 
        
               UTIL[_a] = K[_a]                  + 
                          CINC[_a][_ii]          +
                          CSIZ[_a][_ss]          + 
                          CWRK[_a][_ww]          +
                          CDUT[_a][_dd]          +
                          CMXD[_a] * MIXDEN      +
                          CACC[_a] * COMP_ACC    +
                          CINC15K[_a] * VLOW_INC[I]

               EXPUTIL[_a] = EXP(UTIL[_a])
        
               SUMEXPUTIL = SUMEXPUTIL + EXPUTIL[_a]
        
               ENDLOOP
         
               ; Choice probabilities
                    
               PRB_AUTO[1] =  EXPUTIL[1]/SUMEXPUTIL
               PRB_AUTO[2] =  EXPUTIL[2]/SUMEXPUTIL
               PRB_AUTO[3] =  EXPUTIL[3]/SUMEXPUTIL
               PRB_AUTO[4] =  1.0 - (PRB_AUTO[1] + PRB_AUTO[2] + PRB_AUTO[3])
               SUMEXPUTIL = 0.0

               ; Households by auto choice in each inc/size/wrk/du class
               HHSHARE[1]  =  PRB_AUTO[1] * TOTHHLDS * FRAC_HH   
               HHSHARE[2]  =  PRB_AUTO[2] * TOTHHLDS * FRAC_HH   
               HHSHARE[3]  =  PRB_AUTO[3] * TOTHHLDS * FRAC_HH   
               HHSHARE[4]  =  PRB_AUTO[4] * TOTHHLDS * FRAC_HH    

               ; Household auto choice aggregate statistics

               CLASS_HH[1] = CLASS_HH[1] + HHSHARE[1]
               CLASS_HH[2] = CLASS_HH[2] + HHSHARE[2]
               CLASS_HH[3] = CLASS_HH[3] + HHSHARE[3]
               CLASS_HH[4] = CLASS_HH[4] + HHSHARE[4]
          
               TOT_HH[1][_cnty] = TOT_HH[1][_cnty] + HHSHARE[1]
               TOT_HH[2][_cnty] = TOT_HH[2][_cnty] + HHSHARE[2]
               TOT_HH[3][_cnty] = TOT_HH[3][_cnty] + HHSHARE[3]
               TOT_HH[4][_cnty] = TOT_HH[4][_cnty] + HHSHARE[4]
                    
               TOT_HH[1][7] = TOT_HH[1][7] + HHSHARE[1]
               TOT_HH[2][7] = TOT_HH[2][7] + HHSHARE[2]
               TOT_HH[3][7] = TOT_HH[3][7] + HHSHARE[3]
               TOT_HH[4][7] = TOT_HH[4][7] + HHSHARE[4]
               TOT_HH[5][7] = TOT_HH[5][7] + HHSHARE[1] + HHSHARE[2] + HHSHARE[3] + HHSHARE[4] 

               ; Now some debugging
               IF (ZN == {SelOrigin}) 
          
                 IF(_ii==1 && _ss==1 && _ww==1 && _dd==1)
                 PRINT LIST="\n\nLOGIT MODEL RESULTS--AUTO OWNERSHIP CHOICE PROBABILITIES", PRINTO=1
                 PRINT LIST="\n\nSelect Zone                =      ", I(5.0), PRINTO=1
                 PRINT LIST='Total households this zone = ', TOTHHLDS(10.2), PRINTO=1
                 PRINT LIST='Mixed density              = ', MIXDEN(10.4), PRINTO=1
                 PRINT LIST='Composite accessibility         = ', COMP_ACC(10.4), PRINTO=1
                 ENDIF
                 PRINT LIST="\n\nHHInc=",_ii(1.0),"   HHSize=",_ss(1.0),"   HHWrkrs=",_ww(1.0),"   DUType=",_dd(1.0), PRINTO=1
                 PRINT LIST='Fraction of zonal households = ', FRAC_HH(10.8), PRINTO=1
                 PRINT LIST="UTIL A0 = ", UTIL[1](10.4), "    PRB A0 = ", PRB_AUTO[1]*100(10.2),"%", "    HHLDS A0 = ", HHSHARE[1](10.4), PRINTO=1
                 PRINT LIST="UTIL A1 = ", UTIL[2](10.4), "    PRB A1 = ", PRB_AUTO[2]*100(10.2),"%", "    HHLDS A1 = ", HHSHARE[2](10.4), PRINTO=1
                 PRINT LIST="UTIL A2 = ", UTIL[3](10.4), "    PRB A2 = ", PRB_AUTO[3]*100(10.2),"%", "    HHLDS A2 = ", HHSHARE[3](10.4), PRINTO=1
                 PRINT LIST="UTIL A3 = ", UTIL[4](10.4), "    PRB A3 = ", PRB_AUTO[4]*100(10.2),"%", "    HHLDS A3 = ", HHSHARE[4](10.4), PRINTO=1

               ENDIF

              ; Write out at the end of each dwelling unit loop to report households
              ; by the classes required in trip generation (inc/aut/wrk/hhs)
          
              LOOP _aa = 1,4
              RO.TAZ  = ZN
              RO.INC  = _ii
       RO.AUT  = _aa
       RO.WRK  = _ww
       RO.SIZE = _ss
       RO.RECIDX = (_ii*1000 + _aa*100 + _ww*10 + _ss)*10000 + ZN
              RO.HHLDS = CLASS_HH[_aa]
              IF(_dd == 2) WRITE RECO=1
              ENDLOOP
     
          ENDLOOP    ; end dwelling unit loop
        ENDLOOP     ; end of workers loop
    ENDLOOP   ; end of hh size loop
ENDLOOP   ; end of income loop


; Report aggregate model results

IF(I == ZONES)

   PRINT LIST = "AUTO OWNERSHIP MODEL RESULTS", PRINTO=2
  
   LOOP _xx = 1,7
  
   IF(_xx < 7) PRINT LIST = "\n\n County:  ", CntyName[_xx], PRINTO=2
   IF(_xx == 7) PRINT LIST = "\n\n Region Total", PRINTO=2
   
    LOOP _yy = 0,4
   
     IF(_yy < 4) PRINT LIST = "   Households,  ", _yy(1.0), " Autos =", TOT_HH[_yy+1][_xx](10.2),  PRINTO=2
     IF(_yy == 4) PRINT LIST = "   Households ", "All Autos =", TOT_HH[5][_xx](10.2),  PRINTO=2
   
   ENDLOOP

  ENDLOOP

ENDIF

ENDRUN
