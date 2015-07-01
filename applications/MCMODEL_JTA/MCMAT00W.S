; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00I.PRN"
FILEO RECO[2] = "{SCENARIO_DIR}\output\TRN_COEFFICIENTS.DBF",
FORM=10.6,FIELDS=N1,HBW,HBNW,NHB
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\NEW_TRNCOEFF.CSV"
FILEO RECO[1] = "{SCENARIO_DIR}\output\MC_CONSTANTS.DBF",
FORM=10.6,FIELDS=N1,HBW,HBNW,NHB
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\NEW_MCCONSTS.CSV"

zones=1
array Nconst=108, Ncoeff=54

; LOOKUP for previuos run shares
LOOKUP NAME=NewConst, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=1
LOOKUP NAME=Ncoef, LOOKUP[1]=1, RESULT=2,FAIL=0,0,0,LIST=Y,INTERPOLATE=N, LOOKUPI=2

LOOP _ww=1,108
; records 1 through 9 are for 9 choices for HBW purpose and 0 car households, next 9 is for HBW purpose and 1 car household....
 Nconst[_ww] = NewConst(1,_ww)
 LIST=_ww,Nconst[_ww]
ENDLOOP

LOOP _ww=1,54
 Ncoeff[_ww] = Ncoef(1,_ww)
 LIST=_ww,Ncoef[_ww]
ENDLOOP

; print REVISED modal constants
LOOP _ww=1,36
 _idx=_ww
 RO.N1=_ww
 RO.HBW=Nconst[_idx]
 RO.HBNW=Nconst[_idx+36]
 RO.NHB=Nconst[_idx+72]
 WRITE RECO=1
ENDLOOP

LOOP _ww=1,18
  RO.N1 = _ww
  RO.HBW  = Ncoeff[_ww]
  RO.HBNW = Ncoeff[_ww+18]
  RO.NHB  = Ncoeff[_ww+36]
  WRITE RECO=2
ENDLOOP

ENDRUN
