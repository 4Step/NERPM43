; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\DTMAT00D.PRN" MSG='Finalizes Preload Tables - Original 24-Hour Preassignment'
FILEI MATI[1] = "{SCENARIO_DIR}\output\PRELOAD1.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PRELOAD.MAT",
 MO=1-6,NAME=IEEITRK,SOV,CARPOOL,EETRUCKS,EESOV,EEHOV, DEC=6*s

PAR ZONEMSG=100

;IE/EE TRUCK
MW[01]=(MI.1.9+MI.1.9.T)*0.5
;SOV & SOVIE
MW[02]=(MI.1.1+MI.1.1.T)*0.5
;CARPOOL
MW[03]=(MI.1.2+MI.1.2.T)*0.25+
       (MI.1.3+MI.1.3.T)/{OC3VHBW}/2+
       (MI.1.4+MI.1.4.T)/{OC3VHBNW}/2+
       (MI.1.5+MI.1.5.T)/{OC3VNHB}/2+
       (MI.1.7+MI.1.7.T)*0.5
;EETRUCKS
MW[04]=(MI.1.10+MI.1.10.T)*0.5
;EESOV
MW[05]=(MI.1.6+MI.1.6.T)*0.5
;EEHOV
MW[06]=(MI.1.8+MI.1.8.T)*0.5

ENDRUN
