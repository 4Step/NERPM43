RUN PGM=PUBLIC TRANSPORT 

PROCESS PHASE=NODEREAD
; loops over all nodes computes node based scalar and array variables (Optional) 


ENDPROCESS

PROCESS PHASE=LINKREAD
; loops over all links Computes link based scalar and array variables (Optional)


ENDPROCESS

PROCESS PHASE=DATAPREP
; generates/reads non-transit legs (Optional - Required for PT Network Development)


ENDPROCESS

PROCESS PHASE=MATI
; manipulates input and work matrices prior to processing each Origin zone, I (Optional)


ENDPROCESS

PROCESS PHASE=SELECTIJ
; allows finer selection of zone pairs, IJ, for Route Evaluation, and the setting 
; or revising of trips for Loading (Optional)


ENDPROCESS

PROCESS PHASE=SKIMIJ
; saves and manipulates skims for zone pairs, IJ (Optional - Required for Skimming)


ENDPROCESS

PROCESS PHASE=MATO
; allows processing of work matrices prior to them being written to the MATO files 
; at the end of each Origin zone (Optional)


ENDPROCESS

ENDRUN


