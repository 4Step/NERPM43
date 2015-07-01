; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\DTMAT00B.PRN" MSG='Summarize HBW Trips by CTPP Districts'
FILEI ZDATI[1] = "{CATALOG_DIR}\parameters\CTPPDistricts.dbf",
Z=ZT
FILEI MATI[1] = "{SCENARIO_DIR}\output\PTRIPS.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PTRIPSByCTPPDist.MAT",
 MO=1, NAME=HBWbyCTPPD,dec=1*s

MW[1]=MI.1.1
;MW[2]=MI.1.2
;MW[3]=MI.1.3
;MW[4]=MI.1.4
;MW[5]=MI.1.5

PAR ZONEMSG=100
; renumber OUT.MAT according to ZDATIN.DAT
RENUMBER ZONEO=ZI.1.CTPPDISTN3 MISSINGZI=M, MISSINGZO=W

 
ENDRUN
