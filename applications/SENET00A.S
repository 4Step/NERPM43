; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\SENET00A.PRN" MSG='Prepare files for BRT analysis'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\UNLOADED_PT.NET"
FILEO PRINTO[7] = "{SCENARIO_DIR}\output\BRTreadfile4.TXT"
FILEO PRINTO[6] = "{SCENARIO_DIR}\output\BRTreadfile3.TXT"
FILEO PRINTO[5] = "{SCENARIO_DIR}\output\BRTreadfile2.TXT"
FILEO PRINTO[4] = "{SCENARIO_DIR}\output\BRTreadfile1.TXT"
FILEO PRINTO[3] = "{SCENARIO_DIR}\output\BRTlinktime.CSV"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\BRTLinks.TXT"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\BRTLinks1.TXT"

ARRAY CBDNODETMP=99999, CBDNODE=99999, BRTSTATIONS=500

PHASE=LINKMERGE

; Store BRT nodes for SELECTLINK analysis
    if ( (FACILITY_TYPE=69) && (LI.1.A >= {FirstBRTStationNode}) && (LI.1.B >= {FirstBRTStationNode}) && (LI.1.A < LI.1.B) )   ; pick up the BRT Links (does not include the Skyway Links)
     if (_idx=0)
       _AK=1
       print form=5.0, list = "MW[58] = SELECTLINK(L = ", LI.1.A, "-", LI.1.B, "*", printo=1
       print form=5.0, list = "MW[", _AK(2.0), "] = SELECTLINK(L = ", LI.1.A, "-", LI.1.B, "*)     ",";",TFGDIST(10.2),TFGTIME(10.2), printo=2
       print csv=t, list = _AK, LI.1.A,LI.1.B,TFGDIST,TFGTIME, printo=3
       print list="FILLMW MW[",_AK(L),"]=MI.1.",_AK(L),printo=4
       print list="FILLMW MW[",(_AK+100)(L),"]=MI.2.",_AK(L),printo=5
       print list="FILLMW MW[",(_AK+200)(L),"]=MI.3.",_AK(L),printo=6
       print list="FILLMW MW[",(_AK+300)(L),"]=MI.4.",_AK(L),printo=7
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
       _idx=_idx+2
     else
       BRTSTATIONS[_idx+1]=LI.1.A
       BRTSTATIONS[_idx+2]=LI.1.B
       _AK=_AK+1
       print form=5.0, list = LI.1.A, "-", LI.1.B, "*", printo=1
       print form=5.0, list = "MW[", _AK(2.0), "] = SELECTLINK(L = ", LI.1.A, "-", LI.1.B, "*)     ",";",TFGDIST(10.2),TFGTIME(10.2), printo=2
       print csv=t, list = _AK,LI.1.A,LI.1.B,TFGDIST,TFGTIME, printo=3
       print list="FILLMW MW[",_AK(L),"]=MI.1.",_AK(L),printo=4
       print list="FILLMW MW[",(_AK+100)(L),"]=MI.2.",_AK(L),printo=5
       print list="FILLMW MW[",(_AK+200)(L),"]=MI.3.",_AK(L),printo=6
       print list="FILLMW MW[",(_AK+300)(L),"]=MI.4.",_AK(L),printo=7
      _idx=_idx+2
     endif
    endif

    _lastnode = LI.1.A
ENDPHASE

PHASE=SUMMARY
    if ({isFutureYearAlternative}=1) print form=5.0, list= ")",printo=1

      if ({isFutureYearAlternative}=1)
        log prefix=numBRTlinks var=_ak
      else
        _ak=2
        log prefix=numBRTlinks var=_ak
      endif
ENDPHASE
ENDRUN
