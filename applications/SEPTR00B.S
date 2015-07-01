; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=PUBLIC TRANSPORT PRNFILE="{SCENARIO_DIR}\output\SEPTR00C.PRN" MSG='Perform OP selectlink truthtable'
FILEO REPORTO = "{SCENARIO_DIR}\output\SEPTR00D.PRN"
FILEO MATO[7] = "{SCENARIO_DIR}\output\SELLINKOP7_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*2
FILEO MATO[5] = "{SCENARIO_DIR}\output\SELLINKOP5_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*2
FILEO MATO[3] = "{SCENARIO_DIR}\output\SELLINKOP3_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*2
FILEO MATO[1] = "{SCENARIO_DIR}\output\SELLINKOP1_TMP.MAT",
 MO=1-@numBRTlinks._AK@,DEC=@numBRTlinks._AK@*2
FILEO NETO = "{SCENARIO_DIR}\output\SELLINKOP_TMP.NET"

FILEI ROUTEI[7] = "{SCENARIO_DIR}\output\TPATHOP7_{Alt}{year}.RTE"
FILEI ROUTEI[5] = "{SCENARIO_DIR}\output\TPATHOP5_{Alt}{year}.RTE"
FILEI ROUTEI[3] = "{SCENARIO_DIR}\output\TPATHOP3_{Alt}{year}.RTE"
FILEI ROUTEI[1] = "{SCENARIO_DIR}\output\TPATHOP1_{Alt}{year}.RTE"
FILEI NETI = "{SCENARIO_DIR}\output\TransitOP.NET"

PARAMETERS NOROUTEMSGS=0, NOROUTEERRS=9999999,USERCLASSES=1,3,5,7,HDWAYPERIOD=2,
    TRIPSIJ[1]=1,
    TRIPSIJ[2]=0,
    TRIPSIJ[3]=1,
    TRIPSIJ[4]=0,
    TRIPSIJ[5]=1,
    TRIPSIJ[6]=0,
    TRIPSIJ[7]=1,
    TRIPSIJ[8]=0

PHASE=SKIMIJ

if ({isFutureYearAlternative} == 1) then
 if ({ProjectModeFlag} == 1)
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS.TXT"
  READ, FILE = "{SCENARIO_DIR}\OUTPUT\BRTLINKS1.TXT"
 endif
else
  MW[1] = 0
endif


ENDPHASE

ENDRUN
