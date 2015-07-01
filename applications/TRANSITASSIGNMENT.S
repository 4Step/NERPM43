LOOP per = 1, 1, 1

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

  LOOP Access = 2, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

        IF (ACCESS == 1)
            ACCESS_Name='Walk'
        ELSEIF (ACCESS == 2)
            ACCESS_NAME='PNR'
        ELSEIF (ACCESS == 3)
            ACCESS_NAME='KNR'
        ENDIF
; End of PILOT Script

; Script for program PUBLIC TRANSPORT in file "C:\NERPM43\APPLICATIONS\TAPTR00A.S"
;;<<Default Template>><<PUBLIC TRANSPORT>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT
FILEO STOP2STOPO[1] = "{SCENARIO_DIR}\output\STATION@PERIOD@_@ACCESS_NAME@.DBF",
ACCUMULATE=FIRSTLAST, NODES=1-99999
FILEO REPORTO = "{SCENARIO_DIR}\output\TLOAD@PERIOD@_@ACCESS_NAME@.RPT"
FILEO LINKO[1] = "{SCENARIO_DIR}\output\TLINK@PERIOD@_@ACCESS_NAME@.DBF",
NTLEGS=T, ONOFFS=T
FILEO NETO = "{SCENARIO_DIR}\output\TLOAD@PERIOD@_@ACCESS_NAME@.NET"

FILEO MATO[1] = "{SCENARIO_DIR}\output\LB_Xfers_@PERIOD@_@ACCESS_NAME@.MAT", MO = 1-9, DEC=9*d, NAME = CR_I_95, CR_ALL,  CR_WLK, CR_PNR, CR_KNR,CR_LB, CR_EB, CR_SKY, CR_BRT 
FILEO MATO[2] = "{SCENARIO_DIR}\output\EB_Xfers_@PERIOD@_@ACCESS_NAME@.MAT",MO = 1-9, DEC=9*d, NAME = CR_I_95,CR_ALL,  CR_WLK, CR_PNR, CR_KNR,CR_LB, CR_EB, CR_SKY, CR_BRT 
FILEO MATO[3] = "{SCENARIO_DIR}\output\SKY_Xfers_@PERIOD@_@ACCESS_NAME@.MAT", MO = 1-9,  NAME = CR_I_95, CR_ALL,  CR_WLK, CR_PNR, CR_KNR,CR_LB, CR_EB, CR_SKY, CR_BRT 
FILEO MATO[4] = "{SCENARIO_DIR}\output\BRT_Xfers_@PERIOD@_@ACCESS_NAME@.MAT", MO = 1-9,  NAME = CR_I_95, CR_ALL, CR_WLK, CR_PNR, CR_KNR,CR_LB, CR_EB, CR_SKY, CR_BRT 
FILEO MATO[5] = "{SCENARIO_DIR}\output\CR_Xfers_@PERIOD@_@ACCESS_NAME@.MAT", MO = 1-9, DEC=9*d,  NAME = CR_I_95, CR_ALL, CR_WLK, CR_PNR, CR_KNR, CR_LB, CR_EB, CR_SKY, CR_BRT 

FILEI NETI = "{SCENARIO_DIR}\output\Transit@PERIOD@_@Access_Name@.NET"
FILEI MATI[1] = "{SCENARIO_DIR}\output\tload_@period@_@ACCESS_Name@.mat"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_COMRAIL_@ACCESS_Name@_{Alt}{year}.RTE"
FILEI ROUTEI[4] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_BRTLRT_@ACCESS_Name@_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_EXPRESS_@ACCESS_Name@_{Alt}{year}.RTE"
FILEI ROUTEI[2] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_LOCAL_@ACCESS_Name@_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATH_@PERIOD@_SKYWAY_@ACCESS_Name@_{Alt}{year}.RTE"

            ; OVERALL PARAMETERS OF RUN
            PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999, USERCLASSES=1-5, HDWAYPERIOD=1,
                TRIPSIJ[1]=MI.1.1,
                TRIPSIJ[2]=MI.1.2,
                TRIPSIJ[3]=MI.1.3,
                TRIPSIJ[4]=MI.1.4,
                TRIPSIJ[5]=MI.1.5
            REPORT LINES=T, LINEVOLS=T, STOPSONLY = T

PHASE=SKIMIJ
  MW[1]=SELECTLINK(LINE="CR SE-Rail_I95 SB", "CR SE-Rail_I95 NB")
  MW[2]=SELECTLINK(LINE="CR SE-Rail_I95 SB", "CR SE-Rail_I95 NB", "CR N-Rail NB", "CR N-Rail SB", "CR SW-Rail SB", "CR SW-Rail NB")
  MW[3]=SELECTLINK(MODE=1)                ; All CR trips
  ; MW[3]=SELECTLINK((MODE=26 + MODE=1) & !(MODE = 21, 22, 23, 24))       ; CR trips with walk access (xfer)
  MW[4]=SELECTLINK(MODE=2)       ; CR trips with PNR access (xfer)
  MW[5]=SELECTLINK(MODE=26 & MODE=1,3 & MODE != 21 & MODE != 22 & MODE !=24 & MODE!= 23)       ; CR trips with KNR access (xfer)
  MW[6]=SELECTLINK(MODE=21)      ; CR trips with local bus (xfer)
  MW[7]=SELECTLINK(MODE=22)      ; CR trips with express bus (xfer)
  MW[8]=SELECTLINK(MODE=26 && MODE=23)      ; CR trips with skyway(xfer)
  MW[9]=SELECTLINK(MODE=26 && MODE=24)      ; CR trips with BRT (xfer)
   
ENDPHASE
            
ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; End of PILOT Script

  ENDLOOP

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; End of PILOT Script

ENDLOOP

