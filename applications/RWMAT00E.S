; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\RWMAT00E.PRN" MSG='Revise Off Peak Walk Access Connectors'
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\NTLEG1OP_DEL.NTL"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWOP_TEM.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\NTLEG1OP_{alt}{year}.NTL"
FILEI RECI = "{SCENARIO_DIR}\OUTPUT\NTLEG1OP_TEM.NTL"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\INPUT\PCWALK_{year}{alt}.DAT"
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
 if (cenflag=0 && opprod>=95 && mindist<{AVGWALK}) rule = 3           ; No Transit Stop at centroid connector & PCW>=95% & shortest conn.length<AVGWALK
 if (cenflag=0 && opprod>=95 && mindist>={AVGWALK}) rule = 4          ; No Transit Stop at centroid connector & PCW>=95% & shortest conn.length>=AVGWALK
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
