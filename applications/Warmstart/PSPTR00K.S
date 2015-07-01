; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{CATALOG_DIR}\APPLICATIONS\PSPTR00K.PRN" MSG='All-walk paths'
FILEI NETI = "{SCENARIO_DIR}\output\HwyLoad2_MD_{alt}{year}.net"
FILEI NTLEGI[1] = "{SCENARIO_DIR}\output\NTLEG4PK_{alt}{year}.NTL"
FILEI FACTORI[1] = "C:\NERPM43\applications\Warmstart\WalkPrj.FAC"
FILEI FAREI = "C:\NERPM43\applications\Warmstart\TFARES_10A.FAR"
FILEI SYSTEMI = "C:\NERPM43\applications\Warmstart\SYSTEM.PTS"
FILEI LINEI[1] = "C:\NERPM43\applications\Warmstart\TROUTE_10A.LIN"

FILEO MATO[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{year}.MAT",
  MO=1, DEC=D,NAME=ALLWALK
FILEO ROUTEO[1] = "{SCENARIO_DIR}\output\AllWalk_{alt}{year}.RTE",
  REPORTI={FromNode}, REPORTJ={ToNode}, TRACEI={FromNode}, TRACEJ={ToNode}
FILEO REPORTO = "{SCENARIO_DIR}\output\AllWalk.rpt"
FILEO NETO = "{SCENARIO_DIR}\output\AllWalk.net"

    ; OVERALL PARAMETERS OF RUN
    PARAMETERS USERCLASSES=1,FARE=N, MAPSCALE={UNITS}, HDWAYPERIOD=2,
           NOROUTEERRS=999999, NOROUTEMSGS=999999, 
           TRANTIME=LW.TRANTIME

    PROCESS PHASE=LINKREAD
           LW.TRANTIME=LI.M21TIMEOP
           LW.DISTANCE=LI.ADJDISTANCE
    ENDPROCESS

    PROCESS PHASE=DATAPREP
           ; Generate all-walk links
           GENERATE READNTLEGI=1
    ENDPROCESS

    PROCESS PHASE=SKIMIJ
            MW[1]=TIMEA(0,4)                                         ; Walk time
    ENDPROCESS

ENDRUN
