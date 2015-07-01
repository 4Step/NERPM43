; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\GNMAT00D.PRN" MSG='Transpose & Round 2035 EETRIPS file'
FILEI MATI[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\Jacksonville\SksWorkOfInputFiles\Externals\EETRIPS35Tem.MAT"
FILEO MATO[1] = "C:\FSUTMS\D2\NERPM42_08_30_2011\NERPM4.0\Jacksonville\SksWorkOfInputFiles\Externals\EETRIPS35.MAT",
 MO=3, NAME=EE2035 DEC=1*S

PAR ZONES={ZONESA} ZONEMSG=100

;IF (I>={ExtZnStrt})
   MW[1]=MI.1.1
   MW[2]=MI.1.1.T
   MW[3]=ROUND((MW[1]+MW[2])*0.5)
;ENDIF




ENDRUN
