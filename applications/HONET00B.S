; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="G:\D2\FDOT\NERPM4_HWY\APPLICATIONS\HONET00B.PRN" MSG='Rename Variables and Minor Calculations'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\HWYLOADED{alt}{year}.NET"
FILEO NETO = "{SCENARIO_DIR}\output\HWYLOADED{alt}{year}.NET",
 EXCLUDE=    V_1    TIME_1, ;    VC_1,
    CSPD_1    VDT_1    VHT_1    V1_1    V2_1    V3_1    V4_1    V5_1    V6_1,
    VT_1    V1T_1    V2T_1    V3T_1    V4T_1    V5T_1    V6T_1, 
    V7_1    V8_1    V9_1    V10_1    V11_1    V12_1,
    V7T_1    V8T_1    V9T_1    V10T_1    V11T_1    V12T_1 



VOLTOTAL{YEAR}{ALT}=V_1
VOLTRUCK{YEAR}{ALT}=V1_1+V4_1
VOLSOV{YEAR}{ALT}=V2_1+V5_1
VOLHOV{YEAR}{ALT}=V3_1+V6_1

SEL_VOLTOTAL{YEAR}{ALT}=V7_1+V8_1+V9_1+V10_1+V11_1+V12_1
SEL_VOLTRUCK{YEAR}{ALT}=V7_1+V10_1
SEL_VOLSOV{YEAR}{ALT}=V8_1+V11_1
SEL_VOLHOV{YEAR}{ALT}=V9_1+V12_1

CGSPEED{YEAR}{ALT}=CSPD_1
VMT{YEAR}{ALT}=VDT_1
;CGTIME{YEAR}{ALT}=60*DISTANCE/CGSPEED{YEAR}{ALT}

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (CGSPEED{YEAR}{ALT}>0)
   CGTIME{YEAR}{ALT}=60*(DISTANCEFT/5280)/CGSPEED{YEAR}{ALT}
 else 
   CGTIME{YEAR}{ALT}=60*(DISTANCEFT/5280)/(CGSPEED{YEAR}{ALT}+0.01)
   FlagCGSPDZero=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
if ('{Year}'='05')
   if (Li.1.Count>0)
      VOLCNTRTO= V_1/LI.1.COUNT
     else
      VOLCNTRTO=0.0
   endif 
endif

if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  VOLCAPRTO=(V_1*LI.1.CONFAC)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  VOLCAPRTO=9999.0
endif



ENDRUN
