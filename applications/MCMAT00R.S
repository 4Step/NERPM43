; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='store time and date'
FILEI RECI = "{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

zones={ZONESA}

s1=strpos('Date:',reci)
s2=strpos('Time:',reci)

; get the date and time
if (s1 > 0)
 rundate=substr(reci,s1,80)
 log prefix=date var=rundate
endif
if (s2 > 0) 
 runtime=substr(reci,s2,80)
 log prefix=time var=runtime
endif

ENDRUN
