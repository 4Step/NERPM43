; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\TNMAT00A.PRN" MSG='Create file for generate statement'
FILEI LOOKUPI[1] = "{CATALOG_DIR}\parameters\TRN_COEFFICIENTS.DBF"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\TNMAT00B.PRN"

 ; LOOKUP for coefficient file
 LOOKUP, NAME=COEFF, LOOKUP[1]=1, RESULT=3,FAIL=0,0,0,LIST=Y,INTERPOLATE=N,LOOKUPI=1
 ovtfactor =COEFF(1,3)/COEFF(1,1)     ; out-of-vehicle time factor (OVT time and Wait factor)
 valtime   =0.6*COEFF(1,1)/COEFF(1,4)  ; value of time (in $/hr)
 aatfactor =COEFF(1,5)/COEFF(1,1)     ; drive access to transit time factor

;RO.TAZ=RI.TAZ
STNODE=RI.STATNODE
;RO.STNUM=RI.STATION
STMAXD=RI.DRV
STPKSP=RI.SPACES
PRKCSTAM=RI.A1
;RO.STPKCS2=RI.A2
;STWALKPR=2*RI.B1
;RO.STWALKKR=RI.B2
STUSE=RI.C1
STNAME=RI.NAME
anode1=ri.anode

comment=';'
opcost=(0.6/valtime)*{hwyopcost}/{OCCPNRAccess}
prkfac=(0.6/valtime)*0.5/{OCCPNRAccess}

;cost=aatfactor*time + ovtfactor*pnrtermtime + ((0.6/valtime)*prkcost/{OCCPNRAccess}/2.0) + ((0.6/valtime)*{hwyopcost}/{OCCPNRAccess}*dist)

 if ((STUSE = 1) & (STPKSP > 0))
  PRINT form=5.0,list="GENERATE, ACCESSLINK=", anode1(6.0), "-", STNODE(6.0), ", 0.0, 0.0, ", 
                      "COST=(li.time+li.bridpen),MAXCOST=200*",1.5*4*STMAXD(5.2L),",                     " comment,STNAME(24C),
                      "\n EXTRACTCOST=(li.TIME + li.BRIDPEN)",
;                      "\n EXTRACTCOST=(",aatfactor(3.1),"*li.TIME + ",opcost(3.1),"*li.DISTANCE + ",prkfac(4.2),"*li.PRKCSTAM + ",ovtfactor(3.1),"*li.PNRTERMINALTIME)",
                      ",\n LIST=F,DIRECTION=1,EXCLUDELINK=(LI.FACILITY_TYPE=49,59,69),NTLEGMODE=2,FROMNODE=1-{ZONESI} \n", PRINTO=1
 endif

ENDRUN
