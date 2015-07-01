; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\HNMAT00E.PRN" MSG='Develop Transit  Congested Skims'
FILEI MATI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\CONGSKIM_{ALT}{Year}_MD.MAT"
FILEO MATO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\FHSKIMTT.{ALT}{Year}",
MO=1-4,NAME=COST,DISTANCE,TIME,TIME2, FORMAT=TRANPLAN

MW[1]=MI.1.1*100
MW[2]=MI.1.2*100
MW[3]=MI.1.3*100
MW[4]=MI.1.5*100

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
