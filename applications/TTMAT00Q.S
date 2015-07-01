; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\TTMAT00Q.PRN" MSG='Sum 4 Period Tables for Check'
FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYTTAB_AllPeriod_Chk_{alt}{year}.MAT",
 MO=11-20, NAME=AD_DA_IEII,AD_SR2_IEII,AD_SR3_IEII,AD_TRK_IEII,AD_TRK_EE,
               AD_DA_EE,AD_SR2_EE,AD_SR3_EE,AD_PortTrk,AD_Total, DEC=10*s

FILEI MATI[4] = "{SCENARIO_DIR}\output\HWYTTAB_NT_{alt}{year}.MAT"
FILEI MATI[3] = "{SCENARIO_DIR}\output\HWYTTAB_PM_{alt}{year}.MAT"
FILEI MATI[2] = "{SCENARIO_DIR}\output\HWYTTAB_MD_{alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\HWYTTAB_AM_{alt}{year}.MAT"

PAR ZONEMSG=100

MW[11]=MI.1.1+MI.2.1+MI.3.1+MI.4.1
MW[12]=MI.1.2+MI.2.2+MI.3.2+MI.4.2
MW[13]=MI.1.3+MI.2.3+MI.3.3+MI.4.3
MW[14]=MI.1.4+MI.2.4+MI.3.4+MI.4.4
MW[15]=MI.1.5+MI.2.5+MI.3.5+MI.4.5
MW[16]=MI.1.6+MI.2.6+MI.3.6+MI.4.6
MW[17]=MI.1.7+MI.2.7+MI.3.7+MI.4.7
MW[18]=MI.1.8+MI.2.8+MI.3.8+MI.4.8
MW[19]=MI.1.9+MI.2.9+MI.3.9+MI.4.9

MW[20]=MI.1.10+MI.2.10+MI.3.10+MI.4.10

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

ENDRUN
