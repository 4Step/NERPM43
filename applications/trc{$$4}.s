; Script for program MATRIX in file "D:\NERPM4\APPLICATIONS\CNMAT00D.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B1.PRN" MSG='Modify TROUTE file to remove DELAY (for AUTOCON program)'
FILEI RECI = "{SCENARIO_DIR}\output\TROUTE_MOD.LIN",
MAXSCAN=120
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\troute_modified.lin"

PAR MAXSTRING=200


linestr=reci

; ############## Check for 'DELAY' keyword in the line file
pos_delay=strpos('DELAY=',linestr)
linestrlen=strlen(linestr)
pos_delay_c=strpos('DELAY_C=',linestr)

if (pos_delay_c > 0) goto skip

if (deleten==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline=strpos('N=',linestr)
  s91=substr(linestr,1,pos_n_nextline)
  s92=substr(linestr,pos_n_nextline+2,linestrlen)
  print list='       ',s92,printo=1
  deleten=0
  goto skip
endif

if (deleten1==1)  ; takes care of situations where 'N=' spills into another line
  pos_n_nextline1=strpos('N=',linestr)
  s93=substr(linestr,1,pos_n_nextline1)
  s94=substr(linestr,pos_n_nextline1+2,linestrlen)
  print list='       ',s94,printo=1
  deleten1=0
  goto skip2
endif

if ((pos_delay > 0) & (deleten==0))
; print list=linestr,printo=1
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

; ############### Also check for 'DELAY_C' keyword

if ((pos_delay_c > 0) & (deleten1==0))
; print list=linestr,printo=1
 s11=substr(linestr,1,pos_delay_c-1)
 s21=substr(linestr,pos_delay_c+8,linestrlen)
; print list='*',s21,'*',printo=1
 pos_n=strpos('N=',s21)
 if (pos_n=0)  ; 'N=' is on the next line
  deleten1=1
  s31=' ,'
 else
  deleten1=0
  s31=substr(s21,pos_n+2,strlen(s21))
 endif
 print list=s11,s31,printo=1
 s11=' '
 s21=' '
 s31=' '
else
 deleten1=0
; print list=linestr,printo=1
endif

:skip2

ENDRUN


