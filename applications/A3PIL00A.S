; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*REM -- Copy required Input files of HEVAL/RMSE routines to Cube Folder...
*copy /a {SCENARIO_DIR}\output\PROFILE_NERPM4_Cnty3.TXT PROFILE.MAS
*copy /a {CATALOG_DIR}\parameters\HESCREEN.SYN HESCREEN.SYN
*copy /a {CATALOG_DIR}\parameters\HELABELS.SYN HELABELS.SYN
*copy /a {CATALOG_DIR}\parameters\HERATES.SYN HERATES.SYN
*copy /a {CATALOG_DIR}\parameters\DATABASE.CTL DATABASE.CTL
*copy /b "{SCENARIO_DIR}\output\LinksCnt_Cnty3.DBF" LnksCnt.DBF

*REM -- Clean the Cube Folder of HEVAL/RMSE outputs from any previous run (if any)...
*if exist HEVAL.OUT del HEVAL.OUT
*if exist RMSE.OUT del RMSE.OUT
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC.ASC del HRLDXY2.ASC

*REM -- Run HEVAL/RMSE Routines...
*{CATALOG_DIR}\User.prg\hevaldbf.exe >{SCENARIO_DIR}\output\hevaldbf.LOG
if ('{ANALYSIS}'='YES') GOTO SKPN43
*{CATALOG_DIR}\User.prg\rmsedbf.exe >{SCENARIO_DIR}\output\rmsedbf.LOG
:SKPN43

*REM -- Save HEVAL/RMSE outputs from Cube folder to user's output folder...
*if exist HEVAL.OUT copy /a heval.out {SCENARIO_DIR}\output\heval-24H-N4-StJohns.out
*if exist RMSE.OUT copy /a rmse.out {SCENARIO_DIR}\output\rmse-24H-N4-StJohns.out
*if exist SCRNLINE.ASC copy /a SCRNLINE.ASC {SCENARIO_DIR}\output\SCRNLINE-24H-N4-StJohns.out

*REM -- Delete HEVAL/RMSE outputs from Cube folder...
*if exist HEVAL.OUT del heval.out
*if exist RMSE.OUT del rmse.out
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC del HRLDXY2.ASC

*REM -- Clean Cube folder of HEVAL/RMSE routines' Inputs...
*if exist PROFILE.MAS del PROFILE.MAS
*if exist HESCREEN.SYN del HESCREEN.SYN
*if exist HELABELS.SYN del HELABELS.SYN
*if exist HERATES.SYN del HERATES.SYN
*if exist DATABASE.CTL del DATABASE.CTL
*if exist LnksCnt.DBF del LnksCnt.DBF

