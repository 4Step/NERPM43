; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\HOMAT00D.PRN" MSG='Highway Only Trip Table-Factoring and Adjustment'
FILEI MATI[4] = "{CATALOG_DIR}\\parameters\ORG_ALLVehicle_{alt}{year}.mat"
FILEI MATI[2] = "{CATALOG_DIR}\\parameters\HWYFACTOR_{alt}{year}.mat"
FILEO MATO[1] = "{SCENARIO_DIR}\output\HWYONLYTTAB_{alt}{year}.mat",
MO=51-58 Name=SOVIEII,HOVIEII,TRKIEII,TRKEE,SOVEE,HOVEE,PortTrk, Total, dec=8*d
FILEI MATI[3] = "{CATALOG_DIR}\\parameters\HWYTTAB_{alt}{year}.mat"
FILEI MATI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\HOMAT00B.MAT"


jloop
if (Mi.1.1=0); check if highway trip table is 0
  if (Mi.4.1=0); check if the original value is 0 to allow removing development
  MW[51]=mi.3.1; copy a value after mode choice step of highway trips to the highway only trip table
  else
  MW[51]=0; make it sensitive to have no trip scenario
  endif
else
  If (mi.2.1=0&mi.1.1>mi.4.1); if highway factor is 0 & new highway only trips are more than the  original
  MW[51]=mi.1.1*1; preserve the new demand 
  else
  MW[51]=mi.1.1*mi.2.1/10000 ; adjustment for transit trip
  endif
endif

if (Mi.1.2=0)
  if (Mi.4.2=0)
  MW[52]=mi.3.2
  else
  MW[52]=0
  endif
else
  If (mi.2.2=0&mi.1.2>mi.4.2)
  MW[52]=mi.1.2*1
  else
  MW[52]=mi.1.2*mi.2.2/10000
  endif
endif


if (mi.1.3=0)
  if (Mi.4.3=0)
  MW[53]=mi.3.3
  else
  MW[53]=0
  endif
else
  If (mi.2.3=0&mi.1.3>mi.4.3)
  MW[53]=mi.1.3*1
  else
  mw[53]=mi.1.3*mi.2.3/10000
  endif
endif

if (mi.1.4=0)
  if (Mi.4.4=0)
  MW[54]=mi.3.4
  else
  MW[54]=0
  endif
else 
  If (mi.2.4=0&mi.1.4>mi.4.4)
  MW[54]=mi.1.4*1
  else
  mw[54]=mi.1.4*mi.2.4/10000
  endif
endif

if (mi.1.5=0)
  if (Mi.4.5=0)
  MW[55]=mi.3.5
  else
  MW[55]=0
  endif
else
  If (mi.2.5=0&mi.1.5>mi.4.5)
  MW[55]=mi.1.5*1
  else
  mw[55]=mi.1.5*mi.2.5/10000
  endif
endif

if (mi.1.6=0)
  if (Mi.4.6=0)
  MW[56]=mi.3.6
  else
  MW[56]=0
  endif
else
   If (mi.2.6=0&mi.1.6>mi.4.6)
   MW[56]=mi.1.6*1
   else
   mw[56]=mi.1.6*mi.2.6/10000
   endif
endif


if (mi.1.7=0)
  if (Mi.4.7=0)
  MW[57]=mi.3.7
  else
  MW[57]=0
  endif
else
   If (mi.2.7=0&mi.1.7>mi.4.7)
   MW[57]=mi.1.7*1
   else
   mw[57]=mi.1.7*mi.2.7/10000
   endif
endif

MW[58]=mw[51]+mw[52]+mw[53]+mw[54]+mw[55]+mw[56]+mw[57]

endjloop
ENDRUN
