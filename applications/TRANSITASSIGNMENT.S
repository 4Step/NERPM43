LOOP per = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

    IF (PER == 1)
        Period='PK'
        HWYNET = 'PRELOAD_PT'
        perNum = 1
    ELSEIF (PER == 2)
        Period='OP'
        HWYNET = 'UNLOADED_PT'
        perNum = 2
    ENDIF

; End of PILOT Script

  LOOP Access_Name = 1, 3, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

        IF (ACCESS_NAME == 1)
            ACCESS='Walk'
        ELSEIF (ACCESS_NAME == 2)
            ACCESS='PNR'
        ELSEIF (ACCESS_NAME == 3)
            ACCESS='KNR'
        ENDIF
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\APPLICATIONS\TAPTR00A.S"
;;<<Default Template>><<PUBLIC TRANSPORT>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\STATION@PERIOD@_@ACCESS@.DBF",
 ACCUMULATE=FIRSTLAST, NODES=1-99999
FILEO REPORTO = "{SCENARIO_DIR}\output\TLOAD@PERIOD@_@ACCESS@.RPT"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\TLINK@PERIOD@_@ACCESS@.DBF",
NTLEGS=T, ONOFFS=T
FILEO NETO = "{SCENARIO_DIR}\output\TLOAD@PERIOD@_@ACCESS@.NET"
FILEI NETI = "{SCENARIO_DIR}\output\Transit@PERIOD@_@Access@.NET"
FILEI MATI[1] = "{SCENARIO_DIR}\output\tload_@period@_@ACCESS@.mat"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_COMRAIL_@ACCESS@_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_BRTLRT_@ACCESS@_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_EXPRESS_@ACCESS@_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_LOCAL_@ACCESS@_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_SKYWAY_@ACCESS@_{Alt}{year}.RTE"

            
            ; OVERALL PARAMETERS OF RUN
            PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999, USERCLASSES=1-5,HDWAYPERIOD=1, ;@PERNUM@,
                TRIPSIJ[1]=MI.1.1,
                TRIPSIJ[2]=MI.1.2,
                TRIPSIJ[3]=MI.1.3,
                TRIPSIJ[4]=MI.1.4,
                TRIPSIJ[5]=MI.1.5
            REPORT LINES=T, LINEVOLS=T

ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; End of PILOT Script

  ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; End of PILOT Script

ENDLOOP

