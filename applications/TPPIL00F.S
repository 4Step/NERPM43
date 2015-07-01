; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

IF (ACCESS == 1)
    ACCESS_NAME='Walk'
    ACCESS_MODE=0
    DELACCMODE='2'
ELSEIF (ACCESS == 2)
    ACCESS_NAME='Auto'
    ACCESS_MODE=1
    DELACCMODE='1,4,11,12'
ENDIF

