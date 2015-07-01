; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\GenPrep.PRN"
FILEI LINKI[1] = "{Scenario_Dir}\output\PKPreLoad.NET"
FILEO PRINTO[7] = "{SCENARIO_DIR}\output\FringeKNRBusOP.TXT"
FILEO PRINTO[6] = "{SCENARIO_DIR}\output\FringeKNRBusPK.TXT"
FILEO PRINTO[5] = "{SCENARIO_DIR}\output\STATXFER_TMP.DAT"
FILEO PRINTO[4] = "{SCENARIO_DIR}\output\STATCON_TMP.DAT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\ZONESAT.DAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\CBDXFER.DAT"

ARRAY CBDNODETMP=99999, CBDNODE=99999, BRTSTATIONS=500

PROCESS PHASE=NODEMERGE
 IF (N=1)
   _CNT=1
 ; GENERATE CBD sidewalks
       PRINT FORM=5.0, list="; CBD sidewalk (0.6 mile) from CBD nodes to all other nodes",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=N,",
         "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
         "\n  FROMNODE=",printo=1
  ; 6 - FRINGE PARK ACCESS TO BUS - peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME_1,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=6
  ; 7 - FRINGE PARK ACCESS TO BUS - off-peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=7
 ENDIF

ENDPROCESS

PHASE=LINKMERGE

; Store BRT nodes for SELECTLINK analysis
    if ( (FACILITY_TYPE=69) && (LI.1.A >= {FirstBRTStationNode}) && (LI.1.B >= {FirstBRTStationNode}) && (LI.1.A < LI.1.B) )   ; pick up the BRT Links (does not include the Skyway Links)
     if (_idx=0)
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
       _idx=_idx+2
     else
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
      _idx=_idx+2
     endif
    endif
; store CBD nodes
    _LNKCNT=_LNKCNT+1
    if ( (LI.1.A <> _lastnode) && (LI.1.A > {ZONESA}) )
     if (LI.1.AREA_TYPE>10 && LI.1.AREA_TYPE<20)                    ;list only CBD nodes
;        PRINT FORM=5.0, list= LI.1.A(6.0),",", printo=1
       CBDNODETMP[_LNKCNT]=LI.1.A
     endif
    endif

; list zones with area types (replaces CBDZONES.SYN and EXURBS.SYN files)
   if ( (LI.1.A <> _lastnode) && (LI.1.A <= {ZONESA}) )
     if (LI.1.A > 0) PRINT list=LI.1.A(10.0), LI.1.AREA_TYPE(10.0), printo=2
   endif

    _lastnode = LI.1.A
ENDPHASE

; Issue - Voyager does not allow to have more than 1000 nodes in one FROMNODE list
; assuming that there are no more than 10,000 nodes in the CBD region
; not sure whether the script below will work for more than 10,000 nodes in the CBD region
; summary phase for printing out the GENERATE statement with a list of CBD nodes for CBD sidewalks
PHASE=SUMMARY
    _A=1
    _B=1
    LOOP _N=1,99999
     if (CBDNODETMP[_N]>0)
      CBDNODE[_A]=CBDNODETMP[_N]
      _A=_A+1
     endif

    ENDLOOP

    LOOP _K=1,9999
      _M=(_K-1)*10
      if (CBDNODE[_M+1]>0 & CBDNODE[_M+10]>0)
       _B=_B+1
       if (_B<=50)

        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=1
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=6
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=7
       endif

       if (_B=50)
         PRINT FORM=5.0, list= "TONODE={NODEMIN}-99999", printo=1
         PRINT FORM=5.0, list= "NTLEGMODE=6", printo=6
         PRINT FORM=5.0, list= "NTLEGMODE=6", printo=7
         PRINT FORM=5.0, list="GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*{XFERACC},LIST=N,",
           "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),NTLEGMODE=12,MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
           "\n  FROMNODE=",printo=1

  ; 6 - FRINGE PARK ACCESS TO BUS - peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME_1,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=6

 ; 7 - FRINGE PARK ACCESS TO BUS - off-peak period
       PRINT FORM=5.0, list="; fringe knr access to bus",
         "\n\n  GENERATE, COST=(LW.DISTANCE),EXTRACTCOST=LI.TIME,MINCOST=200*0.2,MAXCOST=200*7,LIST=N,",
         "\n     MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=1,ONEWAY=T,FROMNODE=1-{ZONESI},TONODE=", printo=7
       endif

       if (_B>50)
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=1
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=6
        PRINT FORM=5.0, list= CBDNODE[_M+1](6.0),",",CBDNODE[_M+2](6.0),",",CBDNODE[_M+3](6.0),",",CBDNODE[_M+4](6.0),",",
                              CBDNODE[_M+5](6.0),",",CBDNODE[_M+6](6.0),",",CBDNODE[_M+7](6.0),",",CBDNODE[_M+8](6.0),",",
                              CBDNODE[_M+9](6.0),",",CBDNODE[_M+10](6.0),",",printo=7
       endif
      endif


      if (CBDNODE[_M+10]<=0)
       LOOP _C=1,10
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",printo=1
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",printo=6
        if (CBDNODE[_M+_C]>0) PRINT FORM=5.0, list= CBDNODE[_M+_C](6.0),",",printo=7
       ENDLOOP
      endif

    ENDLOOP

    PRINT FORM=5.0, list= "TONODE={NODEMIN}-99999", printo=1
    PRINT FORM=5.0, list= "NTLEGMODE=6", printo=6
    PRINT FORM=5.0, list= "NTLEGMODE=6", printo=7

;; BRT stations - walk connectors and transfer connectors
   SORT ARRAY=BRTSTATIONS

    loop _ff=1,500
; 3 mile walk connector to/from stations
     if ({isFutureYearAlternative}=1 & _ff=1); & BRTSTATIONS[_ff]>0)
        PRINT FORM=5.0,list="\n\n ; 3 mile walk connector from station to/from all zones",
          "\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*3.0,LIST=N,",
          "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),MAXNTLEGS=200*{MAXWLKACCLNKS},DIRECTION=3,ONEWAY=F,",
          "\n  FROMNODE=",printo=4
     endif
     if ({isFutureYearAlternative}=1 & _ff>1 & BRTSTATIONS[_ff]>0 & BRTSTATIONS[_ff]<>_prevstation) print list=BRTSTATIONS[_ff](9.0),",",printo=4
; station-nearby stop transfer connectors - maxntlegs=20 (99 too much for jax - huge impact on running times)
     if ({isFutureYearAlternative}=1 & _ff=1)
        PRINT FORM=5.0,list=";0.6 mile transfer connectors from all BRT stations to nearby stops",
          "\n\n  GENERATE,COST=(LW.DISTANCE),EXTRACTCOST=(LW.WALKTIME),MAXCOST=200*0.6,LIST=N,",
          "\n  EXCLUDELINK=(LI.FACILITY_TYPE=10-19,69,70-99),MAXNTLEGS=200*20,DIRECTION=3,ONEWAY=F,",
          "\n  FROMNODE=",printo=5
     endif
     if ({isFutureYearAlternative}=1 & _ff>1 & BRTSTATIONS[_ff]>0 & BRTSTATIONS[_ff]<>_prevstation) print list=BRTSTATIONS[_ff](9.0),",",printo=5
     _prevstation=BRTSTATIONS[_ff]

    endloop

    if ({isFutureYearAlternative}=1)
     print list="    TONODE=1-{ZONESA}, NTLEGMODE=1",printo=4
     print list="    TONODE={NODEMIN}-99999, NTLEGMODE=11",printo=5
    endif

ENDPHASE


ENDRUN
