; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\WARMSTART\PNNET00A.PRN" MSG='Remove Transit -Only links from loaded network hor Highway Evaluation'
FILEI LINKI[1] = "{Scenario_Dir}\output\PKPreLoad.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PreAssignLOADED_HEVAL.NET"

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
