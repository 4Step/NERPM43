; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{OUTDIR}\TPMAT00A.PRN"
FILEI LOOKUPI[1] = "{PARAMS}\TRN_COEFFICIENTS.DBF"

zones=1
; LOOKUP for coefficient file
LOOKUP NAME=COEFF, LOOKUP[1]=1, RESULT=2,
FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=1

ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =60*COEFF(1,4)/COEFF(1,1)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

log prefix=trncoeff var=ovtfactor
log prefix=trncoeff var=valtime
log prefix=trncoeff var=aatfactor

print list=ovtfactor,valtime,aatfactor

ENDRUN
