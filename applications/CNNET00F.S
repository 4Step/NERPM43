;;<<Default Template>><<NETWORK>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK MSG='OP-Set Station Info for AUTOCON'
FILEO NETO = "{Scenario_Dir}\output\UNLOADED_PT_TEMP.NET"
FILEI LINKI[1] = "C:\NERPM50\Base2005\INT2010\Output\UNLOADED_PT.NET"

STAZ=0
TSTYPE=0
MAXD=0
SPACE=0
STACOST_AM=0
STACOST_MD=0
STANUM=0

    PROCESS  PHASE=NODEMERGE  
    ; Use this phase to make computations and selections of any data on the LINKI files.
      STANUM = TSSTATION_{year}{alt}    
      STAZ = STATZONE
      TSTYPE = TSTYPE_{year}{alt}
      MAXD = TSRANGE_{year}{alt}
      SPACE = TSPARKSPACE_{year}{alt}
      STACOST_AM= TSCOSTAM_{year}{alt}
      STACOST_MD = TSCOSTMD_{year}{alt}
      STANUM = TSCOSTMD_{year}{alt}
    ENDPROCESS

ENDRUN
