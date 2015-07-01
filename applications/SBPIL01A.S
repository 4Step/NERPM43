; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


*echo Date: %date% >"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Time: %time% >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo NERPM Model Run - {DESCR}>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo Input Directory {SCENARIO_DIR}\input >>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"
*echo ======================================================================================>>"{SCENARIO_DIR}\output\ModelRun_{alt}{year}.prn"

*del "{SCENARIO_DIR}\output\ModeDebugsb.TXT"
*del "{SCENARIO_DIR}\output\ModeSumsb.TXT"
*del "{SCENARIO_DIR}\output\modesharessb.csv"
*del "{SCENARIO_DIR}\output\CBDSHARESsb.CSV"

IF ({RunMSC}==1)
