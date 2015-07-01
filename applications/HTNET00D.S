; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00D.PRN" MSG='Night Period - Rename Loaded Netw Attributes & Minor Calc'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\FINAL_ASGN_NT.NET"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_NT_Period.NET",
 EXCLUDE=TIME_1 VC_1, CSPD_1 VDT_1 VHT_1,
          V_1 V1_1 V2_1 V3_1 V4_1 V5_1 V6_1 V7_1 V8_1 V9_1 V10_1 V11_1 V12_1 V13_1 V14_1 V15_1,
          VT_1 V1T_1 V2T_1 V3T_1 V4T_1 V5T_1 V6T_1 V7T_1 V8T_1 V9T_1 V10T_1 V11T_1 V12T_1 V13T_1 V14T_1 V15T_1
         
NT_VL_TOT_{YEAR}{ALT}=V_1                   ;Total

NT_VL_DA_{YEAR}{ALT}=V1_1+V3_1+V9_1+V13_1   ;DA-Free&Toll-II&IE+EE 
NT_F_DA_{YEAR}{ALT}=V1_1                    ;DA-II&IE-Free
NT_T_DA_{YEAR}{ALT}=V3_1                    ;DA-II&IE-Toll
NT_F_EDA_{YEAR}{ALT}=V9_1                   ;DA-EE-Free
NT_T_EDA_{YEAR}{ALT}=V13_1                  ;DA-EE-Toll

NT_VL_SR2_{YEAR}{ALT}=V2_1+V4_1+V10_1+V14_1 ;SR2-Free&Toll-II&IE+EE 
NT_F_SR2_{YEAR}{ALT}=V2_1                   ;SR2-II&IE-Free
NT_T_SR2_{YEAR}{ALT}=V4_1                   ;SR2-II&IE-Toll
NT_F_ESR2_{YEAR}{ALT}=V10_1                 ;SR2-EE-Free
NT_T_ESR2_{YEAR}{ALT}=V14_1                 ;SR2-EE-Toll

NT_VL_SR3_{YEAR}{ALT}=V5_1+V6_1+V11_1+V15_1 ;SR3-Free&Toll-II&IE+EE 
NT_F_SR3_{YEAR}{ALT}=V5_1                   ;SR3-II&IE-Free
NT_T_SR3_{YEAR}{ALT}=V6_1                   ;SR3-II&IE-Toll
NT_F_ESR3_{YEAR}{ALT}=V11_1                 ;SR3-EE-Free
NT_T_ESR3_{YEAR}{ALT}=V15_1                 ;SR3-EE-Toll

NT_VL_Trk_{YEAR}{ALT}=V7_1+V8_1+V12_1       ;Truck-II&IE+EE+Port
NT_VL_PrtTk_{YEAR}{ALT}=V12_1               ;Port-Truck

NT_VL_EXT_{YEAR}{ALT}=V8_1+V9_1+V10_1+V11_1+V13_1+V14_1+V15_1 ;EXT-TRK + EE-Free&Toll(DA+SR2+SR3) -Note:Does not include ext-ext of Port Truck

NT_CGSPEED_{YEAR}{ALT}=CSPD_1
NT_VMT_{YEAR}{ALT}=VDT_1
NT_VHT_{YEAR}{ALT}=VHT_1

;sks -8/22/08 - Remove computation errors for ZERO congested speed and Flag the link.
if (NT_CGSPEED_{YEAR}{ALT}>0)
   NT_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/NT_CGSPEED_{YEAR}{ALT}
 else 
   NT_CGTIME_{YEAR}{ALT}=60*(DISTANCEFT/5280)/(NT_CGSPEED_{YEAR}{ALT}+0.01)
   NT_FlgCGSPDZero=1
endif

;sks -8/22/08 - For link with year 2005 traffic counts.
;if ('{Year}'='05')
;   if (Li.1.Count>0)
;      VOLCNTRTO= V_1/LI.1.COUNT
;     else
;      VOLCNTRTO=0.0
;   endif 
;endif


if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  NT_VCcapRTO_{YEAR}{ALT}=(V_1*LI.1.CONFACNTP)/(LI.1.CAPACITY*LI.1.NUM_LANES)
 else
  NT_VCcapRTO_{YEAR}{ALT}=9999.0
endif



ENDRUN
