; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\KumarA\NERPM\CUBE\TNMAT00A.PRN" MSG='Build Connector Criteria'
FILEI RECI = "{INDIR}\STATDATA.{YEAR}{ALT}"
FILEI LOOKUPI[1] = "{OUTDIR}\NODES.CSV"
FILEO PRINTO[7] = "C:\KumarA\NERPM\CUBE\STATNO.TXT"
FILEO PRINTO[6] = "C:\KumarA\NERPM\CUBE\SIDEWALKSMD.TXT"
FILEO PRINTO[5] = "C:\KumarA\NERPM\CUBE\SIDEWALKSAM.TXT"
FILEO PRINTO[4] = "C:\KumarA\NERPM\CUBE\STATIONMD.TXT"
FILEO PRINTO[3] = "C:\KumarA\NERPM\CUBE\STATIONAM.TXT"
par zones={zonesa}
ZONESA1={ZONESA}+1
ARRAY STATSTOP=999999 STATNUMB=999999, statspaces=999999, PNRTERM=999999, KNRTERM=999999, nrz=999999,
amcst=999999, mdcst=999999, statzn=999999
VALUEOFTIME=15.00 ; DOLLARS PER HOUR USED TO ADD TIME EQUIVALENT OF PARKING COST TO AUTO CONNECTORS
w=' ; '
if (ri.statnode>0)
STATNAME=SUBSTR(RECI,57,23)
PRINT CSV=T,LIST=ri.statno(3.0),STATNAME
; ALLOW PT TO IDENTIFY STATION NUMBER VS. STATION NODE NUMBER
STATSTOP[RI.STATNODE]=1, STATNUMB[RI.STATNODE]=RI.STATNO, STATSPACES[RI.STATNODE]=RI.PARKINGSPACES, PNRTERM[RI.STATNODE]=RI.TERMPNR, KNRTERM[RI.STATNODE]=RI.TERMKNR,
statzn[ri.statnode]=ri.statzone
amcst[ri.statnode]=ri.amcost
mdcst[ri.statnode]=ri.mdcost
; input record counter
IF (RI.AMUSEFLAG=1)
 PRINT form=5.0,list="\nGENERATE,COST=(lw.distance),",w,statname,"\n  DIRECTLINK=125,MINCOST=255*1.0,MAXNTLEGS=4,MAXCOST=255*",ri.svcarea(5.2L),
   ",EXTRACTCOST=(li.TIME_1),LIST=F,","\n  DIRECTION=1,NTLEGMODE=2,FROMNODE=1-{ZONESA},TONODE=",RI.STATNODE(5.0L),PRINTO=3
 PRINT form=5.0,list="\nGENERATE,COST=(LW.WALKDISTANCE),",W,STATNAME,"\n  MAXNTLEGS=4,DIRECTLINK=125,EXTRACTCOST=(LW.WALKTIME),MAXCOST=255*{MAXD},LIST=F,NTLEGMODE=3,ONEWAY=F,",
      "\n  FROMNODE=",RI.STATNODE,", TONODE=",ZONESA1(4.0L),"-99999",PRINTO=5
endif
mduseflag=ri.amuseflag
IF (mduseflag=1)
 PRINT form=5.0,list="\nGENERATE,COST=(lw.distance),",w,statname,"\n  DIRECTLINK=125,MINCOST=255*1.0,MAXNTLEGS=4,MAXCOST=255*",ri.svcarea(5.2L),
   ",EXTRACTCOST=(li.TIME),LIST=F,","\n  DIRECTION=1,NTLEGMODE=2,FROMNODE=1-{ZONESA},TONODE=",RI.STATNODE(5.0L),PRINTO=4
 PRINT form=5.0,list="\nGENERATE,COST=(LW.WALKDISTANCE),",W,STATNAME,"\n  MAXNTLEGS=4,DIRECTLINK=125,EXTRACTCOST=(LW.WALKTIME),MAXCOST=255*{MAXD},LIST=F,NTLEGMODE=3,ONEWAY=F,",
       "\n  FROMNODE=",RI.STATNODE,", TONODE=",ZONESA1(4.0L),"-99999",PRINTO=6
endif

; put nodes, x and y coordinates into memory for lookup nearest TAZ question
lookup lookupi=1,name=netcoord, lookup[1]=1, result=2, lookup[2]=1, result=3, fail=0

workstat=ri.statnode
workstatx=netcoord(1,workstat,0)
workstaty=netcoord(2,workstat,0)
mindist=999.99
loop ww=1,zones
  zx=netcoord(1,ww,0)
  zy=netcoord(2,ww,0)
  if (ww!=workstat) dist=sqrt((workstatx-zx)^2+(workstaty-zy)^2)/5280
  if (dist<mindist) mindist=dist, nearestzone=ww
;  print form=9.0 list=workstat,workstatx,workstaty,ww, zx,zy,dist(6.2),mindist(6.2),nearestzone
endloop
nrz[ri.statnode]=nearestzone
endif

; NOTE: i is an internal program flag that indicates if the RECI input file is still being read, 1 if still reading, 0 if complete
if (i=0)
  loop STN=1,99999
   if (statstop[stn]>0) print list=stn(6.0),statnumb[stn](6.0),STATSPACES[stn](6.0),PNRTERM[stn](6.0),KNRTERM[stn](6.0),nrz[stn](8.0),statzn[stn](7.0),amcst[stn](8.0),mdcst[stn](8.0),
" station, statnumber, spaces,pnrterm,knrterm,nearestzone(distance),nearestzone(statdata input),ampnrcost,mdpnrcost",   printo=7 
  endloop
endif
ENDRUN
