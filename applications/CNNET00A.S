; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\CNNET00A.PRN"
FILEI LINKI[2] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEI LINKI[3] = "{SCENARIO_DIR}\output\NTLEGPK_{alt}{year}.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\CNNET00B.PRN"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\NTLEGPK_{alt}{year}.DBF"

array STOPNODE=99999, centroidconn=99999, areatype=99999

PROCESS  PHASE=INPUT FILEI=LI.2
 if (A <= {ZONESA}) centroidconn[B]=1
 if (B <= {ZONESA}) centroidconn[A]=1
 if (AREA_TYPE=11-20) areatype[A]=1
 if (centroidconn[A]=1) print list='******',A(10),centroidconn[A]
ENDPROCESS


PROCESS  PHASE=INPUT FILEI=LI.3
; if (STOPA=1) STOPNODE[A]=1
; if (STOPA=0 & centroidconn[A]=1 & MODE=21) print list='***peak period*** ',A(6),B(6),MODE(2),NAME,printo=1
 idx=A
 if (STOPA=0 & centroidconn[idx]=1 & areatype[idx]<>1 & mode<>23 & name<>'WS-38 EB' & name<>'WS-38 WB' & name<>'X2 NB' & name<>'X2 SB' & name<>'X4 NB' & name<>'X4 SB' & name<>'SS-35 NB' & name<>'SS-35 SB') print list='***peak period*** ',idx(6),MODE(3),' ',NAME,printo=1
ENDPROCESS


ENDRUN
