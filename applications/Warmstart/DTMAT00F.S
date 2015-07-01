; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\DTMAT00A.PRN" MSG='Write CTPP Districts from TAZ database file'
FILEI ZDATI[1] = "{CATALOG_DIR}\media\NERPM4_TAZ_W05ZONALDATA.DBF",
 Z=TAZ
FILEO RECO[1] = "{CATALOG_DIR}\parameters\CTPPDistricts.dbf",
 form=10.0, FIELDS=zt,CTPPDISTN3,COUNTY


PAR ZONES={ZONESI}
 
COUNTY=ZI.1.COUNTY

CTPPDISTN3=ZI.1.CTPP_DIST

zt=Z

WRITE RECO=1

;External Zones
if(z={ZONESI})
  loop jj={ZONESI}+1,{ZONESA}
    zt=jj

    if (zt>=2550 & zt<=2553)         ;Nassau Co Externals
      CTPPDISTN3=11
      COUNTY=7
    endif

    if (zt>=2554 & zt<=2563)         ;Baker Co Externals
      CTPPDISTN3=11
      COUNTY=7
    endif

    if (zt>=2564 & zt<=2568)         ;Clay Co Externals
      CTPPDISTN3=11
      COUNTY=7
    endif

    if (zt>=2569 & zt<=2575)         ;Putnam Co Externals
      CTPPDISTN3=11
      COUNTY=7
    endif

    if (zt>=2576 & zt<=2578)         ;St. Johns Co Externals
      CTPPDISTN3=11
      COUNTY=7
    endif

    WRITE RECO=1
 
  endloop
endif


ENDRUN
