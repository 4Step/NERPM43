;;<<Default Template>><<NETWORK>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK MSG='PK-Set Station Info for AUTOCON'
FILEO NETO = "{Scenario_Dir}\output\PRELOAD_PT_TEMP.NET"
FILEI LINKI[1] = "{Scenario_Dir}\output\PRELOAD_PT.NET"

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
