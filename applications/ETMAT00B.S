; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\ETMAT00B.PRN" MSG='Fix Extracted N4 TT to  fix freeway external stations zones'
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\EC2030_SWM\nerpm4tt.mat"
FILEI ZDATI[1] = "{CATALOG_DIR}\output_SWM\EC2030_SWM\jaxext.dbf",
    z=n
FILEO MATO[1] = "{Catalog_Dir}\output_SWM\EC2030_SWM\nerpm4ttx.mat",
    mo=1

mw[1]=mi.1.9
renumber, zoneo=zi.1.m,
  MISSINGZI=M,
  MISSINGZO=w


; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
