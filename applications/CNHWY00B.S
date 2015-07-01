;;<<Default Template>><<HIGHWAY>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=HIGHWAY  PRNFILE="{SCENARIO_DIR}\output\AddAutoConVars.PRN" MSG='Peak period network setup'
FILEO NETO = "{SCENARIO_DIR}\output\PRELOAD_PT_TEMP.NET"
FILEI NETI = "{SCENARIO_DIR}\output\PRELOAD_PT.NET"

PROCESS PHASE = NODEREAD
      NW.STANUM = NI.TSSTATION_{year}{alt}
      NW.STAZ   = NI.STATZONE
      NW.TSTYPE = NI.TSTYPE_{year}{alt}
      NW.MAXD   = NI.TSRANGE_{year}{alt}
      NW.SPACE  = NI.TSPARKSPACE_{year}{alt}
      NW.STACOST_AM = NI.TSCOSTAM_{year}{alt}
      NW.STACOST_MD = NI.TSCOSTMD_{year}{alt}
      NW.STANUM  = NI.TSCOSTMD_{year}{alt}
ENDPHASE




ENDRUN
