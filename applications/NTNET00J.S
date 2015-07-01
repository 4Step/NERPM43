; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00I.PRN" MSG='Incorporate few minor changes that was in RTS 2-hour peak period assignment'
FILEI LINKI[1] = "C:\NERPM43\APPLICATIONS\NTNET00E.NET"
FILEO NETO = "{SCENARIO_DIR}\output\UNLOADED.NET"

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
