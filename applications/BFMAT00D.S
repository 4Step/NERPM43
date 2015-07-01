; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\BFMAT00D.PRN" MSG='Develop Jaxport Truck PA table'
FILEO MATO[1] = "{Catalog_Dir}\output_SWM\base_SWM\Port_trk.mat",
  MO=1 NAME=TRIPSPA
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\base_SWM\FTE_TT.DBF",
    PATTERN=IJ:V, FIELDS=AZ,BZ,TR

PARAMETERS ZONES=508

 MW[1]=MI.1.1

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
