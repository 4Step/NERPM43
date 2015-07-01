; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\CNMAT00B1.PRN" MSG='Modify TROUTE file to remove DELAY (for AUTOCON program)'
FILEI RECI = "{SCENARIO_DIR}\output\TROUTE_MOD.LIN",
MAXSCAN=120
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\troute_modified.lin"

PAR MAXSTRING=200

;what follows is a modified version of the original script to be able to run autocon using Voyager 5.1 or above
;this modified version was provided by CITILABS Heejoo Ham on March 30, 2011 to PBS&J (an Atkins Company)
;further modified by Atkins to temporarily delete the headway[2] variable so that autocon can run

linestr=reci

pos_delay=strpos('DELAY=',linestr)                        ; check position of "DELAY="
pos_delay_c=strpos('DELAY_C=',linestr)                    ; check position of "DELAY_C="
pos_n=strpos('N=',linestr)                                ; check position of "N="
pos_head=strpos('HEADWAY[2]=',linestr)                    ; check position of "HEADWAY[2]="
linestrlen=strlen(linestr)                                ; length of current record string

pos_linename=strpos('LINE ',linestr)                      ; check position of "LINE NAME"
if (pos_linename>0)
   _curline=1                                             ; flag for beginning current transit line record
endif

if (pos_delay>0 || pos_delay_c>0 || pos_n>0 || pos_head>0)
   rev_linestr=linestr                                    ; revised line string record
   
   if (pos_head>0)
      loop _ii=1,500
         pos_a=strpos('HEADWAY[2]=',rev_linestr)
         if (pos_a>0)
            rev_linestr=deletestr(rev_linestr,pos_a,13)    ; delete "HEADWAY[2]=##"
         else
            break
         endif
      endloop
   endif


   if (pos_delay>0)
      loop _ii=1,500
         pos_a=strpos('DELAY=',rev_linestr)
         if (pos_a>0)
            rev_linestr=deletestr(rev_linestr,pos_a,7)    ; delete "DELAY=#"
         else
            break
         endif
      endloop
   endif
   if (pos_delay_c>0)
      loop _ii=1,500
         pos_b=strpos('DELAY_C=',rev_linestr)
         if (pos_b>0)
            rev_linestr=deletestr(rev_linestr,pos_b,9)    ; delete "DELAY_C=#"
         else
            break
         endif
      endloop
   endif
   if (pos_n>0)
      pos_loc=1
      loop _ii=1,500
         pos_c=strposex('N=',rev_linestr,pos_loc)
         if (pos_c>0 & _curline=1)                        ; skip for the first keyword with "N="
            pos_loc=pos_c+2                               ; replace the first column position after "N="
            _curline=0
            continue
         elseif (pos_c>0 & _curline=0)                    ; remove all "N=" if it is not the first one
            rev_linestr=deletestr(rev_linestr,pos_c,2)
         else
            break
         endif
      endloop
   endif
   print list=rev_linestr,printo=1                        ; write the modified current record
   rev_linestr=''
else                                                      ; if the current line record doesn't
   print list=linestr,printo=1                            ; include any designated keywords
endif


;==========================================================================================================
;What follows is the original script that worked fine with Voyager 5.0, but NOT with VOYAGER 5.1 and above

/*
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
*/
;====================================================================================================
;end of the original script for Voyager 5.0

ENDRUN
