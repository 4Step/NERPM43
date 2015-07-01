; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HONET00C.PRN" MSG='Rename Variables and Minor Calculations'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\HWYLOADED{alt}{year}.NET"
FILEO NETO = "{SCENARIO_DIR}\Output\HWYLOADED.NET",
EXCLUDE=    V_1    TIME_1,     VC_1,
    CSPD_1    VDT_1    VHT_1    V1_1    V2_1    V3_1    V4_1    V5_1    V6_1     V7_1,
    VT_1    V1T_1    V2T_1    V3T_1    V4T_1    V5T_1    V6T_1    V7T_1, 
    V8_1    V9_1    V10_1    V11_1    V12_1    V13_1    V14_1,
    V8T_1    V9T_1    V10T_1    V11T_1    V12T_1    V13T_1    V14T_1 

VOLTOT_HO_{YEAR}{ALT}=V_1                      ;Total
VOLSOV_HO_{YEAR}{ALT}=V1_1+V5_1                ;DA-II&IE+EE 
VOLHOV_HO_{YEAR}{ALT}=V2_1+V6_1                ;SR-II&IE+EE
VOLTRK_HO_{YEAR}{ALT}=V3_1+V4_1+V7_1           ;Truck-II&IE+EE+Port
VOLPTRK_HO_{YEAR}{ALT}=V7_1                    ;Port-Truck
VOLEXT_HO_{YEAR}{ALT}=V4_1+V5_1+V6_1           ;EXT-TRK+DA+SR (Does not include ext-ext of Port Truck) 


SEL_VTOT_HO_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V12_1+V13_1+V14_1   ;Selected Total
SEL_VSOV_HO_{YEAR}{ALT}=V8_1+V12_1                                ;Selected DA-II&IE+EE
SEL_VHOV_HO_{YEAR}{ALT}=V9_1+V13_1                                ;Selected SR-II&IE+EE
SEL_VTRK_HO_{YEAR}{ALT}=V10_1+V11_1+V14_1                         ;Selected Truck-II&IE+EE+Port
SEL_VOLPTRK_HO_{YEAR}{ALT}=V14_1                                  ;Selected Port-Truck
SEL_VOLEXT_HO_{YEAR}{ALT}=V11_1+V12_1+V13_1                       ;EXT-TRK+DA+SR (Does not include ext-ext of Port Truck) 

CGSPEED_HO_{YEAR}{ALT}=CSPD_1
VMT_HO_{YEAR}{ALT}=VDT_1
VHT_HO_{YEAR}{ALT}=VHT_1

;CGTIME{YEAR}{ALT}=60*DISTANCE/CGSPEED{YEAR}{ALT}

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (CGSPEED_HO_{YEAR}{ALT}>0)
   CGTIME_HO_{YEAR}{ALT}=60*(DISTANCEFT/5280)/CGSPEED_HO_{YEAR}{ALT}
 else 
   CGTIME_HO_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(CGSPEED_HO_{YEAR}{ALT}+0.01)
   FlgCGSPDZero_HO=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
if ('{Year}'='05')
   if (Li.1.Count>0)
      VOLCNTRTO_HO= V_1/LI.1.COUNT
     else
      VOLCNTRTO_HO=0.0
   endif 
endif

if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  VOLCAPRTO_HO=(V_1*LI.1.CONFAC)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  VOLCAPRTO_HO=9999.0
endif



ENDRUN
