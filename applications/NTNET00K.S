; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00K.PRN" MSG='Write Class Link Counts'
FILEO PRINTO[1] = "{CATALOG_DIR}\ClassCounts.prn"
FILEI LINKI[1] = "C:\NERPM43\parameters\MicroCodedHnet42.net"
FILEO NETO = "{CATALOG_DIR}\ClsCountsNets_tem.net",
include=A,B,FTYPE_05A,ATYPE_05A,CLSCNT_NO,CLSCNTDESCRP,CLSCNTYEAR,
                  CLS_AM_ALLVEH,CLS_MD_ALLVEH,CLS_PM_ALLVEH,CLS_NT_ALLVEH,CLS_24H_ALLVEH,
                  CLS_AM_LRGVEH,CLS_MD_LRGVEH,CLS_PM_LRGVEH,CLS_NT_LRGVEH,CLS_24H_LRGVEH,    
                  CLS_AM_MEDVEH,CLS_MD_MEDVEH,CLS_PM_MEDVEH,CLS_NT_MEDVEH,CLS_24H_MEDVEH

   

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
 

;if (_CTR=0) print list='CTOLL = '(8.0C),CTOLL(5.3) PRINTO=1

;     if(_k=1) LIST="TD","LENGTH","FTC2","PTIME","TDSECFFS","AM_SPEED","PM_SPEED","OP_SPEED","OBS_AM_SPD,"OBS_PM_SPD","OBS_OP_SPD","AM_DIFF","%_AM_DIFF","PM_DIFF","%_PM_DIFF","OP_DIFF","%_OP_DIFF","\n",  PRINTO=3
       if(_k=0)
            PRINT CSV=T LIST="CLSCNT_NO","A","B","DISTANCE","FTYPE_05A","ATYPE_05A","CLSCNTDESCRP_C50","CLSCNTYEAR",
                                 "CLS_AM_ALLVEH","CLS_MD_ALLVEH","CLS_PM_ALLVEH","CLS_NT_ALLVEH","CLS_24H_ALLVEH",
                                 "CLS_AM_LRGVEH","CLS_MD_LRGVEH","CLS_PM_LRGVEH","CLS_NT_LRGVEH","CLS_24H_LRGVEH",    
                                 "CLS_AM_MEDVEH","CLS_MD_MEDVEH","CLS_PM_MEDVEH","CLS_NT_MEDVEH","CLS_24H_MEDVEH","CTR", PRINTO=1
           
       endif    

       if(A>0) _k=_k+1 

       if (CLSCNT_NO>0)
          _CTR=_CTR+1 
       
      

    
 PRINT CSV=T LIST=CLSCNT_NO(5.0),A(5.0),B(5.0),DISTANCE(10.2),FTYPE_05A(5.0),ATYPE_05A(5.0),CLSCNTDESCRP(50.0L),CLSCNTYEAR(5.0),
                  CLS_AM_ALLVEH(5.0),CLS_MD_ALLVEH(5.0),CLS_PM_ALLVEH(5.0),CLS_NT_ALLVEH(5.0),CLS_24H_ALLVEH(5.0),
                  CLS_AM_LRGVEH(5.0),CLS_MD_LRGVEH(5.0),CLS_PM_LRGVEH(5.0),CLS_NT_LRGVEH(5.0),CLS_24H_LRGVEH(5.0),    
                  CLS_AM_MEDVEH(5.0),CLS_MD_MEDVEH(5.0),CLS_PM_MEDVEH(5.0),CLS_NT_MEDVEH(5.0),CLS_24H_MEDVEH(5.0),_CTR(5.0) PRINTO=1


      ;       PRINT CSV=T list=_K(6.0),TDSECLEN[_k](6.2),FTCODE[_k],_PTIME[_K],_TDSECFFS[_k](6.2),_TDSECAMS[_k](6.2),_TDSECPMS[_k](6.2),_TDSECOPS[_k](6.2), _OBSAMSPD(6.2),_OBSPMSPD(6.2),_OBSOPSPD(6.2),_TDIFFAM[_k](6.2),_PDIFFAM[_k](6.2),_TDIFFPM[_k](6.2),_PDIFFPM[_k](6.2),_TDIFFOP[_k](6.2),_PDIFFOP[_k](6.2) PRINTO=2
       endif  


/*

if(WTOLL>0)
   _COUNT=_COUNT+1
    print list=WTOLL(2.0),TOLLTYPE(2.0),A(6.0),B(6.0),' ',PLAZADESC(25.0CB),' ',
               PLZALNSMIN(2.0),PLZALNSMAX(2.0),'  ',CARTOLL(5.2B),
               SVCMINUTES(2.0),':',CTEMP(2.0C),DECELCODE(2.0),ACCELCODE(2.0),
;               SVCMINUTES(2.0),':',SVCSECONDS(2.0),DECELCODE(2.0),ACCELCODE(2.0),
;               EXACTCHGLNS(3.0),AVILANES(3.0),PCTTRUCKS(5.2),_COUNT(4.0),_CTR2(4.0), PRINTO=1
               EXACTCHGLNS(3.0),AVILANES(3.0),PCTTRUCKS(5.2), LOCATION(20.0), SVCSECONDS(5.1) PRINTO=1

endif  

*/



ENDPROCESS


PROCESS  PHASE=SUMMARY   
; Use this phase for combining and reporting of working variables.


ENDPROCESS

ENDRUN
