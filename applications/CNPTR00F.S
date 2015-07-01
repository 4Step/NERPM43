; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\CNPTR00C1.PRN" MSG='Off-peak period connectors'
FILEO ROUTEO[2] = "{SCENARIO_DIR}\output\OPFrKNR_{alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\OPFrPNR_{alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO MATO[2] = "{SCENARIO_DIR}\output\OPFrKNR_{alt}{year}.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,FringeKNR,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[1] = "{SCENARIO_DIR}\output\OPFrPNR_{alt}{year}.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,FringePNR,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO REPORTO = "{SCENARIO_DIR}\output\CNPTR00D.PRN"

FILEI NTLEGI[3] = "{SCENARIO_DIR}\output\NTLEG6OP_{alt}{year}.NTL"
FILEI NTLEGI[2] = "{SCENARIO_DIR}\output\NTLEG5OP_{alt}{year}.NTL"
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG1OP_{alt}{year}.NTL"
FILEI FACTORI[2] = "{CATALOG_DIR}\parameters\FringeKNRBus.FAC"
FILEI FACTORI[1] = "{CATALOG_DIR}\parameters\FringePNRSkyway.FAC"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1-2,FARE=N, MAPSCALE=5280, HDWAYPERIOD=2,
           NOROUTEERRS=999999, NOROUTEMSGS=999999, 
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEOP,
           TRANTIME[22]=LI.M22TIMEOP,
           TRANTIME[23]=LI.M23TIMEOP,
           TRANTIME[27]=LI.M27TIMEOP

REPORT LINES=T
REREPORT LINES=T, TRNLEGS3=T
PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEOP
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP

  ; 1 - Walk access/egress connectors
  GENERATE, READNTLEGI=1
  ; 5 - Fringe PNR to SKyway/Trolley
  GENERATE, READNTLEGI=2
  ; 5 - Fringe KNR to Bus
  GENERATE, READNTLEGI=3

ENDPROCESS

PROCESS PHASE=SKIMIJ

; fringe pnr to skyway/trolley
 IF (USERCLASS==1)
  IF(TIMEA(0,23) > 0)         ; if time on the circulator mode
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
; fringe knr bus 
 IF (USERCLASS==2)
  IF((TIMEA(0,21)+TIMEA(0,22)+TIMEA(0,24)+TIMEA(0,25)+TIMEA(0,26)+TIMEA(0,27)) > 0)   ; if time on a non-circulator mode
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,6)                                        ; Fringe PNR time
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
