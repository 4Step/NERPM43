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
   ;PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s23,;PRINTO=1
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
  ;PRINT LIST="NT LEG=",zonei(5.0),"-",zonej(5.0)," MODE=",mode(2.0)," COST=",time(5.2)," DIST=",dist(5.2)," ",s23,PRINTO=1
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


