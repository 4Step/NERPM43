; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\HNNET00F.PRN" MSG='List Toll Nodes'
FILEI LINKI[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\TEMP.NET"
FILEO PRINTO[1] = "C:\NERPM43\APPLICATIONS\WARMSTART\TEMPNODE.DAT"

if (li.1.TOLLTYPE=1); Toll Road
  a_accel=0
  a_decel=1
  b_accel=1
  b_decel=0
  PRINT form=0, LIST=A,' ',a_accel,' ',a_decel,' ',li.1.toll,printo=1
  PRINT form=0, LIST='NODE= ',A,' ACCEL_NODE= ',a_accel,' DECEL_NODE= ',a_decel,' PLAZA ID= ',li.1.toll
  PRINT form=0, LIST=B,' ',b_accel,' ',b_decel,' ',li.1.toll,printo=1
  PRINT form=0, LIST='NODE= ',B,' ACCEL_NODE= ',b_accel,' DECEL_NODE= ',b_decel,' PLAZA ID= ',li.1.toll
endif

if (li.1.TOLLTYPE=2); ORT
  a_accel=0
  a_decel=0 
  b_accel=0 
  b_decel=0
  PRINT form=0, LIST=A,' ',a_accel,' ',a_decel,' ',li.1.toll,printo=1
  PRINT form=0, LIST='NODE= ',A,' ACCEL_NODE= ',a_accel,' DECEL_NODE= ',a_decel,' PLAZA ID= ',li.1.toll
  PRINT form=0, LIST=B,' ',b_accel,' ',b_decel,' ',li.1.toll,printo=1
  PRINT form=0, LIST='NODE= ',B,' ACCEL_NODE= ',b_accel,' DECEL_NODE= ',b_decel,' PLAZA ID= ',li.1.toll
endif


ENDRUN
