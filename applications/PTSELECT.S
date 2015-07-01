; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

if ({isFutureYearAlternative}=1)
; End of PILOT Script

; Script for program NETWORK in file "D:\JTA RTS Model\APPLICATIONS\SENET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\SENET00A.PRN" MSG='Prepare files for BRT analysis'
FILEO PRINTO[7] = "{SCENARIO_DIR}\output\BRTreadfile4.TXT"
FILEO PRINTO[6] = "{SCENARIO_DIR}\output\BRTreadfile3.TXT"
FILEO PRINTO[5] = "{SCENARIO_DIR}\output\BRTreadfile2.TXT"
FILEO PRINTO[4] = "{SCENARIO_DIR}\output\BRTreadfile1.TXT"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\BRTlinktime.CSV"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\BRTLinks.TXT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\BRTLinks1.TXT"

ARRAY CBDNODETMP=99999, CBDNODE=99999, BRTSTATIONS=500

PHASE=LINKMERGE

; Store BRT nodes for SELECTLINK analysis
    if ( (FACILITY_TYPE=69) && (LI.1.A > 80010) && (LI.1.B > 80010) && (LI.1.A < LI.1.B) )   ; pick up the BRT Links (does not include the Skyway Links)
     if (_idx=0)
       _AK=1
       print form=5.0, list = "MW[58] = SELECTLINK(L = ", LI.1.A, "-", LI.1.B, "*", printo=1
       print form=5.0, list = "MW[", _AK(2.0), "] = SELECTLINK(L = ", LI.1.A, "-", LI.1.B, "*)     ",";",TFGDIST(10.2),TFGTIME(10.2), printo=2
       print csv=t, list = _AK, LI.1.A,LI.1.B,TFGDIST,TFGTIME, printo=3
       print list="FILLMW MW[",_AK(L),"]=MI.1.",_AK(L),printo=4
       print list="FILLMW MW[",(_AK+100)(L),"]=MI.2.",_AK(L),printo=5
       print list="FILLMW MW[",(_AK+200)(L),"]=MI.3.",_AK(L),printo=6
       print list="FILLMW MW[",(_AK+300)(L),"]=MI.4.",_AK(L),printo=7
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
       _idx=_idx+2
     else
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
       _AK=_AK+1
       print form=5.0, list = LI.1.A, "-", LI.1.B, "*", printo=1
       print form=5.0, list = "MW[", _AK(2.0), "] = SELECTLINK(L = ", LI.1.A, "-", LI.1.B, "*)     ",";",TFGDIST(10.2),TFGTIME(10.2), printo=2
       print csv=t, list = _AK,LI.1.A,LI.1.B,TFGDIST,TFGTIME, printo=3
       print list="FILLMW MW[",_AK(L),"]=MI.1.",_AK(L),printo=4
       print list="FILLMW MW[",(_AK+100)(L),"]=MI.2.",_AK(L),printo=5
       print list="FILLMW MW[",(_AK+200)(L),"]=MI.3.",_AK(L),printo=6
       print list="FILLMW MW[",(_AK+300)(L),"]=MI.4.",_AK(L),printo=7
      _idx=_idx+2
     endif
    endif

    _lastnode = LI.1.A
ENDPHASE

PHASE=SUMMARY
    if ({isFutureYearAlternative}=1) print form=5.0, list= ")",printo=1

      if ({isFutureYearAlternative}=1)
        log prefix=numBRTlinks var=_ak
      else
        _ak=2
        log prefix=numBRTlinks var=_ak
      endif
ENDPHASE
ENDRUN


; Script for program PUBLIC TRANSPORT in file "D:\JTA RTS Model\APPLICATIONS\SEPTR00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\SEPTR00A.PRN" MSG='Perform PK selectlink truthtable'
FILEO REPORTO = "{SCENARIO_DIR}\output\SEPTR00B.PRN"
FILEO MATO[7] = "{SCENARIO_DIR}\output\SELLINKPK7_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO MATO[5] = "{SCENARIO_DIR}\output\SELLINKPK5_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D

FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHPK7_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHPK5_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHPK3_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHPK1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitPK.NET"
FILEO NETO = "{SCENARIO_DIR}\output\SELLINKPK_TMP.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES=1,3,5,7,HDWAYPERIOD=1,
    TRIPSIJ[1]=1,
    TRIPSIJ[2]=0,
    TRIPSIJ[3]=1,
    TRIPSIJ[4]=0,
    TRIPSIJ[5]=1,
    TRIPSIJ[6]=0,
    TRIPSIJ[7]=1,
    TRIPSIJ[8]=0

PHASE=SKIMIJ

if ({isFutureYearAlternative} == 1) then
 if ({ProjectModeFlag} == 1)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS.TXT"
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS1.TXT"
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


; Script for program MATRIX in file "D:\JTA RTS Model\APPLICATIONS\SEMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00A.PRN" MSG='PK Extract guideway time'
FILEO MATO[4] = "{SCENARIO_DIR}\output\SELLINKPK7_{alt}{year}.MAT",
 MO=407-408,NAME=pkcbdknrbrttime,pkcbdknrbrtdist,DEC=2*D
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKPK5_{alt}{year}.MAT",
 MO=405-406,NAME=pkknrbrttime,pkknrbrtdist,DEC=2*D
FILEO MATO[2] = "{SCENARIO_DIR}\output\SELLINKPK3_{alt}{year}.MAT",
 MO=403-404,NAME=pkpnrbrttime,pkpnrbrtdist,DEC=2*D
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKPK1_{alt}{year}.MAT",
 MO=401-402,NAME=pkwalkbrttime,pkwalkbrtdist,DEC=2*D

FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\BRTlinktime.CSV"
FILEI MATI[4] = "{SCENARIO_DIR}\output\SELLINKPK7_TMP.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\SELLINKPK5_TMP.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\SELLINKPK3_TMP.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELLINKPK1_TMP.MAT"

zonemsg=100

DistributeINTRASTEP ProcessID="JTADist", ProcessList=1-3

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


; Script for program PUBLIC TRANSPORT in file "D:\JTA RTS Model\APPLICATIONS\SEPTR00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\SEPTR00C.PRN" MSG='Perform OP selectlink truthtable'
FILEO REPORTO = "{SCENARIO_DIR}\output\SEPTR00D.PRN"
FILEO MATO[7] = "{SCENARIO_DIR}\output\SELLINKOP7_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO MATO[5] = "{SCENARIO_DIR}\output\SELLINKOP5_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKOP3_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKOP1_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*D
FILEO NETO = "{SCENARIO_DIR}\output\SELLINKOP_TMP.NET"

FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHOP1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES=1,3,5,7,HDWAYPERIOD=2,
    TRIPSIJ[1]=1,
    TRIPSIJ[2]=0,
    TRIPSIJ[3]=1,
    TRIPSIJ[4]=0,
    TRIPSIJ[5]=1,
    TRIPSIJ[6]=0,
    TRIPSIJ[7]=1,
    TRIPSIJ[8]=0

PHASE=SKIMIJ

if ({isFutureYearAlternative} == 1) then
 if ({ProjectModeFlag} == 1)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS.TXT"
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS1.TXT"
 else
  MW[1]=SELECTLINK(OPERATOR=5)       ; Commuter rail operator
 endif
else
  MW[1] = 0
endif


ENDPHASE

ENDRUN


; Script for program MATRIX in file "D:\JTA RTS Model\APPLICATIONS\SEMAT00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00C.PRN" MSG='OP Extract guideway time'
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\BRTlinktime.CSV"
FILEI MATI[4] = "{SCENARIO_DIR}\output\SELLINKOP7_TMP.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\SELLINKOP5_TMP.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\SELLINKOP3_TMP.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELLINKOP1_TMP.MAT"

FILEO MATO[4] = "{SCENARIO_DIR}\output\SELLINKOP7_{alt}{year}.MAT",
 MO=407-408,NAME=opcbdknrbrttime,opcbdknrbrtdist,DEC=2*D
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKOP5_{alt}{year}.MAT",
 MO=405-406,NAME=opknrbrttime,opknrbrtdist,DEC=2*D
FILEO MATO[2] = "{SCENARIO_DIR}\output\SELLINKOP3_{alt}{year}.MAT",
 MO=403-404,NAME=oppnrbrttime,oppnrbrtdist,DEC=2*D
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKOP1_{alt}{year}.MAT",
 MO=401-402,NAME=opwalkbrttime,opwalkbrtdist,DEC=2*D

zonemsg=100

DistributeINTRASTEP ProcessID="JTADist", ProcessList=1-3

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


; Script for program MATRIX in file "D:\JTA RTS Model\APPLICATIONS\SEMAT00E.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00B.PRN" MSG='Combine selectlink matrices'
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT",
 MO=1-8,DEC=8*D,NAME=pkwalkbbrttime,pkpnrbbrttime,pkknrbbrttime,pkcbdknrbbrttime,opwalkbbrttime,oppnrbbrttime,opknrbbrttime,opcbdknrbbrttime

FILEI MATI[8] = "{SCENARIO_DIR}\output\SELLINKOP7_{alt}{year}.MAT"
FILEI MATI[7] = "{SCENARIO_DIR}\output\SELLINKOP5_{alt}{year}.MAT"
FILEI MATI[6] = "{SCENARIO_DIR}\output\SELLINKOP3_{alt}{year}.MAT"
FILEI MATI[5] = "{SCENARIO_DIR}\output\SELLINKOP1_{alt}{year}.MAT"
FILEI MATI[4] = "{SCENARIO_DIR}\output\SELLINKPK7_{alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\SELLINKPK5_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\SELLINKPK3_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\SELLINKPK1_{alt}{year}.MAT"

zonemsg=100

FILLMW MW[1]=MI.1.1
FILLMW MW[2]=MI.2.1
FILLMW MW[3]=MI.3.1
FILLMW MW[4]=MI.4.1
FILLMW MW[5]=MI.5.1
FILLMW MW[6]=MI.6.1
FILLMW MW[7]=MI.7.1
FILLMW MW[8]=MI.8.1

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

else
; End of PILOT Script

; Script for program MATRIX in file "D:\JTA RTS Model\APPLICATIONS\SEMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\SEMAT00A1.PRN"
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELECTLINK_{alt}{year}.MAT",
 MO=1-8, DEC=8*D,NAME=pkwalkbbrttime,pkpnrbbrttime,pkknrbbrttime,pkcbdknrbbrttime,opwalkbbrttime,oppnrbbrttime,opknrbbrttime,opcbdknrbbrttime

zonemsg=100
zones={ZONESA}

MW[1]=0
MW[2]=0
MW[3]=0
MW[4]=0
MW[5]=0
MW[6]=0
MW[7]=0
MW[8]=0

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

endif
; End of PILOT Script

