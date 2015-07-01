; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\NTMAT00C.PRN" MSG='Identify Appropriate Transit Speed Curve Data'
FILEI RECI = "C:\NERPM43_Delivered\APPLICATIONS\NTREC00B",
CARD=1-1, LOWMODE=2-3, HIGHMODE=4-5,
LOWAT=6-7, HIGHAT=8-9, LOWFT=10-11, HIGHFT=12-13, CURVE=15-16

FILEO PRINTO[1] = "C:\NERPM43_Delivered\APPLICATIONS\NTMAT00D.PRN"

IF (RI.CARD=2) 

  LOOP _WW=RI.LOWMODE,RI.HIGHMODE
      PRINT LIST="IF (AREA_TYPE=",ri.LOWAT(2.0),"-",ri.HIGHAT(2.0),
           "&FACILITY_TYPE=",ri.LOWFT(2.0),"-",ri.HIGHFT(2.0),
           ") _CURVEMODE",_WW(2.0L),"=",ri.CURVE(2.0), printo=1
  ENDLOOP

ENDIF


ENDRUN
