; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\BFMAT00E.PRN" MSG='Develop Jaxport Truck Od table in SWM N4 extract zones'
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\base_SWM\Port_trk.mat"
FILEO MATO[1] = "{CATALOG_DIR}\output_SWM\base_SWM\Port_trk_od.mat",
  MO=1,2 NAME=TRIPSPA,TRIPSOD

PARAMETERS ZONES=508

 MW[1]=MI.1.1
 MW[2]=0.5*(MW[1]+MI.1.1.T)

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
