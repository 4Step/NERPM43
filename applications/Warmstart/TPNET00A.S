; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\TPNET00A.PRN" MSG='Build CBD xfer conn, station conn, & create station data file'
FILEI LOOKUPI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\XY_{alt}{year}.DAT"
FILEI LINKI[2] = "C:\NERPM43\APPLICATIONS\WARMSTART\HWYLOAD2_AM_{Alt}{Year}.NET"
FILEI LINKI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\HwyLoad2_MD_{alt}{year}.net"

FILEO PRINTO[7] = "C:\NERPM43\APPLICATIONS\WARMSTART\mpocounty.dat"
FILEO PRINTO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\ZONESAT.DAT"
FILEO PRINTO[6] = "C:\NERPM43\APPLICATIONS\WARMSTART\STATION_{alt}{year}.DAT"
FILEO PRINTO[5] = "C:\NERPM43\APPLICATIONS\WARMSTART\StationConn_{alt}{year}.DAT"
FILEO PRINTO[3] = "C:\NERPM43\APPLICATIONS\WARMSTART\CBDxfer_TMP.DAT"
ARRAY STATSTOP=99999 STATNUMB=99999, statspaces=99999, PNRTERM=99999, KNRTERM=99999, nrz=99999

PROCESS PHASE=NODEMERGE
; put nodes, x and y coordinates into memory for lookup nearest TAZ question
lookup lookupi=1,
       name=netcoord,
       lookup[1]=1, result=2,
       lookup[2]=1, result=3,
       fail=0

IF(N=1)
 _CNT=1
  ; Print out code for generating CBD sidewalks to a temporary file
 PRINT FORM=5.0, list="GENERATE, COST=(LW.WALKDISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=T,",
 "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
 "\n  FROMNODE=",PRINTO=3
ENDIF

IF(n<(_zones+1)) print list=n(5.0),mpo(5.0),county(5.0),printo=7

; extract station info from network for later calculations

IF (TSTYPE_10A=1)
 workstat=N
 workstatx=netcoord(1,workstat,0)
 workstaty=netcoord(2,workstat,0)
 mindist=99999.99
LOOP _ww=1,{ZONESA}
  zx=netcoord(1,_ww,0)
  zy=netcoord(2,_ww,0)
IF (_ww!=workstat) dist=sqrt((workstatx-zx)^2+(workstaty-zy)^2)
IF (dist<mindist) mindist=dist, nearestzone=_ww
ENDLOOP


 PRINT FORM=5.0, list="GENERATE, COST=(LW.WALKDISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*3.0,LIST=T,",
 "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=1,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
 "\n  FROMNODE=",N,",TONODE=1-{ZONESA}",PRINTO=5

 ; Station data file
 PRINT LIST=_CNT(4.0),N(6.0),NEARESTZONE(6.0),TSRANGE_10A(6.1),TSPARKSPACE_10A(6.0),TSCOSTAM_10A(6.0),TSCOSTMD_10A(6.0),
                           TSPNRTERM(6.1),TSKNRTERM(6.1),"  1 ",TSNAME(24),PRINTO=6
 _CNT=_CNT+1

ENDIF
ENDPROCESS

PHASE=LINKMERGE
  IF( (LI.1.A <> _lastnode) && (LI.1.A > {ZONESA}) )
  IF(LI.1.AREA_TYPE>10 && LI.1.AREA_TYPE<20)                    ;list only CBD zones
    PRINT FORM=5.0, list= LI.1.A(6.0),",", PRINTO=3
  ENDIF
  ENDIF

  ; list zones with area types (replaces CBDZONES.SYN and EXURBS.SYN files)
  IF ( (LI.1.A <> _lastnode) && (LI.1.A <= {ZONESA}) )
  IF (LI.1.A > 0) PRINT list=LI.1.A(10.0), LI.1.AREA_TYPE(10.0), printo=1
  ENDIF

  _lastnode = LI.1.A
ENDPHASE

PHASE=SUMMARY
  PRINT FORM=5.0, list= "TONODE={NODEMIN}-91157", PRINTO=3
ENDPHASE

ENDRUN
