; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\TNNET00C.PRN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\TNNET00D.PRN"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\TNNET00A.NET"

ARRAY CBDNODETMP=99999, CBDNODE=99999

; add in nearest centroid lookup for auto cost to stations HWYOPCOST
     
PROCESS PHASE=NODEMERGE
; put nodes, x and y coordinates into memory for lookup nearest TAZ question
lookup lookupi=1,name=netcoord, lookup[1]=1, result=2, lookup[2]=1, result=3, fail=0

IF (N=1)
       _CNT=1
; GENERATE CBD sidewalks
       PRINT FORM=5.0, list="GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=N,",
         "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
         "\n  FROMNODE=",PRINTO=2
ENDIF

; extract PNR station info from network for later calculations
IF (TSTYPE_{year}{Alt}>0)

workstat=N
workstatx=netcoord(1,workstat,0)
workstaty=netcoord(2,workstat,0)
mindist=999.99
loop _ww=1,{ZONESI}
  zx=netcoord(1,_ww,0)
  zy=netcoord(2,_ww,0)
  if (_ww!=workstat) dist=sqrt((workstatx-zx)^2+(workstaty-zy)^2)/5280
  if (dist<mindist) mindist=dist, nearestzone=_ww
endloop

      if (TSTYPE_{year}{alt} > 0) 
       PRINT form=5.0,list="GENERATE,COST=(li.distance),MAXCOST=200*",TSRANGE_{year}{alt}(5.2L),
         ",\n EXTRACTCOST=(li.TIME_1),LIST=F,DIRECTION=1,NTLEGMODE=2,FROMNODE=1-{ZONESI},TONODE=",N, PRINTO=3
       PRINT form=5.0,list="GENERATE,COST=(li.distance),MAXCOST=200*",TSRANGE_{year}{alt}(5.2L),
         ",\n EXTRACTCOST=(li.TIME),LIST=F,DIRECTION=1,NTLEGMODE=2,FROMNODE=1-{ZONESI},TONODE=",N, PRINTO=4
       ; only fixed-guideways and non-circulator PNR lots 
       if (TSTYPE_{year}{alt} = 1)
        PRINT FORM=5.0,list="GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*3.0,LIST=Y,",
          "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=1,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
          "\n  FROMNODE=1-{ZONESA}, TONODE=",N,PRINTO=8
       endif

       PRINT CSV=T, LIST=N(6.0),NEARESTZONE(6.0),TSCOSTAM_{year}{alt},TSCOSTMD_{year}{alt},TSPNRTERM_{year}{alt},TSKNRTERM_{year}{alt}, PRINTO=5
       print list=_CNT(4.0),N(6.0),NEARESTZONE(6.0),TSRANGE_{year}{alt}(6.1),TSPARKSPACE_{year}{alt}(6.0),TSCOSTAM_{year}{alt}(6.0),
               TSCOSTMD_{year}{alt}(6.0),TSPNRTERM_{year}{alt}(6.1),TSKNRTERM_{year}{alt}(6.1),TSTYPE_{year}{alt}(3.0)," ",TSNAME(24),printo=1
        _CNT=_CNT+1
      endif
endif

ENDPROCESS

PHASE=LINKMERGE

; list zones with area types (replaces CBDZONES.SYN and EXURBS.SYN files)
   if ( (LI.1.A <> _lastnode) && (LI.1.A <= {ZONESA}) )
     if (LI.1.A > 0) PRINT list=LI.1.A(10.0), LI.1.AREA_TYPE(10.0), PRINTO=6
   endif

    _lastnode = LI.1.A
ENDPHASE

PHASE=SUMMARY
       
      if (CBDNODE[_M+10]<=0)
       LOOP _C=1,10
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",PRINTO=2
       ENDLOOP
      endif

    ENDLOOP

    PRINT FORM=5.0, list= "TONODE={NODEMIN}-99999", PRINTO=2
    if ({isFutureYearAlternative}=1)
     print form=5.0, list= ")", printo=7
    endif
ENDPHASE


ENDRUN
