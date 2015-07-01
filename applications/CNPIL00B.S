; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*AUTOCON.exe AM
*if exist "{SCENARIO_DIR}\output\AUTOCON.OUT" copy "{SCENARIO_DIR}\output\AUTOCON.OUT {SCENARIO_DIR}\output\AUTOCONPK.OUT"
*AUTOCON.exe MD
*if exist "{SCENARIO_DIR}\output\AUTOCON.OUT" copy "{SCENARIO_DIR}\output\AUTOCON.OUT {SCENARIO_DIR}\output\AUTOCONOP.OUT"
*if exist "{SCENARIO_DIR}\output\AUTOCON.OUT" del "{SCENARIO_DIR}\output\AUTOCON.OUT"


