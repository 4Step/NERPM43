
IF (MODE==1)                                  ; bus paths
  MODE_NAME='Bus'
  DELMOD='DELMODE = 22,24,25,26,27'
ELSEIF (MODE==2)                              ; proj/prem paths
  MODE_NAME='Proj'
  DELMOD='   '
ENDIF

FAVMODE=1.00
;LOWMODE=1.30    ; [hmm] Value in original script
LOWMODE=1.20
NOMODE=9.99
CRMODE=1.00




