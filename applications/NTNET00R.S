; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\NTNET00W.PRN" MSG='Manual Adj of count net'
FILEI LINKI[1] = "C:\NERPM43_Delivered\APPLICATIONS\NTLNK00F"

;_lastnode=0


PHASE=LINKMERGE
    
    if ( (LI.1.A <> _lastnode) && (LI.1.A <= {ZONESI}) )
      print list=LI.1.A(6.0),LI.1.COUNTY(4.0),LI.1.DISTRICT(4.0),LI.1.AREA_TYPE(4.0),printo=1
    endif
    _lastnode = LI.1.A
ENDPHASE



ENDRUN
