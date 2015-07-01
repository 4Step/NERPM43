;;<<Default Template>><<NETWORK>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK MSG='OffPeak rename fields for AUOTCON'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEO NETO = "{SCENARIO_DIR}\output\UNLOADED_PT_TEMP.NET"

PROCESS  PHASE=INPUT,filei=NI.1
ENDPROCESS

PROCESS PHASE = NODEMERGE
      COMP STAZ   = STATZONE
      COMP STANUM = TSSTATION_{year}{alt}
      COMP TSTYPE = TSTYPE_{year}{alt}
      COMP MAXD   = TSRANGE_{year}{alt}
      COMP SPACE  = TSPARKSPACE_{year}{alt}
      COMP STACOST_AM = TSCOSTAM_{year}{alt}
      COMP STACOST_MD = TSCOSTMD_{year}{alt}
ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS
ENDRUN
