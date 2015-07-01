; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00A.PRN" MSG='PK Extract guideway time'
DISTRIBUTEINTRASTEP PROCESSID='NERPM4Dist', PROCESSLIST=1-%NUMBER_OF_PROCESSORS%,MinGroupSize=20,SavePrn=F
;DistributeINTRASTEP ProcessID='NERPM4Dist', ProcessList=1-4

FILEO MATO[4] = "{SCENARIO_DIR}\output\SELLINKPK7_{alt}{year}.MAT",
 MO=407-408,NAME=pkcbdknrbrttime,pkcbdknrbrtdist,DEC=2*2
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKPK5_{alt}{year}.MAT",
 MO=405-406,NAME=pkknrbrttime,pkknrbrtdist,DEC=2*2
FILEO MATO[2] = "{SCENARIO_DIR}\output\SELLINKPK3_{alt}{year}.MAT",
 MO=403-404,NAME=pkpnrbrttime,pkpnrbrtdist,DEC=2*2
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKPK1_{alt}{year}.MAT",
 MO=401-402,NAME=pkwalkbrttime,pkwalkbrtdist,DEC=2*2

FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\BRTlinktime.CSV"
FILEI MATI[4] = "{SCENARIO_DIR}\output\SELLINKPK7_TMP.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\SELLINKPK5_TMP.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP.MAT"

zonemsg=100

lookup lookupi=1,name=tabletime, lookup[1]=1, result=4, lookup[2]=1, result=5, fail=0 ;lookup1=distance on guideway, lookup2=time on guideway

numtables=@numBRTlinks._AK@

READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTREADFILE1.TXT"
READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTREADFILE2.TXT"
READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTREADFILE3.TXT"
READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTREADFILE4.TXT"

LOOP _ak=1,numtables
 MW[401]=MW[401]+MW[_ak]*tabletime(2,_ak)  ; time on guideway
 MW[402]=MW[402]+MW[_ak]*tabletime(1,_ak)  ; dist on guideway

 _ak1=_ak+100
 MW[403]=MW[403]+MW[_ak1]*tabletime(2,_ak)  ; time on guideway
 MW[404]=MW[404]+MW[_ak1]*tabletime(1,_ak)  ; dist on guideway

 _ak2=_ak+200
 MW[405]=MW[405]+MW[_ak2]*tabletime(2,_ak)  ; time on guideway
 MW[406]=MW[406]+MW[_ak2]*tabletime(1,_ak)  ; dist on guideway

 _ak3=_ak+300
 MW[407]=MW[407]+MW[_ak3]*tabletime(2,_ak)  ; time on guideway
 MW[408]=MW[408]+MW[_ak3]*tabletime(1,_ak)  ; dist on guideway
ENDLOOP

ENDRUN
