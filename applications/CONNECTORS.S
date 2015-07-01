; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\CNNET00G.S"
;;<<Default Template>><<NETWORK>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK MSG='Peak rename fields for AUOTCON'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD_PT_TEMP.NET"

PROCESS  PHASE=INPUT,filei=NI.1
ENDPROCESS

PROCESS PHASE = NODEMERGE
      COMP STAZ   = STATZONE
      COMP STANUM = TSSTATION_{year}{alt}
      COMP TSTYPE = TSTYPE_{year}{alt}
      COMP MAXD   = TSRANGE_{year}{alt}
      COMP SPACE  = TSPARKSPACE_{year}{alt}
      COMP STACOST_AM = TSCOSTAM_{year}{alt}
      COMP STACOST_MD = TSCOSTMD_{year}{alt}
ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS
ENDRUN


; Script for program NETWORK in file "C:\NERPM43\APPLICATIONS\CNNET00H.S"
;;<<Default Template>><<NETWORK>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK MSG='OffPeak rename fields for AUOTCON'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEO NETO = "{SCENARIO_DIR}\output\UNLOADED_PT_TEMP.NET"

PROCESS  PHASE=INPUT,filei=NI.1
ENDPROCESS

PROCESS PHASE = NODEMERGE
      COMP STAZ   = STATZONE
      COMP STANUM = TSSTATION_{year}{alt}
      COMP TSTYPE = TSTYPE_{year}{alt}
      COMP MAXD   = TSRANGE_{year}{alt}
      COMP SPACE  = TSPARKSPACE_{year}{alt}
      COMP STACOST_AM = TSCOSTAM_{year}{alt}
      COMP STACOST_MD = TSCOSTMD_{year}{alt}
ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS
ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\applications\CNPTR00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\CNPTR00A.PRN" MSG='Peak period connectors'
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PT_AUTOCON_PK.OUT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG2PK_10A.PRN"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\PNRCOMRAIL.FAC"
FILEI MATI[1] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT"

; Inputs for walk connectors
FILEI NETI = "{SCENARIO_DIR}\output\PRELOAD_PT_TEMP.NET"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkCOMRAIL.FAC"

; Output files
FILEO NETO = "{SCENARIO_DIR}\output\NTLEGSPK.NET"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\NTLEGPK_{alt}{year}.DBF"
FILEO LINEO = "{SCENARIO_DIR}\output\TROUTE_MOD.LIN"
FILEO NTLEGO = "{SCENARIO_DIR}\output\NTLEGPK_{YEAR}{ALT}.NTL"
FILEO REPORTO = "{SCENARIO_DIR}\output\NTLEGPK.RPT"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE=5280, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEPK,
           TRANTIME[22]=LI.M22TIMEPK,
           TRANTIME[23]=LI.M23TIMEPK,
           TRANTIME[24]=LI.M24TIMEPK
           TRANTIME[25]=LI.M25TIMEPK
           TRANTIME[26]=LI.M26TIMEPK
REPORT LINES=T

PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEPK
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
 LW.ADJDISTANCE=LI.ADJDISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 1 - WALK ACCESS/EGRESS
  GENERATE, COST=(LW.ADJDISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),
            NTLEGMODE=1,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,FROMNODE=1-{ZONESI},TONODE={NODEMIN}-99999
     
  ; 11 - Fixed-guideway to bus (transfer connectors)
  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LI.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,INCLUDELINK=(LI.FACILITY_TYPE=59),
            NTLEGMODE=11,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,DIRECTLINK=2,ONEWAY=F,FROMNODE={NODEMIN}-99999,TONODE={NODEMIN}-99999
  
            ; 11 - station to nearby stop (transfer connectors)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATXFER_TMP.DAT"

  ; 12 - CBD sidewalks
   READ, FILE = "{SCENARIO_DIR}\OUTPUT\CBDXFER.DAT"

            
 ; Add AUTOCON outputs
 list='\nGenerate Zone Access/Egress Legs'
    GENERATE, 
       PNR=T,
       KNR=T,
       PERIOD=1,
       
       PNRMODE=2,
       KNRMODE=3,
       INTERNALZONES=1-2494,
       
       CBDZONE=730,
       ORIGINTERMTIME=2.0,
       DEFDRIVETIME=20.0,
       CHECKRELEVANCE=1,
       CHECKBACKTRACK=1,
       MAXBACKDIST=4.0,
       MAXBACKFACTOR=0.30,
       DISTANCEFACTOR=5280,
       
       PREMIUMMODE=0,1,0,1,1,1,1,  
       MODEPRIORITY=7,5,7,2,1,4,3,
       
       VOT=6,3,
       OVTRATIO=2,2,
       AATRATIO=1.5,1.5,
       AUTOCCPNR=1.2,
       AUTOCCKNR=1.2,
       AOC=9.5,
       INFLTRANSITFARE=0.9487,
       INFLAOC=1,
       INFLPARKINGCOST=1.1976,
       MAXCHECK = 10,
       MAXCONN = 5,
       
       CONNREPORT=1,
       GENREPORT=2,
       TIMEMAT=MI.1.4,
       DISTMAT=MI.1.2,
       AUTOMATCH=T      ; T=original logic, F=Enhanced logic

  ENDPROCESS

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\APPLICATIONS\CNPTR00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="C:\NERPM43\APPLICATIONS\CNPTR00E.PRN" MSG='OffPeak period connectors'
FILEO PRINTO[2] = "{Scenario_Dir}\output\PT_AUTOCON_PK.OUT"
FILEO PRINTO[1] = "{Scenario_Dir}\output\NTLEG2OP_10A.PRN"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\PNRCOMRAIL.FAC"
FILEI MATI[1] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"

; Inputs for walk connectors
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED_PT_TEMP.NET"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkCOMRAIL.FAC"

; Output files
FILEO NETO = "{Scenario_Dir}\output\NTLEGSOP.NET"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\NTLEGOP_{alt}{year}.DBF"
FILEO LINEO = "{Scenario_Dir}\output\TROUTE_MOD.LIN"
FILEO NTLEGO = "{SCENARIO_DIR}\output\NTLEGOP_{YEAR}{ALT}.NTL"
FILEO REPORTO = "{SCENARIO_DIR}\output\NTLEGOP.RPT"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE=5280, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEOP,
           TRANTIME[22]=LI.M22TIMEOP,
           TRANTIME[23]=LI.M23TIMEOP,
           TRANTIME[24]=LI.M24TIMEOP,
           TRANTIME[25]=LI.M25TIMEOP,
           TRANTIME[26]=LI.M26TIMEOP
REPORT LINES=T

PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEOP
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
 LW.ADJDISTANCE=LI.ADJDISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 1 - WALK ACCESS/EGRESS
  GENERATE, COST=(LW.ADJDISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),
            NTLEGMODE=1,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,FROMNODE=1-{ZONESI},TONODE={NODEMIN}-99999

  ; 11 - Fixed-guideway to bus
  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LI.WALKTIME),MAXCOST=200*{WALKACCESSDIST},LIST=N,INCLUDELINK=(LI.FACILITY_TYPE=59),
            NTLEGMODE=11,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,DIRECTLINK=1,ONEWAY=F,FROMNODE={NODEMIN}-99999,TONODE={NODEMIN}-99999
  ;11 - station to nearby stop (transfer connectors)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATXFER_TMP.DAT"

  ; 12 - CBD sidewalks
   READ, FILE = "{SCENARIO_DIR}\OUTPUT\CBDXFER.DAT"

 ; Add AUTOCON outputs
 list='\nGenerate Zone Access/Egress Legs'
    GENERATE, 
       PNR=T,
       KNR=T,
       PERIOD=1,
       
       PNRMODE=2,
       KNRMODE=3,
       INTERNALZONES=1-2494,
       
       CBDZONE=730,
       ORIGINTERMTIME=2.0,
       DEFDRIVETIME=20.0,
       CHECKRELEVANCE=1,
       CHECKBACKTRACK=1,
       MAXBACKDIST=4.0,
       MAXBACKFACTOR=0.30,
       DISTANCEFACTOR=5280,
       
       PREMIUMMODE=0,1,0,1,1,1,1,  
       MODEPRIORITY=7,5,7,2,1,4,3,
       
       VOT=6,3,
       OVTRATIO=2,2,
       AATRATIO=1.5,1.5,
       AUTOCCPNR=1.2,
       AUTOCCKNR=1.2,
       AOC=9.5,
       INFLTRANSITFARE=0.9487,
       INFLAOC=1,
       INFLPARKINGCOST=1.1976,
       MAXCHECK = 10,
       MAXCONN = 5,
       
       CONNREPORT=1,
       GENREPORT=2,
       TIMEMAT=MI.1.4,
       DISTMAT=MI.1.2,
       AUTOMATCH=T      ; T=original logic, F=Enhanced logic

  ENDPROCESS

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\applications\CNMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00A1.PRN" MSG='Peak walk, pnr, knr connectors'
FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI RECI = "{SCENARIO_DIR}\output\NTLEGPK_{YEAR}{ALT}.NTL"

FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG3PK_{alt}{year}.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\NTLEG2PK_{alt}{year}.NTL"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1PK_TEM.NTL"
FILEO PRINTO[4] = "{SCENARIO_DIR}\output\NTLEG11PK_{alt}{year}.NTL"
FILEO PRINTO[5] = "{SCENARIO_DIR}\output\NTLEG12PK_{alt}{year}.NTL"

; print all removed NTLEGS
s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))


; ############# check for error in time field #################
if (time > 999)
 time=999
 print list='*****Error in the time field, Time exceeds 999 min *****', zonei(5.0),'-',zonej(5.0),mode(3.0)
endif
;##############################################################

; LOOKUP for coefficient file
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=2
ovtfactor =COEFF(1,3)/COEFF(1,1)      ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)      ; drive access to transit time factor

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  PRINT LIST=";;<<PT>>;;", PRINTO=2
  PRINT LIST=";;<<PT>>;;", PRINTO=3
  _ctr = _ctr + 1
endif

if (mode=1) PRINT FORM=L, LIST="NT LEG=",zonei,"-",zonej," MODE=",mode," COST=",time(6.2L)," DIST=",dist(6.2L)," ",s23,PRINTO=1
if (mode=2) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=2
if (mode=3) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=3
if (mode=11) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=4
if (mode=12) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=5

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\applications\CNMAT00B.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B.PRN" MSG='OffPeak walk, pnr, knr connectors'

FILEI RECI = "{SCENARIO_DIR}\output\NTLEGOP_{YEAR}{ALT}.NTL"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG3OP_{alt}{year}.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\NTLEG2OP_{alt}{year}.NTL"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1OP_TEM.NTL"

FILEI LOOKUPI[3] = "{SCENARIO_DIR}\output\STATDATA_{alt}{year}.DBF"
FILEI LOOKUPI[2] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEO PRINTO[5] = "{Scenario_Dir}\output\NTLEG12OP_{alt}{year}.NTL"
FILEO PRINTO[4] = "{Scenario_Dir}\output\NTLEG11OP_{alt}{year}.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))

; ############# check for error in time field #################
if (time > 999)
 time=999
 print list='*****Error in the time field, Time exceeds 999 min *****', zonei(5.0),'-',zonej(5.0),mode(3.0)
endif
;##############################################################

; LOOKUP for coefficient file
LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=2
ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  PRINT LIST=";;<<PT>>;;", PRINTO=2
  PRINT LIST=";;<<PT>>;;", PRINTO=3
  _ctr = _ctr + 1
endif

if (mode=1) PRINT FORM=L, LIST="NT LEG=",zonei,"-",zonej," MODE=",mode," COST=",time(6.2L)," DIST=",dist(6.2L)," ",s23,PRINTO=1
if (mode=2) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=2
if (mode=3) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2)," ONEWAY=T",PRINTO=3
if (mode=11) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=4
if (mode=12) PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(6.2)," DIST=",dist(5.2),PRINTO=5

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00A.PRN" MSG='Connector Information for Peak'
FILEO RECO[1] = "{SCENARIO_DIR}\output\PKZONECONN_TEM.DBF",
FIELDS =zonea,conn_ctr,mindist,mincost,cenflag
;FIELDS =zonea(5.0),conn_ctr(3.0),mindist(5.2),mincost(5.2),cenflag(1.0)

FILEI RECI = "{SCENARIO_DIR}\output\NTLEG1PK_TEM.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))

; Get information (# connectors,mindist,centroid stop(?)) about walk access connectors

if (mode==1 && zonei<{ZONESA})     ; mode = walk & Anode less the Number of Zones
 if (_ctrwalk==1)
   zonea=zonei
   conn_ctr=conn_ctr+1
   mindist=dist
   mincost=time
   if (s7==0) cenflag=1            ; Check for stop at centroid Connector
 endif

 if (_ctrwalk >1 && zonei==zonea)
   conn_ctr=conn_ctr+1            ; Number of walk access connectors for a zone
   if (s7==0) cenflag=1
   if (dist<mindist)
       mindist=dist               ; Minimum length of the connector
       mincost=time
   endif
 endif

 if (_ctrwalk>1 && zonei<>zonea)
   WRITE RECO=1                   ; Output # connectors, min.length & Stop flag for centroid connectors
   zonea=zonei
   conn_ctr=1
   mindist=dist
   mincost=time
   cenflag=0
  if (s7==0) cenflag=1
 endif
  _ctrwalk=_ctrwalk + 1
endif

if (i==0)
 WRITE RECO=1                     ; output the information for the last centroid connector
endif

if (i==1 && _ctrwalk==0)
  _ctrwalk=_ctrwalk + 1
endif

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00H.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00C.PRN" MSG='Revise Peak Walk Access Connectors'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG1PK_DEL.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWPK_TEM.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1PK_{alt}{year}.NTL"
FILEI RECI = "{SCENARIO_DIR}\OUTPUT\NTLEG1PK_TEM.NTL"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\pcwalk_{year}{alt}.dat"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\PKZONECONN_TEM.DBF"

avgwalkc=({AVGWALK}/{AVGWLKSPD})*60   ;average walk time (minutes)

if (_ctr>0)
 s1=strpos('NT',reci)
 s2=strpos('LEG',reci)
 s3=strpos('MODE',reci)
 s4=strpos('COST',reci)
 s5=strpos('DIST',reci)
 s6=strpos('ONEWAY',reci)
 s7=strpos('XN',reci)

 ; get the origin and destination zone
 s8=(s3-s2)
 leg1=substr(reci,s2,s8)
 s9=strpos('=',leg1)
 s10=strpos('-',leg1)
 s11=(s9+1)
 s12=(s10-1)
 s13=(s10+1)
 zonei=val(substr(leg1,s11,s12))
 zonej=val(substr(leg1,s13,strlen(leg1)))

 if (tempzone <> zonei )
  new_zone=1
 elseif (tempzone == zonei)
  new_zone=0
 endif

 ; get the mode number
 s14=(s4-s3)
 mode1=substr(reci,s3,s14)
 s15=strpos('=',mode1)
 s16=(s15+1)
 mode=val(substr(mode1,s16,strlen(mode1)))

 ; get the time on the connector (cost field in the NT leg file)
 s17=(s5-s4)
 time1=substr(reci,s4,s17)
 s18=strpos('=',time1)
 s19=(s18+1)
 time=val(substr(time1,s19,strlen(time1)))

 ; get the distance
 s20=(s6-s5)
 dist1=substr(reci,s5,s20)
 s21=strpos('=',dist1)
 s22=(s21+1)
 dist=val(substr(dist1,s22,strlen(dist1)))

 ; get the rest of the string
 s23=substr(reci,s6,strlen(reci))
 s24=strpos('=',s23)
 s25=substr(reci,s6,s24+1)

 if (zonei<{ZONESA})
  zone = zonei                  ; Check if Anode is the zone number
 elseif (zonei>{ZONESA})
  zone=zonej
 endif

 ;Lookup for pcwalk file
 LOOKUP LOOKUPI=1, NAME=PCWALK, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        pkprod=PCWALK(1,zone)
        pkattr=PCWALK(2,zone)
        opprod=PCWALK(3,zone)              ; Lookup for PCW information
        opattr=PCWALK(4,zone)

 ;Lookup for connectors
 LOOKUP LOOKUPI=2, NAME=GETCONNECTORS, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        conn=GETCONNECTORS(1,zone)
        mindist=GETCONNECTORS(2,zone)    ; Lookup for centroid connector information
        mincost=GETCONNECTORS(3,zone)
        cenflag=GETCONNECTORS(4,zone)

 ; Assigning Rule values (rules refer to the rule numbers used in the REWALK documentation)
 if (cenflag=0 && pkprod<95) rule = 2                                ; No Transit Stop at centroid connector and PCW<95%
 if (cenflag=0 && pkprod>=95 && mindist<{AVGWALK}) rule = 3          ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK
 if (cenflag=0 && pkprod>=95 && mindist>={AVGWALK}) rule = 4         ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK
 if (cenflag=1 && pkprod=100) rule = 5                               ; Transit Stop at centroid connector & PCW =100%
 if (cenflag=1 && pkprod>={MINPCW} && pkprod<100) rule = 6           ; Transit Stop at centroid connector & MinPCW<=PCW<100%
 if (cenflag=1 && pkprod<{MINPCW}) rule = 7                          ; Transit Stop at centroid connector & PCW<MinPCW

 ;Rules 3,5: No changes to walk access connectors & PCW
 if (rule=3,5)
   PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
   if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
    tempzone=zonei
   endif
 endif

 ;Rules 2,4,7: Delete walk access connectors and reset PCW =0
 if(rule=2,4,7)
   pkprod=0
   pkattr=0
   PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s23,PRINTO=3
   if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
    tempzone=zonei
   endif
 endif

 ;Rule 6: No changes to PCW, adjust walk access connector dist & times
 if (rule=6)
  if (mindist>{AVGWALK})
   dist_delta =(mindist - {AVGWALK})       ;if minimum connector length > AVGWALK
   time_delta =(mincost-avgwalkc)          ;set minimum distance & time to avgwalk & avgwalkc
   dist=(dist-dist_delta)                  ;and adjust the rest of the connectors by the same delta's
   time=(time-time_delta)
  endif
   PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
  if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
   tempzone=zonei
  endif
 endif

endif

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  tempzone=0
endif

_ctr = _ctr + 1

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00G.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00B.PRN" MSG='Connector Information for Off-Peak'
FILEO RECO[1] = "{SCENARIO_DIR}\output\OPZONECONN_TEM.DBF",
FIELDS =zonea,conn_ctr,mindist,mincost,cenflag

;FIELDS =zonea(5.0),conn_ctr(3.0),mindist(5.2),mincost(5.2),cenflag(1.0)
FILEI RECI = "{SCENARIO_DIR}\output\NTLEG1OP_TEM.NTL"

s1=strpos('NT',reci)
s2=strpos('LEG',reci)
s3=strpos('MODE',reci)
s4=strpos('COST',reci)
s5=strpos('DIST',reci)
s6=strpos('ONEWAY',reci)
s7=strpos('XN',reci)

; get the origin and destination zone
s8=(s3-s2)
leg1=substr(reci,s2,s8)
s9=strpos('=',leg1)
s10=strpos('-',leg1)
s11=(s9+1)
s12=(s10-1)
s13=(s10+1)
zonei=val(substr(leg1,s11,s12))
zonej=val(substr(leg1,s13,strlen(leg1)))

; get the mode number
s14=(s4-s3)
mode1=substr(reci,s3,s14)
s15=strpos('=',mode1)
s16=(s15+1)
mode=val(substr(mode1,s16,strlen(mode1)))

; get the time on the connector (cost field in the NT leg file)
s17=(s5-s4)
time1=substr(reci,s4,s17)
s18=strpos('=',time1)
s19=(s18+1)
time=val(substr(time1,s19,strlen(time1)))

; get the distance
s20=(s6-s5)
dist1=substr(reci,s5,s20)
s21=strpos('=',dist1)
s22=(s21+1)
dist=val(substr(dist1,s22,strlen(dist1)))

; get the rest of the string
s23=substr(reci,s6,strlen(reci))

; Get information (# connectors,mindist,centroid stop(?)) about walk access connectors

if (mode==1 && zonei<{ZONESA})        ; mode = walk & Anode less the Number of Zones
 if (_ctrwalk==1)
   zonea=zonei
   conn_ctr=conn_ctr+1
   mindist=dist
   mincost=time
   if (s7==0) cenflag=1                        ; Check for stop at centroid Connector
 endif

 if (_ctrwalk >1 && zonei==zonea)
   conn_ctr=conn_ctr+1         ; Number of walk access connectors for a zone
   if (s7==0) cenflag=1
   if (dist<mindist)
       mindist=dist               ; Minimum length of the connector
       mincost=time
   endif
 endif

 if (_ctrwalk>1 && zonei<>zonea)
   WRITE RECO=1                   ; Output # connectors, min.length & Stop flag for centroid connectors
   zonea=zonei
   conn_ctr=1
   mindist=dist
   mincost=time
   cenflag=0
  if (s7==0) cenflag=1
 endif
  _ctrwalk=_ctrwalk + 1
endif

if (i==0)
 WRITE RECO=1                 ; output the information for the last centroid connector
endif

if (i==1 && _ctrwalk==0)
  _ctrwalk=_ctrwalk + 1
endif

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00I.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00E.PRN" MSG='Revise Off Peak Walk Access Connectors'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG1OP_DEL.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWOP_TEM.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1OP_{alt}{year}.NTL"
FILEI RECI = "{SCENARIO_DIR}\OUTPUT\NTLEG1OP_TEM.NTL"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\input\pcwalk_{year}{alt}.dat"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\OPZONECONN_TEM.DBF"

avgwalkc=({AVGWALK}/{AVGWLKSPD})*60

if (_ctr>0)
 s1=strpos('NT',reci)
 s2=strpos('LEG',reci)
 s3=strpos('MODE',reci)
 s4=strpos('COST',reci)
 s5=strpos('DIST',reci)
 s6=strpos('ONEWAY',reci)
 s7=strpos('XN',reci)

 ; get the origin and destination zone
 s8=(s3-s2)
 leg1=substr(reci,s2,s8)
 s9=strpos('=',leg1)
 s10=strpos('-',leg1)
 s11=(s9+1)
 s12=(s10-1)
 s13=(s10+1)
 zonei=val(substr(leg1,s11,s12))
 zonej=val(substr(leg1,s13,strlen(leg1)))

 if (tempzone <> zonei )
  new_zone=1
 elseif (tempzone == zonei)
 new_zone=0
 endif

 ; get the mode number
 s14=(s4-s3)
 mode1=substr(reci,s3,s14)
 s15=strpos('=',mode1)
 s16=(s15+1)
 mode=val(substr(mode1,s16,strlen(mode1)))

 ; get the time on the connector (cost field in the NT leg file)
 s17=(s5-s4)
 time1=substr(reci,s4,s17)
 s18=strpos('=',time1)
 s19=(s18+1)
 time=val(substr(time1,s19,strlen(time1)))

 ; get the distance
 s20=(s6-s5)
 dist1=substr(reci,s5,s20)
 s21=strpos('=',dist1)
 s22=(s21+1)
 dist=val(substr(dist1,s22,strlen(dist1)))

 ; get the rest of the string
 s23=substr(reci,s6,strlen(reci))
 s24=strpos('=',s23)
 s25=substr(reci,s6,s24+1)

 if (zonei<{ZONESA})
  zone = zonei                  ; Check if Anode is the zone number
 elseif (zonei>{ZONESA})
  zone=zonej
 endif

 ;Lookup for pcwalk file
 LOOKUP LOOKUPI=1, NAME=PCWALK, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        pkprod=PCWALK(1,zone)
        pkattr=PCWALK(2,zone)
        opprod=PCWALK(3,zone)              ; Lookup for PCW information
        opattr=PCWALK(4,zone)

 ;Lookup for connectors
 LOOKUP LOOKUPI=2, NAME=GETCONNECTORS, LOOKUP[1]=1, RESULT=2,LOOKUP[2]=1, RESULT=3,LOOKUP[3]=1, RESULT=4,LOOKUP[4]=1, RESULT=5,INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0

        conn=GETCONNECTORS(1,zone)
        mindist=GETCONNECTORS(2,zone)    ; Lookup for centroid connector information
        mincost=GETCONNECTORS(3,zone)
        cenflag=GETCONNECTORS(4,zone)

 ; Assigning Rule values (rules refer to the rule numbers used in the REWALK documentation)
 if (cenflag=0 && opprod<95) rule = 2                                ; No Transit Stop at centroid connector and PCW<95%
 if (cenflag=0 && opprod>=95 && mindist<{AVGWALK}) rule = 3           ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK
 if (cenflag=0 && opprod>=95 && mindist>={AVGWALK}) rule = 4          ; No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK
 if (cenflag=1 && opprod=100) rule = 5                               ; Transit Stop at centroid connector & PCW =100%
 if (cenflag=1 && opprod>={MINPCW} && opprod<100) rule = 6           ; Transit Stop at centroid connector & MinPCW<=PCW<100%
 if (cenflag=1 && opprod<{MINPCW}) rule = 7                          ; Transit Stop at centroid connector & PCW<MinPCW

 ;Rules 3,5: No changes to walk access connectors & PCW
 if (rule=3,5)
  PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
  if (zonei<{ZONESA} && new_zone=1)
    PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
    tempzone=zonei
  endif
 endif

 ;Rules 2,4,7: Delete walk access connectors and reset PCW =0
 if(rule=2,4,7)
  opprod=0
  opattr=0
  PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s23,PRINTO=3
  if (zonei<{ZONESA} && new_zone=1)
   PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
   tempzone=zonei
  endif
 endif

 ;Rule 6: No changes to PCW, adjust walk access connector dist & times
 if (rule=6)
  if (mindist>{AVGWALK})
   dist_delta =(mindist - {AVGWALK})        ;if minimum connector length > AVGWALK
   time_delta =(mincost-avgwalkc)         ;set minimum distance & time to avgwalk & avgwalkc
   dist=(dist-dist_delta)                 ;and adjust the rest of the connectors by the same delta's
   time=(time-time_delta)
  endif
  PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s25,PRINTO=1
  if (zonei<{ZONESA} && new_zone=1)
   PRINT LIST= zone(5.0),pkprod(5.0),pkattr(5.0),opprod(5.0),opattr(5.0),rule(3.0), PRINTO=2
   tempzone=zonei
  endif
 endif

endif

if (i==1 && _ctr==0)
  PRINT LIST=";;<<PT>>;;", PRINTO=1
  tempzone=0
endif

_ctr = _ctr + 1

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\RWMAT00J.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00F.PRN" MSG='Revise PCWALK'
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWCHANGE_TEM.DAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\input\PCWALK_{Year}{Alt}.DAT",
  z=#1,pkprod=#2,pkattr=#3,opprod=#4,opattr=#5
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PCWALK_{alt}{year}.DAT"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\PCWOP_TEM.DAT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\PCWPK_TEM.DAT"

zones={ZONESA}    ; Number of zones

;Peak period temp pcwalk file
LOOKUP LOOKUPI=1, NAME=PKPCWALK, LOOKUP[1]=1, RESULT=1,LOOKUP[2]=1, RESULT=2,LOOKUP[3]=1, RESULT=3,LOOKUP[4]=1, RESULT=6,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0
        pk_chkzone=PKPCWALK(1,z)         ; Check for existience of zone in peak walk access connectors file(centroid connector) 
        pk_rule=PKPCWALK(4,z,1)
;Off-Peak period temp pcwalk file
LOOKUP LOOKUPI=2, NAME=OPPCWALK, LOOKUP[1]=1, RESULT=1,LOOKUP[2]=1, RESULT=4,LOOKUP[3]=1, RESULT=5,LOOKUP[4]=1, RESULT=6,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0
        op_chkzone=OPPCWALK(1,z)        ; Check for existience of zone in off peak walk access connectors file(centroid connector)
        op_rule=OPPCWALK(4,z,1)
;;Peak period modifications
if (pk_chkzone>0)
  zone =z
  pkp=PKPCWALK(2,z)
  pka=PKPCWALK(3,z)                    ; revised peak PCW's 
  elseif (pk_chkzone==0)
  zone =z
  pkp=0
  pka=0
endif

;;Off-peak period modifications
if (op_chkzone>0)
  zone =z
  opp=OPPCWALK(2,z)
  opa=OPPCWALK(3,z)                   ;revised off peak PCW's 
elseif (op_chkzone==0)
  zone =z
  opp=0
  opa=0
endif

PRINT LIST= zone(5.0),pkp(6.0),pka(6.0),opp(6.0),opa(6.0), PRINTO=1   ; Output PCW with PCW's updated for peak & off peak 

;;Output zones whose PCW were revised
if (_ctr=0) 
  PRINT  LIST =';Percent Walk updated for the zones below based on the following rules:\n\n',
              ';Rule 1 : No Walk Access Connectors to the Zone(PCW=0)\n',
              ';Rule 2 : No Transit Stop at centroid connector and PCW<95% (PCW=0)\n',
              ';Rule 3 : No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK (No Change in PCW)\n',
              ';Rule 4 : No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK (PCW=0)\n',
              ';Rule 5 : Transit Stop at centroid connector & PCW =100% (No Change in PCW)\n',
              ';Rule 6 : Transit Stop at centroid connector & MinPCW<=PCW<100% (No Change in PCW)\n',
              ';Rule 7 : Transit Stop at centroid connector & PCW<MinPCW (PCW=0)\n',PRINTO=2
  PRINT LIST = 'ZONE   ','REVISED_PK_PROD  ','ORIGINAL_PK_PROD  ','PK_RULE  ','REVISED_OP_PROD  ','ORIGINAL_OP_PROD  ','OP_RULE',PRINTO=2
endif

if ( ((pk_rule=1,2,4,7) && pkprod>0) || ((op_rule=1,2,4,7) && opprod>0) ) PRINT LIST = zone(5.0),'         ',pkp(6.0),
  '            ',pkprod(6.0),'       ',pk_rule(3.0),'          ',opp(6.0),'            ',opprod(6.0),'       ',op_rule(3.0),PRINTO=2
    

_ctr=_ctr+1 

ENDRUN


; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\CNMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B1.PRN" MSG='Modify TROUTE file to remove DELAY (for AUTOCON program)'
FILEI RECI = "{SCENARIO_DIR}\output\TROUTE_MOD.LIN",
MAXSCAN=120
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\troute_modified.lin"

PAR MAXSTRING=200

;what follows is a modified version of the original script to be able to run autocon using Voyager 5.1 or above
;this modified version was provided by CITILABS Heejoo Ham on March 30, 2011 to PBS&J (an Atkins Company)
;further modified by Atkins to temporarily delete the headway[2] variable so that autocon can run

linestr=reci

pos_delay=strpos('DELAY=',linestr)                        ; check position of "DELAY="
pos_delay_c=strpos('DELAY_C=',linestr)                    ; check position of "DELAY_C="
pos_n=strpos('N=',linestr)                                ; check position of "N="
pos_head=strpos('HEADWAY[2]=',linestr)                    ; check position of "HEADWAY[2]="
linestrlen=strlen(linestr)                                ; length of current record string

pos_linename=strpos('LINE ',linestr)                      ; check position of "LINE NAME"
if (pos_linename>0)
   _curline=1                                             ; flag for beginning current transit line record
endif

if (pos_delay>0 || pos_delay_c>0 || pos_n>0 || pos_head>0)
   rev_linestr=linestr                                    ; revised line string record
   
   if (pos_head>0)
      loop _ii=1,500
         pos_a=strpos('HEADWAY[2]=',rev_linestr)
         if (pos_a>0)
            rev_linestr=deletestr(rev_linestr,pos_a,13)    ; delete "HEADWAY[2]=##"
         else
            break
         endif
      endloop
   endif


   if (pos_delay>0)
      loop _ii=1,500
         pos_a=strpos('DELAY=',rev_linestr)
         if (pos_a>0)
            rev_linestr=deletestr(rev_linestr,pos_a,7)    ; delete "DELAY=#"
         else
            break
         endif
      endloop
   endif
   if (pos_delay_c>0)
      loop _ii=1,500
         pos_b=strpos('DELAY_C=',rev_linestr)
         if (pos_b>0)
            rev_linestr=deletestr(rev_linestr,pos_b,9)    ; delete "DELAY_C=#"
         else
            break
         endif
      endloop
   endif
   if (pos_n>0)
      pos_loc=1
      loop _ii=1,500
         pos_c=strposex('N=',rev_linestr,pos_loc)
         if (pos_c>0 & _curline=1)                        ; skip for the first keyword with "N="
            pos_loc=pos_c+2                               ; replace the first column position after "N="
            _curline=0
            continue
         elseif (pos_c>0 & _curline=0)                    ; remove all "N=" if it is not the first one
            rev_linestr=deletestr(rev_linestr,pos_c,2)
         else
            break
         endif
      endloop
   endif
   print list=rev_linestr,printo=1                        ; write the modified current record
   rev_linestr=''
else                                                      ; if the current line record doesn't
   print list=linestr,printo=1                            ; include any designated keywords
endif


;==========================================================================================================
;What follows is the original script that worked fine with Voyager 5.0, but NOT with VOYAGER 5.1 and above

/*
linestr=reci

; ############## Check for 'DELAY' keyword in the line file
pos_delay=strpos('DELAY=',linestr)
linestrlen=strlen(linestr)
pos_delay_c=strpos('DELAY_C=',linestr)

if (pos_delay_c > 0) goto skip

if (deleten==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline=strpos('N=',linestr)
  s91=substr(linestr,1,pos_n_nextline)
  s92=substr(linestr,pos_n_nextline+2,linestrlen)
  print list='       ',s92,printo=1
  deleten=0
  goto skip
endif

if (deleten1==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline1=strpos('N=',linestr)
  s93=substr(linestr,1,pos_n_nextline1)
  s94=substr(linestr,pos_n_nextline1+2,linestrlen)
  print list='       ',s94,printo=1
  deleten1=0
  goto skip2
endif

if ((pos_delay > 0) & (deleten==0))
; print list=linestr,printo=1
 s1=substr(linestr,1,pos_delay-1)   ;yes
 s2=substr(linestr,pos_delay+6,linestrlen)
; print list='*',s2,'*',printo=1
 pos_n=strpos('N=',s2)
 if (pos_n=0)  ; 'N=' is on the next line
  deleten=1
  s3=' ,'
 else
  deleten=0
  s3=substr(s2,pos_n+2,strlen(s2))
 endif
 print list=s1,s3,printo=1
 s1=' '
 s2=' '
 s3=' '
else
 deleten=0
 print list=linestr,printo=1
endif

:skip

; ############### Also check for 'DELAY_C' keyword

if ((pos_delay_c > 0) & (deleten1==0))
; print list=linestr,printo=1
 s11=substr(linestr,1,pos_delay_c-1)
 s21=substr(linestr,pos_delay_c+8,linestrlen)
; print list='*',s21,'*',printo=1
 pos_n=strpos('N=',s21)
 if (pos_n=0)  ; 'N=' is on the next line
  deleten1=1
  s31=' ,'
 else
  deleten1=0
  s31=substr(s21,pos_n+2,strlen(s21))
 endif
 print list=s11,s31,printo=1
 s11=' '
 s21=' '
 s31=' '
else
 deleten1=0
; print list=linestr,printo=1
endif

:skip2
*/
;====================================================================================================
;end of the original script for Voyager 5.0

ENDRUN


; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\applications\CNPTR00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\CNPTR00C.PRN" MSG='All walk skim'
FILEI NETI = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"
FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{Year}.RTE"
FILEO MATO[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{Year}.MAT",
 MO=1,DEC=2,NAME=ALLWALK
FILEO REPORTO = "{SCENARIO_DIR}\output\CNPTR00B.RPT"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkCOMRAIL.FAC"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE=5280, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEPK,
           TRANTIME[22]=LI.M22TIMEPK,
           TRANTIME[23]=LI.M23TIMEPK,
           TRANTIME[24]=LI.M24TIMEPK

REPORT LINES=T
PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEPK
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 4 - ALL-WALKS
  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*7,LIST=N,EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),
            NTLEGMODE=4,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,FROMNODE=1-{ZONESI},TONODE=1-{ZONESI}

ENDPROCESS


PROCESS PHASE=SKIMIJ
 IF (TIMEA(0,4) > 0)
  MW[1]=TIMEA(0,4)     ; all walk time
 ELSE
  MW[1]=9999.99
 ENDIF
ENDPROCESS

ENDRUN


