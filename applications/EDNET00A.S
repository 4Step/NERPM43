; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\parameters\HNETEDIT.PRN" MSG='Micro-code the skyway networks and add the additional links'

FILEI LINKI[3] = "C:\NERPM43\PARAMETERS\PNRLINKS.PRN",
VAR=A,BEG=1,LEN=10,
VAR=B,BEG=11,LEN=10,
VAR=DISTANCE,BEG=21,LEN=10,
VAR=FTYPE_00A,BEG=33,LEN=2,
VAR=FTYPE_05A,BEG=36,LEN=2,
VAR=FTYPE_30A,BEG=39,LEN=2,
VAR=ATYPE_00A,BEG=42,LEN=2,
VAR=ATYPE_05A,BEG=45,LEN=2,
VAR=ATYPE_30A,BEG=48,LEN=2,
VAR=PNRTERMTIME,BEG=51,LEN=10,
VAR=KNRTERMTIME,BEG=61,LEN=10,
VAR=NAME,BEG=71,LEN=30,TYP=a

FILEI LINKI[2] = "C:\NERPM43\parameters\ADDLINKS2000.TXT",
VAR=A,BEG=1,LEN=10,
VAR=B,BEG=11,LEN=10,
VAR=TBSDIST,BEG=21,LEN=10,
VAR=TBSTIME,BEG=31,LEN=10,
VAR=TFGDIST,BEG=41,LEN=10,
VAR=TFGTIME,BEG=51,LEN=10,
VAR=TFGMODE,BEG=61,LEN=10,
VAR=ATYPE_00A,BEG=71,LEN=10,
VAR=ATYPE_05A,BEG=71,LEN=10,
VAR=ATYPE_30A,BEG=71,LEN=10,
VAR=FTYPE_00A,BEG=81,LEN=2,
VAR=FTYPE_05A,BEG=84,LEN=2,
VAR=FTYPE_30A,BEG=87,LEN=2,
VAR=TFGNAME,BEG=120,LEN=30,TYP=a

FILEI NODEI[7] = "C:\NERPM43\PARAMETERS\PNRNODES.PRN",
VAR=N,BEG=1,LEN=5,
VAR=X,BEG=11,LEN=6,
VAR=Y,BEG=21,LEN=7,
VAR=TSNAME,BEG=31,LEN=30,TYP=a

FILEI NODEI[6] = "C:\NERPM43\parameters\BRT_NODES.TXT",
VAR=N,BEG=1,LEN=5,
VAR=X,BEG=11,LEN=6,
VAR=Y,BEG=21,LEN=7,
VAR=TSNAME,BEG=31,LEN=30,TYP=a

FILEI NODEI[5] = "C:\NERPM43\parameters\SKYWAY_NODES.TXT",
VAR=N,BEG=1,LEN=5,
VAR=X,BEG=11,LEN=6,
VAR=Y,BEG=21,LEN=7,
VAR=TSNAME,BEG=31,LEN=30,TYP=a

FILEI NODEI[2] = "C:\NERPM43\parameters\STATDATA.00A",
VAR=TSSTATION_00A, BEG=1,LEN=4,
VAR=N,BEG=6,LEN=5,
VAR=STATZONE,BEG=13,LEN=4,
VAR=TSRANGE_00A,BEG=19,LEN=4,
VAR=TSPARKSPACE_00A,BEG=24,LEN=5, 
VAR=TSCOSTAM_00A,BEG=29,LEN=6,
VAR=TSCOSTMD_00A,BEG=35,LEN=6,
VAR=TSTYPE_00A,BEG=54,LEN=2,
VAR=FAREZONE_00A,BEG=87,LEN=2,
VAR=TSNAME,BEG=57,LEN=30,typ=a

FILEI NODEI[3] = "C:\NERPM43\parameters\STATDATA.05A",
VAR=TSSTATION_05A, BEG=1,LEN=4,
VAR=N,BEG=6,LEN=5,
VAR=STATZONE,BEG=13,LEN=4,
VAR=TSRANGE_05A,BEG=19,LEN=4,
VAR=TSPARKSPACE_05A,BEG=24,LEN=5, 
VAR=TSCOSTAM_05A,BEG=29,LEN=6,
VAR=TSCOSTMD_05A,BEG=35,LEN=6,
VAR=TSTYPE_05A,BEG=54,LEN=2,
VAR=FAREZONE_05A,BEG=87,LEN=2,
VAR=TSNAME,BEG=57,LEN=30,typ=a

FILEI NODEI[4] = "C:\NERPM43\parameters\STATDATA.30A",
VAR=TSSTATION_30A, BEG=1,LEN=4,
VAR=N,BEG=6,LEN=5,
VAR=STATZONE,BEG=13,LEN=4,
VAR=TSRANGE_30A,BEG=19,LEN=4,
VAR=TSPARKSPACE_30A,BEG=24,LEN=5, 
VAR=TSCOSTAM_30A,BEG=29,LEN=6,
VAR=TSCOSTMD_30A,BEG=35,LEN=6,
VAR=TSTYPE_30A,BEG=54,LEN=2,
VAR=FAREZONE_30A,BEG=87,LEN=2,
VAR=TSNAME,BEG=57,LEN=30,typ=a

FILEO NETO = "C:\NERPM43\parameters\MicrocodedHnet.NET"

ENDRUN
