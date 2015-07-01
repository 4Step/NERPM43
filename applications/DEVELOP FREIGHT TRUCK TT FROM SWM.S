DistributeMultiStep ProcessId='NERPM4Dist', ProcessNum=2
EndDistributeMultiStep
DistributeMultiStep ProcessId='NERPM4Dist', ProcessNum=3
EndDistributeMultiStep
; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
Wait4Files Files=NERPM4Dist2.script.end,NERPM4Dist3.script.end, CheckReturnCode=T,
  PrintFiles=MERGE, DelDistribFiles=T

; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\FTMAT00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\FTMAT00A.PRN" MSG='Interpolate Port Truck TTs derived from Statewide Model'
FILEI MATI[1] = "{CATALOG_DIR}\output_SWM\base_SWM\2005_Port_trk_od_N4.mat"
FILEI MATI[2] = "{CATALOG_DIR}\output_SWM\EC2030_SWM\2030_Port_trk_od_N4.mat"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PORT_TRK_24H_{Year}.MAT",
 MO=11,1,2 NAME=PortTrk_N42_{year},PortTrk_SWM_base,PortTrk_SWM_Future

last_year=2030                  ;Statewide model's Future E+C scenario year
base_year=2005                  ;Statewide model's Base year
forc_year=2000+{Year}           ;NERPN42's Scenario year

YRDIFF=last_year-base_year      ;Diference of STW model's Base (2005) and Future (EC2030) years
@YRDIFF_F@=forc_year-base_year  ;Difference of NERPM50's Scenario and Statewide model's base year 


MW[1]=mi.1.1 ; base year matrix
MW[2]=mi.2.1 ; future year matrix

IF (YRDIFF<>0)
  MW[11]=(MW[2]-MW[1])/YRDIFF
ENDIF

MW[11]=MW[1]+@YRDIFF_F@*MW[11]

ENDRUN


