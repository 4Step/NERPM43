
RUN PGM=NETWORK 
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD_PT_temp.NET"

STAZ =0
TSTYPE=0
MAXD= 0
SPACE=0
STACOST_AM=0
STACOST_MD=0

    PROCESS PHASE=LINKMERGE
    ; Use this phase to obtain initial values from the input network (LI.varname) and compute 
    ; link values (LW.varname) that can be used in other phases.
     LW.STAZ = LI.STATZONE
     LW.TSTYPE = LI.TSTYPE_{year}{alt}
     LW.MAXD = LI.TSRANGE_{year}{alt}
     LW.SPACE = LI.TSPARKSPACE_{year}{alt}
     LW.STACOST_AM= LI.TSCOSTAM_{year}{alt}
     LW.STACOST_MD = LI.TSCOSTMD_{year}{alt}
    ENDPROCESS

ENDRUN

