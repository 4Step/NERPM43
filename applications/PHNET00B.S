; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\OUTPUT\PHNET00B.PRN" MSG='Remove Transit -Only links from loaded network hor Highway Evaluation'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\LOADED_CombinedPeriods.NET"
FILEO NETO = "{SCENARIO_DIR}\output\CombLDXX_HEVAL.NET"

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

 
;Delete transit-Only non-highway links from loaded network
  IF(LI.1.Facility_Type=49,59,69) DELETE 

    

ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY


ENDPHASE



ENDRUN
