; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00H.PRN" MSG='Write LINKS & XY Files for PCWALK through ARCVIEW'
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\IXY2.TXT"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\ILINKS2.TXT"


Phase=NodeMerge
;  print CSV=T list=n(6.0),x(9.0),y(9.0),SECTIONID(4.0) PRINTO=2
  print CSV=T list=n(6.0),x(9.0),y(9.0) PRINTO=2
endphase

Phase=LinkMerge
  _AT=int(AREA_TYPE/10)
  _FT=int(FACILITY_TYPE/10)



;EX/AP are not needed and are used as XX, just for space holder
if(_FT<>0)
    print CSV=T list=a(6.0),'XX'(2.0c),B(6.0),NUM_LANES(2.0),_AT(2.0),_FT(2.0),TMODE(2.0) PRINTO=1
endif  


endphase

PHASE=SUMMARY
endphase




ENDRUN
