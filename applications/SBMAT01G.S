; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00C.PRN"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\CBDSHARES.CSV"
FILEO RECO[2] = "{SCENARIO_DIR}\output\CBDSHARES.DBF",
FORM=10.6,FIELDS=N2,HBW1,HBNW1,NHB1
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\MODESHARES.CSV"
FILEO RECO[1] = "{SCENARIO_DIR}\output\MODESHARES.DBF",
FORM=10.6,FIELDS=N1,HBW,HBNW,NHB

zones=1
array Pshr=108, Pcbdshr=12

; LOOKUP for previuos run shares
LOOKUP NAME=SHARES, LOOKUP[1]=1, RESULT=4,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=1
LOOKUP NAME=CBDSHARES, LOOKUP[1]=1, RESULT=3,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=2

LOOP _ww=1,108
; records 1 through 11 are for 11 choices for HBW purpose and 0 car households, next 11 is for HBW purpose and 1 car household....
 Pshr[_ww] = SHARES(1,_ww)
ENDLOOP

LOOP _ww=1,12
; 4 cbd targets (for walk, pnr, knr cbdknr) and 3 purposes
 Pcbdshr[_ww] = CBDSHARES(1,_ww)
ENDLOOP

; print REVISED modal constants
LOOP _ww=1,36
 _idx=_idx+1
 RO.N1=_ww
 RO.HBW=Pshr[_idx]
 RO.HBNW=Pshr[_idx+36]
 RO.NHB=Pshr[_idx+72]
 WRITE RECO=1
ENDLOOP

LOOP _xx=1,4
 RO.N2=_xx
 RO.HBW1=Pcbdshr[_xx]
 RO.HBNW1=Pcbdshr[_xx+4]
 RO.NHB1=Pcbdshr[_xx+8]
 WRITE RECO=2
ENDLOOP

ENDRUN
