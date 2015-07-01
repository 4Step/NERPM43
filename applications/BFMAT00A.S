; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\BFMAT00A.PRN" MSG='Generate a record file to fix freeway external stations zones'
FILEO RECO[1] = "{CATALOG_DIR}\output_SWM\base_SWM\jaxext.dbf",
fields=n,m
zones=1
loop n=1,508
  m=n
  if(n=479) 
     m=480
  endif
  if(n=503) 
     m=504
  endif
  write reco=1
endloop

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
