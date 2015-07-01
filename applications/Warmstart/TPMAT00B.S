
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\TPMAT00B.PRN" MSG='create FACTORS file'
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\@Access_Name@@Mode_Name@.FAC"

LOOKUP NAME=COEFF, 
       LOOKUP[1]=1, RESULT=2,
       FAIL=0,0,0,
       LIST=Y,
       INTERPOLATE=N,
       LOOKUPI=1

ZONES=1
_ovtam =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor
_xpena=COEFF(1,6)/COEFF(1,1)

  comment=';'
;**************************************************************
;BEGIN POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************

  PRINT FORM=5.0,
    list="",comment, " PT Factors File for ********",'@ACCESS_NAME@'," Access - ",'@MODE_NAME@'," ********",
         "\n",comment, " FSUTMS Transit Model - July 2008, AECOM Consult",
         "\n",
         "\n",comment, "Global Settings",
         "\n BESTPATHONLY=T",
         "\n MAXFERS=",@MAXIMUMXFER@(1.0),
         "\n SERVICEMODEL=FREQUENCY",
         "\n RECOSTMAX=",@RECOSTMAX2@(6.2),
         "\n FREQBYMODE=T",
         "\n\n",comment, "Global Settings",
                 "\n ",'@DELMOD@',
         "\n DELACCESSMODE = ",'@DELACCMODE@',
         "\n DELEGRESSMODE = ",'@DELEGRMODE@',
         "\n\n",comment, "Fare and Wait Times",
         "\n FARESYSTEM=1, OPERATOR=1",
         "\n FARESYSTEM=2, OPERATOR=2",
         "\n FARESYSTEM=3, OPERATOR=3",
         "\n FARESYSTEM=4, OPERATOR=4",
         "\n FARESYSTEM=5, OPERATOR=5",
         "\n FARESYSTEM=6, OPERATOR=6",
         "\n IWAITCURVE=1,  NODES={NODEMIN}-99999",
         "\n XWAITCURVE=1, NODES={NODEMIN}-99999",
         "\n WAITFACTOR=2.00, NODES={NODEMIN}-99999",
         "\n\n",comment, "Runfactors",
         "\n RUNFACTOR[1]   =",_ovtam(5.2),
         "\n RUNFACTOR[2]   = 1.00",
                 "\n RUNFACTOR[3]   = 1.00",
         "\n RUNFACTOR[4]   = 9.99",
         "\n RUNFACTOR[11]  =",_ovtam(5.2),
         "\n RUNFACTOR[12]  =",_ovtam(5.2),
         PRINTO=1

    if (@MODE@==1)
      list="",
         "\n RUNFACTOR[21]  = ",@FAVMODE@(4.2),
         "\n RUNFACTOR[22]  = ",@NOMODE@(4.2),
         "\n RUNFACTOR[23]  = ",@FAVMODE@(4.2),
         "\n RUNFACTOR[24]  = ",@NOMODE@(4.2),
         "\n RUNFACTOR[25]  = ",@NOMODE@(4.2),
         "\n RUNFACTOR[26]  = ",@NOMODE@(4.2),
         "\n RUNFACTOR[27]  = ",@NOMODE@(4.2),
       
         PRINTO=1
    elseif (@MODE@==2)
      list="",
         "\n RUNFACTOR[21]  = ",@LOWMODE@(4.2),
         "\n RUNFACTOR[22]  = ",@FAVMODE@(4.2),
         "\n RUNFACTOR[23]  = ",@LOWMODE@(4.2),
         "\n RUNFACTOR[24]  = ",@FAVMODE@(4.2),
         "\n RUNFACTOR[25]  = ",@CRMODE@(4.2),
         "\n RUNFACTOR[26]  = ",@FAVMODE@(4.2),
         "\n RUNFACTOR[27]  = ",@FAVMODE@(4.2),

         PRINTO=1
    endif

    list="",
         "\n\n",comment, "Boarding and Transfer Penalties",
         "\n BRDPEN[21]  = 2.0",
         "\n BRDPEN[22]  = 2.0",
         "\n BRDPEN[23]  = 2.0",
         "\n BRDPEN[24]  = 2.0",
         "\n BRDPEN[25]  = 2.0",  
                 "\n BRDPEN[26]  = 2.0",
         "\n BRDPEN[27]  = 2.0",

         "\n XFERPEN=0.00, from=21-200, to=21-200",
         "\n XFERFACTOR=1.00, from=21-200, to=21-200",
         "\n XFERCONST=",_xpena(4.2),", from=21-200, to=21-200",
         "\n  ",
         PRINTO=1

ENDRUN
