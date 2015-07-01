; Script for program PUBLIC TRANSPORT in file "C:\NERPM50\applications\ASPTR00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00A.PRN" MSG='Load Peak Trips to Transit Network (LEG Reports)'
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHPK9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHPK8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHPK7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHPK6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHPK5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHPK4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHPK2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHPK1_{Alt}{year}.RTE"
FILEO NTLEGO = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.NTL"
FILEO LINKO = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.DBF",
NTLEGS=N,ONOFFS=T
;FILEO LINKO[1] = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.DBF",
;NTLEGS=N,ONOFFS=T
;FILEO LINKO[2] = "{SCENARIO_DIR}\output\TLOAD2PK_{alt}{year}.DBF",
;NTLEGS=N,ONELINKREC=T
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00E.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES={RunUserClasses},HDWAYPERIOD=1,
    TRIPSIJ[1]=MI.1.1,   ;walkbus
    TRIPSIJ[2]=MI.1.2,   ;walkprem
    TRIPSIJ[3]=MI.1.3,   ;pnrbus
    TRIPSIJ[4]=MI.1.4,   ;pnrprem
    TRIPSIJ[5]=MI.1.5,   ;knrbus
    TRIPSIJ[6]=MI.1.6,   ;knrprem
    TRIPSIJ[7]=MI.1.7,   ;knrbus
    TRIPSIJ[8]=MI.1.8,   ;knrprem
    TRIPSIJ[9]=MI.1.9    ;fringe

REPORT LINES=T, LINEVOLS=T

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM50\applications\ASPTR00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00D.PRN" MSG='Load Off-peak Trips to Transit Network (LEG Reports)'
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHOP9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHOP8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHOP6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHOP4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHOP2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHOP1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEO LINKO = "{SCENARIO_DIR}\output\TLOADOP_{alt}{year}.DBF",
NTLEGS=N,ONOFFS=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00F.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\TLOADOP_{alt}{year}.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999, USERCLASSES={RunUserClasses},HDWAYPERIOD=2, 
    TRIPSIJ[1]=MI.1.10,
    TRIPSIJ[2]=MI.1.11,
    TRIPSIJ[3]=MI.1.12,
    TRIPSIJ[4]=MI.1.13,
    TRIPSIJ[5]=MI.1.14,
    TRIPSIJ[6]=MI.1.15,
    TRIPSIJ[7]=MI.1.16,
    TRIPSIJ[8]=MI.1.17,
    TRIPSIJ[9]=MI.1.18

REPORT LINES=T, LINEVOLS=T


ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; Run TAREPORT

copy,
 FILE = "C:\NERPM50\APPLICATIONS\TAREPORT.CTL"
; TAREPORT program files
a    {YEAR}{ALT}
p    {SCENARIO_DIR}\output\TLOADPK_{ALT}{YEAR}.DBF
o    {SCENARIO_DIR}\output\TLOADOP_{ALT}{YEAR}.DBF
endcopy

*TAREPORT.exe
*move tasum_{alt}{year}.prn "{SCENARIO_DIR}\output\"
*move tasroute_{alt}{year}.prn "{SCENARIO_DIR}\output\"
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "C:\NERPM50\APPLICATIONS\ASPTR00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00E.PRN" MSG='Load Peak Trips to Transit Network (LINK Reports)'
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHPK9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHPK8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHPK7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHPK6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHPK5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHPK4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHPK2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHPK1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO NTLEGO = "{SCENARIO_DIR}\output\ASPTR00C.NTL"
FILEO LINKO = "{SCENARIO_DIR}\output\TLINKPK_{alt}{year}.DBF",
  ONELINKREC=T,NTBYLINK=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00F.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\ASPTR00C.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES={RunUserClasses},HDWAYPERIOD=1,
    TRIPSIJ[1]=MI.1.1,   ;walkbus
    TRIPSIJ[2]=MI.1.2,   ;walkprem
    TRIPSIJ[3]=MI.1.3,   ;pnrbus
    TRIPSIJ[4]=MI.1.4,   ;pnrprem
    TRIPSIJ[5]=MI.1.5,   ;knrbus
    TRIPSIJ[6]=MI.1.6,   ;knrprem
    TRIPSIJ[7]=MI.1.7,   ;knrbus
    TRIPSIJ[8]=MI.1.8,   ;knrprem
    TRIPSIJ[9]=MI.1.9    ;fringe

REPORT LINES=T, LINEVOLS=T

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM50\APPLICATIONS\ASPTR00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00G.PRN" MSG='Load Off-peak Trips to Transit Network (LINK Reports)'
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHOP9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHOP8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHOP6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHOP4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHOP2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHOP1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO LINKO = "{SCENARIO_DIR}\output\TLINKOP_{alt}{year}.DBF",
  ONELINKREC=T,NTBYLINK=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00H.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\ASPTR00D.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999, USERCLASSES={RunUserClasses},HDWAYPERIOD=2,
    TRIPSIJ[1]=MI.1.10,
    TRIPSIJ[2]=MI.1.11,
    TRIPSIJ[3]=MI.1.12,
    TRIPSIJ[4]=MI.1.13,
    TRIPSIJ[5]=MI.1.14,
    TRIPSIJ[6]=MI.1.15,
    TRIPSIJ[7]=MI.1.16,
    TRIPSIJ[8]=MI.1.17,
    TRIPSIJ[9]=MI.1.18

REPORT LINES=T, LINEVOLS=T


ENDRUN


; Script for program NETWORK in file "C:\NERPM50\APPLICATIONS\ASNET00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\ASNET00B.PRN" MSG='Add link volumes to network for display'
FILEI LINKI[3] = "{SCENARIO_DIR}\output\TLINKOP_{alt}{year}.DBF"
FILEI LINKI[2] = "{SCENARIO_DIR}\output\TLINKPK_{alt}{year}.DBF"
FILEO NETO = "{SCENARIO_DIR}\output\TransitLinkLoad.NET",
  INCLUDE=A,B,NTVOL_PK,TVOL_PK,NTVL_OP,TVOL_OP,TOTAL_VOLUME
FILEI LINKI[1] = "{SCENARIO_DIR}\output\TransitPK.NET"

MERGE RECORD=F

PROCESS  PHASE=LINKMERGE
  NTVOL_PK = LI.2.NTVOL
  TVOL_PK  = LI.2.TVOL
  NTVOL_OP = LI.3.NTVOL
  TVOL_OP  = LI.3.TVOL
  TOTAL_VOLUME = LI.2.NTVOL + LI.2.TVOL + LI.3.NTVOL + LI.3.TVOL
ENDPROCESS

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM50\APPLICATIONS\ASPTR00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00I.PRN" MSG='Load Peak Trips to Transit Network (LEG Reports) with NT legs'
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHPK9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHPK8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHPK7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHPK6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHPK5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHPK4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHPK2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHPK1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO NTLEGO = "{SCENARIO_DIR}\output\ASPTR00D.NTL"
FILEO LINKO = "{SCENARIO_DIR}\output\TLOADNTPK_{alt}{year}.DBF",
  NTLEGS=T,ONOFFS=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00J.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\ASPTR00E.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES={RunUserClasses},HDWAYPERIOD=1,
    TRIPSIJ[1]=MI.1.1,   ;walkbus
    TRIPSIJ[2]=MI.1.2,   ;walkprem
    TRIPSIJ[3]=MI.1.3,   ;pnrbus
    TRIPSIJ[4]=MI.1.4,   ;pnrprem
    TRIPSIJ[5]=MI.1.5,   ;knrbus
    TRIPSIJ[6]=MI.1.6,   ;knrprem
    TRIPSIJ[7]=MI.1.7,   ;knrbus
    TRIPSIJ[8]=MI.1.8,   ;knrprem
    TRIPSIJ[9]=MI.1.9    ;fringe

REPORT LINES=T, LINEVOLS=T

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM50\APPLICATIONS\ASPTR00J.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\ASPTR00K.PRN" MSG='Load Off-peak Trips to Transit Network (LEG Reports) with NT legs'
FILEI MATI[1] = "{SCENARIO_DIR}\output\TRANSITTAB_{alt}{year}.MAT"
FILEI ROUTEI[9] = "{SCENARIO_DIR}\output\TPATHOP9_{Alt}{year}.RTE"
FILEI ROUTEI[8] = "{SCENARIO_DIR}\output\TPATHOP8_{Alt}{year}.RTE"
FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI ROUTEI[6] = "{SCENARIO_DIR}\output\TPATHOP6_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATHOP4_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATHOP2_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHOP1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"
FILEO LINKO = "{SCENARIO_DIR}\output\TLOADNTOP_{alt}{year}.DBF",
  NTLEGS=T,ONOFFS=T
FILEO REPORTO = "{SCENARIO_DIR}\output\ASPTR00L.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\ASPTR00F.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999, USERCLASSES={RunUserClasses},HDWAYPERIOD=2,
    TRIPSIJ[1]=MI.1.10,
    TRIPSIJ[2]=MI.1.11,
    TRIPSIJ[3]=MI.1.12,
    TRIPSIJ[4]=MI.1.13,
    TRIPSIJ[5]=MI.1.14,
    TRIPSIJ[6]=MI.1.15,
    TRIPSIJ[7]=MI.1.16,
    TRIPSIJ[8]=MI.1.17,
    TRIPSIJ[9]=MI.1.18

REPORT LINES=T, LINEVOLS=T


ENDRUN


; Script for program MATRIX in file "C:\NERPM50\APPLICATIONS\ASMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\ASMAT00G.PRN" MSG='Create station report'
FILEI DBI[2] = "{SCENARIO_DIR}\output\TLOADNTOP_{alt}{year}.DBF"
FILEI DBI[1] = "{SCENARIO_DIR}\output\TLOADNTPK_{alt}{year}.DBF"
FILEI DBI[3] = "{SCENARIO_DIR}\INPUT\STATREP_{year}{alt}.DAT",
  BRTNODE=1-5, DESCR(C)=9-49
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\Stations.prn"


ARRAY STNUM=500 STNODE=500 STNAME=500
ARRAY pACCVOL1=500 pEGRVOL1=500 pACCVOL2=500 pEGRVOL2=500 pACCVOL3=500 pEGRVOL3=500 pACCVOL5=500 pEGRVOL5=500
ARRAY pACCVOL6=500 pEGRVOL6=500 pACCVOL11=500 pEGRVOL11=500 pACCVOL12=500 pEGRVOL12=500
ARRAY pBoard=500 pAlite=500
ARRAY oACCVOL1=500 oEGRVOL1=500 oACCVOL2=500 oEGRVOL2=500 oACCVOL3=500 oEGRVOL3=500 oACCVOL5=500 oEGRVOL5=500
ARRAY oACCVOL6=500 oEGRVOL6=500 oACCVOL11=500 oEGRVOL11=500 oACCVOL12=500 oEGRVOL12=500
ARRAY oBoard=500 oAlite=500

ZONES=1

LOOP k=1,DBI.3.NUMRECORDS
  COMP x=DBIReadRecord(3,k)
  STNUM[k] = k
  STNODE[k] = DI.3.BRTNODE
ENDLOOP
_numStations = DBI.3.NUMRECORDS

_temp = 0

; Peak Period
LOOP k=1,DBI.1.NUMRECORDS
  IF ((k % 1000)==0) PRINT LIST="Reading peak period records...",k(C)," of ",DBI.1.NUMRECORDS(C),PRINTO=0
  COMP x=DBIReadRecord(1,k)
  _A = DI.1.A
  _B = DI.1.B
;  IF ((_A == 35792,65943) || (_B == 35792,65943))
;    IF (_temp==0)
;      LIST="     An     Bn   M","    VOLUME","    ONA   OFFA    ONB   OFFB  R_ONA R_OFFA  R_ONB R_OFFB",PRINTO=1
;      _temp = 1
;    ENDIF
;    LIST=DI.1.A(7.0),DI.1.B(7.0),DI.1.MODE(4.0),DI.1.VOL(10.2),DI.1.ONA(7.2),DI.1.OFFA(7.2),DI.1.ONB(7.2),DI.1.OFFB(7.2),DI.1.REV_ONA(7.2),DI.1.REV_OFFA(7.2),DI.1.REV_ONB(7.2),DI.1.REV_OFFB(7.2),DI.1.NAME(50),PRINTO=1
;  ENDIF
  LOOP y=1,_numStations
    COMP w=DBIReadRecord(3,y)
    ; Access Volumes by Access Mode
    IF (_B == STNODE[y])
      IF (DI.1.MODE == 1) pACCVOL1[y] = pACCVOL1[y] + DI.1.VOL
      IF (DI.1.MODE == 2) pACCVOL2[y] = pACCVOL2[y] + DI.1.VOL
      IF (DI.1.MODE == 3) pACCVOL3[y] = pACCVOL3[y] + DI.1.VOL
      IF (DI.1.MODE == 5) pACCVOL5[y] = pACCVOL5[y] + DI.1.VOL
      IF (DI.1.MODE == 6) pACCVOL6[y] = pACCVOL6[y] + DI.1.VOL
      IF (DI.1.MODE ==11,12) pACCVOL11[y] = pACCVOL11[y] + DI.1.VOL
    ENDIF
    ; pEGRess Volumes by pEGRess Mode
    IF (_A == STNODE[y])
      IF (DI.1.MODE == 1) pEGRVOL1[y] = pEGRVOL1[y] + DI.1.VOL
      IF (DI.1.MODE == 2) pEGRVOL2[y] = pEGRVOL2[y] + DI.1.VOL
      IF (DI.1.MODE == 3) pEGRVOL3[y] = pEGRVOL3[y] + DI.1.VOL
      IF (DI.1.MODE == 5) pEGRVOL5[y] = pEGRVOL5[y] + DI.1.VOL
      IF (DI.1.MODE == 6) pEGRVOL6[y] = pEGRVOL6[y] + DI.1.VOL
      IF (DI.1.MODE ==11,12) pEGRVOL11[y] = pEGRVOL11[y] + DI.1.VOL
      IF (DI.1.MODE >= 20) pBOARD[y] = pBOARD[y] + DI.1.ONA
      IF (DI.1.MODE >= 20) pALITE[y] = pALITE[y] + DI.1.OFFA
    ENDIF
  ENDLOOP
ENDLOOP

; Off-peak Period
LOOP k=1,DBI.2.NUMRECORDS
  IF ((k % 1000)==0) PRINT LIST="Reading offpeak period records...",k(C)," of ",DBI.2.NUMRECORDS(C),PRINTO=0
  COMP x=DBIReadRecord(2,k)
  _A = DI.2.A
  _B = DI.2.B
  LOOP y=1,_numStations
    COMP w=DBIReadRecord(3,y)
    ; Access Volumes by Access Mode
    IF (_B == STNODE[y])
      IF (DI.2.MODE == 1) oACCVOL1[y] = oACCVOL1[y] + DI.2.VOL
      IF (DI.2.MODE == 2) oACCVOL2[y] = oACCVOL2[y] + DI.2.VOL
      IF (DI.2.MODE == 3) oACCVOL3[y] = oACCVOL3[y] + DI.2.VOL
      IF (DI.2.MODE == 5) oACCVOL5[y] = oACCVOL5[y] + DI.2.VOL
      IF (DI.2.MODE == 6) oACCVOL6[y] = oACCVOL6[y] + DI.2.VOL
      IF (DI.2.MODE ==11,12) oACCVOL11[y] = oACCVOL11[y] + DI.2.VOL
    ENDIF
    ; oEGRess Volumes by oEGRess Mode
    IF (_A == STNODE[y])
      IF (DI.2.MODE == 1) oEGRVOL1[y] = oEGRVOL1[y] + DI.2.VOL
      IF (DI.2.MODE == 2) oEGRVOL2[y] = oEGRVOL2[y] + DI.2.VOL
      IF (DI.2.MODE == 3) oEGRVOL3[y] = oEGRVOL3[y] + DI.2.VOL
      IF (DI.2.MODE == 5) oEGRVOL5[y] = oEGRVOL5[y] + DI.2.VOL
      IF (DI.2.MODE == 6) oEGRVOL6[y] = oEGRVOL6[y] + DI.2.VOL
      IF (DI.2.MODE ==11,12) oEGRVOL11[y] = oEGRVOL11[y] + DI.2.VOL
      IF (DI.2.MODE >= 20) oBOARD[y] = oBOARD[y] + DI.2.ONA
      IF (DI.2.MODE >= 20) oALITE[y] = oALITE[y] + DI.2.OFFA
    ENDIF
  ENDLOOP
ENDLOOP


IF (I == _ZONES)
  PRINT LIST="STATION ACTIVITY & ACCESS/EGRESS REPORT",PRINTO=1
  PRINT LIST="ALTERNATIVE: {ALT}{YEAR}",PRINTO=1
  PRINT LIST="\n\n",PRINTO=1

  PRINT LIST=" "(44),"       P E A K      ","    O F F P E A K   ","      D A I L Y     ",PRINTO=1
  PRINT LIST=" "(44),"    Access"(10),"    Egress"(10),"    Access"(10),"    Egress"(10),"    Access"(10),"    Egress"(10),PRINTO=1
  LOOP x=1,_numStations
    COMP y=DBIReadRecord(3,x)
    PRINT LIST=stnum[x](3.0),stnode[x](7.0),"  ",DI.3.DESCR(40),PRINTO=1
    PRINT LIST=" "(32),"PNR         ",pACCVOL2[x](10.1),pEGRVOL2[x](10.1),oACCVOL2[x](10.1),oEGRVOL2[x](10.1),(pACCVOL2[x]+oACCVOL2[x])(10.1),(pEGRVOL2[x]+oEGRVOL2[x])(10.1),PRINTO=1
    PRINT LIST=" "(32),"KNR         ",pACCVOL3[x](10.1),pEGRVOL3[x](10.1),oACCVOL3[x](10.1),oEGRVOL3[x](10.1),(pACCVOL3[x]+oACCVOL3[x])(10.1),(pEGRVOL3[x]+oEGRVOL3[x])(10.1),PRINTO=1
    PRINT LIST=" "(32),"Fringe      ",pACCVOL5[x](10.1),pEGRVOL5[x](10.1),oACCVOL5[x](10.1),oEGRVOL5[x](10.1),(pACCVOL5[x]+oACCVOL5[x])(10.1),(pEGRVOL5[x]+oEGRVOL5[x])(10.1),PRINTO=1
    PRINT LIST=" "(32),"CBD KNR     ",pACCVOL6[x](10.1),pEGRVOL6[x](10.1),oACCVOL6[x](10.1),oEGRVOL6[x](10.1),(pACCVOL6[x]+oACCVOL6[x])(10.1),(pEGRVOL6[x]+oEGRVOL6[x])(10.1),PRINTO=1
    PRINT LIST=" "(32),"Transfer    ",pACCVOL11[x](10.1),pEGRVOL11[x](10.1),oACCVOL11[x](10.1),oEGRVOL11[x](10.1),(pACCVOL11[x]+oACCVOL11[x])(10.1),(pEGRVOL11[x]+oEGRVOL11[x])(10.1),PRINTO=1
    PRINT LIST=" "(32),"Board/Alight",pBOARD[x](10.1),pALITE[x](10.1),oBOARD[x](10.1),oALITE[x](10.1),(pBOARD[x]+oBOARD[x])(10.1),(pALITE[x]+oALITE[x])(10.1),PRINTO=1
    PRINT LIST="\n",PRINTO=1
  ENDLOOP
ENDIF

ENDRUN


