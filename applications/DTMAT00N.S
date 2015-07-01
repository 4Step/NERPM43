; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\KUMARA\NERPM\CUBE\DTMAT00A.PRN" MSG='Matrix Compression'
FILEI MATI[1] = "C:\KUMARA\OTHERMODELS\JAX98J\PTRIPS.J98"

MW[1] = MI.1.1

 JLOOP
   if (j=409,410,412,658,660,662,663,665-672,675,676,679-684,686-699,701-715,717-724,726-741,745-747,749-756,758,759,765-771,1238-1240,1266,1267,1269,1270)  ;CBD
    _check = _check + MW[1][J]
   endif
 ENDJLOOP
   print list =i(5.0)," ",_check, FILE = "{OUTDIR}\HBWTOCBD.TXT"
   _check = 0

 hbw=ROWSUM(1)
   print list =i(5.0)," ",hbw, FILE = "{OUTDIR}\HBW.TXT"

 
ENDRUN
