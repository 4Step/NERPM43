; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\TNPTR00E.PRN"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHPK1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\TNPTR00F.PRN"
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP.MAT",
 MO=1-58,DEC=58*S
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP.MAT",
 MO=1-58,DEC=58*S

FILEO NETO = "{SCENARIO_DIR}\output\SELLINKPK_TMP.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES={RunUserClasses},HDWAYPERIOD=1,
    TRIPSIJ[1]=1,
    TRIPSIJ[2]=1,
    TRIPSIJ[3]=1,
    TRIPSIJ[4]=1

; REPORT LINES=T, LINEVOLS=T

PHASE=SKIMIJ

if ({isFutureYearAlternative} == 1) then
 if ({iSBRTProjectMode} == 1)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS1.TXT"   ;mw1-57
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS.TXT"    ;mw58
/*
  MW[2] =SELECTLINK(OPERATOR=3)               ; premium mode operator
  MW[3] =SELECTLINK(OPERATOR=1 & OPERATOR=3)  ; both premium and local bus are used (these interchange should have atleast one transfer)
  MW[4] =SELECTLINK(MODE=21-27)               ; total trips (interchanges with transit path)
;  MW[5] =SELECTLINK(N=80011-80069)            ; trips which uses one of the BRT stops 
  MW[6] =SELECTLINK(OPERATOR=1-2)             ; local bus and express bus trips
  MW[7] =MW[7] + SELECTLINK(OPERATOR=1)       ; trying to replicate mat 6
  MW[7] =MW[7] + SELECTLINK(OPERATOR=2)
  MW[8] =SELECTLINK(MODE=21)                  ; local bus and premium bus (both are coded as the same mode)
  MW[9] =SELECTLINK(N=80001-80008)            ; skyway trips
  MW[10] =SELECTLINK(OPERATOR=6)              ; trolley trips
  MW[11] =SELECTLINK(OPERATOR=7)              ; skyway trips
  MW[12]=SELECTLINK(MODE=23)                  ; skyway and trolley
;  MW[13]=SELECTLINK(LINE=E-2*,E SW-302*,H?2*,I?6*,K?2*,L?7*,L?8*,M?4*,N?6*,NS?9*,NS?SS*,O?1*,P?2*,P?7*,R?1*,R?5*,SS?7*)
;  MW[14]=SELECTLINK(N=1-99999)
;  MW[15]=SELECTLINK( (N=80011-80069 + OPERATOR=3) )    ; trips which uses BRT stops and premium bus
  MW[16]=SELECTLINK(L=80001-80002*,80002-80003*,80003-80004*)
  MW[17]=SELECTLINK(L=80004-80005*,80003-80006*,80006-80007*,80007-80008*)
  MW[18]=SELECTLINK(L=80001-80002*,80002-80003*,80003-80004*,80004-80005*,80003-80006*,80006-80007*,80007-80008*)
;  MW[19]=SELECTLINK( (N=80011-80069 & OPERATOR=3) )    ; trips which uses BRT stops and premium bus
  MW[20]=1
*/
 else
  MW[1]=SELECTLINK(OPERATOR=5)       ; Commuter rail operator
 endif
else
  MW[1] = 0
endif

ENDPHASE


ENDRUN
