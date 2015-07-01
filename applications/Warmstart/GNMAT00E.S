; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\GNMAT00B.PRN" MSG='Create EE -Strt with Transpose'
FILEO MATO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\EXTERNALS-2ndOUT-TRANSPOSE.MAT",
 MO=3, NAME=EEFakeT DEC=1*S

PAR ZONES={ZONESA} ZONEMSG=100

;IF (I>={ExtZnStrt})
   MW[1]=MI.1.1
   MW[2]=MI.1.1.T
   MW[3]=(MW[1]+MW[2])*0.5
;ENDIF




ENDRUN
