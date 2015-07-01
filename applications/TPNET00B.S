; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\KUMARA\NERPM\CUBE\TPNET00A.PRN"
FILEO PRINTO[4] = "C:\KUMARA\NERPM\CUBE\TPNET00E.PRN"
FILEO PRINTO[3] = "C:\KUMARA\NERPM\CUBE\TPNET00D.PRN"
FILEO PRINTO[2] = "C:\KUMARA\NERPM\CUBE\TPNET00C.PRN"
FILEO PRINTO[1] = "C:\KUMARA\NERPM\CUBE\TPNET00B.PRN"

ARRAY STATSTOP=99999 STATNUMB=99999, statspaces=99999, PNRTERM=99999, KNRTERM=99999, nrz=99999

; add in nearest centroid lookup for auto cost to stations HWYOPCOST

PROCESS PHASE=NODEMERGE
; put nodes, x and y coordinates into memory for lookup nearest TAZ question
lookup lookupi=1,name=netcoord, lookup[1]=1, result=2, lookup[2]=1, result=3, fail=0

IF (N=1)
       _CNT=1
; GENERATE CBD sidewalks
       PRINT FORM=5.0, list="GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=T,",
         "\n  EXCLUDELINK=(LI.FTYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
         "\n  FROMNODE=",PRINTO=1
ENDIF

; extract PNR station info from network for later calculations
IF (TSTYPE=1)

workstat=N
workstatx=netcoord(1,workstat,0)
workstaty=netcoord(2,workstat,0)
mindist=999.99
loop _ww=1,{ZONESA}
  zx=netcoord(1,_ww,0)
  zy=netcoord(2,_ww,0)
  if (_ww!=workstat) dist=sqrt((workstatx-zx)^2+(workstaty-zy)^2)/5280
  if (dist<mindist) mindist=dist, nearestzone=_ww
endloop

       PRINT form=5.0,list="GENERATE,COST=(li.distance),MINCOST=200*1.0,MAXCOST=200*",pnrsvcarea(5.2L),
         ",\n EXTRACTCOST=(li.TIME_1),LIST=F,DIRECTION=1,NTLEGMODE=2,FROMNODE=1-{ZONESA},TONODE=",N, PRINTO=1
       PRINT form=5.0,list="GENERATE,COST=(li.distance),MINCOST=200*1.0,MAXCOST=200*",pnrsvcarea(5.2L),
         ",\n EXTRACTCOST=(li.TIME),LIST=F,DIRECTION=1,NTLEGMODE=2,FROMNODE=1-{ZONESA},TONODE=",N, PRINTO=7

       PRINT CSV=T, LIST=N(6.0),NEARESTZONE(6.0),AMPNRCOST,MDPNRCOST,PNRTERMTIM,KNRTERMTIM PRINTO=3

endif

; extract PNR+KNR-only station info from network for later calculations
IF (TSTYPE=1,2)

workstat=N
workstatx=netcoord(1,workstat,0)
workstaty=netcoord(2,workstat,0)
mindist=999.99
loop _ww=1,{ZONESA}
  zx=netcoord(1,_ww,0)
  zy=netcoord(2,_ww,0)
  if (_ww!=workstat) dist=sqrt((workstatx-zx)^2+(workstaty-zy)^2)/5280
  if (dist<mindist) mindist=dist, nearestzone=_ww
endloop

       PRINT form=5.0,list="GENERATE,COST=(li.distance),MINCOST=200*1.0,MAXCOST=200*",pnrsvcarea(5.2L),
         ",\n EXTRACTCOST=(li.TIME_1),LIST=F,DIRECTION=1,NTLEGMODE=3,FROMNODE=1-{ZONESA},TONODE=",N,PRINTO=2
       PRINT form=5.0,list="GENERATE,COST=(li.distance),MINCOST=200*1.0,MAXCOST=200*",pnrsvcarea(5.2L),
         ",\n EXTRACTCOST=(li.TIME),LIST=F,DIRECTION=1,NTLEGMODE=3,FROMNODE=1-{ZONESA},TONODE=",N,PRINTO=8

       PRINT CSV=T, LIST=N(6.0),NEARESTZONE(6.0),AMPNRCOST,MDPNRCOST,PNRTERMTIM,KNRTERMTIM PRINTO=4

       print list=_CNT(4.0),N(6.0),NEARESTZONE(6.0),PNRSVCAREA(6.1),PARKINGSPA(6.0),AMPNRCOST(6.0),
              MDPNRCOST(6.0),PNRTERMTIM(6.1),KNRTERMTIM(6.1),TSTYPE(3.0)," ",PNRDESCRIP(24),printo=6
       _CNT=_CNT+1

endif

ENDPROCESS


PHASE=LINKMERGE
    if ( (LI.1.A <> _lastnode) && (LI.1.A > {ZONESA}) )
      if (LI.1.ATYPE>10 && LI.1.ATYPE<20)                    ;list only CBD zones
        PRINT FORM=5.0, list= LI.1.A(6.0),",", PRINTO=5
      endif
    endif
    _lastnode = LI.1.A
ENDPHASE


PHASE=SUMMARY
    PRINT FORM=5.0, list= "TONODE={NODEMIN}-99999", PRINTO=5
ENDPHASE


ENDRUN
