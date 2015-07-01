; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=FRATAR PRNFILE="F:\JTA\NERPM50\APPLICATIONS\WARMSTART\GNFRA00B.PRN" MSG='Frartar/Develop 2035 EETRIPS with target trips'
FILEI MATI[1] = "F:\JTA\NERPM50\APPLICATIONS\WARMSTART\EETRIPS05.MAT"
FILEO MATO[1] = "F:\JTA\NERPM50\APPLICATIONS\WARMSTART\EETRIPS35Tem.MAT",
 MO=1, NAME=XX
FILEI ZDATI[1] = "F:\JTA\NERPM50\APPLICATIONS\WARMSTART\EE2035Target.dbf"

; The FRATAR module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  The module implements a FRATAR distribution process by modifying an
; existing matrix based on a set of user supplied production and attraction factors.

PARAMETERS ZONES={ZONESA}
MAXRMSE=0.01 MAXITERS=50
SETPA P[1]=zi.1.EETRGT, A[1]=zi.1.EETRGT, MW[1]=mi.1.5 CONTROL=PA INCLUDE={ExtZnStrt}-{ZONESA}
ACOMP=1,PCOMP=1
MARGINS=1
MARGINREC=y LIST=J,R1(6.0),C1(6.0)





ENDRUN
