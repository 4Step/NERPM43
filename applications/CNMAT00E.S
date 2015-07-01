; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00C11.PRN"
FILEI RECI = "{SCENARIO_DIR}\input\TROUTE_{year}{alt}.LIN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\TROUTE_mod2.LIN"

linestr=reci
;pos_delay_c=strpos('DELAY_C=',linestr)
;linestr=linestr(

pos_delay=strpos('DELAY=',linestr)
linestrlen=strlen(linestr)

if (deleten==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline=strpos('N=',linestr)
  s91=substr(linestr,1,pos_n_nextline)
  s92=substr(linestr,pos_n_nextline+2,linestrlen)
  print list='       ',s92,printo=1
  deleten=0
  goto skip
endif

if ((pos_delay > 0) & (deleten==0))
 print list=linestr,printo=1
 s1=substr(linestr,1,pos_delay-1)   ;yes
 s2=substr(linestr,pos_delay+6,linestrlen)
; print list='*',s2,'*',printo=1
 pos_n=strpos('N=',s2)
 if (pos_n=0)  ; 'N=' is on the next line
  deleten=1
  s3=' ,'
 else
  deleten=0
  s3=substr(s2,pos_n+2,strlen(s2))
 endif
 print list=s1,s3,printo=1
 s1=' '
 s2=' '
 s3=' '
else
 deleten=0
 print list=linestr,printo=1
endif

:skip

ENDRUN
