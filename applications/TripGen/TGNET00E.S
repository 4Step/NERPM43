; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{CATALOG_DIR}\APPLICATIONS\TGNET00A.PRN" MSG='Floating Zone Mixed Density'
FILEI LOOKUPI[1] = "{Scenario_Dir}\Input\TRIPGEN\MixedDensity.csv"
FILEI LINKI[1] = "{SCENARIO_DIR}\OUTPUT\UNLOADED.NET"
FILEI NODEI[2] = "{Scenario_Dir}\Input\TRIPGEN\ZDATA_10A.dbf",
 RENAME=Zone-N
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\Float_ZnData.csv"


LOOKUP, NAME=MDM, LOOKUP[1]=1, RESULT=2, INTERPOLATE=N, LIST=Y, LOOKUPI=1

PROCESS  PHASE=INPUT

    ARRAY _CentNum={zonesi},
        _CentX={zonesi},
        _CentY={zonesi},
        _ResHhld={zonesi},
        _TotEmp={zonesi},
        _FloatResHhld={zonesi},
        _FloatEmp={zonesi},
        _MixedDen={zonesi}

ENDPROCESS


PROCESS  PHASE=NODEMERGE  

    IF (N<={zonesi})
      
    _cnt=_cnt+1
        _FloatResHhld[_cnt]=0
        _FloatEmp[_cnt]=0
        _CentX[_cnt]=X
        _CentY[_cnt]=Y
        _ResHhld[_cnt]=RESDHHLD
        _TotEmp[_cnt]=TOT_EMP
        _regionEmp = _regionEmp + TOT_EMP
        _regionHHs = _regionHHs + RESDHHLD

  ENDIF
ENDPROCESS




PROCESS  PHASE=LINKMERGE  

    _linkcnt=_linkcnt+1
  
    ; Find zones within the half-mile buffer, accumulate count of households and employment, and
  ; then compute the mixed density for the zone
  
    IF (_linkcnt=1)

        LOOP _iTAZ=1,{zonesi}

         LOOP _jTAZ=1,{zonesi}

           ; Calculate the distance between the subject TAZ and the other TAZs
                    _dist=SQRT((_CentX[_iTAZ]-_CentX[_jTAZ])^2 +(_CentY[_iTAZ]-_CentY[_jTAZ])^2)
            
                    IF (_dist <= {UNITS}/2)  ; distance <= 0.5 mile
                 
                        ;Keep a tally of floating zone resident households 
                        _FloatResHhld[_iTAZ]=_FloatResHhld[_iTAZ]+_ResHhld[_jTAZ]
 ;                       _FloatResHhld[_TAZ]=_tmphhld

                        ;Keep a tally of floating zone employment 
                        _FloatEmp[_iTAZ]=_FloatEmp[_iTAZ]+_TotEmp[_jTAZ]
;                        _FloatEmp[_TAZ]=_tmpemp
                        
                    ENDIF   
       ENDLOOP   ; end jTAZ loop

             ; Calculate mixed density

           IF(_FloatResHhld[_iTAZ] == 0.0 || _FloatEmp[_iTAZ] == 0.0)
                _MixedDen[_iTAZ] = -5
      ELSE
                _MixedDen[_iTAZ] = MDM(1,_iTAZ)
           ENDIF

             ; Write to output file

           IF (_iTAZ==1) PRINT CSV=T LIST='TAZ','Households','Tot_Emp','FloatHHlds','FloatEmp','Mixed_Density','CentX','CentY', PRINTO=1
             PRINT CSV=T LIST=_iTAZ(5),_ResHhld[_iTAZ](7),_TotEmp[_iTAZ](7),_FloatResHHld[_iTAZ](7),_FloatEmp[_iTAZ](7),_MixedDen[_iTAZ](7.6),_CentX[_iTAZ],_CentY[_iTAZ], PRINTO=1
       
    ENDLOOP
    ENDIF

  ENDPROCESS


ENDRUN
