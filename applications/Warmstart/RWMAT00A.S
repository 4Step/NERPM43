; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\RWMAT00A.PRN" MSG='Connector Information for PK'
FILEO RECO[1] = "{SCENARIO_DIR}\output\PKZONECONN_TEM.DBF",
FIELDS =zonea(5.0),conn_ctr(3.0),mindist(5.2),mincost(5.2),cenflag(1.0)
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
