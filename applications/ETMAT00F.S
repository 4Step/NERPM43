; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\ETMAT00F.PRN" MSG='Convert Jaxport Truck OD tables in NERPM4 zones'
FILEI MATI[1] = "{CATALOG_DIR}\output_SWM\EC2030_SWM\Port_trk_od.mat"
FILEI ZDATI[1] = "{CATALOG_DIR}\input_SWM\EC2030_SWM\N4EXTRACT_EQ.DBF",
   z=SWTAZ_EX
FILEO MATO[1] = "{CATALOG_DIR}\output_SWM\EC2030_SWM\2030_Port_trk_od_N4.mat",
   mo=1 NAME=Futr_N4_PortTrk


  mw[1]=mi.1.2
renumber, zoneo=zi.1.N4_TAZ,
  MISSINGZI=M,
  MISSINGZO=w


; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
