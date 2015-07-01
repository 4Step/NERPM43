; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00B.PRN" MSG='SKS-Extract Several Link Attributes for Zonal Info'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED.NET"
FILEO PRINTO[1] = "{SCENARIO_DIR}\LinkTazInfo_{Year}{alt}.DAT"

;_lastnode=0


PHASE=LINKMERGE
    
    if ( (LI.1.A <> _lastnode) && (LI.1.A <= {ZONESI}) )
      print list=LI.1.A(6.0),LI.1.COUNTY(4.0),LI.1.DISTRICT(4.0),LI.1.AREA_TYPE(4.0),printo=1
    endif
    _lastnode = LI.1.A
ENDPHASE



ENDRUN
