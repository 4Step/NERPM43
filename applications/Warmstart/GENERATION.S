; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*echo Date: %date% >"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Time: %time% >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo NERPM Model Run - {DESCR}>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Input Directory {SCENARIO_DIR}\input\ >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo ======================================================================================>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"



; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\WARMSTART\GNMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='store time and date'
FILEI RECI = "{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

zones={ZONESA}

s1=strpos('Date:',reci)
s2=strpos('Time:',reci)

; get the date and time
if (s1 > 0)
 rundate=substr(reci,s1,80)
 log prefix=date var=rundate
endif
if (s2 > 0) 
 runtime=substr(reci,s2,80)
 log prefix=time var=runtime
endif

ENDRUN


; Script for program GENERATION in file "C:\NERPM43\APPLICATIONS\WARMSTART\GNGEN00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=GENERATION PRNFILE="{SCENARIO_DIR}\output\GNGEN00A.PRN" MSG='Trip Generation'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\AO_ERRORS.PRN"
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\grates_cube.dbf"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\LUERRORS.PRN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\GEN_SUM.PRN"
FILEO PAO[1] = "{SCENARIO_DIR}\output\PANDA_TEM.DBF",
 LIST=Z,P[1],P[2],P[3],P[4],P[5],P[6],P[7],P[8],P[9],P[10],P[11],P[12],
        A[1],A[2],A[3],A[4],A[5],A[6],A[7],A[8],A[9],A[10],A[11],A[12],DBF=T
FILEI ZDATI[3] = "{SCENARIO_DIR}\input\EITRIPS_{Year}{alt}.DBF"
FILEI ZDATI[2] = "{SCENARIO_DIR}\input\SPGEN_{Year}{alt}.DBF"
FILEI ZDATI[1] = "{SCENARIO_DIR}\input\ZDATA_{Year}{alt}.DBF"

; ================================================================
; OVERALL PROGRAM CONTROLS
PARAMETERS ZONES={ZONESA}, ZONEMSG=100
ARRAY CAR=4 CELL=999 CELLT=999 SPFRAC=12
LOOKUP LOOKUPI=1,
       NAME=PRATE, ;TRIP PRODUCTION RATES
         LOOKUP[1]=PAD, RESULT=RATEHBW,
         LOOKUP[2]=PAD, RESULT=RATEHBSH,
         LOOKUP[3]=PAD, RESULT=RATEHBSR,
         LOOKUP[4]=PAD, RESULT=RATEHBO,
       FAIL[1]=0,FAIL[2]=0,FAIL[3]=0, INTERPOLATE=N

LOOKUP NAME=DUWEIGHT, 
       LOOKUP[1]=1, RESULT=2, ; %1 PERSON
       LOOKUP[2]=1, RESULT=3, ; %2 PERSON
       LOOKUP[3]=1, RESULT=4, ; %3 PERSON
       LOOKUP[4]=1, RESULT=5, ; %4 PERSON
       LOOKUP[5]=1, RESULT=6, ; %5+PERSON
       INTERPOLATE=N,
       R=
       '01 0.89 0.11 0.00 0.00 0.00',         
       '02 0.76 0.22 0.02 0.00 0.00',
       '03 0.59 0.34 0.05 0.01 0.01',
       '04 0.46 0.34 0.11 0.06 0.03',
       '05 0.33 0.38 0.17 0.09 0.03',
       '06 0.25 0.35 0.19 0.13 0.08',
       '07 0.22 0.33 0.19 0.16 0.10',
       '08 0.15 0.32 0.21 0.21 0.11',
       '09 0.13 0.34 0.18 0.16 0.19',
       '10 0.12 0.29 0.18 0.17 0.24',
       '11 0.08 0.24 0.20 0.20 0.28',
       '12 0.05 0.20 0.19 0.23 0.33',
       '13 0.04 0.16 0.17 0.24 0.39',
       '14 0.02 0.15 0.14 0.21 0.48',
       '15 0.01 0.15 0.13 0.17 0.54',
       '16 0.00 0.05 0.07 0.14 0.74',
       '17 0.00 0.00 0.02 0.05 0.93'



PROCESS PHASE=ILOOP 
; ================================================================
; This is the main program loop to calculate initial production
; and attraction values for each zone for each trip purpose
; ================================================================
LOOP HHTYPE=1,3 ; ESTABLISH VARIABLES FOR EACH HOUSEHOLD CLASS
   PRNTAZ=ZI.1.TAZ   ;add by SKS
   COUNTY=ZI.1.COUNTY ;add by sks
IF (HHTYPE=1) ; SINGLE-FAMILY
   UNITS=   ZI.1.SFDU
   VACRATE= ZI.1.SFSEAS;+ZI.1.SFVAC
   PERMVACRATE= ZI.1.SFVAC
   POP=     ZI.1.SFPOP
   CAR[1]=ZI.1.SF0CAR/100, CAR[2]=ZI.1.SF1CAR/100, CAR[3]=ZI.1.SF2CAR/100, CAR[4]=ZI.1.SF3CAR/100
ELSEIF (HHTYPE=2); MULTI-FAMILY
   UNITS=   ZI.1.MFDU
   VACRATE= ZI.1.MFSEAS;+ZI.1.MFVAC
   PERMVACRATE= ZI.1.MFVAC
   POP=     ZI.1.MFPOP
   CAR[1]=ZI.1.MF0CAR/100, CAR[2]=ZI.1.MF1CAR/100, CAR[3]=ZI.1.MF2CAR/100, CAR[4]=ZI.1.MF3CAR/100
ELSEIF (HHTYPE=3) ; HOTEL/MOTEL
   UNITS=   ZI.1.HMUNITS
   VACRATE= 100-ZI.1.HMPCTOCC
   PERMVACRATE= 100-ZI.1.HMPCTOCC
   POP=     ZI.1.HMPOP
   CAR[1]=0, CAR[2]=1.0, CAR[3]=0, CAR[4]=0
ENDIF

; ================================================================
; From here down, the same equations get applied to each
; household size, auto ownership and dwelling unit type.
; Since it is being run in the HHTYPE loop, the same equations
; will be applied and running totals by zone will be accumulated.
; ================================================================
VAC=UNITS*(VACRATE/100), OCC=UNITS-VAC, GENVAC=UNITS*(PERMVACRATE/100), GENOCC=UNITS-GENVAC

IF (HHTYPE<>3) TOCC=TOCC+OCC ;Keep track of total permenantly occupied DUs
TGOCC=TGOCC+GENOCC ;Keep track of total occupied DUs

IF (OCC>0) 
   POPDU=POP/OCC
ELSE
   POPDU=0
ENDIF

IF (POPDU<>0) PDUCNT=PDUCNT+1      ;Keep track of total zones with pop/du ratios
IF (POPDU<>0) PDUTOT=PDUTOT+POPDU  ;total pop/du ratios

IF (POPDU<=1.12) RANGE=1
IF (POPDU>1.12)  RANGE=2
IF (POPDU>1.37)  RANGE=3
IF (POPDU>1.62)  RANGE=4
IF (POPDU>1.87)  RANGE=5
IF (POPDU>2.12)  RANGE=6
IF (POPDU>2.37)  RANGE=7
IF (POPDU>2.62)  RANGE=8
IF (POPDU>2.87)  RANGE=9
IF (POPDU>3.12)  RANGE=10
IF (POPDU>3.37)  RANGE=11
IF (POPDU>3.62)  RANGE=12
IF (POPDU>3.87)  RANGE=13
IF (POPDU>4.12)  RANGE=14
IF (POPDU>4.37)  RANGE=15
IF (POPDU>4.62)  RANGE=16
IF (POPDU>5.99)  RANGE=17
;if (POPDU<1&OCC>0) PRINT LIST="POP/DU ERROR, HHTYPE=",HHTYPE(1.0)," Population=",POP(4.0C)," Occupied Units=",occ(4.0c), printo=2
if (POPDU<1&OCC>0) PRINT LIST="POP/DU ERROR: ", "TAZ=",PRNTAZ(4.0C)," HHTYPE=",HHTYPE(1.0)," Population=",POP(4.0C)," Occupied Units=",occ(4.0c), printo=2

  LOOP PR=1,5
   LOOP AU=1,4
         CL=100*PR+10*(AU-1)+HHTYPE
         CELL[CL]=GENOCC*DUWEIGHT(PR,RANGE)*CAR[AU]
         CELLT[CL]=CELLT[CL]+CELL[CL]
         LOOP PURP=1,4
            PRODRATE=PRATE(PURP,CL)
            
;            P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]
; add by sks

FacPCnty1=(1/(0.7604*1.186))
FacPCnty2=(1/(1.0097*1.186))
FacPCnty3=(1/(0.9251*1.186))
FacPCnty4=(1/(1.2500*1.186))
FacPCnty5=(1/(1.0198*1.186))
FacPCnty6=(1/(1.2500*1.186))

            IF (COUNTY=1)
                 if (PURP=1)
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty1*(1.277/1.5268)*(1/1.08)
                 else
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty1*(1/1.08)
                 endif 
             elseif (COUNTY=2)
                 if (PURP=1)
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty2*(1.277/0.8858)*(1/1.08)
                 else
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty2*(1/1.08)
                 endif
             elseif (COUNTY=3)
                 if (PURP=1)
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty3*(1.277/1.1482)*(1/1.08)
                 else
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty3*(1/1.08)
                 endif
             elseif (COUNTY=4)
                 if (PURP=1)
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty4*(1.277/0.8360)*(1/1.08)
                 else
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty4*(1/1.08)
                 endif
             elseif (COUNTY=5)
                 if (PURP=1)
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty5*(1.277/1.0600)*(1/1.08)
                 else
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty5*(1/1.08)
                 endif
             elseif (COUNTY=6)
                 if (PURP=1)
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty6*(1.277/1.1111)*(1/1.08)
                 else
                    P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*FacPcnty6*(1/1.08)
                 endif
             else
               P[PURP]=P[PURP]+PRATE(PURP,CL)*CELL[CL]*1.000*(1/1.08)
            endif

         ENDLOOP
   ENDLOOP
  ENDLOOP
ENDLOOP ; ON HHTYPE
; ================================================================

; Now process the trip purposes that are attraction-based
; ================================================================
TOTALDUS=ZI.1.SFDU+ZI.1.MFDU

DISTRICT=ZI.1.DISTRICT


; HBW
;A[1]=1.80*ZI.1.EMPTOT+0.50*TOTALDUS
;A[1]=1.80*ZI.1.EMPTOT    ; AECOM - modified 08/27/2007
;Regional Attraction Balance factor keys for four HB purposes were added by SKS(corradino) -10/2/08

;Adjust HBW attraction based on ratios of estimated HBW and CTPP estimates then adjust the other purposes
;   as dictated rural/urban nature (Note second factor of 1.111 is a CAP od 2 trips/emp)

 if (COUNTY=1)
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*0.9524*(1/1.08)  ;Total adj factor 0.7367 & attr rate per emp=1.33
  elseif (COUNTY=2)
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*1.0204*(1/1.08)  ;Total adj factor 0.7893 & attr rate per emp=1.42
  elseif (COUNTY=3)
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*0.9346*(1/1.08)  ;Total adj factor 0.7229 & attr rate per emp=1.30
  elseif (COUNTY=4)
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*0.9615*(1/1.08)  ;Total adj factor 0.7437 & attr rate per emp=1.34
  elseif (COUNTY=5)
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*1.0000*(1/1.08)  ;Total adj factor 0.7735 & attr rate per emp=1.39
  elseif (COUNTY=6)
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*1.0000*(1/1.08)  ;Total adj factor 0.7735 & attr rate per emp=1.39

  else
   A[1]={AttrBalFac_HBW}*(1.80*(ZI.1.EMPMFG+ZI.1.EMPIND+ZI.1.EMPCOM+ZI.1.EMPSVC))*1.0000*(1/1.08)   ;Total adj factor=unbalanced fac({AttrBalFac_HBW})
 endif

if (DISTRICT=11)  ;CBD Type Areas (65% of regular attraction rates for Purposes 3&5 and 50% for Purposes 2&4)
   ; HBSH
   A[2]={AttrBalFac_HBSH}*(6.10*ZI.1.EMPCOM)*0.50*(1/1.08)
   ; HBSR
   A[3]={AttrBalFac_HBSR}*(0.50*ZI.1.EMPCOM+0.50*ZI.1.EMPSVC+1.61*TOTALDUS)*0.65*(1/1.08)
   ; HBO
   A[4]={AttrBalFac_HBO}*(1.50*ZI.1.EMPCOM+1.50*ZI.1.EMPSVC+0.30*TOTALDUS+1.50*ZI.1.SCHENR)*0.50*(1/1.08)
   ; NHB
   A[5]=(3.54*ZI.1.EMPCOM+1.71*ZI.1.EMPSVC+0.30*TOTALDUS)*(1/1.186)*0.65*(1/1.08)
   P[5]=A[5]

elseif (DISTRICT=2-4,21,22,27,28,30-35)   ; Rural Type Areas (95% attraction of regular attraction rates for Purposes 2-5) 
   ; HBSH
   A[2]={AttrBalFac_HBSH}*(6.10*ZI.1.EMPCOM)*0.95*(1/1.08)
   ; HBSR
   A[3]={AttrBalFac_HBSR}*(0.50*ZI.1.EMPCOM+0.50*ZI.1.EMPSVC+1.61*TOTALDUS)*0.95*(1/1.08)
   ; HBO
   A[4]={AttrBalFac_HBO}*(1.50*ZI.1.EMPCOM+1.50*ZI.1.EMPSVC+0.30*TOTALDUS+1.50*ZI.1.SCHENR)*0.95*(1/1.08)
   ; NHB
   A[5]=(3.54*ZI.1.EMPCOM+1.71*ZI.1.EMPSVC+0.30*TOTALDUS)*(1/1.186)*0.95*(1/1.08)
   P[5]=A[5]
else                                     ; regular attraction rates for other districts
   ; HBSH
   A[2]={AttrBalFac_HBSH}*(6.10*ZI.1.EMPCOM)*1.00*(1/1.08)
   ; HBSR
   A[3]={AttrBalFac_HBSR}*(0.50*ZI.1.EMPCOM+0.50*ZI.1.EMPSVC+1.61*TOTALDUS)*1.00*(1/1.08)
   ; HBO
   A[4]={AttrBalFac_HBO}*(1.50*ZI.1.EMPCOM+1.50*ZI.1.EMPSVC+0.30*TOTALDUS+1.50*ZI.1.SCHENR)*1.00*(1/1.08)
   ; NHB
   A[5]=(3.54*ZI.1.EMPCOM+1.71*ZI.1.EMPSVC+0.30*TOTALDUS)*(1/1.186)*1.00*(1/1.08)
   P[5]=A[5]
endif

; 4 Tire truck
A[6]=0.47*ZI.1.EMPMFG+0.55*ZI.1.EMPIND+0.45*ZI.1.EMPCOM+0.22*ZI.1.EMPSVC+0.13*TOTALDUS
P[6]=A[6]
; Single-Unit truck
A[7]=0.12*ZI.1.EMPMFG+0.15*ZI.1.EMPIND+0.13*ZI.1.EMPCOM+0.04*ZI.1.EMPSVC+0.05*TOTALDUS
P[7]=A[7]
; Tractor-trailer
A[8]=0.05*ZI.1.EMPMFG+0.09*ZI.1.EMPIND+0.04*ZI.1.EMPCOM+0.01*ZI.1.EMPSVC+0.02*TOTALDUS
P[8]=A[8]
; .........................................................................
; For the next four purposes, 
; Attractions are a function of the total attractions to a zone.  
; Since totals aren't known until we finish the initial calculations,
; attractions for these purposes will be initially calculated in the
; ADJUST PHASE.
; .........................................................................
; SOV EI
P[9]=ZI.3.TRIPS*(ZI.3.LOVPCT/100)
; HOV EI
P[10]=ZI.3.TRIPS*(ZI.3.HOVPCT/100)
; LDTK EI
P[11]=ZI.3.TRIPS*(ZI.3.LDTPCT/100)
; HDTK EI
P[12]=ZI.3.TRIPS*(ZI.3.HDTPCT/100)

; ================================================================
; NOW PROCESS SPECIAL GENERATORS
; 
SPFRAC[1]=ZI.2.HBWP/100
SPFRAC[2]=ZI.2.HBSHP/100
SPFRAC[3]=ZI.2.HBSRP/100
SPFRAC[4]=ZI.2.HBOP/100
SPFRAC[5]=ZI.2.NHBP/100
SPFRAC[6]=ZI.2.TRK4P/100
SPFRAC[7]=ZI.2.TRKSUNITP/100
SPFRAC[8]=ZI.2.TRKCOMBOP/100
SPFRAC[9]=ZI.2.EILOVP/100
SPFRAC[10]=ZI.2.EIHOVP/100
SPFRAC[11]=ZI.2.EILDTP/100
SPFRAC[12]=ZI.2.EIHDTP/100

LOOP PRP=1,12
    IF (ZI.2.PROD='Y','y') 
       IF (ZI.2.FUNCTIONP='+') P[PRP]=P[PRP]+VALUEP*SPFRAC[PRP]
       IF (ZI.2.FUNCTIONP='-') P[PRP]=P[PRP]-VALUEP*SPFRAC[PRP]
    ENDIF
ENDLOOP

SPFRAC[1]=ZI.2.HBWA/100
SPFRAC[2]=ZI.2.HBSHA/100
SPFRAC[3]=ZI.2.HBSRA/100
SPFRAC[4]=ZI.2.HBOA/100
SPFRAC[5]=ZI.2.NHBA/100
SPFRAC[6]=ZI.2.TRK4A/100
SPFRAC[7]=ZI.2.TRKSUNITA/100
SPFRAC[8]=ZI.2.TRKCOMBOA/100
SPFRAC[9]=ZI.2.EILOVA/100
SPFRAC[10]=ZI.2.EIHOVA/100
SPFRAC[11]=ZI.2.EILDTA/100
SPFRAC[12]=ZI.2.EIHDTA/100

LOOP PRP=1,12
    IF (ZI.2.ATTR='Y','y') 
       IF (ZI.2.FUNCTIONA='+') A[PRP]=A[PRP]+VALUEA*SPFRAC[PRP]
       IF (ZI.2.FUNCTIONA='-') A[PRP]=A[PRP]-VALUEA*SPFRAC[PRP]
    ENDIF
ENDLOOP

;********************************************************************************************************
;This portion of the script checks to see if any zones with populations are lacking values for percent
;automobile ownership.  If so, the model crashes and reports the problem zones so that the user can correct
;the problem.  All zones with populations should have values for percent automobile ownership or the model
;will not generate Home-Based trips for those zones.

IF (I=1)  
  PRINT LIST='\nAUTO OWNERSHIP ERRORS WHERE POPULATION EXISTS BUT AUTO OWNERSHIP DOES NOT', PRINTO=3
  PRINT LIST='\nCHECK LISTED ZONES IN ZDATA_{Year}{alt} FILES FOR AUTO OWNERSHIP PERCENTAGES!!!', PRINTO=3
  PRINT LIST='\n', PRINTO=3
  SFAOERROR=0
  MFAOERROR=0
ENDIF
     SFAO=zi.1.SF0CAR+zi.1.SF1CAR+zi.1.SF2CAR+zi.1.SF3CAR
     MFAO=zi.1.MF0CAR+zi.1.MF1CAR+zi.1.MF2CAR+zi.1.MF3CAR

     IF ((zi.1.SFPOP<>0 & SFAO=0)|(zi.1.MFPOP<>0 & MFAO=0))
        PRINT LIST='\n', PRINTO=3 
     ENDIF   

     IF (zi.1.SFPOP<>0 & SFAO=0) 
        SFAOERROR=SFAOERROR+1
        PRINT LIST='\nAUTO OWNERSHIP = 0 BUT SF POPULATION > 0 ERROR FOR ZONE=',I(5.0),PRINTO=3
     ELSE
     ENDIF
     IF (zi.1.MFPOP<>0 & MFAO=0)
        MFAOERROR=MFAOERROR+1
        PRINT LIST='\nAUTO OWNERSHIP = 0 BUT MF POPULATION > 0 ERROR FOR ZONE=',I(5.0),PRINTO=3
     ELSE
     ENDIF

IF (I={ZONESA})
  PRINT LIST='\n************Error Report Summary*************',
             '\nTOTAL AUTO OWNERSHIP ERRORS FOR SINGLE FAMILY=',SFAOERROR(8.0C),
             '\nTOTAL AUTO OWNERSHIP ERRORS FOR MULTI FAMILY= ',MFAOERROR(8.0C), printo=3

IF (SFAOERROR=0 & MFAOERROR=0)  PRINT LIST='\n',
                                '\nTHERE ARE NO AUTO OWNERSHIP = 0 BUT POPULATION > 0 ERRORS', PRINTO=3

  if (SFAOERROR>1) abort
  if (MFAOERROR>1) abort
ENDIF
 
;********************************************************************************************************

; ================================================================

ENDPROCESS

PROCESS PHASE=ADJUST

LOOP PURP=1,12
 IF (PURP=1) PRINT LIST="TRIP PRODUCTION AND ATTRACTION REPORT BY PURPOSE for All Counties:", PRINTO=1
 IF (PURP=1) PRINT LIST="================================================================= ", PRINTO=1

 PRINT LIST="  Purpose=",PURP(2.0),"  Productions=",P[PURP][0](12.0C)," Unbalanced Attractions=",A[PURP][0](12.0C), PRINTO=1
ENDLOOP

 PRINT LIST=" ", PRINTO=1
 
TOTSTDATTR=A[1][0]+A[2][0]+A[3][0]+A[4][0]+A[5][0]
A[9]=P[9][0]*(A[1]+A[2]+A[3]+A[4]+A[5])/TOTSTDATTR
A[10]=P[10][0]*(A[1]+A[2]+A[3]+A[4]+A[5])/TOTSTDATTR
A[11]=P[11][0]*(A[7]/A[7][0])
A[12]=P[12][0]*(A[8]/A[8][0])
BALANCE A2P=9-12
LOOP PURP=1,12
 PRINT LIST="  Purpose=",PURP(2.0),"  Productions=",P[PURP][0](12.0C),"   Balanced Attractions=",A[PURP][0](12.0C), PRINTO=1
ENDLOOP


  PTOTAL=P[1][0]+P[2][0]+P[3][0]+P[4][0]+P[5][0]+P[6][0]+P[7][0]+P[8][0]+P[9][0]+P[10][0]+P[11][0]+P[12][0]
  ATOTAL=A[1][0]+A[2][0]+A[3][0]+A[4][0]+A[5][0]+A[6][0]+A[7][0]+A[8][0]+A[9][0]+A[10][0]+A[11][0]+A[12][0]


PRINT LIST="  Total","       Productions=",PTOTAL(12.0C),"            Attractions=",ATOTAL(12.0C), PRINTO=1
PRINT LIST=" ", PRINTO=1

  POPTOT=ZI.1.SFPOP[0]+ZI.1.MFPOP[0]
  ALLPOP=POPTOT+ZI.1.HMPOP[0]
  PDUAVG=(POPTOT/TOCC) 
  ALPDAG=(ALLPOP/TGOCC)
  TOTSRV=ZI.1.EMPSVC[0]
  TOTCOM=ZI.1.EMPCOM[0]
  TOTMFG=ZI.1.EMPMFG[0]
  TOTIND=ZI.1.EMPIND[0]
;  TOTEMP=ZI.1.EMPTOT[0]   ; - modified AECOM 8/27/2007
  TOTEMP=(ZI.1.EMPMFG[0]+ZI.1.EMPIND[0]+ZI.1.EMPCOM[0]+ZI.1.EMPSVC[0])
  EMPPOP=TOTEMP/POPTOT
  SRVRTE=TOTSRV/TOTEMP
  COMRTE=TOTCOM/TOTEMP
  MFGRTE=TOTMFG/TOTEMP
  INDRTE=TOTIND/TOTEMP
  IITRIP=P[1][0]+P[2][0]+P[3][0]+P[4][0]+P[5][0]+P[6][0]+P[7][0]+P[8][0]
  ITPPRM=IITRIP/TOCC
  ITPTOC=IITRIP/TGOCC
  ITPEMP=IITRIP/TOTEMP
  HBWPEREMP=P[1][0]/TOTEMP

PRINT LIST="  Trip Generation Summary for All Counties:       ", PRINTO=1
PRINT LIST="  ========================================        ", PRINTO=1

PRINT LIST="  Permanent Population =                                  ",POPTOT(12.0C), PRINTO=1
PRINT LIST="  Total Population =                                      ",ALLPOP(12.0C), PRINTO=1
PRINT LIST="  Permanently Occupied Dwelling Units =                   ",TOCC(12.0C), PRINTO=1
PRINT LIST="  Transient and Permently Occupied Dwelling Units =       ",TGOCC(12.0C), PRINTO=1
PRINT LIST="  Total Service Employment =                              ",TOTSRV(12.0C), PRINTO=1
PRINT LIST="  Total Commercial Employment =                           ",TOTCOM(12.0C), PRINTO=1
PRINT LIST="  Total Manufacturing Employment =                        ",TOTMFG(12.0C), PRINTO=1
PRINT LIST="  Total Other Industrial Employment =                     ",TOTIND(12.0C), PRINTO=1
PRINT LIST="  Total Employment =                                      ",TOTEMP(12.0C), PRINTO=1
PRINT LIST="  HBW Trips per Employment =                                     ",HBWPEREMP(5.3C), PRINTO=1
PRINT LIST="  Permanent Population per Permenantly Occupied Dwelling Unit =  ",PDUAVG(5.2C), PRINTO=1
PRINT LIST="  Total Population per Total Occupied Dwelling Unit =            ",ALPDAG(5.3C), PRINTO=1
PRINT LIST="  Total Employment per Permanent Population =                    ",EMPPOP(5.3C), PRINTO=1
PRINT LIST="  Service to Total Employment =                                  ",SRVRTE(5.3C), PRINTO=1
PRINT LIST="  Commercial to Total Employment =                               ",COMRTE(5.3C), PRINTO=1
PRINT LIST="  Manufacturing to Total Employment =                            ",MFGRTE(5.3C), PRINTO=1
PRINT LIST="  Other Industrial to Total Employment =                         ",INDRTE(5.3C), PRINTO=1
PRINT LIST="  Internal Person Trips per Permanently Occupied Dwelling Unit = ",ITPPRM(5.3C), PRINTO=1
PRINT LIST="  Internal Person Trips per Total Occupied Dwelling Units =      ",ITPTOC(5.3C), PRINTO=1
PRINT LIST="  Internal Person Trips per Employee =                           ",ITPEMP(5.3C), PRINTO=1


ENDPROCESS


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\WARMSTART\GNMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\GNMAT00A.PRN" MSG='Subarea Balancing of Attractions Rates'
FILEI RECI = "{SCENARIO_DIR}\output\PANDA_TEM.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\SUBAREABAL.CSV"
FILEO RECO[1] = "{SCENARIO_DIR}\output\PANDA.DBF",
FIELDS=Z,DISTRICT,HBWKP,HBWKA,HBSHP,HBSHA,HBSRP,HBSRA,HBOTP,HBOTA,NHBSP,NHBSA,
LTRKP,LTRKA,MTRKP,MTRKA,HTRKP,HTRKA,SOIEP,SOIEA,HOIEP,HOIEA,LDIEP,LDIEA,HDIEP,HDIEA

PAR ZONES={ZONESA}, ZONEMSG=100
;ARRAY P1=5,P2=5,P3=5,P4=5,P5=5,P6=5,P7=5,P8=5,P9=5,P10=5,P11=5,P12=5,
; A1=5,A2=5,A3=5,A4=5,A5=5,A6=5,A7=5,A8=5,A9=5,A10=5,A11=5,A12=5, DSTS={ZONESA}
ARRAY P1=8,P2=8,P3=8,P4=8,P5=8,P6=8,P7=8,P8=8,P9=8,P10=8,P11=8,P12=8,
 A1=8,A2=8,A3=8,A4=8,A5=8,A6=8,A7=8,A8=8,A9=8,A10=8,A11=8,A12=8, DSTS={ZONESA}


READ,
 FILE = "{CATALOG_DIR}\PARAMETERS\ATTRDIST.SYN"
RO.DISTRICT=DST
DSTS[RI.Z]=RO.DISTRICT
RO.HBWKP=RI.P1
RO.HBWKA=RI.A1
RO.HBSHP=RI.P2
RO.HBSHA=RI.A2
RO.HBSRP=RI.P3
RO.HBSRA=RI.A3
RO.HBOTP=RI.P4
RO.HBOTA=RI.A4
RO.NHBSP=RI.P5
RO.NHBSA=RI.A5
RO.LTRKP=RI.P6
RO.LTRKA=RI.A6
RO.MTRKP=RI.P7
RO.MTRKA=RI.A7
RO.HTRKP=RI.P8
RO.HTRKA=RI.A8
RO.SOIEP=RI.P9
RO.SOIEA=RI.A9
RO.HOIEP=RI.P10
RO.HOIEA=RI.A10
RO.LDIEP=RI.P11
RO.LDIEA=RI.A11
RO.HDIEP=RI.P12
RO.HDIEA=RI.A12
  WRITE RECO=1


; CREATE DISTRICT TOTALS OF PRODUCTIONS AND ATTRACTIONS TO APPLY AS FACTORS LATER
; (creates sub-area balancing of attractions
P1[RO.DISTRICT]=P1[RO.DISTRICT]+RO.HBWKP, A1[RO.DISTRICT]=A1[RO.DISTRICT]+RO.HBWKA
P2[RO.DISTRICT]=P2[RO.DISTRICT]+RO.HBSHP, A2[RO.DISTRICT]=A2[RO.DISTRICT]+RO.HBSHA
P3[RO.DISTRICT]=P3[RO.DISTRICT]+RO.HBSRP, A3[RO.DISTRICT]=A3[RO.DISTRICT]+RO.HBSRA
P4[RO.DISTRICT]=P4[RO.DISTRICT]+RO.HBOTP, A4[RO.DISTRICT]=A4[RO.DISTRICT]+RO.HBOTA
P5[RO.DISTRICT]=P5[RO.DISTRICT]+RO.NHBSP, A5[RO.DISTRICT]=A5[RO.DISTRICT]+RO.NHBSA
P6[RO.DISTRICT]=P6[RO.DISTRICT]+RO.LTRKP, A6[RO.DISTRICT]=A6[RO.DISTRICT]+RO.LTRKA
P7[RO.DISTRICT]=P7[RO.DISTRICT]+RO.MTRKP, A7[RO.DISTRICT]=A7[RO.DISTRICT]+RO.MTRKA
P8[RO.DISTRICT]=P8[RO.DISTRICT]+RO.HTRKP, A8[RO.DISTRICT]=A8[RO.DISTRICT]+RO.HTRKA
P9[RO.DISTRICT]=P9[RO.DISTRICT]+RO.SOIEP, A9[RO.DISTRICT]=A9[RO.DISTRICT]+RO.SOIEA
P10[RO.DISTRICT]=P10[RO.DISTRICT]+RO.HOIEP, A10[RO.DISTRICT]=A10[RO.DISTRICT]+RO.HOIEA
P11[RO.DISTRICT]=P11[RO.DISTRICT]+RO.LDIEP, A11[RO.DISTRICT]=A11[RO.DISTRICT]+RO.LDIEA
P12[RO.DISTRICT]=P12[RO.DISTRICT]+RO.HDIEP, A12[RO.DISTRICT]=A12[RO.DISTRICT]+RO.HDIEA
DST=RO.DISTRICT

;SKS-Override P's and A's total for Dummy districts for subarea balancing factors t=8, see ATTRDIST.SYN file in parameters folder)
if (DST=8)
   P1[8]=1.0
   A1[8]=1.0
   P2[8]=1.0
   A2[8]=1.0
   P3[8]=1.0
   A3[8]=1.0
   P4[8]=1.0
   A4[8]=1.0
   P5[8]=1.0
   A5[8]=1.0
   P6[8]=1.0
   A6[8]=1.0
   P7[8]=1.0
   A7[8]=1.0
   P8[8]=1.0
   A8[8]=1.0
   P9[8]=1.0
   A9[8]=1.0
   P10[8]=1.0
   A10[8]=1.0
   P11[8]=1.0
   A11[8]=1.0
   P12[8]=1.0
   A12[8]=1.0
endif  

; PUT IN TO MORE OR LESS REPRODUCE Sub-area Balancing
IF (RI.Z={ZONESA})
   LOOP WW=1,{ZONESA}
   RO.DISTRICT=DSTS[WW]
   if(RO.DISTRICT<>1)
      PRINT CSV=T, LIST=WW(6.0),RO.DISTRICT(3.0),
                P1[RO.DISTRICT]/A1[RO.DISTRICT](12.8),
                P2[RO.DISTRICT]/A2[RO.DISTRICT](12.8),
                P3[RO.DISTRICT]/A3[RO.DISTRICT](12.8),
                P4[RO.DISTRICT]/A4[RO.DISTRICT](12.8),
                P5[RO.DISTRICT]/A5[RO.DISTRICT](12.8),
                P6[RO.DISTRICT]/A6[RO.DISTRICT](12.8),
                P7[RO.DISTRICT]/A7[RO.DISTRICT](12.8),
                P8[RO.DISTRICT]/A8[RO.DISTRICT](12.8),
                P9[RO.DISTRICT]/A9[RO.DISTRICT](12.8),
                P10[RO.DISTRICT]/A10[RO.DISTRICT](12.8),
                P11[RO.DISTRICT]/A11[RO.DISTRICT](12.8),
                P12[RO.DISTRICT]/A12[RO.DISTRICT](12.8), PRINTO=1
    else
       PRINT CSV=T, LIST=WW(6.0),RO.DISTRICT(3.0),
                P1[RO.DISTRICT]/A1[RO.DISTRICT](12.8),
                P2[RO.DISTRICT]/A2[RO.DISTRICT](12.8),
                P3[RO.DISTRICT]/A3[RO.DISTRICT](12.8),
                P4[RO.DISTRICT]/A4[RO.DISTRICT](12.8),
                P5[RO.DISTRICT]/A5[RO.DISTRICT](12.8),
                P6[RO.DISTRICT]/A6[RO.DISTRICT](12.8),
                P7[RO.DISTRICT]/A7[RO.DISTRICT](12.8),
                P8[RO.DISTRICT]/A8[RO.DISTRICT](12.8),
      (P9[1]+P9[2]+P9[3]+P9[4]+P9[5]+P9[6]+P9[7])/(A9[1]+A9[2]+A9[3]+A9[4]+A9[5]+A9[6]+A9[7])(12.8),
      (P10[1]+P10[2]+P10[3]+P10[4]+P10[5]+P10[6]+P10[7])/(A10[1]+A10[2]+A10[3]+A10[4]+A10[5]+A10[6]+A10[7])(12.8),
      (P11[1]+P11[2]+P11[3]+P11[4]+P11[5]+P11[6]+P11[7])/(A11[1]+A11[2]+A11[3]+A11[4]+A11[5]+A11[6]+A11[7])(12.8),
      (P12[1]+P12[2]+P12[3]+P12[4]+P12[5]+P12[6]+P12[7])/(A12[1]+A12[2]+A12[3]+A12[4]+A12[5]+A12[6]+A12[7])(12.8), PRINTO=1
    endif
    ENDLOOP

ENDIF
ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\WARMSTART\GNMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\EXT.PRN" MSG='Create FSUTMS.CTL and EE Matrix'
FILEI MATI[5] = "{SCENARIO_DIR}\input\EXTAOFAC.DBF",
 PATTERN=IJ:V, FIELDS=ORZ,DSZ,FACTORHTK
FILEI MATI[4] = "{SCENARIO_DIR}\input\EXTAOFAC.DBF",
 PATTERN=IJ:V, FIELDS=ORZ,DSZ,FACTORLTK
FILEI MATI[3] = "{SCENARIO_DIR}\input\EXTAOFAC.DBF",
 PATTERN=IJ:V, FIELDS=ORZ,DSZ,FACTORHOV
FILEI MATI[2] = "{SCENARIO_DIR}\input\EXTAOFAC.DBF",
 PATTERN=IJ:V, FIELDS=ORZ,DSZ,FACTORSOV
FILEI MATI[1] = "{SCENARIO_DIR}\input\EETRIPS.DBF",
 PATTERN=IJ:V, FIELDS=ORZ,DSZ,TRIPS
FILEO MATO[1] = "{SCENARIO_DIR}\output\EETRIPS.MAT",
 MO=1-5, NAME=EESOV,EEHOV,EELIGHTTRUCK,EEHEAVYTRUCK,TOTAL DEC=5*S
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\FSUTMS.CTL"

PAR ZONES={ZONESA} ZONEMSG=100

IF (I>={ExtZnStrt})
   MW[1]=MI.1.1*MI.2.1
   MW[2]=MI.1.1*MI.3.1
   MW[3]=MI.1.1*MI.4.1
   MW[4]=MI.1.1*MI.5.1
   MW[5]=MI.1.1
ENDIF

IF (I=1)
PRINT LIST="~SELECT","\n3","\n~FILEIN","\n{YEAR}{Alt}","\n~FILEOUT","\n{Alt}{YEAR}","\n~{descr}",
      "\ntest","\n~MODE","\nHIGHWAY","\n~MODULE","\nEXT       1 RANGE","\nHEVAL     8 RANGE",
      PRINTO=1
ENDIF



ENDRUN


