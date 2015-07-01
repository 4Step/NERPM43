; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
IF (PER == 1)
    Period='PK'
    HWYNET = 'PRELOAD_PT'
ELSEIF (PER == 2)
    Period='OP'
    HWYNET = 'UNLOADED_PT'
ENDIF

