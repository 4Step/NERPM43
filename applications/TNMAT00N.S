; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00A1.PRN"
FILEI MATI[2] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP.MAT"
FILEO MATO[2] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP2.MAT",
 MO=203-204,NAME=pkautobrttime,pkautobrtdist,DEC=2*D
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP2.MAT",
 MO=201-202,NAME=pkwalkbrttime,pkwalkbrtdist,DEC=2*D
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\BRTlinktime.csv"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP.MAT"

zonemsg=100

lookup lookupi=1,name=tabletime, lookup[1]=1, result=4, lookup[2]=1, result=5, fail=0 ;lookup1=distance on guideway, lookup2=time on guideway

numtables=57

log prefix=brt var=numtables

;LOOP _ak=1,numtables
; FILLMW MW[_ak]=MI.1.'@_ak@'
;ENDLOOP

FILLMW MW[1]=MI.1.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57
FILLMW MW[101]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57

LOOP _ak=1,numtables
 MW[201]=MW[201]+MW[_ak]*tabletime(2,_ak)  ; time on guideway
 MW[202]=MW[202]+MW[_ak]*tabletime(1,_ak)  ; dist on guideway
ENDLOOP

LOOP _ak=1,numtables
 _ak1=_ak+100
 MW[203]=MW[203]+MW[_ak1]*tabletime(2,_ak)  ; time on guideway
 MW[204]=MW[204]+MW[_ak1]*tabletime(1,_ak)  ; dist on guideway
ENDLOOP

ENDRUN
