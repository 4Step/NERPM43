; Script for program DISTRIBUTION in file "C:\NERPM43\APPLICATIONS\DCMODEL\TDDST00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=DISTRIBUTION PRNFILE="{CATALOG_DIR}\APPLICATIONS\TDDST00A.PRN" MSG='Gravity Model Distribution - Peak'
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\MMLOO_PKSKIM.MAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\OUTPUT\PANDA_{ALT}{YEAR}_PK.DBF",
 Z=#1, HBSCP2 = #23 ,	HBSCP3 = #24 ,	HBSCP4 = #25 ,HBCUP1 = #26 ,HBCUP2 = #27 ,HBCUP3 = #28 ,HBCUP4 = #29 ,HBSCA  = #42 ,HBCUA  = #43
FILEO MATO[1] = "{SCENARIO_DIR}\OUTPUT\GVMTRIPS_{ALT}{YEAR}_PK.MAT",
    MO=7,1-3,8,4-6,DEC=8*S, NAME=HBCU1,HBCU2,HBCU3,HBCU4,HBSC1,HBSC2,HBSC3,HBSC4
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\FF.DBF"
;FILEI MATI[2] = "{Scenario_Dir}\OUTPUT\KFACTOR.MAT"

PAR MAXITERS={TDistIters},MAXRMSE=10.0, ZONEMSG=100

    LOOKUP LOOKUPI=1,
        NAME=FF,
            LOOKUP[1]=TI, RESULT=HBU,      ; using HBW friction factors for HBCU trip purpose
            LOOKUP[2]=TI, RESULT=HBU,
            LOOKUP[3]=TI, RESULT=HBU,
            LOOKUP[4]=TI, RESULT=HBSC,
            LOOKUP[5]=TI, RESULT=HBSC,      ; using HBO friction factors for HBSC trip purpose
            LOOKUP[6]=TI, RESULT=HBSC,
        INTERPOLATE=Y, FAIL[3]=0

; example of use: v=FF(9,25)
; look for 25 in the TI field and returns the IE value

;   ----- SETUP THE WORKING P'S AND A'S

;  HBSC, HBCU, TRKTXI and IE use gravity models; all other purposes use destination choice
;  For the prototype, use existing FFs to distribute these trips
;  Note HBSC1 has no productions -- no school trips in one person hhlds

    MW[7] = 0.0
    MW[8] = 0.0
    
    SETPA P[1]= HBCUP2     A[1]=HBCUA      
    SETPA P[2]= HBCUP3     A[2]=HBCUA      
    SETPA P[3]= HBCUP4     A[3]=HBCUA      
    SETPA P[4]=HBSCP2     A[4]=HBSCA      
    SETPA P[5]=HBSCP3     A[5]=HBSCA      
    SETPA P[6]=HBSCP4     A[6]=HBSCA      
;   SETPA P[8]=TKTXP      A[8]=TKTXA
;   SETPA P[9]=IEP        A[9]=IEA
 
  
;   ----- DO 6 GRAVITY MODELS
    MW[20]=MI.1.TIME+MI.1.TERMINALTIME

; no k-factors in this model
 
    GRAVITY PURPOSE=1, LOS=MW[20], FFACTORS=FF    ;HBCU2  
    GRAVITY PURPOSE=2, LOS=MW[20], FFACTORS=FF    ;HBCU3  
    GRAVITY PURPOSE=3, LOS=MW[20], FFACTORS=FF    ;HBCU4  
    GRAVITY PURPOSE=4, LOS=MW[20], FFACTORS=FF    ;HBSC2  
    GRAVITY PURPOSE=5, LOS=MW[20], FFACTORS=FF    ;HBSC3   
    GRAVITY PURPOSE=6, LOS=MW[20], FFACTORS=FF    ;HBSC4   
 

    MW[9] = MW[1]+MW[2]+MW[3]+MW[7]
    MW[10]= MW[4]+MW[5]+MW[6]+MW[8]
    
;   ----- GENERATE FREQUENCY DISTRIBUTION REPORTS

 
;   FREQUENCY VALUEMW=9  BASEMW=20,  RANGE=0-150, TITLE='HBU TRIP LENGTH FREQUENCY LONGER TIME RANGE'
    
 
    FREQUENCY VALUEMW=9  BASEMW=20,  RANGE=0-49, TITLE='HBCU TRIP LENGTH FREQUENCY'
    FREQUENCY VALUEMW=10  BASEMW=20,  RANGE=0-49, TITLE='HBSC TRIP LENGTH FREQUENCY'
    


ENDRUN


