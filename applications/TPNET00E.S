; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\TPNET00A.PRN" MSG='Create STATDATA file using PNR information'
FILEI LINKI[1] = "{Scenario_Dir}\output\PKPreLoad.NET"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\FringePNROP.TXT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\FringePNRPK.TXT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NODES.CSV"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\STATDATA_{ALT}{YEAR}.DAT"


ARRAY PNR=9999,RNG=9999,ZON=9999,PRK=9999,CSTAM=9999,CSTMD=9999,PNRT=9999,KNRT=9999,TYPE=9999

PROCESS  PHASE=NODEMERGE
; put nodes, x and y coordinates into memory for lookup nearest TAZ question
lookup lookupi=1,name=netcoord, lookup[1]=1, result=2, lookup[2]=1, result=3, fail=0

if (N=1) _CNT=1
if (N=1) _CNT1=1

if (TSTYPE_{year}{alt} > 0)
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

 PNR[_CNT]=N
 RNG[_CNT]=TSRANGE_{year}{alt}
 ZON[_CNT]=nearestzone
 PRK[_CNT]=TSPARKSPACE_{year}{alt}
 CSTAM[_CNT]=TSCOSTAM_{year}{alt}
 CSTMD[_CNT]=TSCOSTMD_{year}{alt}
 PNRT[_CNT]=2.0
 KNRT[_CNT]=0.5
 TYPE[_CNT]=TSTYPE_{year}{alt}
; get all the informal PNRs first (locations obtained from the on-board survey)
  if (TSTYPE_{year}{alt}=3,4,5,6) ; informal PNRs (locations obtained from on-board survey) stations
   autocontype=1
   if (TSTYPE_{year}{alt}=4) autocontype=4
   print list=_CNT1(4.0),PNR[_CNT](6.0),ZON[_CNT](6.0),RNG[_CNT](6.1),PRK[_CNT](6.0),CSTAM[_CNT](6.0),CSTMD[_CNT](6.0),
                                    PNRT[_CNT](6.1),KNRT[_CNT](6.1),autocontype(3.0)," Informal PNR/KNR", printo=1
   _CNT1=_CNT1+1
  endif

 _CNT=_CNT+1
endif

ENDPROCESS

PROCESS PHASE=LINKMERGE

 LOOP _ww=1,_CNT
  if ((LI.1.A = PNR[_ww]) & (LI.1.A >0) & (LI.1.FACILITY_TYPE=59))  ; formal PNR
   print list=_CNT1(4.0),li.1.B(6.0),ZON[_ww](6.0),RNG[_ww](6.1),PRK[_ww](6.0),CSTAM[_ww](6.0),CSTMD[_ww](6.0),
                                    LI.1.PNRTERMTIME(6.1),LI.1.KNRTERMTIME(6.1),TYPE[_ww](3.0)," PNR Station", li.1.A(6.0), printo=1
   _CNT1=_CNT1+1
  endif
; GENERATE statement for Fringe PNRs
  IF ((LI.1.A = PNR[_ww]) & (LI.1.B >80000) & (LI.1.FACILITY_TYPE=59) & (TYPE[_ww]=2))
    PRINT FORM=5.0,list="\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(li.time_1+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60),MINCOST=200*6,MAXCOST=200*20,LIST=N,",
    "\n  NTLEGMODE=5,MAXNTLEGS=200*1,DIRECTION=1,ONEWAY=T,EXCLUDELINK=(LI.COUNTY=1,3,4,5,6),",
    "\n  FROMNODE=1-{ZONESA}, TONODE=",LI.1.B,printo=2                                 ;peak period

    PRINT FORM=5.0,list="\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(li.time+li.svcminutes+li.svcseconds/60+li.cartoll*{ctoll}*60),MINCOST=200*6,MAXCOST=200*20,LIST=N,",
    "\n  NTLEGMODE=5,MAXNTLEGS=200*1,DIRECTION=1,ONEWAY=T,EXCLUDELINK=(LI.COUNTY=1,3,4,5,6),",
    "\n  FROMNODE=1-{ZONESA}, TONODE=",LI.1.B,printo=3                                 ;off-peak period
  ENDIF

  if (LI.1.B=PNR[_ww])
   PRKCSTAM=CSTAM[_ww]
   PRKCSTMD=CSTMD[_ww]
   PNRTerminalTime=PNRT[_ww]
   KNRTerminalTime=KNRT[_ww]
  endif
 ENDLOOP

ENDPROCESS

ENDRUN
