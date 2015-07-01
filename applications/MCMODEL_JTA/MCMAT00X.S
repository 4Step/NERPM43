; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\MCMAT00A2.PRN" MSG='Calculate HOV time savings (to be used in mode choice model)'
FILEI MATI[2] = "{SCENARIO_DIR}\output\PRELSKIMS.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\FHSKIMS.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT",
 MO=21-22,DEC=2*2,NAME=HOVsaveOP,HOVsavePK

PAR ZONEMSG=100

FILLMW MW[1] =MI.1.4,8   ; note that time2 is used here (time2 contains both time and time-equivalent of toll)
FILLMW MW[11]=MI.2.4,8

MW[21]=MW[1] - MW[2]   ; hov time savings during off-peak hours
MW[22]=MW[11] - MW[12] ; hov time savings during peak hours

JLOOP
; if (MW[21] > 0) MW[21]=0.0   ; if less than HOVMIN zero out the savings
; if (MW[22] > 0) MW[22]=0.0
 if (MW[21] < {HOVMIN}) MW[21]=0.0   ; if less than HOVMIN zero out the savings
 if (MW[22] < {HOVMIN}) MW[22]=0.0
ENDJLOOP
ENDRUN
