; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\MSMAT00A.PRN" MSG='Transform "calib98a.mc3" matrix to NERPM2000 with new ext taz'
FILEO MATO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\CALIB98Amod.MC3",
 MO=1-12, NAME=M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,dec=1*s

FILEI ZDATI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\NERPM2000_RTSExt2NERPM3Ext.DBF",
Z=ZT
FILEI MATI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\CALIB98A_pre.MC3"


zonemsg=500

MW[1]=MI.1.1 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[2]=MI.1.2 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[3]=MI.1.3 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[4]=MI.1.4 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[5]=MI.1.5 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[6]=MI.1.6 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[7]=MI.1.7 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[8]=MI.1.8 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[9]=MI.1.9 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[10]=MI.1.10 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[11]=MI.1.11 ; must load values into MW[1], else OUT.MAT will be all zeros
MW[12]=MI.1.12 ; must load values into MW[1], else OUT.MAT will be all zeros

; renumber OUT.MAT according to ZDATIN.DAT
RENUMBER ZONEO=ZI.1.NZ  MISSINGZI=M, MISSINGZO=W


ENDRUN
