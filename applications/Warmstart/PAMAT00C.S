; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{Scenario_Dir}\output\PAMAT00B.PRN" MSG='Use pk-hour factors to get the peak hour trip table'
FILEI MATI[2] = "{Scenario_Dir}\output\PORT_TRK_24H_{Year}.MAT"
FILEI MATI[1] = "{Scenario_Dir}\Output\PKPRELOAD1.MAT"
FILEO MATO[1] = "{SCENARIO_DIR}\output\PKPRELOAD.MAT",
 MO=1-8,NAME=SOV,CARPOOL,IEEITRK,EETRUCKS,EESOV,EEHOV,PRTTRK,TotAM2HR, DEC=8*S

PAR ZONEMSG=100

pahbwpkfac = 0.45299   ; 2000 HH survey
pahbnwpkfac= 0.25757   ; 2000 HH survey
panhbpkfac = 0.036640  ; 2000 HH survey
aphbwpkfac = 0.02367   ; 2000 HH survey
aphbnwpkfac= 0.03536   ; 2000 HH survey
apnhbpkfac = 0.036640  ; 2000 HH survey
iepkfac    = 0.1537    ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
eepkfac    = 0.136     ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
trkpkfac   = 0.20      ; from FDOT_BC353_08rpt.pdf - Time of day modeling procedure in FSUTMS
prttrkfac  = 0.05431*2


;SOV & SOVIE
MW[01]=(pahbwpkfac * MI.1.1 + aphbwpkfac * MI.1.1.T) * 0.5 +
       (pahbnwpkfac * MI.1.2 + aphbnwpkfac * MI.1.2.T) * 0.5 +
       (panhbpkfac * MI.1.3 + apnhbpkfac * MI.1.3.T) * 0.5 +
       (iepkfac * MI.1.4 + iepkfac * MI.1.4.T) * 0.5
;CARPOOL
MW[02]=(pahbwpkfac * MI.1.5 + aphbwpkfac * MI.1.5.T) * 0.5 /2 +
       (pahbnwpkfac * MI.1.6 + aphbnwpkfac * MI.1.6.T) * 0.5 /2 +
       (panhbpkfac * MI.1.7 + apnhbpkfac * MI.1.7.T) * 0.5 /2 +
       (pahbwpkfac * MI.1.8 + aphbwpkfac * MI.1.8.T) * 0.5 /{OC3VHBW} +
       (pahbnwpkfac * MI.1.9 + aphbnwpkfac * MI.1.9.T) * 0.5 /{OC3VHBNW} +
       (panhbpkfac * MI.1.10 + apnhbpkfac * MI.1.10.T) * 0.5 /{OC3VNHB} +
       (iepkfac * MI.1.12 + iepkfac * MI.1.12.T) * 0.5

;IE/EE TRUCK
MW[03]=(trkpkfac * MI.1.14 + trkpkfac * MI.1.14.T) * 0.5

;EETRUCKS
MW[04]=(trkpkfac * MI.1.15 + trkpkfac * MI.1.15.T) * 0.5
;EESOV
MW[05]=(eepkfac * MI.1.11 + eepkfac * MI.1.11.T) * 0.5
;EEHOV
MW[06]=(eepkfac * MI.1.13 + eepkfac * MI.1.13.T) * 0.5

;Jax Port Trucks
MW[07]=MI.2.1*prttrkfac

;Total Trips
MW[8]=MW[1]+MW[2]+MW[3]+MW[4]+MW[5]+MW[6]+MW[7]


ENDRUN
