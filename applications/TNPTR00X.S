; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\TNPTR00C.PRN" MSG='Off-peak transit paths and skims'
FILEI LINEI[2] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI FAREMATI[1] = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEO NTLEGO = "{SCENARIO_DIR}\output\OPNTL.NTL"
; Output files
FILEO MATO[9] = "{SCENARIO_DIR}\output\TSKIMOP9_{alt}{year}.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,FringePNR,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[8] = "{SCENARIO_DIR}\output\TSKIMOP8_{alt}{year}.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,FringePNR,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[7] = "{SCENARIO_DIR}\output\TSKIMOP7_{alt}{year}.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,FringePNR,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[6] = "{SCENARIO_DIR}\output\TSKIMOP6_TEM.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[5] = "{SCENARIO_DIR}\output\TSKIMOP5_TEM.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[4] = "{SCENARIO_DIR}\output\TSKIMOP4_TEM.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[3] = "{SCENARIO_DIR}\output\TSKIMOP3_TEM.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIMOP2_TEM.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIMOP1_TEM.MAT",
 MO=1-15,DEC=15*2, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,RailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO ROUTEO[9] = "{SCENARIO_DIR}\output\TPATHOP9_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[8] = "{SCENARIO_DIR}\output\TPATHOP8_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[6] = "{SCENARIO_DIR}\output\TPATHOP6_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[4] = "{SCENARIO_DIR}\output\TPATHOP4_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[2] = "{SCENARIO_DIR}\output\TPATHOP2_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\TPATHOP1_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO REPORTO = "{SCENARIO_DIR}\output\TNPTR00D.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\TransitOP.NET"

; Input files
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI FACTORI[9] = "{SCENARIO_DIR}\output\FringeCir.FAC"
FILEI FACTORI[8] = "{SCENARIO_DIR}\output\CBDKNRPrj.FAC"
FILEI FACTORI[7] = "{SCENARIO_DIR}\output\CBDKNRBus.FAC"
FILEI FACTORI[6] = "{SCENARIO_DIR}\output\KNRPrj.FAC"
FILEI FACTORI[5] = "{SCENARIO_DIR}\output\KNRBus.FAC"
FILEI FACTORI[4] = "{SCENARIO_DIR}\output\PNRPrj.FAC"
FILEI FACTORI[3] = "{SCENARIO_DIR}\output\PNRBus.FAC"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\WalkPrj.FAC"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkBus.FAC"
FILEI NTLEGI[7] = "{SCENARIO_DIR}\output\NTLEG12OP_{alt}{year}.NTL"
FILEI NTLEGI[6] = "{SCENARIO_DIR}\output\NTLEG11OP_{alt}{year}.NTL"
FILEI NTLEGI[5] = "{SCENARIO_DIR}\output\NTLEG6OP_{alt}{year}.NTL"
FILEI NTLEGI[4] = "{SCENARIO_DIR}\output\NTLEG5OP_{alt}{year}.NTL"
FILEI NTLEGI[3] = "{SCENARIO_DIR}\output\NTLEG3OP_{alt}{year}.NTL"
FILEI NTLEGI[2] = "{SCENARIO_DIR}\output\NTLEG2OP_{alt}{year}.NTL"
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG1OP_{alt}{year}.NTL"

zonemsg=50

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES={RunUserClasses},FARE=N, MAPSCALE=5280, HDWAYPERIOD=2,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEOP,
           TRANTIME[22]=LI.M22TIMEOP,
           TRANTIME[23]=LI.M23TIMEOP,
           TRANTIME[27]=LI.M27TIMEOP

;REPORT LINES=T
;REREPORT LINES=T,TRNLEGS3=T
PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEOP
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP
    ; 1- Generate walk-access links
     GENERATE READNTLEGI=1
    ; 1- Generate station walk connectors
     if ({isFutureYearAlternative}=1)
      READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATCON_TMP.DAT"
     endif
    ; 2- Generate PNR-access links
     GENERATE READNTLEGI=2
    ; 3- Generate KNR-access links
     GENERATE READNTLEGI=3
    ; 5- Fringe Fringe PNR
     GENERATE READNTLEGI=4
    ; 6- CBD KNR access links
     GENERATE READNTLEGI=5
    ; 11- Generate fixed-guideway to bus links
     GENERATE READNTLEGI=6
    ; 12- Generate CBD transfer links
     GENERATE READNTLEGI=7
ENDPROCESS

PROCESS PHASE=SKIMIJ

 IF (USERCLASS==1 | USERCLASS=3)
  IF ((TIMEA(0,21)+TIMEA(0,22)+TIMEA(0,23)) > 0)
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
   MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
   MW[4]=TIMEA(0,21)                                       ; Local and express bus time
   MW[5]=TIMEA(0,22)                                       ; Premium bus time
   MW[6]=TIMEA(0,23)                                       ; Circulator bus time
   MW[7]=TIMEA(0,24)                                       ; Light, Heavy Rail time
   MW[8]=TIMEA(0,25)                                       ; Commuter Rail time
   MW[9]=TIMEA(0,26)                                       ; Other mode time
   MW[10]=TIMEA(0,27)                                      ; Project mode time
   IF (BRDINGS(0,TMODES) > 0)
    MW[11]=BRDINGS(0,TMODES)-1                              ; Number of transfers
   ELSE
    MW[11]=0
   ENDIF
   MW[12]=IWAITA(0)                                        ; Initial wait time
   MW[13]=XWAITA(0)                                        ; Transfer wait time
   MW[14]=FAREA(0)*100                                     ; Fare matrix
   MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
  ELSE
   MW[1]=0
   MW[2]=0
   MW[3]=0
   MW[4]=0
   MW[5]=0
   MW[6]=0
   MW[7]=0
   MW[8]=0
   MW[9]=0
   MW[10]=0
   MW[11]=0
   MW[12]=0
   MW[13]=0
   MW[14]=0
   MW[15]=0
  ENDIF

 ELSEIF (USERCLASS=5 | USERCLASS=7)  ; 2.5 miles minimum bus ride on KNR paths - from OD survey
  IF ((DIST(0,21)+DIST(0,22)+DIST(0,23)) > 2.5)
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
   MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
   MW[4]=TIMEA(0,21)                                       ; Local and express bus time
   MW[5]=TIMEA(0,22)                                       ; Premium bus time
   MW[6]=TIMEA(0,23)                                       ; Circulator bus time
   MW[7]=TIMEA(0,24)                                       ; Light, Heavy Rail time
   MW[8]=TIMEA(0,25)                                       ; Commuter Rail time
   MW[9]=TIMEA(0,26)                                       ; Other mode time
   MW[10]=TIMEA(0,27)                                      ; Project mode time
   IF (BRDINGS(0,TMODES) > 0)
    MW[11]=BRDINGS(0,TMODES)-1                              ; Number of transfers
   ELSE
    MW[11]=0
   ENDIF
   MW[12]=IWAITA(0)                                        ; Initial wait time
   MW[13]=XWAITA(0)                                        ; Transfer wait time
   MW[14]=FAREA(0)*100                                     ; Fare matrix
   MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
  ELSE
   MW[1]=0
   MW[2]=0
   MW[3]=0
   MW[4]=0
   MW[5]=0
   MW[6]=0
   MW[7]=0
   MW[8]=0
   MW[9]=0
   MW[10]=0
   MW[11]=0
   MW[12]=0
   MW[13]=0
   MW[14]=0
   MW[15]=0
  ENDIF

 ELSEIF (USERCLASS==2 | USERCLASS=4)
  IF (TIMEA(0,27) > 0)
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
   MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
   MW[4]=TIMEA(0,21)                                       ; Local and express bus time
   MW[5]=TIMEA(0,22)                                       ; Premium bus time
   MW[6]=TIMEA(0,23)                                       ; Circulator bus time
   MW[7]=TIMEA(0,24)                                       ; Light, Heavy Rail time
   MW[8]=TIMEA(0,25)                                       ; Commuter Rail time
   MW[9]=TIMEA(0,26)                                       ; Other mode time
   MW[10]=TIMEA(0,27)                                      ; Project mode time
   IF (BRDINGS(0,TMODES) > 0)
    MW[11]=BRDINGS(0,TMODES)-1                              ; Number of transfers
   ELSE
    MW[11]=0
   ENDIF
   MW[12]=IWAITA(0)                                        ; Initial wait time
   MW[13]=XWAITA(0)                                        ; Transfer wait time
   MW[14]=FAREA(0)*100                                     ; Fare matrix
   MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
  ELSE
   MW[1]=0
   MW[2]=0
   MW[3]=0
   MW[4]=0
   MW[5]=0
   MW[6]=0
   MW[7]=0
   MW[8]=0
   MW[9]=0
   MW[10]=0
   MW[11]=0
   MW[12]=0
   MW[13]=0
   MW[14]=0
   MW[15]=0
  ENDIF

 ELSEIF (USERCLASS=6 | USERCLASS=8)    ; 2.5 miles minimum bus ride on KNR paths - from OD survey
  IF ((TIMEA(0,27) > 0) & (DIST(0,21)+DIST(0,22)+DIST(0,23)+DIST(0,27) > 2.5))
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,2)+TIMEA(0,3)+TIMEA(0,6)                  ; Auto access time (PNR/KNR)
   MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
   MW[4]=TIMEA(0,21)                                       ; Local and express bus time
   MW[5]=TIMEA(0,22)                                       ; Premium bus time
   MW[6]=TIMEA(0,23)                                       ; Circulator bus time
   MW[7]=TIMEA(0,24)                                       ; Light, Heavy Rail time
   MW[8]=TIMEA(0,25)                                       ; Commuter Rail time
   MW[9]=TIMEA(0,26)                                       ; Other mode time
   MW[10]=TIMEA(0,27)                                      ; Project mode time
   IF (BRDINGS(0,TMODES) > 0)
    MW[11]=BRDINGS(0,TMODES)-1                              ; Number of transfers
   ELSE
    MW[11]=0
   ENDIF
   MW[12]=IWAITA(0)                                        ; Initial wait time
   MW[13]=XWAITA(0)                                        ; Transfer wait time
   MW[14]=FAREA(0)*100                                     ; Fare matrix
   MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
  ELSE
   MW[1]=0
   MW[2]=0
   MW[3]=0
   MW[4]=0
   MW[5]=0
   MW[6]=0
   MW[7]=0
   MW[8]=0
   MW[9]=0
   MW[10]=0
   MW[11]=0
   MW[12]=0
   MW[13]=0
   MW[14]=0
   MW[15]=0
  ENDIF

; fringe pnr to skyway/trolley
 ELSEIF (USERCLASS==9)
  IF(TIMEA(0,23) > 0)    ; if time on circulator mode
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,5)                                        ; Fringe PNR time
   MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
   MW[4]=TIMEA(0,21)                                       ; Local and express bus time
   MW[5]=TIMEA(0,22)                                       ; Premium bus time
   MW[6]=TIMEA(0,23)                                       ; Circulator bus time
   MW[7]=TIMEA(0,24)                                       ; Light, Heavy Rail time
   MW[8]=TIMEA(0,25)                                       ; Commuter Rail time
   MW[9]=TIMEA(0,26)                                       ; Other mode time
   MW[10]=TIMEA(0,27)                                      ; Project mode time
   IF (BRDINGS(0,TMODES) > 0)
    MW[11]=BRDINGS(0,TMODES)-1                              ; Number of transfers
   ELSE
    MW[11]=0
   ENDIF
   MW[12]=IWAITA(0)                                        ; Initial wait time
   MW[13]=XWAITA(0)                                        ; Transfer wait time
   MW[14]=FAREA(0)*100                                     ; Fare matrix
   MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
  ELSE
   MW[1]=0
   MW[2]=0
   MW[3]=0
   MW[4]=0
   MW[5]=0
   MW[6]=0
   MW[7]=0
   MW[8]=0
   MW[9]=0
   MW[10]=0
   MW[11]=0
   MW[12]=0
   MW[13]=0
   MW[14]=0
   MW[15]=0
  ENDIF
 ENDIF

ENDPROCESS

ENDRUN
