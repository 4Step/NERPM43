; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\RWMAT00E.PRN" MSG='Revise PCWALK'
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PCWCHANGE_TEM.DAT"
FILEI ZDATI[1] = "{SCENARIO_DIR}\input\PCWALK_{Year}{Alt}.DAT",
  z=#1,pkprod=#2,pkattr=#3,opprod=#4,opattr=#5
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\PCWALK_{alt}{year}.DAT"
FILEI LOOKUPI[2] = "{SCENARIO_DIR}\output\PCWOP_TEM.DAT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\PCWPK_TEM.DAT"

zones={ZONESA}    ; Number of zones

;Peak period temp pcwalk file
LOOKUP LOOKUPI=1, NAME=PKPCWALK, LOOKUP[1]=1, RESULT=1,LOOKUP[2]=1, RESULT=2,LOOKUP[3]=1, RESULT=3,LOOKUP[4]=1, RESULT=6,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0
        pk_chkzone=PKPCWALK(1,z)         ; Check for existience of zone in peak walk access connectors file(centroid connector)
        pk_rule=PKPCWALK(4,z,1)
;Off-Peak period temp pcwalk file
LOOKUP LOOKUPI=2, NAME=OPPCWALK, LOOKUP[1]=1, RESULT=1,LOOKUP[2]=1, RESULT=4,LOOKUP[3]=1, RESULT=5,LOOKUP[4]=1, RESULT=6,
        INTERPOLATE=F, FAIL[1]=0, FAIL[2]=0
        op_chkzone=OPPCWALK(1,z)        ; Check for existience of zone in off peak walk access connectors file(centroid connector)
        op_rule=OPPCWALK(4,z,1)
;;Peak period modifications
if (pk_chkzone>0)
  zone =z
  pkp=PKPCWALK(2,z)
  pka=PKPCWALK(3,z)                    ; revised peak PCW's
  elseif (pk_chkzone==0)
  zone =z
  pkp=0
  pka=0
endif

;;Off-peak period modifications
if (op_chkzone>0)
  zone =z
  opp=OPPCWALK(2,z)
  opa=OPPCWALK(3,z)                   ;revised off peak PCW's
elseif (op_chkzone==0)
  zone =z
  opp=0
  opa=0
endif

PRINT LIST= zone(5.0),pkp(6.0),pka(6.0),opp(6.0),opa(6.0), PRINTO=1   ; Output PCW with PCW's updated for peak & off peak

;;Output zones whose PCW were revised
if (_ctr=0)
  PRINT  LIST =';Percent Walk updated for the zones below based on the following rules:\n\n',
              ';Rule 1 : No Walk Access Connectors to the Zone(PCW=0)\n',
              ';Rule 2 : No Transit Stop at centroid connector and PCW<95% (PCW=0)\n',
              ';Rule 3 : No Transit Stop at centroid connector & PCW>95% & shortest conn.length<AVGWALK (No Change in PCW)\n',
              ';Rule 4 : No Transit Stop at centroid connector & PCW>95% & shortest conn.length>=AVGWALK (PCW=0)\n',
              ';Rule 5 : Transit Stop at centroid connector & PCW =100% (No Change in PCW)\n',
              ';Rule 6 : Transit Stop at centroid connector & MinPCW<=PCW<100% (No Change in PCW)\n',
              ';Rule 7 : Transit Stop at centroid connector & PCW<MinPCW (PCW=0)\n',PRINTO=2
  PRINT LIST = 'ZONE   ','REVISED_PK_PROD  ','ORIGINAL_PK_PROD  ','PK_RULE  ','REVISED_OP_PROD  ','ORIGINAL_OP_PROD  ','OP_RULE',PRINTO=2
endif

if ( ((pk_rule=1,2,4,7) && pkprod>0) || ((op_rule=1,2,4,7) && opprod>0) ) PRINT LIST = zone(5.0),'         ',pkp(6.0),
  '            ',pkprod(6.0),'       ',pk_rule(3.0),'          ',opp(6.0),'            ',opprod(6.0),'       ',op_rule(3.0),PRINTO=2


_ctr=_ctr+1

ENDRUN
