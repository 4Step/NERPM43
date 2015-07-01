; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; DistributeMULTISTEP ProcessID="NERPM4Dist", ProcessNum=1
; End of PILOT Script

LOOP PER = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
IF (PER == 1)
    Period='PK'
    HWYNET = 'PRELOAD_PT'
ELSEIF (PER == 2)
    Period='OP'
    HWYNET = 'UNLOADED_PT'
ENDIF

; End of PILOT Script

  LOOP ACCESS = 1, 3, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


IF (ACCESS == 1)
    ACCESS_NAME='Walk'
ELSEIF (ACCESS == 2)
    ACCESS_NAME='PNR'
ELSEIF (ACCESS == 3)
    ACCESS_NAME='KNR'
ENDIF
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\APPLICATIONS\TNPTR00W.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\TNPTR00A11_@period@_@access_NAME@.PRN" MSG='Peak transit paths and skims'
FILEI NETI = "{SCENARIO_DIR}\output\@HWYNET@_Temp.NET"
FILEO REPORTO = "{SCENARIO_DIR}\output\TNPTR00B_@period@_@access_NAME@.PRN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\trnskim_@period@_@access_NAME@.rpt"

 ; OUTPUT files
FILEO NTLEGO = "{SCENARIO_DIR}\output\@PERIOD@NTL.NTL"
FILEO NETO = "{SCENARIO_DIR}\output\Transit@PERIOD@_@access_name@.NET"

FILEO MATO[1] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_SKYWAY_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-20,DEC=20*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,BRT_Wlk_EgTime,CR_Wlk_EgTime,NumXfers,InitWait,XferWait,Fare,WlkTime_BRT,PNRTime_BRT,KNRTime_BRT,WalkTime_CR,PNRTime_CR,KNRTime_CR 
FILEO MATO[2] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_LOCAL_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-20,DEC=20*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,BRT_Wlk_EgTime,CR_Wlk_EgTime,NumXfers,InitWait,XferWait,Fare,WlkTime_BRT,PNRTime_BRT,KNRTime_BRT,WalkTime_CR,PNRTime_CR,KNRTime_CR 
FILEO MATO[3] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_EXPRESS_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-20,DEC=20*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,BRT_Wlk_EgTime,CR_Wlk_EgTime,NumXfers,InitWait,XferWait,Fare,WlkTime_BRT,PNRTime_BRT,KNRTime_BRT,WalkTime_CR,PNRTime_CR,KNRTime_CR 
FILEO MATO[4] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_BRTLRT_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-20,DEC=20*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,BRT_Wlk_EgTime,CR_Wlk_EgTime,NumXfers,InitWait,XferWait,Fare,WlkTime_BRT,PNRTime_BRT,KNRTime_BRT,WalkTime_CR,PNRTime_CR,KNRTime_CR 
FILEO MATO[5] = "{SCENARIO_DIR}\output\TSKIM_@PERIOD@_COMRAIL_@ACCESS_NAME@_{alt}{year}.MAT",
MO=1-20,DEC=20*2 , NAME = WalkTime,DriveTime,XferTime,SkywayTime,LocalTime,ExpTime,BRTTime,CRailTime,BRT_Wlk_EgTime,CR_Wlk_EgTime,NumXfers,InitWait,XferWait,Fare,WlkTime_BRT,PNRTime_BRT,KNRTime_BRT,WalkTime_CR,PNRTime_CR,KNRTime_CR 

FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_SKYWAY_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[2] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_LOCAL_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[3] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_EXPRESS_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[4] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_BRTLRT_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}
FILEO ROUTEO[5] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_COMRAIL_@ACCESS_NAME@_{Alt}{year}.RTE",
  REPORTI={REPI}, REPORTJ={REPJ},TRACEI={REPI}, TRACEJ={REPJ} ;,I={REPI},J={REPJ}

 ; Input files
FILEI FAREI = "{SCENARIO_DIR}\input\TFARES_{year}{alt}.FAR"
FILEI SYSTEMI = "{CATALOG_DIR}\parameters\SYSTEM.PTS"
FILEI LINEI[1] = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEI FACTORI[1] = "{SCENARIO_DIR}\output\@ACCESS_NAME@SKYWAY.FAC"
FILEI FACTORI[2] = "{SCENARIO_DIR}\output\@ACCESS_NAME@LOCAL.FAC"
FILEI FACTORI[3] = "{SCENARIO_DIR}\output\@ACCESS_NAME@EXPRESS.FAC"
FILEI FACTORI[4] = "{SCENARIO_DIR}\output\@ACCESS_NAME@BRTLRT.FAC"
FILEI FACTORI[5] = "{SCENARIO_DIR}\output\@ACCESS_NAME@COMRAIL.FAC"

; Trn walk,pnr, knr connectors
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG1@Period@_{alt}{year}.NTL"
FILEI NTLEGI[2] = "{SCENARIO_DIR}\output\NTLEG2@Period@_{alt}{year}.NTL"
FILEI NTLEGI[3] = "{SCENARIO_DIR}\output\NTLEG3@Period@_{alt}{year}.NTL"

; Trn xfer connectors
FILEI NTLEGI[10] = "{SCENARIO_DIR}\output\NTLEG11@Period@_{alt}{year}.NTL"
FILEI NTLEGI[11] = "{SCENARIO_DIR}\output\NTLEG12@Period@_{alt}{year}.NTL"

; BRT walk, pnr, knr connectors
FILEI NTLEGI[4] = "{SCENARIO_DIR}\output\NTLEG4@Period@_{alt}{year}.NTL"
FILEI NTLEGI[5] = "{SCENARIO_DIR}\output\NTLEG5@Period@_{alt}{year}.NTL"
FILEI NTLEGI[6] = "{SCENARIO_DIR}\output\NTLEG6@Period@_{alt}{year}.NTL"

; Com Rail walk, pnr,knr connectors
FILEI NTLEGI[7] = "{SCENARIO_DIR}\input\CR_Manual_Walk_Connectors.NTL"
FILEI NTLEGI[8] = "{SCENARIO_DIR}\output\NTLEG8@Period@_{alt}{year}.NTL"
FILEI NTLEGI[9] = "{SCENARIO_DIR}\output\NTLEG9@Period@_{alt}{year}.NTL"

zonemsg=50

; OVERALL PARAMETERS OF RUN
PARAMETERS USERCLASSES=1-5,FARE=N, MAPSCALE=5280, HDWAYPERIOD=@PER@,
           NOROUTEERRS=999999, NOROUTEMSGS=999999,
           TRANTIME=LW.TRANTIME,
           TRANTIME[21]=LI.M21TIME@PERIOD@,
           TRANTIME[22]=LI.M22TIME@PERIOD@,
           TRANTIME[23]=LI.M23TIME@PERIOD@,
           TRANTIME[24]=LI.M24TIME@PERIOD@,
           TRANTIME[25]=LI.M25TIME@PERIOD@,
           TRANTIME[26]=LI.M26TIME@PERIOD@

;REPORT LINES=T
;REREPORT LINES=T,TRNLEGS3=T

PROCESS PHASE=LINKREAD
 LW.TRANTIME=LI.M21TIME@PERIOD@
 LW.WALKTIME=LI.WALKTIME
 LW.WALKDISTANCE=LI.DISTANCE
 LW.DISTANCE=LI.DISTANCE
ENDPROCESS

PROCESS PHASE=DATAPREP
    ; 1- Generate walk-access links
     GENERATE READNTLEGI=1
    ; 2- Generate PNR-access links
     GENERATE READNTLEGI=2
    ; 3- Generate KNR-access links
     GENERATE READNTLEGI=3
     
      ; 4- Generate BRT WALK links
     GENERATE READNTLEGI=4 
     ; 5- Generate BRT PNR links
     GENERATE READNTLEGI=5
      ; 6- Generate BRT KNR links
     GENERATE READNTLEGI=6
     
     ; 7- Generate CR WALK links
     GENERATE READNTLEGI=7  
     ; 8- Generate CR PNR links
     GENERATE READNTLEGI=8
      ; 9- Generate CR KNR links
     GENERATE READNTLEGI=9
     
    ; 11- Generate fixed-guideway to bus links
     GENERATE READNTLEGI=10
    ; 12- Generate transfer links
     GENERATE READNTLEGI=11
        
ENDPROCESS

PROCESS PHASE=SKIMIJ
  ; SKYWAY 
  IF (USERCLASS==1)
      IF (TIMEA(0,23) > 0)                                     ; If Skyway path exists
       MW[1]=TIMEA(0,1)                                        ; Walk Access time to Trn
       MW[2]=TIMEA(0,2)+ TIMEA(0,3)                            ; PNR/KNR Access time to Trn
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; CR IVTT 
       MW[9]=TIMEA(0,13)                                       ; Walk Egress time from BRT  
       MW[10]=TIMEA(0,14)                                      ; Walk Egress time from CR
       MW[15]=TIMEA(0,4)                                       ; Walk Time to BRT      
       MW[16]=TIMEA(0,5)                                       ; PNR Time to BRT
       MW[17]=TIMEA(0,6)                                       ; KNR Time to BRT
       MW[18]=TIMEA(0,7)                                       ; Walk Time to CR
       MW[19]=TIMEA(0,8)                                       ; PNR Time to CR
       MW[20]=TIMEA(0,9)                                       ; KNR Time to CR      
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
      ; MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
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
       MW[16]=0
       MW[17]=0
       MW[18]=0
       MW[19]=0
       MW[20]=0
      ENDIF
  
  ; LOCAL BUS path
   ELSEIF (USERCLASS=2)  
     IF (TIMEA(0,21) > 0)                                    ; If local bus path exists
       MW[1]=TIMEA(0,1)                                        ; Walk Access time to Trn
       MW[2]=TIMEA(0,2)+ TIMEA(0,3)                            ; PNR/KNR Access time to Trn
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; CR IVTT 
       MW[9]=TIMEA(0,13)                                       ; Walk Egress time from BRT  
       MW[10]=TIMEA(0,14)                                      ; Walk Egress time from CR
       MW[15]=TIMEA(0,4)                                       ; Walk Time to BRT      
       MW[16]=TIMEA(0,5)                                       ; PNR Time to BRT
       MW[17]=TIMEA(0,6)                                       ; KNR Time to BRT
       MW[18]=TIMEA(0,7)                                       ; Walk Time to CR
       MW[19]=TIMEA(0,8)                                       ; PNR Time to CR
       MW[20]=TIMEA(0,9)                                       ; KNR Time to CR  
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       ;MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
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
       MW[16]=0
       MW[17]=0
       MW[18]=0
       MW[19]=0 
       MW[20]=0
      ENDIF
       
  ; EXPRESS BUS path
   ELSEIF (USERCLASS=3)  
     IF (TIMEA(0,22) > 0)                                    ; If express bus path exists
       MW[1]=TIMEA(0,1)                                        ; Walk Access time to Trn
       MW[2]=TIMEA(0,2)+ TIMEA(0,3)                            ; PNR/KNR Access time to Trn
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; CR IVTT 
       MW[9]=TIMEA(0,13)                                       ; Walk Egress time from BRT  
       MW[10]=TIMEA(0,14)                                      ; Walk Egress time from CR
       MW[15]=TIMEA(0,4)                                       ; Walk Time to BRT      
       MW[16]=TIMEA(0,5)                                       ; PNR Time to BRT
       MW[17]=TIMEA(0,6)                                       ; KNR Time to BRT
       MW[18]=TIMEA(0,7)                                       ; Walk Time to CR
       MW[19]=TIMEA(0,8)                                       ; PNR Time to CR
       MW[20]=TIMEA(0,9)                                       ; KNR Time to CR   
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       ;MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
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
       MW[16]=0
       MW[17]=0
       MW[18]=0
       MW[19]=0 
       MW[20]=0
      ENDIF
     
  ; BRTLRT  path
   ELSEIF (USERCLASS=4)  
     IF (TIMEA(0,24) > 0)                       ; If BRT or LRT bus path exists
     ; IF ((TIMEA(0,24)+TIMEA(0,25)) > 0)                       ; If BRT or LRT bus path exists
       MW[1]=TIMEA(0,1)                                        ; Walk Access time to Trn
       MW[2]=TIMEA(0,2)+ TIMEA(0,3)                            ; PNR/KNR Access time to Trn
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; CR IVTT 
       MW[9]=TIMEA(0,13)                                       ; Walk Egress time from BRT  
       MW[10]=TIMEA(0,14)                                      ; Walk Egress time from CR
       MW[15]=TIMEA(0,4)                                       ; Walk Time to BRT      
       MW[16]=TIMEA(0,5)                                       ; PNR Time to BRT
       MW[17]=TIMEA(0,6)                                       ; KNR Time to BRT
       MW[18]=TIMEA(0,7)                                       ; Walk Time to CR
       MW[19]=TIMEA(0,8)                                       ; PNR Time to CR
       MW[20]=TIMEA(0,9)                                       ; KNR Time to CR   
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
       ;MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
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
       MW[16]=0
       MW[17]=0
       MW[18]=0
       MW[19]=0 
       MW[20]=0
      ENDIF   
      
  ; Commuter Rail path
   ELSEIF (USERCLASS=5)  ; 2.5 miles minimum bus ride on KNR paths - from OD survey
     IF (TIMEA(0,26) > 0)                                    ; If Commuter rail path exists
       MW[1]=TIMEA(0,1)                                        ; Walk Access time to Trn
       MW[2]=TIMEA(0,2)+ TIMEA(0,3)                            ; PNR/KNR Access time to Trn
       MW[3]=TIMEA(0,11)+TIMEA(0,12)                           ; Transfer time
       MW[4]=TIMEA(0,23)                                       ; SKYWAY bus time
       MW[5]=TIMEA(0,21)                                       ; Local and express bus time
       MW[6]=TIMEA(0,22)                                       ; EXPRESS bus time
       MW[7]=TIMEA(0,24)+TIMEA(0,25)                           ; BRT, LRT time
       MW[8]=TIMEA(0,26)                                       ; CR IVTT 
       MW[9]=TIMEA(0,13)                                       ; Walk Egress time from BRT  
       MW[10]=TIMEA(0,14)                                      ; Walk Egress time from CR
       MW[15]=TIMEA(0,4)                                       ; Walk Time to BRT      
       MW[16]=TIMEA(0,5)                                       ; PNR Time to BRT
       MW[17]=TIMEA(0,6)                                       ; KNR Time to BRT
       MW[18]=TIMEA(0,7)                                       ; Walk Time to CR
       MW[19]=TIMEA(0,8)                                       ; PNR Time to CR
       MW[20]=TIMEA(0,9)                                       ; KNR Time to CR  
       IF (BRDINGS(0,TMODES) > 0)
        MW[11]=BRDINGS(0,TMODES)-1                             ; Number of transfers
       ELSE
        MW[11]=0
       ENDIF
       MW[12]=IWAITA(0)                                        ; Initial wait time
       MW[13]=XWAITA(0)                                        ; Transfer wait time
       MW[14]=FAREA(0)*100                                     ; Fare matrix
      ; MW[15]=TIMEA(0,ALLMODES)                                ; Time on all modes
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
       MW[16]=0
       MW[17]=0
       MW[18]=0
       MW[19]=0 
       MW[20]=0
      ENDIF
   
 ENDIF

ENDPROCESS

ENDRUN


  ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
; End of PILOT Script

ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; EndDistributeMULTISTEP



; End of PILOT Script

