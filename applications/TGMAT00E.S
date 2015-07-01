; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\GENRATESNP.PRN" MSG='Production Rates Non-Permanent Population'
FILEI RECI = "{CATALOG_DIR}\Parameters\GENRATESNP.DBF"

FILEO RECO[1] = "{SCENARIO_DIR}\OUTPUT\GENRATESNP.DBF",
FIELDS=PAD,PERSONS_DU,AUTOS_DU,DU_TYPE,PRATEHBW,PRATEHBSH,PRATEHBSR,PRATEHBO

ARRAY HBW_PRATE=999, HBSH_PRATE=999, HBSR_PRATE=999, HBO_PRATE=999

PAD=100*RI.PERSONS_DU+10*(RI.AUTOS_DU-1)+RI.DU_TYPE

HBW_PRATE[PAD]=RI.HBW_PRATE
HBSH_PRATE[PAD]=RI.HBSH_PRATE
HBSR_PRATE[PAD]=RI.HBSR_PRATE
HBO_PRATE[PAD]=RI.HBO_PRATE


IF (I=0)
  LOOP P=1,5
   LOOP A=1,3
     LOOP D=1,3
     PAD=100*P+10*(A-1)+D
        IF (HBW_PRATE[PAD]>0|HBSH_PRATE[PAD]>0|HBSR_PRATE[PAD]>0|HBO_PRATE[PAD]>0)
           RO.PERSONS_DU=P
           RO.AUTOS_DU=A-1
           RO.DU_TYPE=D
           RO.PRATEHBW=HBW_PRATE[PAD]
           RO.PRATEHBSH=HBSH_PRATE[PAD]
           RO.PRATEHBSR=HBSR_PRATE[PAD]
           RO.PRATEHBO=HBO_PRATE[PAD]
           WRITE RECO=1
        ENDIF ; HBW_PRATE[PAD], ETC
     ENDLOOP;  D
    ENDLOOP ;  A
  ENDLOOP   ;  P
ENDIF
; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
