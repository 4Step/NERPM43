; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\HTNET00E.PRN"
FILEO NETO = "{SCENARIO_DIR}\output\LOADED_CombinedPeriods.NET"
FILEI LINKI[4] = "{SCENARIO_DIR}\output\LOADED_NT_Period.NET"
FILEI LINKI[3] = "{SCENARIO_DIR}\output\LOADED_PM_Period.NET"
FILEI LINKI[2] = "{SCENARIO_DIR}\output\LOADED_MD_Period.NET"
FILEI LINKI[1] = "{SCENARIO_DIR}\output\LOADED_AM_Period.NET"

PROCESS  PHASE=INPUT
;Use this phase to modify data as it is read, such as recoding node numbers.


ENDPROCESS


PROCESS  PHASE=NODEMERGE  
; Use this phase to make computations and selections of any data on the NODEI files.


ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.


;Directional Attributes:
AL_VL_TOT_{YEAR}{ALT}  =LI.1.AM_VL_TOT_{YEAR}{ALT}  +LI.2.MD_VL_TOT_{YEAR}{ALT}  +LI.3.PM_VL_TOT_{YEAR}{ALT}  +LI.4.NT_VL_TOT_{YEAR}{ALT}

AL_VL_DA_{YEAR}{ALT}   =LI.1.AM_VL_DA_{YEAR}{ALT}   +LI.2.MD_VL_DA_{YEAR}{ALT}   +LI.3.PM_VL_DA_{YEAR}{ALT}   +LI.4.NT_VL_DA_{YEAR}{ALT}
AL_F_DA_{YEAR}{ALT}  =LI.1.AM_F_DA_{YEAR}{ALT}  +LI.2.MD_F_DA_{YEAR}{ALT}  +LI.3.PM_F_DA_{YEAR}{ALT}  +LI.4.NT_F_DA_{YEAR}{ALT}
AL_T_DA_{YEAR}{ALT}  =LI.1.AM_T_DA_{YEAR}{ALT}  +LI.2.MD_T_DA_{YEAR}{ALT}  +LI.3.PM_T_DA_{YEAR}{ALT}  +LI.4.NT_T_DA_{YEAR}{ALT}
AL_F_EDA_{YEAR}{ALT}  =LI.1.AM_F_EDA_{YEAR}{ALT}  +LI.2.MD_F_EDA_{YEAR}{ALT}  +LI.3.PM_F_EDA_{YEAR}{ALT}  +LI.4.NT_F_EDA_{YEAR}{ALT}
AL_T_EDA_{YEAR}{ALT}  =LI.1.AM_T_EDA_{YEAR}{ALT}  +LI.2.MD_T_EDA_{YEAR}{ALT}  +LI.3.PM_T_EDA_{YEAR}{ALT}  +LI.4.NT_T_EDA_{YEAR}{ALT}


AL_VL_SR2_{YEAR}{ALT}  =LI.1.AM_VL_SR2_{YEAR}{ALT}  +LI.2.MD_VL_SR2_{YEAR}{ALT}  +LI.3.PM_VL_SR2_{YEAR}{ALT}  +LI.4.NT_VL_SR2_{YEAR}{ALT}
AL_F_SR2_{YEAR}{ALT} =LI.1.AM_F_SR2_{YEAR}{ALT} +LI.2.MD_F_SR2_{YEAR}{ALT} +LI.3.PM_F_SR2_{YEAR}{ALT} +LI.4.NT_F_SR2_{YEAR}{ALT}
AL_T_SR2_{YEAR}{ALT} =LI.1.AM_T_SR2_{YEAR}{ALT} +LI.2.MD_T_SR2_{YEAR}{ALT} +LI.3.PM_T_SR2_{YEAR}{ALT} +LI.4.NT_T_SR2_{YEAR}{ALT}
AL_F_ESR2_{YEAR}{ALT}  =LI.1.AM_F_ESR2_{YEAR}{ALT}  +LI.2.MD_F_ESR2_{YEAR}{ALT}  +LI.3.PM_F_ESR2_{YEAR}{ALT}  +LI.4.NT_F_ESR2_{YEAR}{ALT}
AL_T_ESR2_{YEAR}{ALT}  =LI.1.AM_T_ESR2_{YEAR}{ALT}  +LI.2.MD_T_ESR2_{YEAR}{ALT}  +LI.3.PM_T_ESR2_{YEAR}{ALT}  +LI.4.NT_T_ESR2_{YEAR}{ALT}

AL_VL_SR3_{YEAR}{ALT}  =LI.1.AM_VL_SR3_{YEAR}{ALT}  +LI.2.MD_VL_SR3_{YEAR}{ALT}  +LI.3.PM_VL_SR3_{YEAR}{ALT}  +LI.4.NT_VL_SR3_{YEAR}{ALT}
AL_F_SR3_{YEAR}{ALT} =LI.1.AM_F_SR3_{YEAR}{ALT} +LI.2.MD_F_SR3_{YEAR}{ALT} +LI.3.PM_F_SR3_{YEAR}{ALT} +LI.4.NT_F_SR3_{YEAR}{ALT}
AL_T_SR3_{YEAR}{ALT} =LI.1.AM_T_SR3_{YEAR}{ALT} +LI.2.MD_T_SR3_{YEAR}{ALT} +LI.3.PM_T_SR3_{YEAR}{ALT} +LI.4.NT_T_SR3_{YEAR}{ALT}
AL_F_ESR3_{YEAR}{ALT}  =LI.1.AM_F_ESR3_{YEAR}{ALT}  +LI.2.MD_F_ESR3_{YEAR}{ALT}  +LI.3.PM_F_ESR3_{YEAR}{ALT}  +LI.4.NT_F_ESR3_{YEAR}{ALT}
AL_T_ESR3_{YEAR}{ALT}  =LI.1.AM_T_ESR3_{YEAR}{ALT}  +LI.2.MD_T_ESR3_{YEAR}{ALT}  +LI.3.PM_T_ESR3_{YEAR}{ALT}  +LI.4.NT_T_ESR3_{YEAR}{ALT}

AL_VL_Trk_{YEAR}{ALT}  =LI.1.AM_VL_Trk_{YEAR}{ALT}  +LI.2.MD_VL_Trk_{YEAR}{ALT}  +LI.3.PM_VL_Trk_{YEAR}{ALT}  +LI.4.NT_VL_Trk_{YEAR}{ALT}
AL_VL_PrtTk_{YEAR}{ALT}=LI.1.AM_VL_PrtTk_{YEAR}{ALT}+LI.2.MD_VL_PrtTk_{YEAR}{ALT}+LI.3.PM_VL_PrtTk_{YEAR}{ALT}+LI.4.NT_VL_PrtTk_{YEAR}{ALT}

AL_VL_EXT_{YEAR}{ALT}  =LI.1.AM_VL_EXT_{YEAR}{ALT}  +LI.2.MD_VL_EXT_{YEAR}{ALT}  +LI.3.PM_VL_EXT_{YEAR}{ALT}  +LI.4.NT_VL_EXT_{YEAR}{ALT}

AL_VMT_{YEAR}{ALT}   =LI.1.AM_VMT_{YEAR}{ALT}   +LI.2.MD_VMT_{YEAR}{ALT}   +LI.3.PM_VMT_{YEAR}{ALT}   +LI.4.NT_VMT_{YEAR}{ALT}
AL_VHT_{YEAR}{ALT}   =LI.1.AM_VHT_{YEAR}{ALT}   +LI.2.MD_VHT_{YEAR}{ALT}   +LI.3.PM_VHT_{YEAR}{ALT}   +LI.4.NT_VHT_{YEAR}{ALT}

;Calulate All day Congested time and Speed based on summation of period VMT & VHT (SKS-10/12/2006):

if (AL_VMT_{YEAR}{ALT}>0)
  AL_CGTIME_{YEAR}{ALT}=60*(AL_VHT_{YEAR}{ALT}*LI.1.DISTANCEFT/5280)/AL_VMT_{YEAR}{ALT}           ;in minutes
 else
 
;   _FracAMVMT=LI.1.AM_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;   _FracMDVMT=LI.2.MD_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;   _FracPMVMT=LI.3.PM_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;   _FracNTVMT=LI.4.NT_VMT_{YEAR}{ALT}/AL_VMT_{YEAR}{ALT}
;  AL_CGTIME_{YEAR}{ALT}=((LI.1.AM_CGTIME_{YEAR}{ALT}*_FracAMVMT) + (LI.2.MD_CGTIME_{YEAR}{ALT}*_FracMDVMT)+
;                         (LI.3.PM_CGTIME_{YEAR}{ALT}*_FracPMVMT) + (LI.4.NT_CGTIME_{YEAR}{ALT}*_FracNTVMT))
  AL_CGTIME_{YEAR}{ALT}=((LI.1.AM_CGTIME_{YEAR}{ALT}*0.17) + (LI.2.MD_CGTIME_{YEAR}{ALT}*0.31)+
                         (LI.3.PM_CGTIME_{YEAR}{ALT}*0.25) + (LI.4.NT_CGTIME_{YEAR}{ALT}*0.27))+0.0001


endif

AL_CGSPEED_{YEAR}{ALT}=((LI.1.DISTANCEFT/5280)/AL_CGTIME_{YEAR}{ALT})*60


;sks -8/22/08 - For link with year 2005 traffic counts.
if ('{Year}'='05')
   if (Li.1.Count>0)
      AL_VOLCNTRTO= AL_VL_TOT_{YEAR}{ALT}/LI.1.COUNT
     else
      AL_VOLCNTRTO=0.0
   endif 
endif

;An Estimated All Day Volume/Capacity Ratio...
if (LI.1.CAPACITY>0 & LI.1.NUM_LANES>0)
  AL_VCcapRTO_{YEAR}{ALT}=(AL_VL_TOT_{YEAR}{ALT}*LI.1.CONFAC)/(LI.1.CAPACITY*LI.1.NUM_LANES)  ;(An Esimated) Directional Volume/Capacity Ratio
                                                                                              ;CONFAC represnts 24-Hour Condition
 else
  AL_VCcapRTO_{YEAR}{ALT}=9999.0
endif


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS

ENDRUN
