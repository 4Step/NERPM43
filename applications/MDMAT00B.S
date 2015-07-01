; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MDMAT00A.PRN"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PTRIPS_MCSEED2_TMP.MAT",
MO=31-42,DEC=12*S
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\MCSEED2_{alt}{year}.OUT"
FILEI LOOKUPI[1] = "{SCENARIO_DIR}\output\seedmat2.csv"
FILEI ZDATI[1] = "{CATALOG_DIR}\parameters\Model_TAZ_District_Lookup.prn",
Z=16-20,DIST=12-13
FILEI MATI[2] = "{CATALOG_DIR}\parameters\CALIB98A.MC3"
FILEI MATI[1] = "{SCENARIO_DIR}\output\PERSON3.TEM"

zonemsg=100

DST=INT(DIST)

FILLMW MW[1]=MI.1.1.T
FILLMW MW[2]=MI.1.2.T
FILLMW MW[3]=MI.1.3.T

FILLMW MW[11]=MI.2.1.T
FILLMW MW[12]=MI.2.2.T
FILLMW MW[13]=MI.2.3.T
FILLMW MW[14]=MI.2.4.T
FILLMW MW[15]=MI.2.5.T
FILLMW MW[16]=MI.2.6.T
FILLMW MW[17]=MI.2.7.T
FILLMW MW[18]=MI.2.8.T
FILLMW MW[19]=MI.2.9.T
FILLMW MW[20]=MI.2.10.T
FILLMW MW[21]=MI.2.11.T
FILLMW MW[22]=MI.2.12.T

if ((ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14)) > 0.0)
 hbwdafac=ROWSUM(11)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
 hbwhov2fac=ROWSUM(12)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
 hbwhov3fac=ROWSUM(13)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
 hbwtranfac=ROWSUM(14)/(ROWSUM(11)+ROWSUM(12)+ROWSUM(13)+ROWSUM(14))
else
 LOOKUP, NAME=HBWFACTORS,LOOKUP[1]=1,RESULT=2,LOOKUP[2]=1,RESULT=3,LOOKUP[3]=1,RESULT=4,LOOKUP[4]=1,RESULT=5,INTERPOLATE=N,LIST=Y,LOOKUPI=1
 hbwdafac=HBWFACTORS(1,DST)
 hbwhov2fac=HBWFACTORS(2,DST)
 hbwhov3fac=HBWFACTORS(3,DST)
 hbwtranfac=HBWFACTORS(4,DST)
print list='******************',I(5.0),DST(4.0)
endif
if ((ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18)) > 0.0)
 hbnwdafac=ROWSUM(15)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
 hbnwhov2fac=ROWSUM(16)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
 hbnwhov3fac=ROWSUM(17)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
 hbnwtranfac=ROWSUM(18)/(ROWSUM(15)+ROWSUM(16)+ROWSUM(17)+ROWSUM(18))
else
 LOOKUP, NAME=HBNWFACTORS,LOOKUP[1]=1,RESULT=6,LOOKUP[2]=1,RESULT=7,LOOKUP[3]=1,RESULT=8,LOOKUP[4]=1,RESULT=9,INTERPOLATE=N,LIST=Y,LOOKUPI=1
 hbnwdafac=HBNWFACTORS(1,DST)
 hbnwhov2fac=HBNWFACTORS(2,DST)
 hbnwhov3fac=HBNWFACTORS(3,DST)
 hbnwtranfac=HBNWFACTORS(4,DST)
endif
if ((ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22)) > 0.0)
 nhbdafac=ROWSUM(19)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
 nhbhov2fac=ROWSUM(20)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
 nhbhov3fac=ROWSUM(21)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
 nhbtranfac=ROWSUM(22)/(ROWSUM(19)+ROWSUM(20)+ROWSUM(21)+ROWSUM(22))
else
 LOOKUP, NAME=NHBFACTORS,LOOKUP[1]=1,RESULT=10,LOOKUP[2]=1,RESULT=11,LOOKUP[3]=1,RESULT=12,LOOKUP[4]=1,RESULT=13,INTERPOLATE=N,LIST=Y,LOOKUPI=1
 nhbdafac=NHBFACTORS(1,DST)
 nhbhov2fac=NHBFACTORS(2,DST)
 nhbhov3fac=NHBFACTORS(3,DST)
 nhbtranfac=NHBFACTORS(4,DST)
endif

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

if (i=1)
 print list='\n\n                 HOME-BASED WORK            HOME-BASED NON-WORK            NON-HOME-BASED',printo=1
 print list='  ZONE     D/A    2-P   3+ P   TRANSIT    D/A    2-P   3+ P   TRANSIT    D/A    2-P   3+ P   TRANSIT',printo=1
 print list='         ------ ------ ------  -------  ------ ------ ------  -------  ------ ------ ------  -------\n',printo=1
endif
 print list=I(6.0),'    ',hbwdafac(5.3),'  ',hbwhov2fac(5.3),'  ',hbwhov3fac(5.3),'   ',hbwtranfac(6.4),'   ',hbnwdafac(5.3),'  ',hbnwhov2fac(5.3),'  ',hbnwhov3fac(5.3),'   ',hbnwtranfac(6.4),'   ',nhbdafac(5.3),'  ',nhbhov2fac(5.3),'  ',nhbhov3fac(5.3),'   ',nhbtranfac(6.4),printo=1
if ((i/10)=INT(i/10))
 print list=' ', printo=1
endif

ENDRUN
