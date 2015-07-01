; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\MCMAT00A3.PRN" MSG='Preparation for mode choice model'
FILEI ZDATI[4] = "{SCENARIO_DIR}\INPUT\PCWALK_07C.DAT",
    z=#1,pkprod=2,pkattr=3,opprod=4,opattr=5
FILEI ZDATI[2] = "{SCENARIO_DIR}\output\ZONESAT.DAT",
    Z=6-10,A1=16-20
FILEI ZDATI[1] = "{SCENARIO_DIR}\INPUT\ZONEDATA_07C.dbf"

FILEO RECO[1] = "{SCENARIO_DIR}\output\TAZDATA_{alt}{year}.DBF",
   FIELDS= TAZ,SHORTPARK,LONGPARK,PCWPRDPK,PCWATTPK,PCWPRDOP,PCWATTOP,AREA_TYPE,CBD_DUMMY,EXU_DUMMY,TERMTIME

PAR ZONES={ZONESI,Spin-INTEGER,"Maximum internal zone number","3700",5,10000} ZONEMSG=100

;**************************************************************
;BEGIN POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************

RO.TAZ=ZI.1.ZONE
RO.SHORTPARK=ZI.1.SHORTPARK
RO.LONGPARK=ZI.1.LONGPARK

RO.PCWPRDPK=ZI.4.PKPROD   ; percent walk at production end for peak period
RO.PCWATTPK=ZI.4.PKATTR
RO.PCWPRDOP=ZI.4.OPPROD
RO.PCWATTOP=ZI.4.OPATTR

RO.AREA_TYPE=ZI.2.A1
_atype=ROUND(ZI.2.A1/10)
if (_atype=1) RO.TERMTIME={TERM10}
if (_atype=2) RO.TERMTIME={TERM20}
if (_atype=3) RO.TERMTIME={TERM30}
if (_atype=4) RO.TERMTIME={TERM40}
if (_atype=5) RO.TERMTIME={TERM50}

CBD_DUMMY=0
EXU_DUMMY=0
; define CBD zones for mode chocie
if (ZI.2.A1>10 & ZI.2.A1<20) CBD_DUMMY=1
; define EXURBAN zones for mode choice
if (ZI.2.A1>40 & ZI.2.A1<50) EXU_DUMMY=1

WRITE RECO=1
;**************************************************************
;END POTENTIAL SCRIPT ADJUSTMENT
;**************************************************************

ENDRUN
