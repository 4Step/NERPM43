; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{CATALOG_DIR}\APPLICATIONS\PSPTR00J.PRN" MSG='Auto-Access Paths/Skims - PK'
FILEI NETI = "{SCENARIO_DIR}\output\HWYLOAD2_AM_{Alt}{Year}.NET"
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG1PK_{alt}{year}.NTL"
FILEI NTLEGI[3] = "{SCENARIO_DIR}\output\NTLEG11PK_{alt}{year}.NTL"
FILEI NTLEGI[4] = "{SCENARIO_DIR}\output\NTLEG12PK_{alt}{year}.NTL"
FILEI NTLEGI[2] = "{SCENARIO_DIR}\OUTPUT\NTLEG2PK_{ALT}{Year}.NTL"
FILEI FACTORI[2] = "C:\NERPM43\applications\Warmstart\PNRBus.FAC"
FILEI FACTORI[1] = "C:\NERPM43\applications\Warmstart\PNRPrj.FAC"
FILEI FAREI = "C:\NERPM43\applications\Warmstart\TFARES_10A.FAR"
FILEI SYSTEMI = "C:\NERPM43\applications\Warmstart\SYSTEM.PTS"
FILEI LINEI[1] = "C:\NERPM43\applications\Warmstart\TROUTE_10A.LIN"

FILEO LINEO = "{SCENARIO_DIR}\output\pkwalk.lin"
FILEO NTLEGO = "{SCENARIO_DIR}\output\pkauto.ntl"
FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIMAM4_{alt}{year}.MAT",
  MO=1-15, NAME=WALKTIME,AutoTIME,SidewalkTime,BUSTIME,PBUSTIME,CIRCTIME,RAILTIME,COMRLTIME,OTHTIME,PRJTIME,XFER,IWAIT,XWAIT,FARE,TOTTIME
FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIMAM3_{alt}{year}.MAT",
  MO=1-15, NAME=WALKTIME,AutoTIME,SidewalkTIME,BUSTIME,PBUSTIME,CIRCTIME,RAILTIME,COMRLTIME,OTHTIME,PRJTIME,XFER,IWAIT,XWAIT,FARE,TOTTIME
FILEO ROUTEO[2] = "{SCENARIO_DIR}\output\TPATHAM4_{alt}{year}.RTE",
  REPORTI={FromNode}, REPORTJ={ToNode}, TRACEI={FromNode}, TRACEJ={ToNode};, I={FromNode}, J={ToNode}
FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\TPATHAM3_{alt}{year}.RTE",
  REPORTI={FromNode}, REPORTJ={ToNode}, TRACEI={FromNode}, TRACEJ={ToNode};, I={FromNode}, J={ToNode}
FILEO REPORTO = "{SCENARIO_DIR}\output\pkauto.rpt"
FILEO NETO = "{SCENARIO_DIR}\output\PKAuto.NET"

;**************************************************************
;BEGIN POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************

; OVERALL PARAMETERS
   PARAMETERS USERCLASSES=1-2,FARE=N, MAPSCALE={Units}, HDWAYPERIOD=1,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIMEPK,
           TRANTIME[22]=LI.M22TIMEPK,
           TRANTIME[23]=LI.M23TIMEPK,
           ;TRANTIME[24]=LI.M24TIMEPK,
           ;TRANTIME[25]=LI.M25TIMEPK,
           ;TRANTIME[26]=LI.M26TIMEPK,
           TRANTIME[27]=LI.M27TIMEPK

;**************************************************************
;END POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************
       
   PROCESS PHASE=LINKREAD
           LW.TRANTIME=LI.M21TIMEPK
           LW.WALKTIME=LI.WALKTIME
           LW.WALKDISTANCE=LI.ADJDISTANCE
           LW.DISTANCE=LI.DISTANCE
   ENDPROCESS

   PROCESS PHASE=DATAPREP
          ; Generate walk-access links
          GENERATE READNTLEGI=1
          ; Generate station-access links
          READ, FILE = "{SCENARIO_DIR}\OUTPUT\STATIONCONN_{ALT}{YEAR}.DAT"
          ; Generate auto-access links
          GENERATE READNTLEGI=2

    IF({isMicroCode} <> 0)
          ; Generate fixed-guideway to bus links
          GENERATE READNTLEGI=3
    ENDIF
          ; Generate CBD transfer links
          GENERATE READNTLEGI=4

    ENDPROCESS

;**************************************************************
;BEGIN POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************

    PROCESS PHASE=SKIMIJ
           MW[1]=TIMEA(0,1)                                                              ; Walk time
           MW[2]=TIMEA(0,2)                                                              ; Auto time
           MW[3]=TIMEA(0,11)+TIMEA(0,12)                                                 ; Sidewalk time
           MW[4]=TIMEA(0,21)                                                              ; Local bus time
           MW[5]=TIMEA(0,22)                                                            ; Premium bus time
           MW[6]=TIMEA(0,23)                                                              ; Circulator time
           MW[7]=TIMEA(0,24)                                                              ; Light/Heavy Rail time
           MW[8]=TIMEA(0,25)                                                              ; Commuter Rail time
           MW[9]=TIMEA(0,26)                                                             ; Other mode time
           MW[10]=TIMEA(0,27)                                                             ; Project mode time

;**************************************************************
;END POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************
     
    IF (BRDINGS(0,TMODES) > 0)
           MW[11]=BRDINGS(0,TMODES)-1                                                   ; Number of transfers
    ELSE
           MW[11]=0
    ENDIF

           MW[12]=IWAITA(0)                                                              ; Initial wait time
           MW[13]=XWAITA(0)                                                              ; Transfer wait time
           MW[14]=FAREA(0)                                                               ; Fare matrix
           MW[15]=TIMEA(0,ALLMODES)                                                      ; Time on all modes
    ENDPROCESS

ENDRUN
