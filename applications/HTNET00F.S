; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\HTNET00F.PRN" MSG='Combine Class Counts to Base Loaded Network & Write ClsLnk Loads'
FILEO PRINTO[1] = "{CATALOG_DIR}\ClassCountsTODLoads.prn"
FILEI LINKI[2] = "C:\NERPM43_Delivered\ClsCountsNets_tem.net"
FILEI LINKI[1] = "C:\NERPM43_Delivered\Base2005\output\LOADED_CombinedPeriods.NET"
FILEO NETO = "C:\NERPM43_Delivered\LoadedBaseTODNetWithClsCnt.NET"

PROCESS  PHASE=INPUT
;Use this phase to modify data as it is read, such as recoding node numbers.


ENDPROCESS


PROCESS  PHASE=NODEMERGE  
; Use this phase to make computations and selections of any data on the NODEI files.


ENDPROCESS


PROCESS  PHASE=LINKMERGE  
; Use this phase to make computations and selections of any data on the LINKI files.

IF (CLSCNT_NO<1) DELETE

 FACILITY_TYPE=FTYPE_05A

 IF (FACILITY_TYPE=0) DELETE
 


;     if(_k=1) LIST="TD","LENGTH","FTC2","PTIME","TDSECFFS","AM_SPEED","PM_SPEED","OP_SPEED","OBS_AM_SPD,"OBS_PM_SPD","OBS_OP_SPD","AM_DIFF","%_AM_DIFF","PM_DIFF","%_PM_DIFF","OP_DIFF","%_OP_DIFF","\n",  PRINTO=3
       if(_k=0)
            PRINT CSV=T LIST="CLSCNT_NO","A","B",
            "AM_VL_TOT_05A","AM_VL_DA_05A","AM_VL_SR2_05A","AM_VL_SR3_05A","AM_VL_TRK_05A","AM_VL_PRTTK_05A", 
            "MD_VL_TOT_05A","MD_VL_DA_05A","MD_VL_SR2_05A","MD_VL_SR3_05A","MD_VL_TRK_05A","MD_VL_PRTTK_05A",
            "PM_VL_TOT_05A","PM_VL_DA_05A","PM_VL_SR2_05A","PM_VL_SR3_05A","PM_VL_TRK_05A","PM_VL_PRTTK_05A", 
            "NT_VL_TOT_05A","NT_VL_DA_05A","NT_VL_SR2_05A","NT_VL_SR3_05A","NT_VL_TRK_05A","NT_VL_PRTTK_05A",
            "AL_VL_TOT_05A","AL_VL_DA_05A","AL_VL_SR2_05A","AL_VL_SR3_05A","AL_VL_TRK_05A","AL_VL_PRTTK_05A", "CTR", PRINTO=1
           
       endif    

       if(A>0) _k=_k+1 

       if (CLSCNT_NO>0)
          _CTR=_CTR+1 
      
PRINT CSV=T LIST=CLSCNT_NO(5.0),A(5.0),B(5.0),
AM_VL_TOT_05A(5.0),AM_VL_DA_05A(5.0),AM_VL_SR2_05A(5.0),AM_VL_SR3_05A(5.0),AM_VL_TRK_05A(5.0),AM_VL_PRTTK_05A(5.0),
MD_VL_TOT_05A(5.0),MD_VL_DA_05A(5.0),MD_VL_SR2_05A(5.0),MD_VL_SR3_05A(5.0),MD_VL_TRK_05A(5.0),MD_VL_PRTTK_05A(5.0),
PM_VL_TOT_05A(5.0),PM_VL_DA_05A(5.0),PM_VL_SR2_05A(5.0),PM_VL_SR3_05A(5.0),PM_VL_TRK_05A(5.0),PM_VL_PRTTK_05A(5.0),
NT_VL_TOT_05A(5.0),NT_VL_DA_05A(5.0),NT_VL_SR2_05A(5.0),NT_VL_SR3_05A(5.0),NT_VL_TRK_05A(5.0),NT_VL_PRTTK_05A(5.0),
AL_VL_TOT_05A(5.0),AL_VL_DA_05A(5.0),AL_VL_SR2_05A(5.0),AL_VL_SR3_05A(5.0),AL_VL_TRK_05A(5.0),AL_VL_PRTTK_05A(5.0),_CTR(5.0) PRINTO=1

endif




/*

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

*/


ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS

ENDRUN
