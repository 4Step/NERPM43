; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\KumarA\NERPM\CUBE\TNMAT00G.PRN" MSG='Bld Flag for Stn 2 Stn and LOS'
FILEO MATO[8] = "C:\KumarA\NERPM\CUBE\TFAREMD.{ALT}{YEAR}",
 MO=109,119,129,139,149,159, NAME=FAREWLB,FAREWEB,FAREWRL,FAREALB,FAREAEB,FAREARL, FORMAT=TRANPLAN
FILEO MATO[7] = "C:\KumarA\NERPM\CUBE\TSKIMMD6.{ALT}{YEAR}",
MO=151-158, NAME=WALK,AUTO,IWAIT,LBTIME,EBTIME,RLTIME,XWAIT,XFER, FORMAT=TRANPLAN
FILEO MATO[6] = "C:\KumarA\NERPM\CUBE\TSKIMMD5.{ALT}{YEAR}",
MO=141-148, NAME=WALK,AUTO,IWAIT,LBTIME,EBTIME,RLTIME,XWAIT,XFER, FORMAT=TRANPLAN
FILEO MATO[5] = "C:\KumarA\NERPM\CUBE\TSKIMMD4.{ALT}{YEAR}",
MO=131-138, NAME=WALK,AUTO,IWAIT,LBTIME,EBTIME,RLTIME,XWAIT,XFER, FORMAT=TRANPLAN
FILEO MATO[4] = "C:\KumarA\NERPM\CUBE\TSKIMMD3.{ALT}{YEAR}",
MO=121-128, NAME=WALK,AUTO,IWAIT,LBTIME,EBTIME,RLTIME,XWAIT,XFER, FORMAT=TRANPLAN
FILEO MATO[3] = "C:\KumarA\NERPM\CUBE\TSKIMMD2.{ALT}{YEAR}",
MO=111-118, NAME=WALK,AUTO,IWAIT,LBTIME,EBTIME,RLTIME,XWAIT,XFER, FORMAT=TRANPLAN
FILEO MATO[2] = "C:\KumarA\NERPM\CUBE\TSKIMMD1.{ALT}{YEAR}",
MO=101-108, NAME=WALK,AUTO,IWAIT,LBTIME,EBTIME,RLTIME,XWAIT,XFER, FORMAT=TRANPLAN
FILEO MATO[1] = "C:\KumarA\NERPM\CUBE\MDFLAGS.MAT",
 MO=1-6,NAME=LBFLAGWK,EBFLAGWK,RLFLAGWK,LBFLAGAU,EBFLAGAU,RLFLAGAU

PAR ZONEMSG=100
; BEGIN STATION TO STATION FLAGS & PILOT CONTROLS
MW[1]=MI.1.4 ; WLB
MW[2]=MI.2.5 ; WEB
MW[3]=MI.3.6 ; WRL
MW[4]=MI.4.4 ; ALB
MW[5]=MI.5.5 ; AEB
MW[6]=MI.6.6 ; ARL
LOOP WW=1,6
  JLOOP
     IF (MW[WW]>0) MW[WW]=1
     IF (MI.1.5!=0&MI.1.6!=0) MW[1]=0
     IF (MI.4.5!=0&MI.4.6!=0) MW[4]=0
  ENDJLOOP
ENDLOOP

  rs1=rowsum(1)
  if (rs1>0)  r1flag=1
  log prefix=tnetmd var=r1flag

  rs2=rowsum(2)
  if (rs2>0) r2flag=1
  log prefix=tnetmd var=r2flag

  rs3=rowsum(3)
  if (rs3>0) r3flag=1
  log prefix=tnetmd var=r3flag

  rs4=rowsum(4)
  if (rs4>0) r4flag=1
  log prefix=tnetmd var=r4flag

  rs5=rowsum(5)
  if (rs5>0) r5flag=1
  log prefix=tnetmd var=r5flag

  rs6=rowsum(6)
  if (rs6>0) r6flag=1
  log prefix=tnetmd var=r6flag
; END STATION TO STATION FLAGS & PILOT CONTROLS

; BEGIN SKIM PROCESSING
mw[101]=mi.1.1*100*mw[1]
mw[102]=mi.1.2*100*mw[1]
mw[103]=mi.1.3*100*mw[1]
mw[104]=mi.1.4*100*mw[1]
mw[105]=mi.1.5*100*mw[1]
mw[106]=mi.1.6*100*mw[1]
mw[107]=mi.1.7*100*mw[1]
mw[108]=mi.1.8*mw[1]
mw[109]=mi.1.9*100*mw[1]

mw[111]=mi.2.1*100*mw[2]
mw[112]=mi.2.2*100*mw[2]
mw[113]=mi.2.3*100*mw[2]
mw[114]=mi.2.4*100*mw[2]
mw[115]=mi.2.5*100*mw[2]
mw[116]=mi.2.6*100*mw[2]
mw[117]=mi.2.7*100*mw[2]
mw[118]=mi.2.8*mw[2]
mw[119]=mi.2.9*100*mw[2]

mw[121]=mi.3.1*100*mw[3]
mw[122]=mi.3.2*100*mw[3]
mw[123]=mi.3.3*100*mw[3]
mw[124]=mi.3.4*100*mw[3]
mw[125]=mi.3.5*100*mw[3]
mw[126]=mi.3.6*100*mw[3]
mw[127]=mi.3.7*100*mw[3]
mw[128]=mi.3.8*mw[3]
mw[129]=mi.3.9*100*mw[3]

mw[131]=mi.4.1*100*mw[4]
mw[132]=mi.4.2*100*mw[4]
mw[133]=mi.4.3*100*mw[4]
mw[134]=mi.4.4*100*mw[4]
mw[135]=mi.4.5*100*mw[4]
mw[136]=mi.4.6*100*mw[4]
mw[137]=mi.4.7*100*mw[4]
mw[138]=mi.4.8*mw[4]
mw[139]=mi.4.9*100*mw[4]

mw[141]=mi.5.1*100*mw[5]
mw[142]=mi.5.2*100*mw[5]
mw[143]=mi.5.3*100*mw[5]
mw[144]=mi.5.4*100*mw[5]
mw[145]=mi.5.5*100*mw[5]
mw[146]=mi.5.6*100*mw[5]
mw[147]=mi.5.7*100*mw[5]
mw[148]=mi.5.8*mw[5]
mw[149]=mi.5.9*100*mw[5]

mw[151]=mi.6.1*100*mw[6]
mw[152]=mi.6.2*100*mw[6]
mw[153]=mi.6.3*100*mw[6]
mw[154]=mi.6.4*100*mw[6]
mw[155]=mi.6.5*100*mw[6]
mw[156]=mi.6.6*100*mw[6]
mw[157]=mi.6.7*100*mw[6]
mw[158]=mi.6.8*mw[6]
mw[159]=mi.6.9*100*mw[6]

; END SKIM PROCESSING


ENDRUN
