; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM50\APPLICATIONS\CANET00A.PRN" MSG='Create selected Test2035b Scenario attributes to a copy of your existing Master network and save the file to a new master network'
FILEO NETO = "{CATALOG_DIR}\parameters\My_MicroCodedHnet42_FromMiltonUpdated.net"
FILEI LINKI[1] = "{CATALOG_DIR}\parameters\My_MicroCodedHnet42_TEM.net"

;OLDYYA=35x
;NEWYYA=35b

PHASE=NODEMERGE

   TSSTATION_35b=TSSTATION_35x
   TSRANGE_35b=TSRANGE_35x
   TSPARKSPACE_35b=TSPARKSPACE_35x
   TSCOSTAM_35b=TSCOSTAM_35x
   TSCOSTMD_35b=TSCOSTMD_35x
   TSTYPE_35b=TSTYPE_35x
   FAREZONE_35b=FAREZONE_35x

ENDPHASE

PHASE=LINKMERGE

FTYPE_35b=FTYPE_35x
ATYPE_35b=ATYPE_35x
LANES_35b=LANES_35x
TWOWAY_35b=TWOWAY_35x
DESC_35b=DESC_35x


ENDPHASE

ENDRUN
