; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\WARMSTART\GNMAT00F.PRN" MSG='Develop County Level TG Summaries'
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\GEN_SUM_By_County.PRN"
FILEI ZDATI[2] = "{SCENARIO_DIR}\output\PANDA.DBF"
FILEI ZDATI[1] = "{SCENARIO_DIR}\output\SelectedZdata.DBF"
FILEO RECO[1] = "{SCENARIO_DIR}\output\ZD_PA_Smry.DBF",
   FIELDS= TAZ,DESCR,COUNTY,TOTALDUS,TOTALDUS3,HHOCCU,HHTGOCC,POPTOT,ALLPOP,TOTEMP,
           PTOTAL,ATOTAL,HBW_Prod,HBW_Attr,IITRIP_P,IITRIP_A


PAR ZONES={ZONESA} ZONEMSG=100


;LOOKUP, NAME=TERM, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LOOKUPI=1, FAIL=0

;N=ZI.1.TAZ


TAZ=ZI.1.TAZ
DESCR=ZI.1.DESCR
COUNTY=ZI.1.COUNTY
TOTALDUS=ZI.1.TOTALDUS
TOTALDUS3=ZI.1.TOTALDUS3
HHOCCU=ZI.1.HHOCCU
HHTGOCC=ZI.1.HHTGOCC
POPTOT=ZI.1.POPTOT
ALLPOP=ZI.1.ALLPOP
TOTEMP=ZI.1.TOTEMP

PTOTAL=ZI.2.HBWKP+ZI.2.HBSHP+ZI.2.HBSRP+ZI.2.HBOTP+ZI.2.NHBSP+ZI.2.LTRKP+ZI.2.MTRKP+ZI.2.HTRKP+ZI.2.SOIEP+ZI.2.HOIEP+ZI.2.LDIEP+ZI.2.HDIEP

ATOTAL=ZI.2.HBWKA+ZI.2.HBSHA+ZI.2.HBSRA+ZI.2.HBOTA+ZI.2.NHBSA+ZI.2.LTRKA+ZI.2.MTRKA+ZI.2.HTRKA+ZI.2.SOIEA+ZI.2.HOIEA+ZI.2.LDIEA+ZI.2.HDIEA

HBW_Prod=ZI.2.HBWKP
HBW_Attr=ZI.2.HBWKA

IITRIP_P=ZI.2.HBWKP+ZI.2.HBSHP+ZI.2.HBSRP+ZI.2.HBOTP+ZI.2.NHBSP+ZI.2.LTRKP+ZI.2.MTRKP+ZI.2.HTRKP
IITRIP_A=ZI.2.HBWKA+ZI.2.HBSHA+ZI.2.HBSRA+ZI.2.HBOTA+ZI.2.NHBSA+ZI.2.LTRKA+ZI.2.MTRKA+ZI.2.HTRKA

;Gather County Level Total Values

if (COUNTY=1)          ;Nassau

    TOTALDUS_C1=TOTALDUS_C1+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C1=TOTALDUS3_C1+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C1=HHOCCU_C1+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C1=HHTGOCC_C1+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C1=POPTOT_C1+POPTOT                   ;Permanent Population
    ALLPOP_C1=ALLPOP_C1+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C1=TOTEMP_C1+TOTEMP                   ;Total employment

    PTOTAL_C1=PTOTAL_C1+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C1=ATOTAL_C1+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C1=HBW_Prod_C1+HBW_Prod             ;HBW prod total 
    HBW_Attr_C1=HBW_Attr_C1+HBW_Attr             ;HBW attr total  
    IITRIP_P_C1=IITRIP_P_C1+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C1=IITRIP_A_C1+IITRIP_A             ;Internal Purps (1-8) attr total
  
 elseif (COUNTY=2)     ;Duval

    TOTALDUS_C2=TOTALDUS_C2+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C2=TOTALDUS3_C2+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C2=HHOCCU_C2+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C2=HHTGOCC_C2+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C2=POPTOT_C2+POPTOT                   ;Permanent Population
    ALLPOP_C2=ALLPOP_C2+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C2=TOTEMP_C2+TOTEMP                   ;Total employment

    PTOTAL_C2=PTOTAL_C2+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C2=ATOTAL_C2+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C2=HBW_Prod_C2+HBW_Prod             ;HBW prod total 
    HBW_Attr_C2=HBW_Attr_C2+HBW_Attr             ;HBW attr total  
    IITRIP_P_C2=IITRIP_P_C2+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C2=IITRIP_A_C2+IITRIP_A             ;Internal Purps (1-8) attr total

 elseif (COUNTY=3)     ;St. Johns

    TOTALDUS_C3=TOTALDUS_C3+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C3=TOTALDUS3_C3+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C3=HHOCCU_C3+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C3=HHTGOCC_C3+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C3=POPTOT_C3+POPTOT                   ;Permanent Population
    ALLPOP_C3=ALLPOP_C3+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C3=TOTEMP_C3+TOTEMP                   ;Total employment

    PTOTAL_C3=PTOTAL_C3+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C3=ATOTAL_C3+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C3=HBW_Prod_C3+HBW_Prod             ;HBW prod total 
    HBW_Attr_C3=HBW_Attr_C3+HBW_Attr             ;HBW attr total  
    IITRIP_P_C3=IITRIP_P_C3+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C3=IITRIP_A_C3+IITRIP_A             ;Internal Purps (1-8) attr total

 elseif (COUNTY=4)     ;Clay

    TOTALDUS_C4=TOTALDUS_C4+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C4=TOTALDUS3_C4+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C4=HHOCCU_C4+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C4=HHTGOCC_C4+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C4=POPTOT_C4+POPTOT                   ;Permanent Population
    ALLPOP_C4=ALLPOP_C4+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C4=TOTEMP_C4+TOTEMP                   ;Total employment

    PTOTAL_C4=PTOTAL_C4+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C4=ATOTAL_C4+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C4=HBW_Prod_C4+HBW_Prod             ;HBW prod total 
    HBW_Attr_C4=HBW_Attr_C4+HBW_Attr             ;HBW attr total  
    IITRIP_P_C4=IITRIP_P_C4+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C4=IITRIP_A_C4+IITRIP_A             ;Internal Purps (1-8) attr total

 elseif (COUNTY=5)     ;Baker

    TOTALDUS_C5=TOTALDUS_C5+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C5=TOTALDUS3_C5+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C5=HHOCCU_C5+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C5=HHTGOCC_C5+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C5=POPTOT_C5+POPTOT                   ;Permanent Population
    ALLPOP_C5=ALLPOP_C5+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C5=TOTEMP_C5+TOTEMP                   ;Total employment

    PTOTAL_C5=PTOTAL_C5+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C5=ATOTAL_C5+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C5=HBW_Prod_C5+HBW_Prod             ;HBW prod total 
    HBW_Attr_C5=HBW_Attr_C5+HBW_Attr             ;HBW attr total  
    IITRIP_P_C5=IITRIP_P_C5+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C5=IITRIP_A_C5+IITRIP_A             ;Internal Purps (1-8) attr total

 elseif (COUNTY=6)     ;Putnam

    TOTALDUS_C6=TOTALDUS_C6+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C6=TOTALDUS3_C6+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C6=HHOCCU_C6+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C6=HHTGOCC_C6+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C6=POPTOT_C6+POPTOT                   ;Permanent Population
    ALLPOP_C6=ALLPOP_C6+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C6=TOTEMP_C6+TOTEMP                   ;Total employment

    PTOTAL_C6=PTOTAL_C6+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C6=ATOTAL_C6+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C6=HBW_Prod_C6+HBW_Prod             ;HBW prod total 
    HBW_Attr_C6=HBW_Attr_C6+HBW_Attr             ;HBW attr total  
    IITRIP_P_C6=IITRIP_P_C6+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C6=IITRIP_A_C6+IITRIP_A             ;Internal Purps (1-8) attr total

 else                  ;Dummy zones (County=9)

    TOTALDUS_C9=TOTALDUS_C9+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_C9=TOTALDUS3_C9+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_C9=HHOCCU_C9+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_C9=HHTGOCC_C9+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_C9=POPTOT_C9+POPTOT                   ;Permanent Population
    ALLPOP_C9=ALLPOP_C9+ALLPOP                   ;Total Population including HM persons
    TOTEMP_C9=TOTEMP_C9+TOTEMP                   ;Total employment

    PTOTAL_C9=PTOTAL_C9+PTOTAL                   ;12-purpose prod total  
    ATOTAL_C9=ATOTAL_C9+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_C9=HBW_Prod_C9+HBW_Prod             ;HBW prod total 
    HBW_Attr_C9=HBW_Attr_C9+HBW_Attr             ;HBW attr total  
    IITRIP_P_C9=IITRIP_P_C9+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_C9=IITRIP_A_C9+IITRIP_A             ;Internal Purps (1-8) attr total

endif 

;Total of All Counties..
    TOTALDUS_CT=TOTALDUS_CT+TOTALDUS             ;Total SF & MH DUs
    TOTALDUS3_CT=TOTALDUS3_CT+TOTALDUS3          ;Total DUS including HM units
    HHOCCU_CT=HHOCCU_CT+HHOCCU                   ;permanently occupied DUs
    HHTGOCC_CT=HHTGOCC_CT+HHTGOCC                ;total occupied DUs including HMs
    POPTOT_CT=POPTOT_CT+POPTOT                   ;Permanent Population
    ALLPOP_CT=ALLPOP_CT+ALLPOP                   ;Total Population including HM persons
    TOTEMP_CT=TOTEMP_CT+TOTEMP                   ;Total employment

    PTOTAL_CT=PTOTAL_CT+PTOTAL                   ;12-purpose prod total  
    ATOTAL_CT=ATOTAL_CT+ATOTAL                   ;12-purpose attr total 
    HBW_Prod_CT=HBW_Prod_CT+HBW_Prod             ;HBW prod total 
    HBW_Attr_CT=HBW_Attr_CT+HBW_Attr             ;HBW attr total  
    IITRIP_P_CT=IITRIP_P_CT+IITRIP_P             ;Internal Purps (1-8) prod total
    IITRIP_A_CT=IITRIP_A_CT+IITRIP_A             ;Internal Purps (1-8) attr total

WRITE RECO=1


;Write T/G Key Summaries By Counties...

if(z={ZONESA})

; All Counties
   PRINT LIST="A. Trip Generation Summary for All Six Counties:       ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_CT(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_CT(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_CT(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_CT(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_CT(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_CT(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_CT(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_CT/HHOCCU_CT)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_CT/HHTGOCC_CT)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_CT/HHTGOCC_CT)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_CT/POPTOT_CT)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_CT(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_CT(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_CT(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_CT(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_CT(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_CT(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_CT/TOTEMP_CT)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_CT/HHOCCU_CT)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_CT/HHTGOCC_CT)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_CT/TOTEMP_CT)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_CT/TOTEMP_CT)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_CT/HHOCCU_CT)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_CT/HHTGOCC_CT)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_CT/TOTEMP_CT)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1
 
; County 1 - Nassau
   PRINT LIST="B. Trip Generation Summary for (1) Nassau County:       ", PRINTO=1
   PRINT LIST="   =============================================        ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_C1(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_C1(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_C1(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_C1(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_C1(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_C1(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_C1(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_C1/HHOCCU_C1)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_C1/HHTGOCC_C1)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_C1/HHTGOCC_C1)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_C1/POPTOT_C1)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_C1(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_C1(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_C1(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_C1(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_C1(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_C1(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_C1/TOTEMP_C1)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_C1/HHOCCU_C1)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_C1/HHTGOCC_C1)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_C1/TOTEMP_C1)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_C1/TOTEMP_C1)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_C1/HHOCCU_C1)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_C1/HHTGOCC_C1)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_C1/TOTEMP_C1)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1
 
; County 2 - Duval
   PRINT LIST="C. Trip Generation Summary for (2) Duval County:       ", PRINTO=1
   PRINT LIST="   ============================================        ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_C2(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_C2(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_C2(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_C2(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_C2(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_C2(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_C2(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_C2/HHOCCU_C2)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_C2/HHTGOCC_C2)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_C2/HHTGOCC_C2)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_C2/POPTOT_C2)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_C2(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_C2(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_C2(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_C2(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_C2(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_C2(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_C2/TOTEMP_C2)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_C2/HHOCCU_C2)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_C2/HHTGOCC_C2)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_C2/TOTEMP_C2)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_C2/TOTEMP_C2)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_C2/HHOCCU_C2)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_C2/HHTGOCC_C2)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_C2/TOTEMP_C2)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1
 
; County 3 - St. Johns
   PRINT LIST="D. Trip Generation Summary for (3) St. Johns County:       ", PRINTO=1
   PRINT LIST="   ================================================        ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_C3(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_C3(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_C3(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_C3(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_C3(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_C3(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_C3(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_C3/HHOCCU_C3)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_C3/HHTGOCC_C3)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_C3/HHTGOCC_C3)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_C3/POPTOT_C3)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_C3(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_C3(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_C3(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_C3(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_C3(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_C3(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_C3/TOTEMP_C3)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_C3/HHOCCU_C3)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_C3/HHTGOCC_C3)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_C3/TOTEMP_C3)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_C3/TOTEMP_C3)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_C3/HHOCCU_C3)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_C3/HHTGOCC_C3)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_C3/TOTEMP_C3)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1

; County 4 - Clay
   PRINT LIST="E. Trip Generation Summary for (4) Clay County:       ", PRINTO=1
   PRINT LIST="   ===========================================        ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_C4(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_C4(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_C4(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_C4(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_C4(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_C4(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_C4(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_C4/HHOCCU_C4)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_C4/HHTGOCC_C4)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_C4/HHTGOCC_C4)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_C4/POPTOT_C4)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_C4(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_C4(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_C4(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_C4(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_C4(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_C4(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_C4/TOTEMP_C4)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_C4/HHOCCU_C4)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_C4/HHTGOCC_C4)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_C4/TOTEMP_C4)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_C4/TOTEMP_C4)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_C4/HHOCCU_C4)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_C4/HHTGOCC_C4)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_C4/TOTEMP_C4)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1

; County 5 - Baker
   PRINT LIST="F. Trip Generation Summary for (5) Baker County:       ", PRINTO=1
   PRINT LIST="   ============================================        ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_C5(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_C5(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_C5(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_C5(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_C5(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_C5(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_C5(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_C5/HHOCCU_C5)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_C5/HHTGOCC_C5)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_C5/HHTGOCC_C5)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_C5/POPTOT_C5)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_C5(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_C5(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_C5(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_C5(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_C5(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_C5(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_C5/TOTEMP_C5)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_C5/HHOCCU_C5)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_C5/HHTGOCC_C5)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_C5/TOTEMP_C5)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_C5/TOTEMP_C5)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_C5/HHOCCU_C5)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_C5/HHTGOCC_C5)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_C5/TOTEMP_C5)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1

; County 6 - Putnam
   PRINT LIST="G. Trip Generation Summary for (6) Putnam County:       ", PRINTO=1
   PRINT LIST="   =============================================        ", PRINTO=1
   PRINT LIST=" 1. Permanent Dwelling Units                                 = ",TOTALDUS_C6(10.0C), PRINTO=1
   PRINT LIST=" 2. Total Dwelling Units, includes HM units                  = ",TOTALDUS3_C6(10.0C), PRINTO=1
   PRINT LIST=" 3. Permanently Occupied Dwelling Units (HHs)                = ",HHOCCU_C6(10.0C), PRINTO=1
   PRINT LIST=" 4. Transient and Permently Occupied Dwelling Units (HHs)    = ",HHTGOCC_C6(10.0C), PRINTO=1
   PRINT LIST=" 5. Permanent Population                                     = ",POPTOT_C6(10.0C), PRINTO=1
   PRINT LIST=" 6. Total Population, includes HM persons                    = ",ALLPOP_C6(10.0C), PRINTO=1
   PRINT LIST=" 7. Total Employment                                         = ",TOTEMP_C6(10.0C),"\n", PRINTO=1
   PRINT LIST=" 8. Permanent Population per Permenant HHs                   =      ",(POPTOT_C6/HHOCCU_C6)(5.3C), PRINTO=1
   PRINT LIST=" 9. Total Population per Total HHs                           =      ",(ALLPOP_C6/HHTGOCC_C6)(5.3C), PRINTO=1
   PRINT LIST="10. Total Employment per Total HHs                           =      ",(TOTEMP_C6/HHTGOCC_C6)(5.3C), PRINTO=1
   PRINT LIST="11. Total Employment per Permanent Population                =      ",(TOTEMP_C6/POPTOT_C6)(5.3C),"\n", PRINTO=1
   PRINT LIST="12. All Purposes (1-12) Production Totals                    = ",PTOTAL_C6(10.0C), PRINTO=1
   PRINT LIST="13. All Purposes (1-12) Attraction Totals                    = ",ATOTAL_C6(10.0C), PRINTO=1
   PRINT LIST="14. HBW Production Totals                                    = ",HBW_Prod_C6(10.0C), PRINTO=1
   PRINT LIST="15. HBW Attraction Totals                                    = ",HBW_Attr_C6(10.0C), PRINTO=1
   PRINT LIST="16. Internal Trips Purposes (1-8) Production Totals          = ",IITRIP_P_C6(10.0C), PRINTO=1
   PRINT LIST="17. Internal Trips Purposes (1-8) Attraction Totals          = ",IITRIP_A_C6(10.0C),"\n", PRINTO=1
   PRINT LIST="18. HBW (Prsn) Productions per Employment                    =      ",(HBW_Prod_C6/TOTEMP_C6)(5.2C), PRINTO=1
   PRINT LIST="19. Internal (Prsn) Productions per Permanent HHs            =      ",(IITRIP_P_C6/HHOCCU_C6)(5.2C), PRINTO=1
   PRINT LIST="20. Internal (Prsn) Productions per Total HHs                =      ",(IITRIP_P_C6/HHTGOCC_C6)(5.2C), PRINTO=1
   PRINT LIST="21. Internal (Prsn) Productions per Employee                 =      ",(IITRIP_P_C6/TOTEMP_C6)(5.2C),"\n", PRINTO=1
   PRINT LIST="22. HBW (Prsn) Attractions per Employment                    =      ",(HBW_Attr_C6/TOTEMP_C6)(5.2C), PRINTO=1
   PRINT LIST="23. Internal (Prsn) Attractions per Permanent HHs            =      ",(IITRIP_A_C6/HHOCCU_C6)(5.2C), PRINTO=1
   PRINT LIST="24. Internal (Prsn) Attractions per Total HHs                =      ",(IITRIP_A_C6/HHTGOCC_C6)(5.2C), PRINTO=1
   PRINT LIST="25. Internal (Prsn) Attractions per Employee                 =      ",(IITRIP_A_C6/TOTEMP_C6)(5.2C),"\n", PRINTO=1
   PRINT LIST="\n", PRINTO=1

endif

ENDRUN
