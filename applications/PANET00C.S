; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\PANET00A.PRN" MSG='Adjust Extreme Congested Speed and Time of Peak Hour loaded network'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PKPreLoad_tem.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PKPreLoad.NET"

PROCESS PHASE=LINKMERGE

;===========================================================
;SKS-CAP Congested Speed to 2.5-75 mph and recalculate time_1 (congested time)
;Also if congested speed greater than initial speed (SPEED), then cap that to initial speed
;This changes will be required for unreasonable congested speeds for congested skims used in HBW final distribution;
;as well as to have proper transit connector speed. 

If (CSPD_1<2.5) CSPD_1=2.5
IF (CSPD_1>75.0) CSPD_1=75.0
if (!(facility_type=49,59,69))             ; exclude transit-only links
    IF (CSPD_1>SPEED) CSPD_1=SPEED
endif

time_1 = 60.0*DISTANCE/CSPD_1

;=======================================


ENDPROCESS

ENDRUN
