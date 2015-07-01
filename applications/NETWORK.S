; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\NTMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\NTMAT00A.PRN" MSG='Prepares MVFACTORS.{YEAR}{ALT} for Lookup Function'
FILEO PRINTO[1] = "{Scenario_Dir}\output\MVFACTORS.CSV"
FILEI RECI = "{Scenario_Dir}\input\MVFACTORS.{YEAR}{ALT}"
;var=n,6-7,UF,18-24,CF,35-41,BPRLOS,53-59,BPREXP,71-77

FT=SUBSTR(RECI,6,2)
UF=SUBSTR(RECI,18,7)
CF=SUBSTR(RECI,35,7)               ;24_Hour Confac
BPRLOS=SUBSTR(RECI,53,7)
BPREXP=SUBSTR(RECI,71,7)

CF_AM=SUBSTR(RECI,92,7)            ;AM Peak (07:30-09:30) Period Confac
CF_MD=SUBSTR(RECI,112,7)           ;Mid-day (09:30-15:30) Period Confac
CF_PM=SUBSTR(RECI,132,7)           ;PM Peak (15:30-18:30) Period Confac
CF_NT=SUBSTR(RECI,152,7)           ;Overnight (18:30-07:00) Period Confac



PRINT CSV=T, LIST=FT,UF,CF,BPRLOS,BPREXP,CF_AM,CF_MD,CF_PM,CF_NT, PRINTO=1


ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\NTMAT00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Create SPDCAP Lookup'
FILEO PRINTO[2] = "{Scenario_Dir}\output\SPDCAP.ERR"
FILEO PRINTO[1] = "{Scenario_Dir}\output\SPDCAP.CSV"
FILEI RECI = "{Scenario_Dir}\input\SPDCAP.{YEAR}{ALT}"
ARRAY SPDLOOKUP=999999 CAPLOOKUP=999999
LAT=SUBSTR(RECI,1,2)
HAT=SUBSTR(RECI,3,2)
LFT=SUBSTR(RECI,5,2)
HFT=SUBSTR(RECI,7,2)
LLN=SUBSTR(RECI,9,2)
HLN=SUBSTR(RECI,11,2)
CAPFUNC=SUBSTR(RECI,13,1)
CAP=SUBSTR(RECI,14,5)
SPDFUNC=SUBSTR(RECI,19,1)
SPD=SUBSTR(RECI,20,4)
    LATVAL=VAL(LAT)
    HATVAL=VAL(HAT)
    LFTVAL=VAL(LFT)
    HFTVAL=VAL(HFT)
    LLNVAL=VAL(LLN)
    HLNVAL=VAL(HLN)
    CAPVAL=VAL(CAP)
    SPDVAL=VAL(SPD)
; PLACE INITIAL CAPACITIES & SPEEDS INTO AN ARRAY
IF (CAPFUNC=' ') 
    LOOP ATYPE=LATVAL,HATVAL
      LOOP FTYPE=LFTVAL,HFTVAL
        LOOP LANES=LLNVAL,HLNVAL
        INDEXVAL=ATYPE*10000+FTYPE*100+LANES
        CAPLOOKUP[INDEXVAL]=CAPVAL  
        ENDLOOP
      ENDLOOP
    ENDLOOP
ENDIF
IF (SPDFUNC=' ') 
    LOOP ATYPE=LATVAL,HATVAL
      LOOP FTYPE=LFTVAL,HFTVAL
        LOOP LANES=LLNVAL,HLNVAL
        INDEXVAL=ATYPE*10000+FTYPE*100+LANES
        SPDLOOKUP[INDEXVAL]=SPDVAL  
        ENDLOOP
      ENDLOOP
    ENDLOOP
ENDIF
;IF (CAPFUNC='*')
IF (CAPFUNC='*'|CAPFUNC='+'|CAPFUNC='-')
    LOOP ATYPE=LATVAL,HATVAL
      LOOP FTYPE=LFTVAL,HFTVAL
        LOOP LANES=LLNVAL,HLNVAL
        INDEXVAL=ATYPE*10000+FTYPE*100+LANES
;        CAPLOOKUP[INDEXVAL]=CAPLOOKUP[INDEXVAL]*CAPVAL
        IF (CAPFUNC='*') CAPLOOKUP[INDEXVAL]=CAPLOOKUP[INDEXVAL]*CAPVAL
        IF (CAPFUNC='+') CAPLOOKUP[INDEXVAL]=CAPLOOKUP[INDEXVAL]+CAPVAL
        IF (CAPFUNC='-') CAPLOOKUP[INDEXVAL]=CAPLOOKUP[INDEXVAL]-CAPVAL
        ENDLOOP
      ENDLOOP
    ENDLOOP
ENDIF
IF (SPDFUNC='*'|SPDFUNC='+'|SPDFUNC='-')
    LOOP ATYPE=LATVAL,HATVAL
      LOOP FTYPE=LFTVAL,HFTVAL
        LOOP LANES=LLNVAL,HLNVAL
        INDEXVAL=ATYPE*10000+FTYPE*100+LANES
        IF (SPDFUNC='*') SPDLOOKUP[INDEXVAL]=SPDLOOKUP[INDEXVAL]*SPDVAL
        IF (SPDFUNC='+') SPDLOOKUP[INDEXVAL]=SPDLOOKUP[INDEXVAL]+SPDVAL
        IF (SPDFUNC='-') SPDLOOKUP[INDEXVAL]=SPDLOOKUP[INDEXVAL]-SPDVAL
        ENDLOOP
      ENDLOOP
    ENDLOOP
ENDIF


IF (I=0)
  PRINT LIST='SPEED OR CAPACITY ERRORS WHERE THE SPDCAP RESULT IS LESS THAN ZERO', PRINTO=2
  LOOP IVAL=1,999999
     IF (CAPLOOKUP[IVAL]>0|SPDLOOKUP[IVAL]>0)   PRINT CSV=T, LIST=IVAL(6.0),CAPLOOKUP[IVAL],SPDLOOKUP[IVAL],PRINTO=1
     IF (CAPLOOKUP[IVAL]<0)   
        CAPERRCNT=CAPERRCNT+1
        PRINT CSV=T, LIST='SPDCAP ERROR FOR ATFTLN=',IVAL(6.0),'  CAPACITY=',CAPLOOKUP[IVAL](9.2),PRINTO=2
     ENDIF
     IF (SPDLOOKUP[IVAL]<0)
        SPDERRCNT=SPDERRCNT+1
        PRINT CSV=T, LIST='SPDCAP ERROR FOR ATFTLN=',IVAL(6.0),'     SPEED=',SPDLOOKUP[IVAL](9.2),PRINTO=2
     ENDIF
  ENDLOOP
  PRINT LIST='\n************Error Report Summary*************',
             '\nTOTAL LESS THAN ZERO CAPACITY ERRORS=',CAPERRCNT(8.0C),
             '\nTOTAL LESS THAN ZERO SPEED ERRORS   =',SPDERRCNT(8.0C), printo=2
ENDIF

ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\NTNET00L.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00L.PRN" MSG='Process Highway Network'
FILEO LINKO = "{Scenario_Dir}\output\LINK4CNT.DBF",
 FORMAT=DBF, INCLUDE=A,B,NAME
FILEI LOOKUPI[2] = "{Scenario_Dir}\output\SPDCAP.CSV"
FILEI LOOKUPI[1] = "{Scenario_Dir}\output\MVFACTORS.CSV"
FILEI LINKI[3] = "{Scenario_Dir}\input\TOLLLINK.{YEAR}{ALT}",
 var=TOLL,beg=1,len=2,  
 var=TOLLTYPE,beg=3,len=2,
 var=A,beg=5,len=5, 
 var=B,beg=11,len=5, 
 var=PLAZADESC,beg=18,len=25,typ=a,
 var=PLZALNSMIN,beg=44,len=2,
 var=PLZALNSMAX,beg=47,len=2,
 var=CARTOLL,beg=50,len=5,
 var=SVCMINUTES,beg=56,len=1,
 var=SVCSECONDS,beg=58,len=2,
 var=DECELCODE,beg=61,len=1,
 var=ACCELCODE,beg=63,len=1,
 var=EXACTCHGLNS,beg=65,len=2,
 var=AVILANES,beg=68,len=2,
 var=PCTTRUCKS,beg=71,len=4,
START=(substr(record,4,1)=='1'),
STOP=(SUBSTR(RECORD,1,1)=='C')
FILEI LINKI[1] = "{CATALOG_DIR}\Parameters\MicroCodedHnet42.net"
FILEO NETO = "{Scenario_Dir}\output\TEMP.NET",
    INCLUDE=A,B,TOLL,TOLLTYPE,PLAZADESC,PLZALNSMIN,PLZALNSMAX,CARTOLL,SVCMINUTES,SVCSECONDS,DECELCODE,
           ACCELCODE,EXACTCHGLNS,AVILANES,PCTTRUCKS,DISTANCE,NAME,ALT_NAME,COFIPS,COUNTY,DISTRICT,
           SCREENLINE,PSCF_YR00,CNT_SRC_YR00,STN_ID_YR00,CONSTR_00A,ROADDIR,LEVEL,TMODE,TTIME,EECODE,TOLLID,
           IDLINK,COUNT_YR00,TCARD,TC,TV,VC,TWOWAY_{Year}{alt},DISTANCEFT,FACILITY_TYPE,AREA_TYPE,
           NUM_LANES,UROADFACTOR,CONFAC,BPRCOEFFICIENT,BPREXPONENT,CAPACITY,SPEED,TIME,TIME2,HOT,
           WALKTIME,TBSDIST,TBSTIME,TFGDIST,TFGTIME,TFGMODE,PNRTERMTIME,KNRTERMTIME,
           STN_ID,AADT_YR05,CNTYR,YRADJUST,COUNTDESC,CNTSRC_YR05,MOCF_YR05,PSCF_YR05,COUNT_YR05,COUNT,SELSPDADJ,AADT10

PAR  LIST_ERRS=0 MAX_IP_ERRS=10000
ARRAY _ATCNT=99,_FTCNT=99
LOOKUP, NAME=MVFACTORS, 
    LOOKUP[1]=1, RESULT=2,
    LOOKUP[2]=1, RESULT=3,
    LOOKUP[3]=1, RESULT=4,
    LOOKUP[4]=1, RESULT=5,
    LOOKUP[5]=1, RESULT=6,
    LOOKUP[6]=1, RESULT=7,
    LOOKUP[7]=1, RESULT=8,
    LOOKUP[8]=1, RESULT=9,
    INTERPOLATE=N, LOOKUPI=1
LOOKUP, NAME=SPDCAP, 
    LOOKUP[1]=1, RESULT=2,
    LOOKUP[2]=1, RESULT=3,
    INTERPOLATE=N, LOOKUPI=2

PROCESS PHASE=LINKMERGE
; if no distance in network, calculate one (in feet)
if (distance=0)  distance=sqrt((a.x-b.x)^2+(a.y-b.y)^2)
distanceft=distance
distance=distance/5280
DISTANCEFT=ROUND(DISTANCEFT) ; DISTANCE TO ONE FOOT IS SUFFICIENT 
FACILITY_TYPE=FTYPE_{YEAR}{ALT}
AREA_TYPE=ATYPE_{YEAR}{ALT}
NUM_LANES=LANES_{YEAR}{ALT}
IF (FACILITY_TYPE=0) DELETE
; PUT MVFACTORS ON NETWORK
  linkcnt=1
  UROADFACTOR=MVFACTORS(1,FACILITY_TYPE)
  CONFAC=MVFACTORS(2,FACILITY_TYPE)              ;24-Hour Confac
  BPRCOEFFICIENT=MVFACTORS(3,FACILITY_TYPE)
  BPREXPONENT=MVFACTORS(4,FACILITY_TYPE)
  CONFACAMP=MVFACTORS(5,FACILITY_TYPE)           ;AM Peak (07:30-09:30) Period Confac
  CONFACMDP=MVFACTORS(6,FACILITY_TYPE)           ;Mid-Day (09:30-15:30) Period Confac
  CONFACPMP=MVFACTORS(7,FACILITY_TYPE)           ;PM Peak (15:30-18:30) Period Confac
  CONFACNTP=MVFACTORS(8,FACILITY_TYPE)           ;Overnight (18:30-07:00) Period Confac

; PUT SPEEDS AND CAPACITIES ON NETWORK
  _INDEXVAL=10000*AREA_TYPE+100*FACILITY_TYPE+NUM_LANES
  CAPACITY=SPDCAP(1,_INDEXVAL)
;following code modified to make the model work with the new highway network
;COUNT=ROUND(COUNT_{VALYEAR}*PSCF_{VALYEAR})
;PSCF=PSCF_{VALYEAR}

;sks-IMP-Fix later on next two records
;PSCF1=val(PSCF)
;COUNT=ROUND(COUNT_{VALYEAR}*PSCF1)

;==================================================================================
;Save Year 2000 count as Count_YR00
Count_YR00=COUNT2000

;sks-count based on 2005 AADT
if (MOCF_YR05<>0)
   PSCF_YR05=(1.0/MOCF_YR05)
 else
  PSCF_YR05=1.0
endif
;Note on AADT_YR05: AADT_05 is directional 2005 AADT (ref. FDOT Traffic CDROM) for freeways and other directionally coded facilities.
;                 For nondirectional facilities, AADT_YR05 are total of two directions.
;YRADJUST attribute represents for few external station counts that are not for year 2005. For count year of 2005 YRADJUST is 1.0.
;COUNT_YR05 is directional 2005 counts

if (TWOWAY_05A=1)
  COUNT_YR05=AADT_YR05*YRADJUST*PSCF_YR05*0.5
 else
  COUNT_YR05=AADT_YR05*YRADJUST*PSCF_YR05
endif

;Pass Year 2005 count to "count" field
Count=COUNT_YR05


;================================================================================

 
  SPEED=SPDCAP(2,_INDEXVAL)

  IF (SPEED!=0)
    TIME=60*(DISTANCEFT/5280)/SPEED
    TIME2=60*(DISTANCEFT/5280)/SPEED
  ENDIF
 
;sks-11/3/08 (comment out round off action on TIME and TIME2)
;  TIME=ROUND(TIME*100)/100
;  TIME2=ROUND(TIME2*100)/100

  if (time<0.01) time=0.01
  if (time2<0.01) time2=0.01
; PUT WALKTIME ON NETWORK
  WALKTIME=ROUND(100*(DISTANCEFT/5280)/2.5*60)/100
  _ATCNT[AREA_TYPE]=_ATCNT[AREA_TYPE]+1
  _FTCNT[FACILITY_TYPE]=_FTCNT[FACILITY_TYPE]+1
ENDPROCESS

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\NTMAT00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Counts Times Nodes Used by Links'
FILEO RECO[1] = "{Scenario_Dir}\output\NODECNT.DBF",
 FIELDS=N,TIMESUSED
FILEI RECI = "{Scenario_Dir}\output\LINK4CNT.DBF"

ARRAY NODECNT=999999

NODECNT[RI.A]=NODECNT[RI.A]+1
NODECNT[RI.B]=NODECNT[RI.B]+1
IF (RI.A>HINODE) HINODE=RI.A
IF (RI.B>HINODE) HINODE=RI.B

IF (I=0)

  LOOP RO.N=1,HINODE
    IF (NODECNT[RO.N]>0)
     RO.TIMESUSED=NODECNT[RO.N] 
     WRITE RECO=1
    ENDIF
  ENDLOOP

ENDIF

ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\NTNET00M.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00M.PRN" MSG='Flags Toll Accel/Decel Nodes'
FILEI LINKI[1] = "{Scenario_Dir}\output\TEMP.NET"
FILEO PRINTO[1] = "{Scenario_Dir}\output\TEMPNODE.DAT"

;if (li.1.toll>0)  
if ((li.1.toll>0)&(li.1.tolltype=1))  ; Note: Tolltype 2 may not get any acceleration/decelration codes
  a_accel=0
;  a_decel=1 ; commented out for ORT
;  a_decel=0 ; added for ORT
  a_decel=1 

;  b_accel=1 ; commented out for ORT
;  b_accel=0 ; added for ORT
  b_accel=1 
  b_decel=0
  PRINT form=0, LIST=A,' ',a_accel,' ',a_decel,printo=1
  PRINT form=0, LIST='NODE= ',A,' ACCEL_NODE= ',a_accel,' DECEL_NODE= ',a_decel
  PRINT form=0, LIST=B,' ',b_accel,' ',b_decel,printo=1
  PRINT form=0, LIST='NODE= ',B,' ACCEL_NODE= ',b_accel,' DECEL_NODE= ',b_decel
endif



ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\NTNET00N.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{Scenario_Dir}\output\HNET.PRN" MSG='Assigns Accel/Decel Attributes to Links'
FILEO PRINTO[3] = "{Scenario_Dir}\output\XY_{alt}{year}.DAT"
FILEI NODEI[3] = "{Scenario_Dir}\output\NODECNT.DBF"
FILEO PRINTO[2] = "{Scenario_Dir}\output\LINKS.{YEAR}{ALT}"
FILEO PRINTO[1] = "{Scenario_Dir}\output\NODES.CSV"
FILEI LOOKUPI[1] = "{Scenario_Dir}\input\TSPDS.CSV"
FILEO NETO = "{Scenario_Dir}\output\UNLOADEDpre.NET"
FILEI LINKI[1] = "{Scenario_Dir}\output\TEMP.NET"
FILEI NODEI[2] = "{Scenario_Dir}\output\TEMPNODE.DAT",
 VAR=N,_TOLL_ACC,_TOLL_DEC

PAR ZONES={ZONESA}


PROCESS  PHASE=INPUT, FILEI=LI.1
  TOLL_ACC=0
  TOLL_DEC=0
ENDPROCESS

PROCESS PHASE=NODEMERGE
   PRINT CSV=T, LIST=N(8.0),X,Y printo=1
   PRINT LIST=N(6.0),X(20.2),Y(20.2) printo=3
   IF (TIMESUSED=0) DELETE
ENDPROCESS

PROCESS PHASE=LINKMERGE   
  IF(B._TOLL_DEC=1) TOLL_DEC=1
  IF(A._TOLL_ACC=1) TOLL_ACC=1

_focus=1
_ft=int(facility_type/10)
_at=int(area_type/10)
print list=_focus(2.0),a(5.0),b(5.0),distance*100/5280(4.0),toll(2.0),_ft(1.0),_at(1.0), printo=2



;sks (5-11-2011) (Check CARTOLL NON-Zero but SVCSEC IS ZERO, then add a small/tiny SVCSEC)...

IF (CARTOLL>0 & SVCSECONDS=0) SVCSECONDS=0.00001
IF (CARTOLL>0 & PLZALNSMAX=0) PLZALNSMAX=NUM_LANES

ENDPROCESS



ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\NTNET00T.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00I.PRN" MSG='Incorporate few minor changes that was in RTS 2-hour peak period assignment'
FILEI LINKI[1] = "{Scenario_Dir}\output\UNLOADEDpre.NET"
FILEO NETO = "{Scenario_Dir}\output\UNLOADED.NET"

PROCESS PHASE=LINKMERGE

;sks-12/18/2008 - Incorporate few corridor level speed adjustment usin field (SELSPDADJ)
;                 This was done by comparing model initial speed with posted speed limit of FHD

 if (SELSPDADJ<>0)
  SPEED=SPEED+(SELSPDADJ)  ;Selected corridor level speed adjustment
 endif

;; adjust number of lanes on I-95 (based on Google Earth - AECOM / 09/07/2007)

;Corradino(8/21/08): Comment out the SB & NB I-95 lane modification after confirming that with the original input/master network.
;                    Note this script specific modification may not hold for future alternative scenarios.

;Start comment on I-95 lane modification:
/* 
; SB on I-95
if (A=34374 & B=74008) NUM_LANES=4
if (A=74008 & B=34569) NUM_LANES=4
if (A=34569 & B=34601) NUM_LANES=4
if (A=34601 & B=34658) NUM_LANES=4
if (A=34658 & B=74014) NUM_LANES=4
if (A=74014 & B=34767) NUM_LANES=4
if (A=34767 & B=35094) NUM_LANES=4
if (A=35094 & B=74034) NUM_LANES=5
if (A=74034 & B=35233) NUM_LANES=5
if (A=37006 & B=74146) NUM_LANES=3
if (A=74146 & B=74164) NUM_LANES=3
if (A=74164 & B=74174) NUM_LANES=3
if (A=74174 & B=37766) NUM_LANES=3
if (A=37766 & B=37880) NUM_LANES=3
if (A=37880 & B=74187) NUM_LANES=3
if (A=74187 & B=74197) NUM_LANES=3
if (A=74197 & B=38649) NUM_LANES=3
if (A=38649 & B=74238) NUM_LANES=3
if (A=74238 & B=74242) NUM_LANES=3
if (A=74242 & B=39041) NUM_LANES=3
if (A=39041 & B=39276) NUM_LANES=3
if (A=39276 & B=74256) NUM_LANES=3
if (A=74256 & B=39392) NUM_LANES=3
if (A=39392 & B=39406) NUM_LANES=3
if (A=39547 & B=39633) NUM_LANES=2    ;ramp at I-95/US1/US90
if (A=39633 & B=74303) NUM_LANES=2    ;ramp at I-95/US1/US90
if (A=74303 & B=74305) NUM_LANES=2    ;ramp at I-95/US1/US90
if (A=74305 & B=74841) NUM_LANES=2    ;ramp at I-95/US1/US90
if (A=74841 & B=40752) NUM_LANES=2    ;ramp at I-95/US1/US90
if (A=40752 & B=40781) NUM_LANES=4
if (A=40555 & B=40568) NUM_LANES=4
;NB on I-95
if (A=40777 & B=40627) NUM_LANES=2
if (A=40627 & B=74840) NUM_LANES=2
if (A=74840 & B=39513) NUM_LANES=2
if (A=39172 & B=74244) NUM_LANES=3
if (A=74244 & B=74234) NUM_LANES=3
if (A=74234 & B=38650) NUM_LANES=3
if (A=38650 & B=74189) NUM_LANES=3
if (A=74189 & B=74179) NUM_LANES=3
if (A=74179 & B=37866) NUM_LANES=3
if (A=37866 & B=37765) NUM_LANES=3
if (A=37765 & B=74172) NUM_LANES=3
if (A=74172 & B=74166) NUM_LANES=3
if (A=74166 & B=74148) NUM_LANES=3
if (A=74148 & B=37039) NUM_LANES=3
if (A=37039 & B=36950) NUM_LANES=3
if (A=35102 & B=34775) NUM_LANES=3   ;reduced from 4 lanes to 3
if (A=34775 & B=74016) NUM_LANES=3
if (A=74016 & B=34664) NUM_LANES=3
if (A=34664 & B=34607) NUM_LANES=3
if (A=34607 & B=34576) NUM_LANES=3
if (A=34576 & B=34420) NUM_LANES=4
if (A=34420 & B=34398) NUM_LANES=4
if (A=34398 & B=34370) NUM_LANES=4

*/ 
;End comment on I-95 lane modification:

; adjust speeds
 if (SPEED!=0)
  SPEED=(SPEED + 0.00001)  ; AECOMS global addition was 5 MPH
 else
  SPEED=0
 endif

;Start comment on AECOM's changes (since they were brought in SPDCAP and VFACTORS:
/* 

 if (FACILITY_TYPE=11-12 & AREA_TYPE=22-60 & AREA_TYPE<>35) SPEED=70 ;interstate outside the CBD, <>35 takes care of I-95 bridge
 if (FACILITY_TYPE=12 & AREA_TYPE=35) SPEED=65 ;takes care of I-295 bridges on StJohns
 if (FACILITY_TYPE=16 & AREA_TYPE=35 & NUM_LANES=3) SPEED=30 ;takes care of Acosta Bridge
 if (FACILITY_TYPE=16 & AREA_TYPE=35 & NUM_LANES<3) SPEED=45 ;takes care of Hart and Mathews Bridge
 if (FACILITY_TYPE=35 & AREA_TYPE=35) SPEED=55 ;takes care of Shands Bridge
; if (FACILITY_TYPE=21-24) SPEED=SPEED+10 ;divided arterials - this increases the speed by 15 overall
 if (FACILITY_TYPE=21) SPEED=60 ;divided arterials unsignalized
 if (FACILITY_TYPE=22) SPEED=45 ;divided arterials unsignalized
 if (FACILITY_TYPE=23 & AREA_TYPE=21-30) SPEED=45 ;divided arterials class 1a
 if (FACILITY_TYPE=23 & AREA_TYPE=31-40) SPEED=50 ;divided arterials class 1a
 if (FACILITY_TYPE=23 & AREA_TYPE=41-50) SPEED=40 ;divided arterials class 1a
 if (FACILITY_TYPE=24 & AREA_TYPE=21-30) SPEED=40 ;divided arterials class 1b
 if (FACILITY_TYPE=24 & AREA_TYPE=31-40) SPEED=45 ;divided arterials class 1b
 if (FACILITY_TYPE=24 & AREA_TYPE=41-50) SPEED=40 ;divided arterials class 1b
 if (FACILITY_TYPE=71-79) SPEED=SPEED+10 ;ramps - this increases the speed by 15 overall
 if (FACILITY_TYPE=29) SPEED=1 ;Mayport ferry

; adjust capacity
 if (FACILITY_TYPE=11-19) UROADFACTOR=0.95 ; freeways (changed from 0.9 to 0.95)
 if (FACILITY_TYPE=71-79) UROADFACTOR=1.00 ; ramps (changed from 0.9 to 1.00)
 if (FACILITY_TYPE=24 & AREA_TYPE=41-49) UROADFACTOR=1.00 ; Class 1b in OBD (take care of Orange Mall area)
 if (FACILITY_TYPE>=21 & FACILITY_TYPE<=29 & NUM_LANES>=3) CAPACITY=CAPACITY+200 
 if (FACILITY_TYPE>=11 & FACILITY_TYPE<=19 & NUM_LANES>=3) CAPACITY=CAPACITY+200 


*/ 
;End comment on AECOM's changes (since they were brought in SPDCAP and VFACTORS:

  IF (SPEED!=0)
    TIME=60*(DISTANCEFT/5280)/SPEED
    TIME2=60*(DISTANCEFT/5280)/SPEED
  ENDIF

; SECTION ADDED BY SKS following I-95 (SERPM65) Corridor Study Logic
; HOT= (any negative value) means that the link, for whatever reason, should not be in the network
; Thus it is deleted here.
; Possible reasons are that it has not yet been buit, or it is a ramp left over from HOV analysis, etc.
If(HOT <0) FACILITY_TYPE=69 ; in-active HOT links:MAKE TRANSIT ONLY - not available for highway, but buses are allowed.

;sks-11/3/08 (comment out round off action on TIME and TIME2)
;  TIME=ROUND(TIME*100)/100
;  TIME2=ROUND(TIME2*100)/100

  if (time<0.01) time=0.01
  if (time2<0.01) time2=0.01

ENDPROCESS

ENDRUN


; Script for program HIGHWAY in file "C:\NERPM43\APPLICATIONS\NTHWY00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY PRNFILE="C:\NERPM43\APPLICATIONS\NTHWY00A.PRN" MSG='Build Skims and Terminal Time Matrix'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEI LOOKUPI[1] = "{Scenario_Dir}\input\TERMTIME.CSV"
FILEI TURNPENI = "{Scenario_Dir}\input\tcards_{Year}{alt}.pen"
FILEO MATO[1] = "{Scenario_Dir}\output\FHSKIMS.MAT",
 MO=1-9 NAME=Toll,Distance,Time,WtdTime,HOVToll,HOVDistance,HOVTime,HOVWtdTime,TerminalTime
FILEI NETI = "{Scenario_Dir}\output\UNLOADED.NET"

PAR ZONEMSG=100

; ARRAY TERMINAL TIMES INTO MEMORY
ARRAY ATYPE={ZONESA}
LOOKUP, NAME=TERMTIME, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LOOKUPI=1
PROCESS PHASE=LINKREAD
   lw.distance=li.distanceft/5280; CONVERTS DISTANCES FROM NETWORK (FEET) TO MILES FOR SKIMS
   IF (LI.FACILITY_TYPE=80-89) ADDTOGROUP=1
   IF (LI.FACILITY_TYPE=49 | LI.FACILITY_TYPE=59 | LI.FACILITY_TYPE=69) ADDTOGROUP=9   ; AK-these are transit only links/fixed guideways
   IF (A<={ZONESA})  ; FLAGS LAST ENCOUNTERED LINK FOR TERMINAL TIME CALCULATION LATER
        ATYPE[A]=LI.AREA_TYPE
        PRINT LIST=A,LI.AREA_TYPE
   ENDIF
   LW.TIME=li.time+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60
ENDPROCESS

PROCESS PHASE=ILOOP
   PATHLOAD PATH=LW.TIME, PENI=1,                                 ;LOV Skims - Sks (use Path LW.TIME) - earlier was on LI.TIME
      MW[1]=PATHTRACE(LI.CARTOLL), NOACCESS=999.99,dec=2,
      MW[2]=PATHTRACE(LW.DISTANCE), NOACCESS=999.99,dec=2,
      MW[3]=PATHTRACE(LI.TIME), NOACCESS=999.99,dec=3,
      MW[4]=PATHTRACE(LW.TIME), NOACCESS=999.99,dec=3,
      EXCLUDEGROUP=1,9

   PATHLOAD PATH=LW.TIME, PENI=1,                                ;HOV Skims - Sks (use Path LW.TIME) - earlier was on LI.TIME
      MW[5]=PATHTRACE(LI.CARTOLL), NOACCESS=999.99,dec=2,
      MW[6]=PATHTRACE(LW.DISTANCE), NOACCESS=999.99,dec=2,
      MW[7]=PATHTRACE(LI.TIME), NOACCESS=999.99,dec=3,
      MW[8]=PATHTRACE(LW.TIME), NOACCESS=999.99,dec=3,
      EXCLUDEGROUP=9
; intrazonal array
;(precede this comment with block comment to disable) DISABLE THE INTRAZONAL TO MIMIC TRANPLAN VALIDATION RESULTS
deno={AVEZONE}*2.0
loop _ww=1,8
  mw[_ww][i]=lowest(_ww,{AVEZONE})/deno
endloop
; set intrazonal array to zero for cost
mw[1][i]=0
mw[5][i]=0

;set intrazonal travel times at externals to very high numbers
jloop
  if (j>={ExtZnStrt} & i=j)
    mw[3][i]=999999
    mw[4][i]=999999
    mw[7][i]=999999
    mw[8][i]=999999
 ; else
  endif
endjloop
;finish set intrazonal travel times at externals to very high numbers

;(precede this comment with block comment to close disable) END DISABLE INTRAZONAL CALCULATIONS
; BUILD TERMINAL TIME MATRIX
JLOOP
    ATYPEI=ATYPE[I]
    ATYPEJ=ATYPE[J]
    TERMTI=TERMTIME(1,ATYPEI)
    TERMTJ=TERMTIME(1,ATYPEJ)
    MW[9]=TERMTI+TERMTJ
ENDJLOOP

ENDPROCESS

ENDRUN


