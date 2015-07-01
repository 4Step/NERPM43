; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00A.PRN" MSG='replace MCSEED program - no longer used'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PERSONS.TEM"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\MCSEED_{alt}{year}.OUT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PTRIPS_MC.MAT",
MO=31-42,DEC=12*S  ;, FORMAT=TRANPLAN
FILEI MATI[2] = "{CATALOG_DIR}\parameters\CALIB98A.MC3"

zonemsg=100
array bucket=255

FILLMW MW[1]=MI.1.1,2,3
FILLMW MW[11]=MI.2.1,2,3,4,5,6,7,8,9,10,11,12

if ((ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14)) > 0.0)
 hbwdafac=ROWSUM(11)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
 hbwhov2fac=ROWSUM(12)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
 hbwhov3fac=ROWSUM(13)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
 hbwtranfac=ROWSUM(14)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
else
 hbwdafac=1.0
 hbwhov2fac=0.0
 hbwhov3fac=0.0
 hbwtranfac=0.0
endif
if ((ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18)) > 0.0)
 hbnwdafac=ROWSUM(15)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
 hbnwhov2fac=ROWSUM(16)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
 hbnwhov3fac=ROWSUM(17)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
 hbnwtranfac=ROWSUM(18)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
else
 hbnwdafac=1.0
 hbnwhov2fac=0.0
 hbnwhov3fac=0.0
 hbnwtranfac=0.0
endif
if ((ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22)) > 0.0)
 nhbdafac=ROWSUM(19)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
 nhbhov2fac=ROWSUM(20)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
 nhbhov3fac=ROWSUM(21)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
 nhbtranfac=ROWSUM(22)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
else
 nhbdafac=1.0
 nhbhov2fac=0.0
 nhbhov3fac=0.0
 nhbtranfac=0.0
endif

;JLOOP
 MW[31]=hbwdafac*MW[1]
 MW[32]=hbwhov2fac*MW[1]
 MW[33]=hbwhov3fac*MW[1]
 MW[34]=hbwtranfac*MW[1]
 MW[35]=hbnwdafac*MW[2]
 MW[36]=hbnwhov2fac*MW[2]
 MW[37]=hbnwhov3fac*MW[2]
 MW[38]=hbnwtranfac*MW[2]
 MW[39]=nhbdafac*MW[3]
 MW[40]=nhbhov2fac*MW[3]
 MW[41]=nhbhov3fac*MW[3]
 MW[42]=nhbtranfac*MW[3]
;ENDJLOOP

/*
; TRANPLAN STYLE row bucket rounder
loop k=31,42
  jloop
    if (i=1&J=1) BUCKET[K]=0.5
    FRONTEND=(mw[k][j]+bucket[k])
    mw[k][j]=INT(FRONTEND)
    bucket[k]=FRONTEND-(mw[k][j])
  endjloop
endloop
*/

if (i=1)
 print list='\n\n                 HOME-BASED WORK            HOME-BASED NON-WORK            NON-HOME-BASED',printo=1
 print list='  ZONE     D/A    2-P   3+ P   TRANSIT    D/A    2-P   3+ P   TRANSIT    D/A    2-P   3+ P   TRANSIT',printo=1
 print list='         ------ ------ ------  -------  ------ ------ ------  -------  ------ ------ ------  -------\n',printo=1
endif
 print list=I(6.0),'    ',hbwdafac(5.3),'  ',hbwhov2fac(5.3),'  ',hbwhov3fac(5.3),'    ',hbwtranfac(5.3),'   ',hbnwdafac(5.3),'  ',hbnwhov2fac(5.3),'  ',hbnwhov3fac(5.3),'    ',hbnwtranfac(5.3),'   ',nhbdafac(5.3),'  ',nhbhov2fac(5.3),'  ',nhbhov3fac(5.3),'    ',nhbtranfac(5.3),printo=1
if ((i/10)=INT(i/10))
 print list=' ', printo=1
endif

ENDRUN
