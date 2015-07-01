; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Counts Times Nodes Used by Links'
FILEO RECO[1] = "{Scenario_Dir}\output\NODECNT.DBF",
 FIELDS=N,TIMESUSED
FILEI RECI = "{Scenario_Dir}\output\LINK4CNT.DBF"

ARRAY NODECNT=999999

NODECNT[RI.A]=NODECNT[RI.A]+1
NODECNT[RI.B]=NODECNT[RI.B]+1
IF (RI.A>HINODE) HINODE=RI.A
IF (RI.B>HINODE) HINODE=RI.B

IF (I=0)

  LOOP RO.N=1,HINODE
    IF (NODECNT[RO.N]>0)
     RO.TIMESUSED=NODECNT[RO.N] 
     WRITE RECO=1
    ENDIF
  ENDLOOP

ENDIF

ENDRUN
