; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*echo  Trip Generation Complete          = %date%  %time% >>{SCENARIO_DIR}\Output\runtime.prn
PRINT LIST="Trip Generation Complete", PRINTO=0
SLEEP TIME = 5
