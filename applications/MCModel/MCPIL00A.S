; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*echo  Mode Choice                       = %date%  %time% >>{SCENARIO_DIR}\Output\runtime.prn
PRINT LIST="Feedback Loop Mode Choice", printo=0
SLEEP TIME = 5
