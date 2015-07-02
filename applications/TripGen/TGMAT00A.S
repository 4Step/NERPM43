; Household Joint Probability Model (IPF) 
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00H.PRN" MSG='Household Joint Classification Model (IPF)'
;Output Files
FILEO PRINTO[3] = "{SCENARIO_DIR}\OUTPUT\HHCLASS_DEBUG.TXT"
FILEO RECO[2] = "{SCENARIO_DIR}\OUTPUT\HHClass.DBF",
   FIELDS=RECID(10.0),TAZ(4.0),HINC(1.0),HSIZ(1.0),HWRK(1.0),HDUT(1.0),HHFRAC(10.8)
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\HHCONVERGENCE.PRN"


;Household Seed Lookup
FILEI LOOKUPI[1] = "{CATALOG_DIR}\PARAMETERS\HHSeed.csv"
FILEI LOOKUPI[2] = "{Scenario_Dir}\Input\TRIPGEN\nftpo_incomebytaz2.dbf"
FILEI LOOKUPI[3] = "{Scenario_Dir}\Input\TRIPGEN\jacksonville_hhsize_marginals.dbf"
FILEI LOOKUPI[4] = "{Scenario_Dir}\Input\TRIPGEN\jacksonville_hhworkers_marginals.dbf"
FILEI LOOKUPI[5] = "{Scenario_Dir}\Input\TRIPGEN\abm_se_jta_1_23_13.dbf"

PAR ZONES={zonesi}, ZONEMSG=100

; Define arrays for distributions
ARRAY TYPE=D, ZD_MA=ZONES,4,4,4,2
ARRAY TYPE=D, INCM_MA=ZONES,4
ARRAY TYPE=D, HHSZ_MA=ZONES,4
ARRAY TYPE=D, WRKR_MA=ZONES,4
ARRAY TYPE=D, DU_MA=ZONES,2
ARRAY TYPE=4, TOTDU=ZONES
ARRAY ZDSKIP=4442, HHLDS=ZONES, INC_TOT=ZONES

; Read in lookup seed matrix
LOOKUP, NAME=HHSEED,
    LOOKUP[1]=1, RESULT=2,
    LOOKUP[2]=1, RESULT=3,
    LOOKUP[3]=1, RESULT=4,
    LOOKUP[4]=1, RESULT=5,
    LOOKUP[5]=1, RESULT=6,
    LOOKUP[6]=1, RESULT=7,
    LOOKUP[7]=1, RESULT=8,
    LOOKUP[8]=1, RESULT=9,
    LOOKUP[9]=1, RESULT=10,
    LOOKUP[10]=1, RESULT=11,
    LOOKUP[11]=1, RESULT=12,
    LOOKUP[12]=1, RESULT=13,
    LOOKUP[13]=1, RESULT=14,
    LOOKUP[14]=1, RESULT=15,
    LOOKUP[15]=1, RESULT=16,
    LOOKUP[16]=1, RESULT=17,
    LOOKUP[17]=1, RESULT=18,
    LOOKUP[18]=1, RESULT=19,
    LOOKUP[19]=1, RESULT=20,
    LOOKUP[20]=1, RESULT=21,
    LOOKUP[21]=1, RESULT=22,
    LOOKUP[22]=1, RESULT=23,
    LOOKUP[23]=1, RESULT=24,
    LOOKUP[24]=1, RESULT=25,
    LOOKUP[25]=1, RESULT=26,
    LOOKUP[26]=1, RESULT=27,
    LOOKUP[27]=1, RESULT=28,
    LOOKUP[28]=1, RESULT=29,
    LOOKUP[29]=1, RESULT=30,
    LOOKUP[30]=1, RESULT=31,
    LOOKUP[31]=1, RESULT=32,
    LOOKUP[32]=1, RESULT=33,
    
    INTERPOLATE=N, FAIL[1]=0, FAIL[2]=0, FAIL[3]=0, LIST=Y, LOOKUPI=1

       
 LOOKUP LOOKUPI=2,
        NAME=HHINCOME_Lookup,
          LOOKUP[1]=HHTAZ, RESULT=HHINC_LT15,
          LOOKUP[2]=HHTAZ, RESULT=HHINC_LT25,
          LOOKUP[3]=HHTAZ, RESULT=HHINC_LT50,
          LOOKUP[4]=HHTAZ, RESULT=HHINC_LT75,
          LOOKUP[5]=HHTAZ, RESULT=HHINC_75KP,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0, FAIL[3]=0
        
 LOOKUP LOOKUPI=3,
        NAME=HHSIZE_Lookup,
          LOOKUP[1]=TAZ, RESULT=HH1P,
          LOOKUP[2]=TAZ, RESULT=HH2P,
          LOOKUP[3]=TAZ, RESULT=HH3P,
          LOOKUP[4]=TAZ, RESULT=HH4P,
          LOOKUP[5]=TAZ, RESULT=HH5P,
          LOOKUP[6]=TAZ, RESULT=HH6P,
          LOOKUP[7]=TAZ, RESULT=HH7P,
          LOOKUP[8]=TAZ, RESULT=TOTHH,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0, FAIL[3]=0
        
 LOOKUP LOOKUPI=4,
        NAME=HHWORKERS_Lookup,
          LOOKUP[1]=TAZ, RESULT=WORKER0,
          LOOKUP[2]=TAZ, RESULT=WORKER1,
          LOOKUP[3]=TAZ, RESULT=WORKER2,
          LOOKUP[4]=TAZ, RESULT=WORKER3,
          LOOKUP[5]=TAZ, RESULT=HHTOT,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0, FAIL[3]=0       
        
        
 LOOKUP LOOKUPI=5,
        NAME=DU_Lookup,
          LOOKUP[1]=TAZ, RESULT=SF_UNITS,
          LOOKUP[2]=TAZ, RESULT=MF_UNITS,
          LOOKUP[3]=TAZ, RESULT=TOTAL_OCCU,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0, FAIL[3]=0 
        
 
; -------------------------------------------------------------------------------------------
;        READ IN NUMBER OF HOUSEHOLDS
; -------------------------------------------------------------------------------------------
HHLDS[I]=HHSIZE_LOOKUP(8,I)
; -------------------------------------------------------------------------------------------
;        READ IN MARGINALS FOR INCOME
; -------------------------------------------------------------------------------------------
INC_TOT[I]=HHINCOME_LOOKUP(1,I)+HHINCOME_LOOKUP(2,I)+HHINCOME_LOOKUP(3,I)+HHINCOME_LOOKUP(4,I)+HHINCOME_LOOKUP(5,I)

IF(INC_TOT[I]>0)
  INCM_MA[I][1]=(HHINCOME_LOOKUP(1,I)+HHINCOME_LOOKUP(2,I))/INC_TOT[I]
  INCM_MA[I][2]=HHINCOME_LOOKUP(3,I)/INC_TOT[I]
  INCM_MA[I][3]=HHINCOME_LOOKUP(4,I)/INC_TOT[I]
  INCM_MA[I][4]=HHINCOME_LOOKUP(5,I)/INC_TOT[I]
ELSE
  INCM_MA[I][1]=0
  INCM_MA[I][2]=0
  INCM_MA[I][3]=0
  INCM_MA[I][4]=0
ENDIF
; -------------------------------------------------------------------------------------------
;        READ IN MARGINALS FOR PERSONS
; -------------------------------------------------------------------------------------------
IF(HHSIZE_LOOKUP(8,I)>0)
  HHSZ_MA[I][1]=HHSIZE_LOOKUP(1,I)/HHSIZE_LOOKUP(8,I)
  HHSZ_MA[I][2]=HHSIZE_LOOKUP(2,I)/HHSIZE_LOOKUP(8,I)
  HHSZ_MA[I][3]=HHSIZE_LOOKUP(3,I)/HHSIZE_LOOKUP(8,I)
  HHSZ_MA[I][4]=(HHSIZE_LOOKUP(4,I)+HHSIZE_LOOKUP(5,I)+HHSIZE_LOOKUP(6,I)+HHSIZE_LOOKUP(7,I))/HHSIZE_LOOKUP(8,I)
ELSE
  HHSZ_MA[I][1]=0
  HHSZ_MA[I][2]=0
  HHSZ_MA[I][3]=0
  HHSZ_MA[I][4]=0
ENDIF
; -------------------------------------------------------------------------------------------
;        READ IN MARGINALS FOR WORKERS
; -------------------------------------------------------------------------------------------
IF(HHWORKERS_LOOKUP(5,I)>0)
  WRKR_MA[I][1]=HHWORKERS_LOOKUP(1,I)/HHWORKERS_LOOKUP(5,I)
  WRKR_MA[I][2]=HHWORKERS_LOOKUP(2,I)/HHWORKERS_LOOKUP(5,I)
  WRKR_MA[I][3]=HHWORKERS_LOOKUP(3,I)/HHWORKERS_LOOKUP(5,I)
  WRKR_MA[I][4]=HHWORKERS_LOOKUP(4,I)/HHWORKERS_LOOKUP(5,I)
ELSE
  WRKR_MA[I][1]=0
  WRKR_MA[I][2]=0
  WRKR_MA[I][3]=0
  WRKR_MA[I][4]=0
ENDIF
; -------------------------------------------------------------------------------------------
;        READ IN MARGINALS FOR DU TYPE
; -------------------------------------------------------------------------------------------

  TOTDU[I]=DU_LOOKUP(1,I)+DU_LOOKUP(2,I)
  PRINT LIST="TOT DWELLING UNITS=", TOTDU(8.0)
  IF (TOTDU[I] > 0)
    DU_MA[I][1]=ROUND(DU_LOOKUP(1,I)/TOTDU[I]*1000)/1000
    DU_MA[I][2]=ROUND(DU_LOOKUP(2,I)/TOTDU[I]*1000)/1000
  ELSE
    DU_MA[I][1]=0
    DU_MA[I][2]=0
ENDIF


; ===========================================================================================
;      PERFORM ITERATIVE PROPORTIONAL FIT (IPF) BY ZONE
; ===========================================================================================
IF (I == ZONES)  ; after reading all ZONEDATA, perform analysis

    LOOP ZN=1,ZONES  ; main loop on zones
        PRINT LIST="(TGMAT00H) Household Joint Classification Model:  Zone = ",ZN(4.0), printo=0
        IF (ZN == 1) PRINT LIST="Household Joint Classification Model (IPF) Results","\nModel Year= 20{YEAR}","\n ", printo=2
        IF (HHLDS[ZN] > 0)
            ; -------------------------------------------------------------------------------------------
            ; Reinitialize seed matrix from regional seed matrix for each zone's starting point
            LOOP INCM = 1,4    ; Income
                LOOP PERS = 1,4    ; Persons
                    LOOP WRKS = 1,4    ; Workers
                        LOOP DUTYPE = 1,2    ; Dwelling Unit Type
                            IPWD= (1000*INCM) + (100*PERS) + (10*WRKS) + DUTYPE
                            ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]=HHSEED(PERS*8 + WRKS*2 + DUTYPE - 10,INCM)
                            IF (ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]=0) ZDSKIP[IPWD]=1
              IF(ZN={SelOrigin,EditBox-INTEGER,"Select zone for IPF debugging","227"})
                                IF (INCM==1 && PERS==1 && WRKS==1 && DUTYPE==1) PRINT LIST="*****INITIAL REGIONAL SEED MATRIX*****", PRINTO=3
                                PRINT LIST="SELZONE=",ZN(4.0)," INCM=",INCM(1.0)," PERSONS=",PERS(1.0)," WORKERS=",WRKS-1(1.0)," DUTYPE=",DUTYPE(1.0),IPWD(4.0),100*ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE](10.6),"%", PRINTO=3
                            ENDIF
                        ENDLOOP ;Dwelling Unit Type
                    ENDLOOP ;Workers
                ENDLOOP ;Persons
            ENDLOOP ;Income
        
            ; -------------------------------------------------------------------------------------------
            ;        MAIN IPF LOOP BEGINS HERE
            ; -------------------------------------------------------------------------------------------
            LOOP _it=1,{HHIPFITER,ComboEdit-INTEGER,"Max number of IPF zonal Iterations","15","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20",5,20}
                ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
                ; Calculate Marginals for Seed Matrix
                SINC1 = 0, SINC2 = 0, SINC3 = 0, SINC4 = 0
                SPR1M = 0, SPR2M = 0, SPR3M = 0, SPR4M = 0
                SWK0 = 0, SWK1 = 0, SWK2 = 0, SWK3 = 0
                SDU1 = 0, SDU2 = 0 
           
                LOOP INCM=1,4
                    LOOP PERS=1,4
                        LOOP WRKS=1,4
                            LOOP DUTYPE=1,2
                                IF (INCM=1) SINC1 = SINC1 + ZD_MA[ZN][1][PERS][WRKS][DUTYPE]
                                IF (INCM=2) SINC2 = SINC2 + ZD_MA[ZN][2][PERS][WRKS][DUTYPE]
                                IF (INCM=3) SINC3 = SINC3 + ZD_MA[ZN][3][PERS][WRKS][DUTYPE]
                                IF (INCM=4) SINC4 = SINC4 + ZD_MA[ZN][4][PERS][WRKS][DUTYPE]
                                  
                                IF (PERS=1) SPR1M = SPR1M + ZD_MA[ZN][INCM][1][WRKS][DUTYPE]
                                IF (PERS=2) SPR2M = SPR2M + ZD_MA[ZN][INCM][2][WRKS][DUTYPE]
                                IF (PERS=3) SPR3M = SPR3M + ZD_MA[ZN][INCM][3][WRKS][DUTYPE]
                                IF (PERS=4) SPR4M = SPR4M + ZD_MA[ZN][INCM][4][WRKS][DUTYPE]
                                  
                                IF (WRKS=1) SWK0 = SWK0 + ZD_MA[ZN][INCM][PERS][1][DUTYPE]
                                IF (WRKS=2) SWK1 = SWK1 + ZD_MA[ZN][INCM][PERS][2][DUTYPE]
                                IF (WRKS=3) SWK2 = SWK2 + ZD_MA[ZN][INCM][PERS][3][DUTYPE]
                                IF (WRKS=4) SWK3 = SWK3 + ZD_MA[ZN][INCM][PERS][4][DUTYPE]
                      
                                IF (DUTYPE=1) SDU1 = SDU1 + ZD_MA[ZN][INCM][PERS][WRKS][1]
                                IF (DUTYPE=2) SDU2 = SDU2 + ZD_MA[ZN][INCM][PERS][WRKS][2]
                            ENDLOOP
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
        
                            
                ; calculate ratios where appropriate
                margin0=0
                IF (sinc1>0) margin0=margin0+abs(1-(INCM_MA[ZN][1]/sinc1))
                IF (sinc2>0) margin0=margin0+abs(1-(INCM_MA[ZN][2]/sinc2))
                IF (sinc3>0) margin0=margin0+abs(1-(INCM_MA[ZN][3]/sinc3))
                IF (sinc4>0) margin0=margin0+abs(1-(INCM_MA[ZN][4]/sinc4))
        
                IF (spr1m>0) margin0=margin0+abs(1-(HHSZ_MA[ZN][1]/spr1m))
                IF (spr2m>0) margin0=margin0+abs(1-(HHSZ_MA[ZN][2]/spr2m))
                IF (spr3m>0) margin0=margin0+abs(1-(HHSZ_MA[ZN][3]/spr3m))
                IF (spr4m>0) margin0=margin0+abs(1-(HHSZ_MA[ZN][4]/spr4m))
        
                IF (swk0>0) margin0=margin0+abs(1-(WRKR_MA[ZN][1]/swk0))
                IF (swk1>0) margin0=margin0+abs(1-(WRKR_MA[ZN][2]/swk1))
                IF (swk2>0) margin0=margin0+abs(1-(WRKR_MA[ZN][3]/swk2))
                IF (swk3>0) margin0=margin0+abs(1-(WRKR_MA[ZN][4]/swk3))
        
                IF (sdu1>0) margin0=margin0+abs(1-(DU_MA[ZN][1]/sdu1))
                IF (sdu2>0) margin0=margin0+abs(1-(DU_MA[ZN][2]/sdu2))
                       
    
                PRINT LIST = "TAZ = ", zn(4.0), "  MARGIN = ", margin0(12.6),{ipftol}
    
                   
                ; check for convergence
                IF (margin0<{ipftol})
                    converged=1
                    BREAK
                ELSE
                    converged=0
                ENDIF
                   
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Add Print for Diagnostics
            IF (ZN={SelOrigin}&_it<{hhipfiter})
                PRINT LIST="\n\n----------------------------------------------------------------- ",
                "\nZONE=",ZN(4.0)," IPF ITERATION=",_it(5.0),"  GRP1   GRP2   GRP3   GRP4",
                "\n  INCOME MODEL RESULTS        ",SINC1(6.4)," ",SINC2(6.4)," ",SINC3(6.4)," ",SINC4(6.4),
                "\n    TARGET VALUES             ",INCM_MA[ZN][1](6.4)," ",INCM_MA[ZN][2](6.4)," ",INCM_MA[ZN][3](6.4)," ",INCM_MA[ZN][4](6.4),
                "\n  PERSON MODEL RESULTS        ",SPR1M(6.4)," ",SPR2M(6.4)," ",SPR3M(6.4)," ",SPR4M(6.4),
                "\n    TARGET VALUES             ",HHSZ_MA[ZN][1](6.4)," ",HHSZ_MA[ZN][2](6.4)," ",HHSZ_MA[ZN][3](6.4)," ",HHSZ_MA[ZN][4](6.4),
                "\n  WORKER MODEL RESULTS        ",SWK0(6.4)," ",SWK1(6.4)," ",SWK2(6.4)," ",SWK3(6.4),
                "\n    TARGET VALUES             ",WRKR_MA[ZN][1](6.4)," ",WRKR_MA[ZN][2](6.4)," ",WRKR_MA[ZN][3](6.4)," ",WRKR_MA[ZN][4](6.4),
                "\n  DUTYPE MODEL RESULTS        ",SDU1(6.4)," ",SDU2(6.4),
                "\n    TARGET VALUES             ",DU_MA[ZN][1](6.4)," ",DU_MA[ZN][2](6.4), printo=3
            ENDIF
                   
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Perform Adjustments to Seed Values based on Joint Probabilities of Marginals
            ; Zero out any cell where the marginal is zero
    
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF (INCM_MA[ZN][1]=0) ZD_MA[ZN][1][PERS][WRKS][DUTYPE] = 0
                            IF (INCM_MA[ZN][2]=0) ZD_MA[ZN][2][PERS][WRKS][DUTYPE] = 0
                            IF (INCM_MA[ZN][3]=0) ZD_MA[ZN][3][PERS][WRKS][DUTYPE] = 0
                            IF (INCM_MA[ZN][4]=0) ZD_MA[ZN][4][PERS][WRKS][DUTYPE] = 0
                              
                            IF (HHSZ_MA[ZN][1]=0) ZD_MA[ZN][INCM][1][WRKS][DUTYPE] = 0
                            IF (HHSZ_MA[ZN][2]=0) ZD_MA[ZN][INCM][2][WRKS][DUTYPE] = 0
                            IF (HHSZ_MA[ZN][3]=0) ZD_MA[ZN][INCM][3][WRKS][DUTYPE] = 0
                            IF (HHSZ_MA[ZN][4]=0) ZD_MA[ZN][INCM][4][WRKS][DUTYPE] = 0
                              
                            IF (WRKR_MA[ZN][1]=0) ZD_MA[ZN][INCM][PERS][1][DUTYPE] = 0
                            IF (WRKR_MA[ZN][2]=0) ZD_MA[ZN][INCM][PERS][2][DUTYPE] = 0
                            IF (WRKR_MA[ZN][3]=0) ZD_MA[ZN][INCM][PERS][3][DUTYPE] = 0
                            IF (WRKR_MA[ZN][4]=0) ZD_MA[ZN][INCM][PERS][4][DUTYPE] = 0
                  
                            IF (DU_MA[ZN][1]=0) ZD_MA[ZN][INCM][PERS][WRKS][1] = 0
                            IF (DU_MA[ZN][2]=0) ZD_MA[ZN][INCM][PERS][WRKS][2] = 0
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP
                   
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; First calculate adjustment for income
        
             LOOP INCM=1,4
                 LOOP PERS=1,4
                     LOOP WRKS=1,4
                         LOOP DUTYPE=1,2
                             IF ((INCM_MA[ZN][INCM]>0) && (HHSZ_MA[ZN][PERS]>0) && (WRKR_MA[ZN][WRKS]>0) && (DU_MA[ZN][DUTYPE]>0))
                                 IF (INCM=1) ZD_MA[ZN][1][PERS][WRKS][DUTYPE] = ZD_MA[ZN][1][PERS][WRKS][DUTYPE] * INCM_MA[ZN][1] / SINC1
                                 IF (INCM=2) ZD_MA[ZN][2][PERS][WRKS][DUTYPE] = ZD_MA[ZN][2][PERS][WRKS][DUTYPE] * INCM_MA[ZN][2] / SINC2
                                 IF (INCM=3) ZD_MA[ZN][3][PERS][WRKS][DUTYPE] = ZD_MA[ZN][3][PERS][WRKS][DUTYPE] * INCM_MA[ZN][3] / SINC3
                                 IF (INCM=4) ZD_MA[ZN][4][PERS][WRKS][DUTYPE] = ZD_MA[ZN][4][PERS][WRKS][DUTYPE] * INCM_MA[ZN][4] / SINC4
                             ENDIF
                          ENDLOOP
                      ENDLOOP
                  ENDLOOP
            ENDLOOP          
        
            ;   Recalculate Marginals for Seed Matrix
    
            SINC1 = 0, SINC2 = 0, SINC3 = 0, SINC4 = 0
            SPR1M = 0, SPR2M = 0, SPR3M = 0, SPR4M = 0
            SWK0 = 0, SWK1 = 0, SWK2 = 0, SWK3 = 0
            SDU1 = 0, SDU2 = 0 
        
            LOOP INCM=1,4
               LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF (INCM=1) SINC1 = SINC1 + ZD_MA[ZN][1][PERS][WRKS][DUTYPE]
                            IF (INCM=2) SINC2 = SINC2 + ZD_MA[ZN][2][PERS][WRKS][DUTYPE]
                            IF (INCM=3) SINC3 = SINC3 + ZD_MA[ZN][3][PERS][WRKS][DUTYPE]
                            IF (INCM=4) SINC4 = SINC4 + ZD_MA[ZN][4][PERS][WRKS][DUTYPE]
                                   
                            IF (PERS=1) SPR1M = SPR1M + ZD_MA[ZN][INCM][1][WRKS][DUTYPE]
                            IF (PERS=2) SPR2M = SPR2M + ZD_MA[ZN][INCM][2][WRKS][DUTYPE]
                            IF (PERS=3) SPR3M = SPR3M + ZD_MA[ZN][INCM][3][WRKS][DUTYPE]
                            IF (PERS=4) SPR4M = SPR4M + ZD_MA[ZN][INCM][4][WRKS][DUTYPE]
                                  
                            IF (WRKS=1) SWK0 = SWK0 + ZD_MA[ZN][INCM][PERS][1][DUTYPE]
                            IF (WRKS=2) SWK1 = SWK1 + ZD_MA[ZN][INCM][PERS][2][DUTYPE]
                            IF (WRKS=3) SWK2 = SWK2 + ZD_MA[ZN][INCM][PERS][3][DUTYPE]
                            IF (WRKS=4) SWK3 = SWK3 + ZD_MA[ZN][INCM][PERS][4][DUTYPE]
                               
                            IF (DUTYPE=1) SDU1 = SDU1 + ZD_MA[ZN][INCM][PERS][WRKS][1]
                            IF (DUTYPE=2) SDU2 = SDU2 + ZD_MA[ZN][INCM][PERS][WRKS][2]
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP           
                  
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Second calculate adjustment for household size
             LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF ((INCM_MA[ZN][INCM]>0) && (HHSZ_MA[ZN][PERS]>0) && (WRKR_MA[ZN][WRKS]>0) && (DU_MA[ZN][DUTYPE]>0))
                                IF (PERS=1) ZD_MA[ZN][INCM][1][WRKS][DUTYPE] = ZD_MA[ZN][INCM][1][WRKS][DUTYPE] * HHSZ_MA[ZN][1] / SPR1M
                                IF (PERS=2) ZD_MA[ZN][INCM][2][WRKS][DUTYPE] = ZD_MA[ZN][INCM][2][WRKS][DUTYPE] * HHSZ_MA[ZN][2] / SPR2M
                                IF (PERS=3) ZD_MA[ZN][INCM][3][WRKS][DUTYPE] = ZD_MA[ZN][INCM][3][WRKS][DUTYPE] * HHSZ_MA[ZN][3] / SPR3M
                                IF (PERS=4) ZD_MA[ZN][INCM][4][WRKS][DUTYPE] = ZD_MA[ZN][INCM][4][WRKS][DUTYPE] * HHSZ_MA[ZN][4] / SPR4M
                            ENDIF
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP        
    
            ; Recalculate Marginals for Seed Matrix
            SINC1 = 0, SINC2 = 0, SINC3 = 0, SINC4 = 0
            SPR1M = 0, SPR2M = 0, SPR3M = 0, SPR4M = 0
            SWK0 = 0, SWK1 = 0, SWK2 = 0, SWK3 = 0
            SDU1 = 0, SDU2 = 0         
            
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF (INCM=1) SINC1 = SINC1 + ZD_MA[ZN][1][PERS][WRKS][DUTYPE]
                            IF (INCM=2) SINC2 = SINC2 + ZD_MA[ZN][2][PERS][WRKS][DUTYPE]
                            IF (INCM=3) SINC3 = SINC3 + ZD_MA[ZN][3][PERS][WRKS][DUTYPE]
                            IF (INCM=4) SINC4 = SINC4 + ZD_MA[ZN][4][PERS][WRKS][DUTYPE]
                               
                            IF (PERS=1) SPR1M = SPR1M + ZD_MA[ZN][INCM][1][WRKS][DUTYPE]
                            IF (PERS=2) SPR2M = SPR2M + ZD_MA[ZN][INCM][2][WRKS][DUTYPE]
                            IF (PERS=3) SPR3M = SPR3M + ZD_MA[ZN][INCM][3][WRKS][DUTYPE]
                            IF (PERS=4) SPR4M = SPR4M + ZD_MA[ZN][INCM][4][WRKS][DUTYPE]
                               
                            IF (WRKS=1) SWK0 = SWK0 + ZD_MA[ZN][INCM][PERS][1][DUTYPE]
                            IF (WRKS=2) SWK1 = SWK1 + ZD_MA[ZN][INCM][PERS][2][DUTYPE]
                            IF (WRKS=3) SWK2 = SWK2 + ZD_MA[ZN][INCM][PERS][3][DUTYPE]
                            IF (WRKS=4) SWK3 = SWK3 + ZD_MA[ZN][INCM][PERS][4][DUTYPE]
                           
                            IF (DUTYPE=1) SDU1 = SDU1 + ZD_MA[ZN][INCM][PERS][WRKS][1]
                            IF (DUTYPE=2) SDU2 = SDU2 + ZD_MA[ZN][INCM][PERS][WRKS][2]
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP           
                  
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Third calculate adjustment for workers in households
             LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF ((INCM_MA[ZN][INCM]>0) && (HHSZ_MA[ZN][PERS]>0) && (WRKR_MA[ZN][WRKS]>0) && (DU_MA[ZN][DUTYPE]>0))
                                IF (WRKS=1 && SWK0>0) ZD_MA[ZN][INCM][PERS][1][DUTYPE] = ZD_MA[ZN][INCM][PERS][1][DUTYPE] * WRKR_MA[ZN][1] / SWK0
                                IF (WRKS=2 && SWK1>0) ZD_MA[ZN][INCM][PERS][2][DUTYPE] = ZD_MA[ZN][INCM][PERS][2][DUTYPE] * WRKR_MA[ZN][2] / SWK1
                                IF (WRKS=3 && SWK2>0) ZD_MA[ZN][INCM][PERS][3][DUTYPE] = ZD_MA[ZN][INCM][PERS][3][DUTYPE] * WRKR_MA[ZN][3] / SWK2
                                IF (WRKS=4 && SWK3>0) ZD_MA[ZN][INCM][PERS][4][DUTYPE] = ZD_MA[ZN][INCM][PERS][4][DUTYPE] * WRKR_MA[ZN][4] / SWK3
                            ENDIF
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP          
                                  
            ; Recalculate Marginals for Seed Matrix
             
            SINC1 = 0, SINC2 = 0, SINC3 = 0, SINC4 = 0
            SPR1M = 0, SPR2M = 0, SPR3M = 0, SPR4M = 0
            SWK0 = 0, SWK1 = 0, SWK2 = 0, SWK3 = 0
            SDU1 = 0, SDU2 = 0  
        
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF (INCM=1) SINC1 = SINC1 + ZD_MA[ZN][1][PERS][WRKS][DUTYPE]
                            IF (INCM=2) SINC2 = SINC2 + ZD_MA[ZN][2][PERS][WRKS][DUTYPE]
                            IF (INCM=3) SINC3 = SINC3 + ZD_MA[ZN][3][PERS][WRKS][DUTYPE]
                            IF (INCM=4) SINC4 = SINC4 + ZD_MA[ZN][4][PERS][WRKS][DUTYPE]
                               
                            IF (PERS=1) SPR1M = SPR1M + ZD_MA[ZN][INCM][1][WRKS][DUTYPE]
                            IF (PERS=2) SPR2M = SPR2M + ZD_MA[ZN][INCM][2][WRKS][DUTYPE]
                            IF (PERS=3) SPR3M = SPR3M + ZD_MA[ZN][INCM][3][WRKS][DUTYPE]
                            IF (PERS=4) SPR4M = SPR4M + ZD_MA[ZN][INCM][4][WRKS][DUTYPE]
                               
                            IF (WRKS=1) SWK0 = SWK0 + ZD_MA[ZN][INCM][PERS][1][DUTYPE]
                            IF (WRKS=2) SWK1 = SWK1 + ZD_MA[ZN][INCM][PERS][2][DUTYPE]
                            IF (WRKS=3) SWK2 = SWK2 + ZD_MA[ZN][INCM][PERS][3][DUTYPE]
                            IF (WRKS=4) SWK3 = SWK3 + ZD_MA[ZN][INCM][PERS][4][DUTYPE]
                           
                            IF (DUTYPE=1) SDU1 = SDU1 + ZD_MA[ZN][INCM][PERS][WRKS][1]
                            IF (DUTYPE=2) SDU2 = SDU2 + ZD_MA[ZN][INCM][PERS][WRKS][2]
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP           
                             
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Fourth calculate adjustment for Dwelling Units
            
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF ((INCM_MA[ZN][INCM]>0) && (HHSZ_MA[ZN][PERS]>0) && (WRKR_MA[ZN][WRKS]>0) && (DU_MA[ZN][DUTYPE]>0))
                                                            IF (DUTYPE=1) ZD_MA[ZN][INCM][PERS][WRKS][1] = ZD_MA[ZN][INCM][PERS][WRKS][1] * DU_MA[ZN][1] / SDU1
                                IF (DUTYPE=2) ZD_MA[ZN][INCM][PERS][WRKS][2] = ZD_MA[ZN][INCM][PERS][WRKS][2] * DU_MA[ZN][2] / SDU2
                            ENDIF
                        ENDLOOP
                    ENDLOOP
                ENDLOOP
            ENDLOOP          
    
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Normalize the Seed Arrays on each iteration just to avoid ending up with bizarre results
            ; when the matrix is not solvable
               
            ZDTOTAL=0
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            ZDTOTAL = ZDTOTAL + ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]
                        ENDLOOP ; DUType
                    ENDLOOP ; Workers
                ENDLOOP ; Persons
            ENDLOOP ; Income
                 
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF(ZDTOTAL>0)
                              ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE] = ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]/ZDTOTAL
                            ELSE
                              ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE] = 0
                            ENDIF
                            
                        ENDLOOP ; DUType
                    ENDLOOP ; Workers
                ENDLOOP ; Persons
            ENDLOOP ; Income
               
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; On the last iteration, remove any cells with really small values
        
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IPWD= (1000*INCM) + (100*PERS) + (10*WRKS) + DUTYPE
                            IF (ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]<0.00001 & _it={HHIPFITER})
                                ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]=0.0
                            ENDIF
                        ENDLOOP ; DUType
                    ENDLOOP ; Workers
                ENDLOOP ; Persons
            ENDLOOP ; Income
        
            ; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
            ; Normalize the final written values WRT 1.0
            IF (_it={HHIPFITER})
            
            ZDTOTAL=0
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            ZDTOTAL = ZDTOTAL + ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]
                        ENDLOOP    ; DUType
                    ENDLOOP    ; Workers
                ENDLOOP    ; Persons
            ENDLOOP    ; Income
                     
            
            LOOP INCM=1,4
                LOOP PERS=1,4
                    LOOP WRKS=1,4
                        LOOP DUTYPE=1,2
                            IF(ZDTOTAL>0)
                              ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE] = ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]/ZDTOTAL
                            ELSE
                              ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE] = 0
                            ENDIF
                        ENDLOOP    ; DUType
                    ENDLOOP    ; Workers
                ENDLOOP    ; Persons
            ENDLOOP    ; Income
                 
            ENDIF    ; _it=HHIPFITER
        
        ENDLOOP    ;_it=1,HHIPFITER
      
      ;     -------------------------------------------------------------------------------------------
      ;             MAIN IPF LOOP ENDS HERE
      ;     -------------------------------------------------------------------------------------------
         
      ;  Report convergence for each zone at final iteration
   
   IF(ZN==1) PRINT LIST = "HOUSEHOLD CLASSIFICATION IPF CONVERGENCE", PRINTO=2
   PRINT LIST = "TAZ = ", ZN(4), "  MARGIN = ", margin0(8.3), "  CONVERGED [1=YES] = ", converged(1), PRINTO=2

   
      ;     -------------------------------------------------------------------------------------------
      ;           WRITE HOUSEHOLD CLASSIFICATION
      ;     -------------------------------------------------------------------------------------------
      LOOP INCM=1,4
          LOOP PERS=1,4
              LOOP WRKS=1,4
                  LOOP DUTYPE=1,2
                      IPWD= (1000*INCM) + (100*PERS) + (10*WRKS) + DUTYPE
                      IF (ZN={SelOrigin}) 
           IF(INCM==1 && PERS==1 && WRKS==1 && DUTYPE==1) PRINT LIST="\n\nHOUSEHOLD CLASSFICATION FOR SELECT ZONE", PRINTO=3
           PRINT LIST="TAZ=",ZN," INCM=",INCM(1.0)," PERSONS=",PERS(1.0)," WORKERS=",WRKS-1(1.0)," DUTYPE=",DUTYPE(1.0)," HHFRACTION=",100*ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE](10.6),"%",PRINTO=3
                      ENDIF
                      RO.RECID=IPWD*10000 + ZN
                      RO.TAZ=ZN
                      RO.HINC=INCM
                      RO.HSIZ=PERS
                      RO.HWRK=WRKS
                      RO.HDUT=DUTYPE
                      RO.HHFRAC=ZD_MA[ZN][INCM][PERS][WRKS][DUTYPE]
                    WRITE RECO=2
                  ENDLOOP
              ENDLOOP  
          ENDLOOP  
      ENDLOOP   
              
      ; more print diagnostics
      IF (ZN={SelOrigin})
          finalit=_it-1
        IF (converged=1)
          CNVRG='YES'
        ELSE
          CNVRG='NO!'
        ENDIF
        
        PRINT LIST="\n----------------------------------------------------------------- ",
        "\nZONE=",ZN(4.0)," Closure <",{ipftol}(10.8lr)," Achieved=",CNVRG," IPF ITERATION=",finalit(5.0l),
        "\n                              GRP1   GRP2   GRP3   GRP4",
        "\n  INCOME MODEL RESULTS       ",SINC1(6.4)," ",SINC2(6.4)," ",SINC3(6.4)," ",SINC4(6.4),
        "\n    TARGET VALUES            ",INCM_MA[ZN][1](6.4)," ",INCM_MA[ZN][2](6.4)," ",INCM_MA[ZN][3](6.4)," ",INCM_MA[ZN][4](6.4),
        "\n  PERSON MODEL RESULTS       ",SPR1M(6.4)," ",SPR2M(6.4)," ",SPR3M(6.4)," ",SPR4M(6.4),
        "\n    TARGET VALUES            ",HHSZ_MA[ZN][1](6.4)," ",HHSZ_MA[ZN][2](6.4)," ",HHSZ_MA[ZN][3](6.4)," ",HHSZ_MA[ZN][4](6.4),
        "\n  WORKER MODEL RESULTS       ",SWK0(6.4)," ",SWK1(6.4)," ",SWK2(6.4)," ",SWK3(6.4),
        "\n    TARGET VALUES            ",WRKR_MA[ZN][1](6.4)," ",WRKR_MA[ZN][2](6.4)," ",WRKR_MA[ZN][3](6.4)," ",WRKR_MA[ZN][4](6.4),
        "\n  DUTYPE MODEL RESULTS       ",SDU1(6.4)," ",SDU2(6.4),
        "\n    TARGET VALUES            ",DU_MA[ZN][1](6.4)," ",DU_MA[ZN][2](6.4), printo=3
      ENDIF

    ELSE           ; No households in this zone, report zero for all classes
  
      LOOP INCM=1,4
          LOOP PERS=1,4
              LOOP WRKS=1,4
                  LOOP DUTYPE=1,2
                      IPWD= (1000*INCM) + (100*PERS) + (10*WRKS) + DUTYPE
                      RO.RECID=IPWD*10000 + ZN
                      RO.TAZ=ZN
                      RO.HINC=INCM
                      RO.HSIZ=PERS
                      RO.HWRK=WRKS
                      RO.HDUT=DUTYPE
                      RO.HHFRAC=0.00
                    WRITE RECO=2
                  ENDLOOP
              ENDLOOP  
          ENDLOOP  
      ENDLOOP   
      IF (ZN={SelOrigin}) PRINT LIST="\n----------------------------------------------------------------- ",
                  "\nZONE=",ZN(4.0)," No Households in this Zone - No IPF performed", PRINTO=3

    ENDIF    ; HHLDS[ZN] equal 0
    
    ENDLOOP    ; CLOSE ZONE LOOP

ENDIF ; End Analysis

; Clear User Progress Message
;PRINT LIST="", printo=0

ENDRUN
