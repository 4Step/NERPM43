; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; Run TAREPORT

copy,
 FILE = "C:\NERPM43\APPLICATIONS\TAREPORT.CTL"
; TAREPORT program files
a    {YEAR}{ALT}
p    {SCENARIO_DIR}\output\BRTLEGSPK.DBF
o    {SCENARIO_DIR}\output\BRTLEGSOP.DBF
endcopy

*TAREPORT.exe
*copy tasum_{alt}{year}.prn {SCENARIO_DIR}\output\BRTsum_{alt}{year}.prn
*move tasroute_{alt}{year}.prn {SCENARIO_DIR}\output\BRTroute_{alt}{year}.prn
