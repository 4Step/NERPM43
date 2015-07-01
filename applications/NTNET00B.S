; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\NTNET00J.PRN" MSG='Flags Toll Accel/Decel Nodes'
FILEI LINKI[1] = "C:\NERPM43\APPLICATIONS\NTNET00D.NET"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\TEMPNODE.DAT"

;if (li.1.toll>0)  
if ((li.1.toll>0)&(li.1.tolltype=1))  ; Note: Tolltype 2 may not get any acceleration/decelration codes
  a_accel=0
;  a_decel=1 ; commented out for ORT
;  a_decel=0 ; added for ORT
  a_decel=1 

;  b_accel=1 ; commented out for ORT
;  b_accel=0 ; added for ORT
  b_accel=1 
  b_decel=0
  PRINT form=0, LIST=A,' ',a_accel,' ',a_decel,printo=1
  PRINT form=0, LIST='NODE= ',A,' ACCEL_NODE= ',a_accel,' DECEL_NODE= ',a_decel
  PRINT form=0, LIST=B,' ',b_accel,' ',b_decel,printo=1
  PRINT form=0, LIST='NODE= ',B,' ACCEL_NODE= ',b_accel,' DECEL_NODE= ',b_decel
endif



ENDRUN
