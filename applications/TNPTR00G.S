; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\TNPTR00C.PRN" MSG='OP transit paths and skims'
FILEI NTLEGI[5] = "{SCENARIO_DIR}\output\NTLEG6OP_{alt}{year}.NTL"
; Output files
FILEO MATO[6] = "{SCENARIO_DIR}\output\TSKIMOP6_{alt}{year}.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[5] = "{SCENARIO_DIR}\output\TSKIMOP5_{alt}{year}.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[4] = "{SCENARIO_DIR}\output\TSKIMOP4_{alt}{year}.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[3] = "{SCENARIO_DIR}\output\TSKIMOP3_{alt}{year}.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIMOP2_TEM.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIMOP1_TEM.MAT",
 MO=1-15,DEC=15*D, NAME=WalkTime,AutoTime,XferTime,BusTime,PremBusTime,CircTime,HRailTime,CRailTime,OtherTime,ProjTime,NumXfers,InitWait,XferWait,Fare,TotalTime
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
FILEI NETI = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEI NTLEGI[4] = "{SCENARIO_DIR}\output\NTLEG12OP_{alt}{year}.NTL"
FILEI NTLEGI[3] = "{SCENARIO_DIR}\output\NTLEG11OP_{alt}{year}.NTL"
FILEI NTLEGI[2] = "{SCENARIO_DIR}\output\NTLEG2OP_{alt}{year}.NTL"
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG1OP_{alt}{year}.NTL"
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI FACTORI[6] = "{SCENARIO_DIR}\output\KNRProj.FAC"
FILEI FACTORI[5] = "{SCENARIO_DIR}\output\KNRBus.FAC"
FILEI FACTORI[4] = "{SCENARIO_DIR}\output\PNRProj.FAC"
FILEI FACTORI[3] = "{SCENARIO_DIR}\output\PNRBus.FAC"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\WalkProj.FAC"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\WalkBus.FAC"

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
REREPORT LINES=T,TRNLEGS3=T
PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIMEOP
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP
    ; Generate walk-access links
     GENERATE READNTLEGI=1
    ; Generate PNR-access links
     GENERATE READNTLEGI=2
    ; Generate station walk connectors
     READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATCON_TMP.DAT"
    ; Generate fixed-guideway to bus links
     GENERATE READNTLEGI=3
    ; Generate CBD transfer links
     GENERATE READNTLEGI=4
ENDPROCESS

PROCESS PHASE=SKIMIJ

 IF (USERCLASS==1 | USERCLASS=3 | USERCLASS=5)
  IF ((TIMEA(0,21)+TIMEA(0,22)+TIMEA(0,23)) > 0)
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,2)                                        ; PNR time
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

 ELSEIF (USERCLASS==2 | USERCLASS=4 | USERCLASS=6)
  IF (TIMEA(0,27) > 0)
   MW[1]=TIMEA(0,1)                                        ; Walk time
   MW[2]=TIMEA(0,2)                                        ; PNR time
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
