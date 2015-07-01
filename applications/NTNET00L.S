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
