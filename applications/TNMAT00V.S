; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\TNMAT00I.PRN" MSG=' Build survey trip table to compare boardings'
FILEO MATO[1] = "C:\NERPM50\APPLICATIONS\TNMAT00D.MAT",
MO=1,4,5,NAME=count,access,surveyboarding
FILEI MATI[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\Model_Data\NERPM_Data\jta_surveys\SurveyOD_BoardingComparison2.dbf",
pattern=IJM:V, FIELDS=IZ,JZ,0,ACCESS,SURVEY_BOA,COUNT

par zones={ZONESA} zonemsg=100

MW[1]=MI.1.3
MW[2]=MI.1.1
MW[3]=MI.1.2

JLOOP
 if (MW[1] >0) MW[4]=MW[2]/MW[1]
 if (MW[1] >0) MW[5]=MW[3]/MW[1]
ENDJLOOP

ENDRUN
