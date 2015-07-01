; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TRIPGEN\TGMAT00A.S"
; Household Joint Probability Model (IPF) 
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00H.PRN" MSG='Household Joint Classification Model (IPF)'
;Output Files
FILEO PRINTO[3] = "{SCENARIO_DIR}\OUTPUT\HHCLASS_DEBUG.TXT"
FILEO RECO[2] = "{SCENARIO_DIR}\OUTPUT\HHClass.DBF",
   FIELDS=RECID(10.0),TAZ(4.0),HINC(1.0),HSIZ(1.0),HWRK(1.0),HDUT(1.0),HHFRAC(10.8)
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\HHCONVERGENCE.PRN"


;Household Seed Lookup
FILEI LOOKUPI[1] = "{Scenario_Dir}\Input\TRIPGEN\HHSeed.csv"
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


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\TRIPGEN\TGNET00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGNET00A.PRN" MSG='Floating Zone Mixed Density'
FILEI LOOKUPI[1] = "{Scenario_Dir}\Input\TRIPGEN\MixedDensity.csv"
FILEI LINKI[1] = "{SCENARIO_DIR}\OUTPUT\UNLOADED.NET"
FILEI NODEI[2] = "{Scenario_Dir}\Input\TRIPGEN\ZDATA_{year}{alt}.dbf",
 RENAME=Zone-N
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\Float_ZnData.csv"


LOOKUP, NAME=MDM, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LIST=Y, LOOKUPI=1

PROCESS  PHASE=INPUT

    ARRAY _CentNum={zonesi},
        _CentX={zonesi},
        _CentY={zonesi},
        _ResHhld={zonesi},
        _TotEmp={zonesi},
        _FloatResHhld={zonesi},
        _FloatEmp={zonesi},
        _MixedDen={zonesi}

ENDPROCESS


PROCESS  PHASE=NODEMERGE  

    IF (N<={zonesi})
      
    _cnt=_cnt+1
        _FloatResHhld[_cnt]=0
        _FloatEmp[_cnt]=0
        _CentX[_cnt]=X
        _CentY[_cnt]=Y
        _ResHhld[_cnt]=RESDHHLD
        _TotEmp[_cnt]=TOT_EMP
        _regionEmp = _regionEmp + TOT_EMP
        _regionHHs = _regionHHs + RESDHHLD

  ENDIF
ENDPROCESS




PROCESS  PHASE=LINKMERGE  

    _linkcnt=_linkcnt+1
  
    ; Find zones within the half-mile buffer, accumulate count of households and employment, and
  ; then compute the mixed density for the zone
  
    IF (_linkcnt=1)

        LOOP _iTAZ=1,{zonesi}

         LOOP _jTAZ=1,{zonesi}

           ; Calculate the distance between the subject TAZ and the other TAZs
                    _dist=SQRT((_CentX[_iTAZ]-_CentX[_jTAZ])^2 +(_CentY[_iTAZ]-_CentY[_jTAZ])^2)
            
                    IF (_dist <= {UNITS}/2)  ; distance <= 0.5 mile
                 
                        ;Keep a tally of floating zone resident households 
                        _FloatResHhld[_iTAZ]=_FloatResHhld[_iTAZ]+_ResHhld[_jTAZ]
 ;                       _FloatResHhld[_TAZ]=_tmphhld

                        ;Keep a tally of floating zone employment 
                        _FloatEmp[_iTAZ]=_FloatEmp[_iTAZ]+_TotEmp[_jTAZ]
;                        _FloatEmp[_TAZ]=_tmpemp
                        
                    ENDIF   
       ENDLOOP   ; end jTAZ loop

             ; Calculate mixed density

           IF(_FloatResHhld[_iTAZ] == 0.0 || _FloatEmp[_iTAZ] == 0.0)
                _MixedDen[_iTAZ] = -5
      ELSE
                _MixedDen[_iTAZ] = MDM(1,_iTAZ)
           ENDIF

             ; Write to output file

           IF (_iTAZ==1) PRINT CSV=T LIST='TAZ','Households','Tot_Emp','FloatHHlds','FloatEmp','Mixed_Density','CentX','CentY', PRINTO=1
             PRINT CSV=T LIST=_iTAZ(5),_ResHhld[_iTAZ](7),_TotEmp[_iTAZ](7),_FloatResHHld[_iTAZ](7),_FloatEmp[_iTAZ](7),_MixedDen[_iTAZ](7.6),_CentX[_iTAZ],_CentY[_iTAZ], PRINTO=1
       
    ENDLOOP
    ENDIF

  ENDPROCESS


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TRIPGEN\TGMAT00J.S"
*del *.prj
*del *.var

; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

RUN PGM=MATRIX PRNFILE="{Scenario_Dir}\OUTPUT\TGMAT00J.PRN" MSG='Transit and Walk Accessibility'
FILEO PRINTO[1] = "{Scenario_Dir}\OUTPUT\AccCalcsDebug.TXT"

FILEO RECO[1] = "{Scenario_Dir}\OUTPUT\WalkTranAcc.dbf",
 FIELDS=TAZ(4.0),Trn_Acc(8.4),Aut_Acc(8.4),Wlk_Acc(8.4),Comp_Acc(8.4)



;Floating Zones Data
FILEI ZDATI[1] = "{Scenario_Dir}\OUTPUT\Float_ZnData.csv",
   Z=#1,TotHhlds=#2,TotEmp=#3,FloatHhld=#4,FloatEmp=#5,MixedDen=#6,CentX=#7,CentY=#8

;Congested Highway Skim
FILEI MATI[4] = "{Scenario_Dir}\OUTPUT\PRELSKIMS.MAT"

;Walk to transit skim
FILEI MATI[2] = "{Scenario_Dir}\OUTPUT\TSKIM_PK_LOCAL_Walk_{alt}{year}.MAT"

; ----------------------------------------------------------------------------------

ZONES=2494
ZONEMSG=10


; ----------------------------------------------------------------------------------

; READ IN INPUT DATA

; Walk to Transit Time

MW[1] = MI.2.4 + MI.2.5 + MI.2.6 + MI.2.7 + MI.2.8 + MI.2.9 + MI.2.10      ; in-vehicle time
MW[2] = MI.2.1 + MI.2.3 + MI.2.12 + MI.2.13                                ; out-of-vehicle time

; Auto Time
MW[9] = MI.4.3                                                            ; SOV Time

; Walk Distance
MW[10] = MI.4.2                                                            ; SOV distance


; CALCULATE ACCESSIBILITIES

ARRAY TRNACC=2494, AUTACC=2494, WLKACC=2494

JLOOP

    ; transit accessibility -- include only if there's a valid transit path
  IF(MW[1] > 0.0)  TRNACC[I] = TRNACC[I] + EXP(-0.025 * (MW[1] + 2*MW[2])) * ZI.1.TotEmp[J]

    ; Auto accessibility -- include only if there's a valid Auto path
  IF(MW[9] > 0.0)  AUTACC[I] = AUTACC[I] + EXP(-0.025 * (MW[9])) * ZI.1.TotEmp[J]

  ; walk accessibility
  WLKACC[I] = WLKACC[I] + EXP(-2.0 * MW[10]) * ZI.1.TotEmp[J]
  
  ; now some debugging
  
  IF(I == 3)
  
    IF(J==1) PRINT LIST = 'Transit Accessibility Calculations for Zone = ', I(5), printo=1
    IF(J==1) PRINT LIST = '\n JZone   TranIVTime    TranOVTime    SovTime   WalkDist     Employment', printo=1
    PRINT LIST = J(5), MW[1](10.2), '     ', MW[2](10.2), '     ', MW[9](10.2), '     ', MW[10](10.2), '     ', ZI.1.TotEmp[J], printo=1

  ENDIF
ENDJLOOP


; WRITE OUTPUT FILE

RO.TAZ=I

IF(TRNACC[I] > 0.0)
   RO.TRN_ACC = LN(TRNACC[I])
ELSE
   RO.TRN_ACC = -9.9
ENDIF

IF(AUTACC[I] > 0.0)
   RO.AUT_ACC = LN(AUTACC[I])
ELSE
   RO.AUT_ACC = -9.9
ENDIF

IF(WLKACC[I] > 0.0)
   RO.WLK_ACC = LN(WLKACC[I])
ELSE
   RO.WLK_ACC = -9.9
ENDIF

RO.COMP_ACC = RO.TRN_ACC - RO.AUT_ACC


WRITE RECO=1

; DEBUG

IF(I == 3)

  PRINT LIST = '\n\nTransit Accessibility = ',RO.TRN_ACC(10.3), printo=1
  PRINT LIST = '\n\nAuto Accessibility = ',RO.AUT_ACC(10.3), printo=1
  PRINT LIST = '\n\nComposite Accessibility = ',RO.COMP_ACC(10.3), printo=1
 PRINT LIST = '\nWalk Accessibility    = ', RO.WLK_ACC(10.3), printo=1

ENDIF


ENDRUN

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TRIPGEN\TGMAT00K.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00K.PRN" MSG='Auto Availability Model'
FILEI LOOKUPI[3] = "{SCENARIO_DIR}\Input\TRIPGEN\nftpo_incomebytaz2.dbf"
FILEI LOOKUPI[2] = "{Scenario_Dir}\Input\TRIPGEN\COEFF_AUTOOWN.csv"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\OUTPUT\HHClass.DBF"
FILEI ZDATI[1] = "{Scenario_Dir}\Input\TRIPGEN\ZDATA_{year}{alt}.dbf"
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


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TRIPGEN\TGMAT00N.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGMAT00N.PRN" MSG='New TMU Trip Generation'
FILEI LOOKUPI[4] = "{Scenario_Dir}\INPUT\TripGEN\HBW_ARates.csv"
FILEI LOOKUPI[3] = "{Scenario_Dir}\Input\TRIPGEN\jaxemp_taz_level.dbf"
FILEI LOOKUPI[1] = "{Scenario_Dir}\Input\TRIPGEN\Work_Prates.csv"
FILEI LOOKUPI[2] = "{Scenario_Dir}\Input\TRIPGEN\NonWork_PRates.csv"
; header "IAP_CLASS	IAP	INCOME	AUTO	PERSON	HBSH_PRATE	HBSR_PRATE	HBO_PRATE	NHB_PRATE	HBCU_PRATE	HBSC_PRATE"
FILEI LOOKUPI[5] = "{SCENARIO_DIR}\OUTPUT\AUTOOWN_MODEL.DBF"
FILEI LOOKUPI[6] = "{Scenario_Dir}\Input\TRIPGEN\OBO_ARates.csv"
; header #1 Purpose, #2 PurposeNo, #3 Retail Trade, #4 Arts, Entertainment, and Recreation, #5 Accommodation and Food Services, #6 Educational Services, #7	Health Care and Social Assistance, #8	enrlsc - enrollment pk-12, #9	enrluniv - university, #10 TotalHH

FILEI LOOKUPI[7] = "{Scenario_Dir}\Input\TRIPGEN\school_enroll.dbf"
FILEI ZDATI[1] = "{Scenario_Dir}\Input\TRIPGEN\ZDATA_{year}{alt}.dbf"
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
  NHBWP(10.3), NHBOP(10.3), 
    HBWA1(10.3), HBWA2(10.3), HBWA3(10.3), HBWA4(10.3), HBWA5(10.3), 
  HBSHA(10.3), HBSRA(10.3), HBOA(10.3),  HBSCA(10.3), HBCUA(10.3),  
    NHBWA(10.3), NHBOA(10.3)
 
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

NHBOA[1] = RETAILA(1,7)
NHBOA[2] = ARTSA(1,7)
NHBOA[3] = ACCOMA(1,7)
NHBOA[4] = EDUA(1,7)
NHBOA[5] = HEALTHA(1,7)
NHBOA[6] = ENRLSCA(1,7)
NHBOA[7] = ENRLUNIVA(1,7)
NHBOA[8] = TOTALHHA(1,7)

; Read in household classification

LOOKUP LOOKUPI=5, NAME=HHCLASS, LOOKUP[1]=1, RESULT=7, 
       FAIL=0,0,0,INTERPOLATE=N, LIST=N

; Read in School Enrollment

LOOKUP LOOKUPI=7, NAME=SCHOOL_ENROLL, LOOKUP[1]=TAZ, RESULT=SCHOOL,
                                      LOOKUP[2]=TAZ, RESULT=UNIVERSITY,
       FAIL=0,0,0, INTERPOLATE=N

; Define arrays

ARRAY TYPE=D HHLDS=ZONES
ARRAY TYPE=D HBWP_SPM=ZONES, HBSHP_SPM=ZONES, HBSRP_SPM=ZONES, HBOP_SPM=ZONES, NHBOP_SPM=ZONES
ARRAY TYPE=D HBWA_SPM=ZONES, HBSHA=ZONES, HBSRA=ZONES, HBSCA=ZONES, HBCUA=ZONES, HBOA=ZONES, NHBOA=ZONES,NHBWA=ZONES
ARRAY TYPE=D HBWTRIPS=ZONES,4,4,4
ARRAY TYPE=D HBSHTRIPS=ZONES,4,4,4
ARRAY TYPE=D HBSRTRIPS=ZONES,4,4,4
ARRAY TYPE=D HBOTRIPS=ZONES,4,4,4

ARRAY TYPE=D HBWPRODS=ZONES,5
ARRAY TYPE=D HBSHPRODS=ZONES,5
ARRAY TYPE=D HBSRPRODS=ZONES,5
ARRAY TYPE=D HBOPRODS=ZONES,5
ARRAY TYPE=D NHBWPRODS=ZONES
ARRAY TYPE=D NHBOPRODS=ZONES
ARRAY TYPE=D HBSCPRODS=ZONES,4
ARRAY TYPE=D HBCUPRODS=ZONES,4

ARRAY TYPE=D HBWATTS=ZONES,5
ARRAY TYPE=D HBSHATTS=ZONES
ARRAY TYPE=D HBSRATTS=ZONES
ARRAY TYPE=D HBOATTS=ZONES
ARRAY TYPE=D NHBWATTS=ZONES
ARRAY TYPE=D NHBOATTS=ZONES
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
     NHBOPRODS[ZN]                = NHBOPRODS[ZN] + NonWork_PRates(4,IAP) * HHS

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
                          NHBWPRODS[ZN](10.4), NHBOPRODS[ZN](10.4), PRINTO=1
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
          NHBOATTS[ZN] = NHBOATTS[ZN] + TAZ_Emp(17,ZN)* NHBOA[1]+ TAZ_Emp(4,ZN)* NHBOA[2] + TAZ_Emp(1,ZN)* NHBOA[3]+ TAZ_Emp(6,ZN)* NHBOA[4]+ TAZ_Emp(8,ZN)* NHBOA[5]+ School_Enroll(1,ZN)* NHBOA[6]+ School_Enroll(2,ZN)* NHBOA[7] + HHLDS[ZN]* NHBOA[8]


        

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
     TOTNHBOP   = TOTNHBOP   + NHBOPRODS[ZN]
     TOTHBSHA  = TOTHBSHA  + HBSHATTS[ZN]
     TOTHBSRA  = TOTHBSRA  + HBSRATTS[ZN]
     TOTHBOA   = TOTHBOA   + HBOATTS[ZN]
     TOTHBSCA  = TOTHBSCA  + HBSCATTS[ZN]
     TOTHBCUA  = TOTHBCUA  + HBCUATTS[ZN]
     TOTNHBWA  = TOTNHBWA  + NHBWATTS[ZN]
     TOTNHBOA  = TOTNHBOA  + NHBOATTS[ZN]

     ENDIF
     
    ENDLOOP
    
    ENDLOOP   ; (ZN=1,ZONES,  loop on zones)
  

  ; REPORT PRODUCTIONS AND ATTRACTIONS PRIOR TO TRIP BALANCING
    
  PRINT LIST = "TRIP GENERATION REPORT", PRINTO=2
  PRINT LIST = "\n\nREGIONAL TRIP PRODUCTION TOTALS PRIOR TO BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWP     HBSHP     HBSRP      HBOP     HBSCP     HBCUP     NHBWP     NHBOP", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), 
                    TOTHBCUP[_mm](10.0), TOTNHBWP(10.0), TOTNHBOP(10.0), PRINTO=2
    ELSEIF(_mm < 4)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), 
                    TOTHBCUP[_mm](10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP

  PRINT LIST = "\n\nREGIONAL TRIP ATTRACTION TOTALS PRIOR TO BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWA     HBSHA     HBSRA      HBOA     HBSCA     HBCUA     NHBWA     NHBOA", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), TOTHBSHA(10.0), TOTHBSRA(10.0), TOTHBOA(10.0), TOTHBSCA(10.0), 
                    TOTHBCUA(10.0), TOTNHBWA(10.0), TOTNHBOA(10.0), PRINTO=2
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
  RO.NHBOP  = NHBOPRODS[ZN]
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
  RO.NHBOA  = NHBOATTS[ZN]
  WRITE RECO=1
 ENDLOOP         ; end ZN loop

  ; REPORT PRODUCTIONS AND ATTRACTIONS AFTER TRIP BALANCING
    
  PRINT LIST = "\n\n\nREGIONAL TRIP PRODUCTION TOTALS AFTER BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWP     HBSHP     HBSRP      HBOP     HBSCP     HBCUP     NHBWP     NHBOP", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), 
                    TOTHBCUP[_mm](10.0), TOTNHBWP(10.0), TOTNHBOP(10.0), PRINTO=2
    ELSEIF(_mm < 5)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), TOTHBSCP[_mm](10.0), TOTHBCUP[_mm](10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWP[_mm](10.0), TOTHBSHP[_mm](10.0), TOTHBSRP[_mm](10.0), TOTHBOP[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP

  PRINT LIST = "\n\nREGIONAL TRIP ATTRACTION TOTALS AFTER BALANCING", PRINTO=2
  PRINT LIST = "\n\n HHLD MKT     HBWA     HBSHA     HBSRA      HBOA     HBSCA     HBCUA     NHBWA     NHBOA", PRINTO=2
  LOOP _mm = 1, 5
    IF(_mm == 1)
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), TOTHBSHA(10.0), TOTHBSRA(10.0), TOTHBOA(10.0), TOTHBSCA(10.0), 
                    TOTHBCUA(10.0), TOTNHBWA(10.0), TOTNHBOA(10.0), PRINTO=2
  ELSE
  PRINT LIST = "    ", _mm(1), "   ", TOTHBWA[_mm](10.0), PRINTO=2
  ENDIF
  ENDLOOP
 
ENDIF   ;(i=zones) 

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*echo  Trip Generation Complete          = %date%  %time% >>{SCENARIO_DIR}\Output\runtime.prn
PRINT LIST="Trip Generation Complete", PRINTO=0
SLEEP TIME = 5
; End of PILOT Script

