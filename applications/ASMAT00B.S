; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\ASMAT00C.PRN"
FILEI RECI = "{SCENARIO_DIR}\output\TLOADPK_{alt}{year}.DBF"
FILEO PRINTO[1] = "C:\NERPM43\APPLICATIONS\ASMAT00D.PRN"
FILEO RECO[1] = "C:\NERPM43\APPLICATIONS\ASMAT00B.DBF",
fields=prevname

array sumtrips=500,sumtime=500,sumdist=500,freq=500,sumpax=500,sumph=500,sumpm=500,headway=2
array sumMtrips=500,sumMtime=500,sumMdist=500,sumMpax=500,sumMph=500,sumMpm=500
array sumOPtrips=500,sumOPtime=500,sumOPdist=500,sumOPpax=500,sumOPph=500,sumOPpm=500
_ctr=_ctr+1

if (_ctr=1) ; read the first record
 prevname=ri.name
 moden=ri.mode
 op=ri.operator
 cnt=1
 sumtime[cnt]=sumtime[cnt]+ri.time
 sumdist[cnt]=sumdist[cnt]+ri.dist
 freq[cnt]=30
; freq[cnt]=ri.headway[2]
 sumpax[cnt]=sumpax[cnt]+ri.ona
 sumpm[cnt]=sumpm[cnt]+ri.vol*ri.dist
 sumph[cnt]=sumph[cnt]+ri.vol*ri.time/60.0

 if (moden>0) sumMtime[moden]=sumMtime[moden]+ri.time
 if (moden>0) sumMdist[moden]=sumMdist[moden]+ri.dist
 if (moden>0) sumMpax[moden]=sumMpax[moden]+ri.ona
 if (moden>0) sumMpm[moden]=sumMpm[moden]+ri.vol*ri.dist
 if (moden>0) sumMph[moden]=sumMph[moden]+ri.vol*ri.time/60.0

 if (op>0) sumOPtime[op]=sumOPtime[op]+ri.time
 if (op>0) sumOPdist[op]=sumOPdist[op]+ri.dist
 if (op>0) sumOPpax[op]=sumOPpax[op]+ri.ona
 if (op>0) sumOPpm[op]=sumOPpm[op]+ri.vol*ri.dist
 if (op>0) sumOPph[op]=sumOPph[op]+ri.vol*ri.time/60.0

; print list='Transit Assignment Summary Report',printo=1
; print list='07-25-2007    5:39 pm','\n',printo=1
; print list='-------------------------------Off-Peak-------------------------------',printo=1
; print list='  Name                    Time      Freq       Pax     PaxMi     PaxHr',printo=1
endif

if (_ctr > 1) ; read subsequent records
 if (ri.name=prevname)
 sumtime[cnt]=sumtime[cnt]+ri.time
 sumdist[cnt]=sumdist[cnt]+ri.dist
 freq[cnt]=30
; freq[cnt]=ri.headway
 sumpax[cnt]=sumpax[cnt]+ri.ona
 sumpm[cnt]=sumpm[cnt]+ri.vol*ri.dist
 sumph[cnt]=sumph[cnt]+ri.vol*ri.time/60.0

 if (moden>0) sumMtime[moden]=sumMtime[moden]+ri.time
 if (moden>0) sumMdist[moden]=sumMdist[moden]+ri.dist
 if (moden>0) sumMpax[moden]=sumMpax[moden]+ri.ona
 if (moden>0) sumMpm[moden]=sumMpm[moden]+ri.vol*ri.dist
 if (moden>0) sumMph[moden]=sumMph[moden]+ri.vol*ri.time/60.0

 if (op>0) sumOPtime[op]=sumOPtime[op]+ri.time
 if (op>0) sumOPdist[op]=sumOPdist[op]+ri.dist
 if (op>0) sumOPpax[op]=sumOPpax[op]+ri.ona
 if (op>0) sumOPpm[op]=sumOPpm[op]+ri.vol*ri.dist
 if (op>0) sumOPph[op]=sumOPph[op]+ri.vol*ri.time/60.0

 if (_ctr=RECI.NUMRECORDS)   print list=cnt(4),' ',prevname(18C),moden(2),sumtime[cnt],freq[cnt],sumpax[cnt],sumpm[cnt],sumph[cnt],printo=1

 if (_ctr=RECI.NUMRECORDS)
  loop ww=1,500
;   if (ww=1) print list='\n','  Mode                    Time      Freq       Pax     PaxMi     PaxHr',printo=1
   if (sumMtime[ww]>0)  print list='9998',' ','ModeTotal', ww(11C),sumMtime[ww], '          ',sumMpax[ww],sumMpm[ww],sumMph[ww],printo=1
   _sumtime=_sumtime+sumMtime[ww]
   _sumpax=_sumpax+sumMpax[ww]
   _sumpm=_sumpm+sumMpm[ww]
   _sumph=_sumph+sumMph[ww]
   if (ww=500)
;     print list='---------------------------------------------------------------------------------',printo=1
;     print list='        Total       ',_sumtime,'          ',_sumpax,_sumpm,_sumph,printo=1 
   endif
  endloop
  loop ww=1,500
;   if (ww=1) print list='\n','  Operator                Time      Freq       Pax     PaxMi     PaxHr',printo=1
   if (sumOPtime[ww]>0)  print list='9999',' ','OperatorTotal',ww(7C),sumOPtime[ww],'          ', sumOPpax[ww],sumOPpm[ww],sumOPph[ww],printo=1
   if (ww=500)
;     print list='---------------------------------------------------------------------------------',printo=1
;     print list='        Total       ',_sumtime,'          ',_sumpax,_sumpm,_sumph,printo=1 
   endif
  endloop
 endif
 
 else
  print list=cnt(4),' ',prevname(18C),moden(2),sumtime[cnt],freq[cnt],sumpax[cnt],sumpm[cnt],sumph[cnt],printo=1
  prevname=ri.name
  moden=ri.mode
  op=ri.operator  
  cnt=cnt+1
  sumtime[cnt]=sumtime[cnt]+ri.time
  sumdist[cnt]=sumdist[cnt]+ri.dist
  freq[cnt]=30
; freq[cnt]=ri.headway
  sumpax[cnt]=sumpax[cnt]+ri.ona
  sumpm[cnt]=sumpm[cnt]+ri.vol*ri.dist
  sumph[cnt]=sumph[cnt]+ri.vol*ri.time/60.0

 if (moden>0) sumMtime[moden]=sumMtime[moden]+ri.time
 if (moden>0) sumMdist[moden]=sumMdist[moden]+ri.dist
 if (moden>0) sumMpax[moden]=sumMpax[moden]+ri.ona
 if (moden>0) sumMpm[moden]=sumMpm[moden]+ri.vol*ri.dist
 if (moden>0) sumMph[moden]=sumMph[moden]+ri.vol*ri.time/60.0

 if (op>0) sumOPtime[op]=sumOPtime[op]+ri.time
 if (op>0) sumOPdist[op]=sumOPdist[op]+ri.dist
 if (op>0) sumOPpax[op]=sumOPpax[op]+ri.ona
 if (op>0) sumOPpm[op]=sumOPpm[op]+ri.vol*ri.dist
 if (op>0) sumOPph[op]=sumOPph[op]+ri.vol*ri.time/60.0

FILEO RECO[1] = "C:\NERPM43\APPLICATIONS\ASMAT00B.DBF"
 endif
endif


ENDRUN
