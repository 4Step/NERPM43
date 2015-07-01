; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; Run TAREPORT

copy,
 FILE = "C:\NERPM43\APPLICATIONS\TAREPORT.CTL"
; TAREPORT program files
a    {YEAR}{ALT}
p    {SCENARIO_DIR}\output\TLOADPK_{ALT}{YEAR}.DBF
o    {SCENARIO_DIR}\output\TLOADOP_{ALT}{YEAR}.DBF
endcopy

*TAREPORT.exe
*move tasum_{alt}{year}.prn "{SCENARIO_DIR}\output\"
*move tasroute_{alt}{year}.prn "{SCENARIO_DIR}\output\"
