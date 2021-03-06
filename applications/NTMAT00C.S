; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\NTMAT00A.PRN" MSG='Prepares MVFACTORS.{YEAR}{ALT} for Lookup Function'
FILEO PRINTO[1] = "{Scenario_Dir}\output\MVFACTORS.CSV"
FILEI RECI = "{Scenario_Dir}\input\MVFACTORS.{YEAR}{ALT}"
;var=n,6-7,UF,18-24,CF,35-41,BPRLOS,53-59,BPREXP,71-77

FT=SUBSTR(RECI,6,2)
UF=SUBSTR(RECI,18,7)
CF=SUBSTR(RECI,35,7)               ;24_Hour Confac
BPRLOS=SUBSTR(RECI,53,7)
BPREXP=SUBSTR(RECI,71,7)

CF_AM=SUBSTR(RECI,92,7)            ;AM Peak (07:30-09:30) Period Confac
CF_MD=SUBSTR(RECI,112,7)           ;Mid-day (09:30-15:30) Period Confac
CF_PM=SUBSTR(RECI,132,7)           ;PM Peak (15:30-18:30) Period Confac
CF_NT=SUBSTR(RECI,152,7)           ;Overnight (18:30-07:00) Period Confac



PRINT CSV=T, LIST=FT,UF,CF,BPRLOS,BPREXP,CF_AM,CF_MD,CF_PM,CF_NT, PRINTO=1


ENDRUN
