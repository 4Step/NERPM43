; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\FACTORS.PRN" MSG='create FACTORS file'
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\@Access_Name@@Mode_Name@.FAC"

ZONES=1

; LOOKUP for coefficient file
LOOKUP NAME=COEFF, LOOKUP[1]=1, RESULT=2,
FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=1

ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

comment=';'

IF (I=1)
  PRINT FORM=5.0,
    list="",comment, "PT Factors File for ********",'@ACCESS_NAME@'," Access - ",'@MODE_NAME@'," ********",
         "\n",comment, "NERPM - December 2006, AECOM Consult",
         "\n\n",comment, "Global Settings",
         "\n BESTPATHONLY=T",
         "\n FREQBYMODE=T",
         "\n RECOSTMAX=",@RECOSTMAX2@(6.2),
         "\n MAXFERS=",@MAXIMUMXFER@(1.0),
         "\n SERVICEMODEL=FREQUENCY",
         
         ; Don't write delete modes for Commuter Rail 
         @ALLOWEXCLUDEMODES@ "\n\n",comment, "Available Transit Modes",
         @ALLOWEXCLUDEMODES@"\n DELMODE = ",'@DELETEMODE@',
         
         "\n\n",comment, "Access & Egress Modes",
         "\n DELACCESSMODE = ",'@DELACCMODE@',
         "\n DELEGRESSMODE = ",'@DELEGRMODE@',

         "\n\n",comment, "Fare & Wait Times",
         "\n FARESYSTEM=1, OPERATOR=1",
         "\n FARESYSTEM=2, OPERATOR=2",
         "\n FARESYSTEM=3, OPERATOR=3",
         "\n FARESYSTEM=4, OPERATOR=4",
         "\n FARESYSTEM=5, OPERATOR=5",
         "\n FARESYSTEM=6, OPERATOR=6",
         "\n FARESYSTEM=7, OPERATOR=7",
         "\n FARESYSTEM=8, OPERATOR=8",
         "\n IWAITCURVE=1,  NODES={NODEMIN}-99999",
         "\n XWAITCURVE=1,  NODES={NODEMIN}-99999",
         "\n WAITFACTOR=",ovtfactor(5.2)," NODES={NODEMIN}-99999",

         "\n\n",comment, "Run Factors",
         "\n RUNFACTOR[1]   =",ovtfactor(5.2),
         "\n RUNFACTOR[2]   = 1.00",
         "\n RUNFACTOR[3]   = 1.00",
         "\n RUNFACTOR[4]   =",ovtfactor(5.2),
         "\n RUNFACTOR[5]   = 1.00",
         "\n RUNFACTOR[6]   = 1.00",
         "\n RUNFACTOR[11]  =",ovtfactor(5.2),
         "\n RUNFACTOR[12]  =",ovtfactor(5.2),
         "\n RUNFACTOR[21]  = ",@PREFLB@(4.2),
         "\n RUNFACTOR[22]  = ",@PREFEB@(4.2),
         "\n RUNFACTOR[23]  = ",@PREFSKY@(4.2),
         "\n RUNFACTOR[24]  = ",@PREFBRT@(4.2),
         "\n RUNFACTOR[25]  = ",@PREFLRT@(4.2),
         "\n RUNFACTOR[26]  = ",@PREFCRL@(4.2),

         "\n\n",comment, "Boarding & Transfer Penalties",
         "\n BRDPEN[21]  = 2.0",
         "\n BRDPEN[22]  = 2.0",
         "\n BRDPEN[23]  = ",@BRDpen23@(3.1),
         "\n BRDPEN[24]  = 2.0",
         "\n BRDPEN[25]  = 2.0",
         "\n BRDPEN[26]  = 2.0",
         "\n BRDPEN[27]  = 2.0",
         "\n XFERPEN=0.00, from=21-200, to=21-200",
         "\n XFERFACTOR=1.00, from=21-200, to=21-200",
         "\n ",'@TRANSFERPEN1@',

         "\n  ",PRINTO=1
ENDIF


ENDRUN
