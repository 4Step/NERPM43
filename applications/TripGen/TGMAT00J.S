*del *.prj
*del *.var

; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

RUN PGM=MATRIX PRNFILE="{Scenario_Dir}\OUTPUT\TGMAT00J.PRN" MSG='Transit and Walk Accessibility'
FILEO PRINTO[1] = "{Scenario_Dir}\OUTPUT\AccCalcsDebug.TXT"

FILEO RECO[1] = "{Scenario_Dir}\OUTPUT\WalkTranAcc.dbf",
 FIELDS=TAZ(4.0),Trn_Acc(8.4),Aut_Acc(8.4),Wlk_Acc(8.4),Comp_Acc(8.4)



;Floating Zones Data
FILEI ZDATI[1] = "{Scenario_Dir}\OUTPUT\Float_ZnData.csv",
   Z=#1,TotHhlds=#2,TotEmp=#3,FloatHhld=#4,FloatEmp=#5,MixedDen=#6,CentX=#7,CentY=#8

;Congested Highway Skim
FILEI MATI[4] = "{Scenario_Dir}\OUTPUT\PRELSKIMS.MAT"

;Walk to transit skim
FILEI MATI[2] = "{Scenario_Dir}\OUTPUT\TSKIM_PK_LOCAL_Walk_{alt}{year}.MAT"

; ----------------------------------------------------------------------------------

ZONES=2494
ZONEMSG=10


; ----------------------------------------------------------------------------------

; READ IN INPUT DATA

; Walk to Transit Time

MW[1] = MI.2.4 + MI.2.5 + MI.2.6 + MI.2.7 + MI.2.8 + MI.2.9 + MI.2.10      ; in-vehicle time
MW[2] = MI.2.1 + MI.2.3 + MI.2.12 + MI.2.13                                ; out-of-vehicle time

; Auto Time
MW[9] = MI.4.3                                                            ; SOV Time

; Walk Distance
MW[10] = MI.4.2                                                            ; SOV distance


; CALCULATE ACCESSIBILITIES

ARRAY TRNACC=2494, AUTACC=2494, WLKACC=2494

JLOOP

    ; transit accessibility -- include only if there's a valid transit path
  IF(MW[1] > 0.0)  TRNACC[I] = TRNACC[I] + EXP(-0.025 * (MW[1] + 2*MW[2])) * ZI.1.TotEmp[J]

    ; Auto accessibility -- include only if there's a valid Auto path
  IF(MW[9] > 0.0)  AUTACC[I] = AUTACC[I] + EXP(-0.025 * (MW[9])) * ZI.1.TotEmp[J]

  ; walk accessibility
  WLKACC[I] = WLKACC[I] + EXP(-2.0 * MW[10]) * ZI.1.TotEmp[J]
  
  ; now some debugging
  
  IF(I == 3)
  
    IF(J==1) PRINT LIST = 'Transit Accessibility Calculations for Zone = ', I(5), printo=1
    IF(J==1) PRINT LIST = '\n JZone   TranIVTime    TranOVTime    SovTime   WalkDist     Employment', printo=1
    PRINT LIST = J(5), MW[1](10.2), '     ', MW[2](10.2), '     ', MW[9](10.2), '     ', MW[10](10.2), '     ', ZI.1.TotEmp[J], printo=1

  ENDIF
ENDJLOOP


; WRITE OUTPUT FILE

RO.TAZ=I

IF(TRNACC[I] > 0.0)
   RO.TRN_ACC = LN(TRNACC[I])
ELSE
   RO.TRN_ACC = -9.9
ENDIF

IF(AUTACC[I] > 0.0)
   RO.AUT_ACC = LN(AUTACC[I])
ELSE
   RO.AUT_ACC = -9.9
ENDIF

IF(WLKACC[I] > 0.0)
   RO.WLK_ACC = LN(WLKACC[I])
ELSE
   RO.WLK_ACC = -9.9
ENDIF

RO.COMP_ACC = RO.TRN_ACC - RO.AUT_ACC


WRITE RECO=1

; DEBUG

IF(I == 3)

  PRINT LIST = '\n\nTransit Accessibility = ',RO.TRN_ACC(10.3), printo=1
  PRINT LIST = '\n\nAuto Accessibility = ',RO.AUT_ACC(10.3), printo=1
  PRINT LIST = '\n\nComposite Accessibility = ',RO.COMP_ACC(10.3), printo=1
 PRINT LIST = '\nWalk Accessibility    = ', RO.WLK_ACC(10.3), printo=1

ENDIF


ENDRUN