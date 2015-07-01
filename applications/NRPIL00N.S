; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
; modified by DDM 9/2012
IF (SOFTWAREVERSION<60001)
  CLEARERROR CODE=0 RESUME=T
  PROMPT QUESTION='THIS MODEL REQUIRES CUBE VERSION 6.0.1 OR HIGHER',
  ANSWER='Please call the FDOT District One Model Coordinator'
  IF (RETURNCODE==2) EXIT
ENDIF

*del "{SCENARIO_DIR}\output\*.* "
*del "{CATALOG_DIR}\applications\*.prn "
*del "{CATALOG_DIR}\applications\*.bak "
*del "{CATALOG_DIR}\applications\*.txt "
*del "{CATALOG_DIR}\applications\*.log "
*del "{CATALOG_DIR}\applications\*.cmdstart "

*echo FSUMTS Model Run - {SCENARIO_FULLNAME}>"{SCENARIO_DIR}\output\runtime.prn"
*echo Input Directory {SCENARIO_DIR}\input >>"{SCENARIO_DIR}\output\runtime.prn"
*echo ================================================================>>"{SCENARIO_DIR}\output\runtime.prn"
*echo Begin Run >>"{SCENARIO_DIR}\output\runtime.prn"
*echo Date: %date% >>"{SCENARIO_DIR}\output\runtime.prn"
*echo Time: %time% >>"{SCENARIO_DIR}\output\runtime.prn"
*echo ================================================================>>"{SCENARIO_DIR}\output\runtime.prn"

; Open cluster nodes
IF ({USECLUSTER}=1)
;*CLUSTER TMUDemoDist 1-%NUMBER_OF_PROCESSORS% START EXIT
*CLUSTER TMUDemoDist 1-2 START EXIT
ENDIF
