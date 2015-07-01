; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\TNMAT00L.PRN" MSG='print file'
FILEO PRINTO[1] = "C:\NERPM50\APPLICATIONS\TNMAT00K.PRN"
FILEI MATI[1] = "C:\NERPM50\APPLICATIONS\TNMAT00E.MAT"

zones={zonesa}, zonemsg=100

FILLMW MW[1]=MI.1.1,2,3,4,5,6

JLOOP
 IF (I<>J)
  if (MW[1] <> 0) print list=I(5),J(5),'   1',MW[2](10),MW[1](10),(mw[1]-mw[2])(10),printo=1
  if (MW[3] <> 0) print list=I(5),J(5),'   2',MW[4](10),MW[3](10),(mw[3]-mw[4])(10),printo=1
  if (MW[5] <> 0) print list=I(5),J(5),'   3',MW[6](10),MW[5](10),(mw[5]-mw[6])(10),printo=1
 ENDIF
ENDJLOOP

ENDRUN
