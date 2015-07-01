; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\TNNET00A.PRN" MSG='station information on PNR node'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\statdata.csv"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\tempnode.csv"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\TNNET00B.PRN"

FILEO NETO = "{SCENARIO_DIR}\output\TNNET00A.NET"
FILEI LINKI[2] = "{SCENARIO_DIR}\input\BridgePenalty.txt",
VAR=A,BEG=1,LEN=7,
VAR=B,BEG=8,LEN=7,
VAR=BRIDPEN,BEG=24,LEN=5

ARRAY PNR=9999,RNG=9999,ZON=9999,PRK=9999,CSTAM=9999,CSTMD=9999,PNRT=9999,KNRT=9999,TYPE=9999

PROCESS  PHASE=NODEMERGE  
; Use this phase to make computations and selections of any data on the NODEI files.
 x1=x/5280
 y1=y/5280
 PRINT CSV=T, LIST=N(8.0),X1(12.6),Y1(12.6) printo=2

if (N=1) _CNT=1
if (N=1) _CNT1=1

if (TSRANGE_{year}{alt} > 0 & TSTYPE_{year}{alt}==1)
 PNR[_CNT]=N
 RNG[_CNT]=TSRANGE_{year}{alt}
 ZON[_CNT]=STATZONE
 PRK[_CNT]=TSPARKSPACE_{year}{alt}
 CSTAM[_CNT]=TSCOSTAM_{year}{alt}
 CSTMD[_CNT]=TSCOSTMD_{year}{alt}
 PNRT[_CNT]=TSPNRTERM_{year}{alt}
 KNRT[_CNT]=TSKNRTERM_{year}{alt}
 TYPE[_CNT]=TSTYPE_{year}{alt}
 _CNT=_CNT+1
endif

ENDPROCESS

PROCESS PHASE=LINKMERGE

 LOOP _ww=1,_CNT
  if ((LI.1.A = PNR[_ww]) & (LI.1.A >0))
   print list=_CNT1(4.0),li.1.B(6.0),ZON[_ww](6.0),RNG[_ww](6.1),PRK[_ww](6.0),CSTAM[_ww](6.0),CSTMD[_ww](6.0),
                                    PNRT[_ww](6.1),KNRT[_ww](6.1),TYPE[_ww](3.0)," PNR Station", li.1.A(6.0), printo=1
   print csv=t, list=_CNT1(4.0),li.1.B(6.0),ZON[_ww](6.0),RNG[_ww](6.1),PRK[_ww](6.0),CSTAM[_ww](6.0),CSTMD[_ww](6.0),
                                    PNRT[_ww](6.1),KNRT[_ww](6.1),TYPE[_ww](3.0)," PNR Station", li.1.A(6.0), printo=3
  _CNT1=_CNT1+1
  endif
  
  if (LI.1.B=PNR[_ww])
   PRKCSTAM=CSTAM[_ww]
   PRKCSTMD=CSTMD[_ww]
   PNRTerminalTime=PNRT[_ww]
   KNRTerminalTime=KNRT[_ww]
  endif
 ENDLOOP

ENDPROCESS

ENDRUN
