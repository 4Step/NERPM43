; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="D:\JTA RTS Model\APPLICATIONS\SCMAT00A.PRN"
FILEI RECI = "D:\JTA RTS Model\APPLICATIONS\SCPTR00A.DBF"
FILEO PRINTO[1] = "D:\JTA RTS Model\APPLICATIONS\SCMAT00B.PRN"
FILEO RECO[1] = "D:\JTA RTS Model\APPLICATIONS\SCMAT00A.DBF",
FIELDS=prevname,prevmode,prevHEADWAY,SUMDIST,SUMTIME

if (_ctr=0)
 sumdist=sumdist+ri.dist
 sumtime=sumtime+ri.time
 prevname=RI.NAME
 prevlongname=RI.LONGNAME
 prevmode=RI.MODE
 prevheadway=RI.HEADWAY
else
 if (RI.NAME=prevname)
  sumdist=sumdist+ri.dist
  sumtime=sumtime+ri.time
  prevname=RI.name
  prevlongname=RI.LONGNAME
  prevmode=RI.MODE
  prevheadway=RI.HEADWAY
 else
  WRITE RECO=1
  print list=prevname(14C),prevlongname(30C),prevmode(3.0),prevheadway(4.0),sumdist(10.2),sumtime(10.2), printo=1
  prevname=RI.name
  prevlongname=RI.LONGNAME
  prevmode=RI.MODE
  prevheadway=RI.HEADWAY
  sumdist=ri.dist
  sumtime=ri.time
 endif
endif

_ctr=1

if (i=0)
  WRITE RECO=1
  print list=prevname(14C),prevlongname(30C),prevmode(3.0),prevheadway(4.0),sumdist(10.2),sumtime(10.2), printo=1
endif

ENDRUN
