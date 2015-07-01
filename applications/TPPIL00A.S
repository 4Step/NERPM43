; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

IF (ACCESS == 1)
    ACCESS_NAME='Walk'
    DELACCMODE='2,3,4,5,6'
    DELEGRMODE='2,3,4,5,6'
    MAXIMUMXFER=2
    RECOSTMAX2=250.0
ELSEIF (ACCESS == 2)
    ACCESS_NAME='PNR'
    DELACCMODE='1,3,4,5,6'
    DELEGRMODE='2,3,4,5,6'
    MAXIMUMXFER=2
    RECOSTMAX2=250.0
ELSEIF (ACCESS == 3)
    ACCESS_NAME='KNR'
    DELACCMODE='1,2,4,5,6'
    DELEGRMODE='2,3,4,5,6'
    MAXIMUMXFER=2
    RECOSTMAX2=250.0
ENDIF

