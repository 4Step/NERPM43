; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{CATALOG_DIR}\APPLICATIONS\MCMAT00A2.PRN" MSG='Calculate HOV time savings'
FILEI MATI[2] = "{SCENARIO_DIR}\OUTPUT\MMLOO_OPSKIM.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\OUTPUT\MMLOO_PKSKIM.MAT"


FILEO MATO[3] = "{SCENARIO_DIR}\OUTPUT\PKSKIM_{ALT}{Year}.MAT",
    mo=41-49,name=STOLL,SDISTANCE,STIME,STIME2,HTOLL,HDISTANCE,HTIME,HTIME2,TERMTIME

FILEO MATO[2] = "{SCENARIO_DIR}\OUTPUT\OPSKIM_{ALT}{Year}.MAT",
    mo=31-39,name=STOLL,SDISTANCE,STIME,STIME2,HTOLL,HDISTANCE,HTIME,HTIME2,TERMTIME

FILEO MATO[1] = "{SCENARIO_DIR}\output\HOVSavings_{alt}{year}.MAT",
    MO=21-22,DEC=2*2,NAME=HOVsavePK,HOVsaveOP

PAR ZONEMSG=100

DistributeINTRASTEP ProcessID="TMUDemoDist", ProcessList=1-%NUMBER_OF_PROCESSORS%

;Peak period HOV and SOV times
FILLMW MW[1] =MI.1.9   ; HOV time: note that time2 is used here (time2 contains both time and time-equivalent of toll)
FILLMW MW[2] =MI.1.5   ; SOV time

;Off-Peak period HOV and SOV times
FILLMW MW[11]=MI.2.9
FILLMW MW[12]=MI.2.5

;Off-Peak period HOV and SOV skims
FILLMW MW[31]=MI.2.1,2,3,5,6,7,8,9,4

;Peak period HOV and SOV skims
FILLMW MW[41]=MI.1.1,2,3,5,6,7,8,9,4


MW[21]=MW[2] - MW[1]   ; Peak period hov time savings
MW[22]=MW[12] - MW[11] ; Off-Peak period hov time savings


JLOOP
 IF (MW[21] < {HOVMIN}) MW[21]=0.0   ; if less than HOVMIN zero out the savings
 IF (MW[22] < {HOVMIN}) MW[22]=0.0
ENDJLOOP


ENDRUN
