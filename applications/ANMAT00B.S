;;<<PROCESS TEMPLATE>><<MATRIX>>;;
;{note1,note,10,"Matrix Balancing - Daily"}  Matrix Balancing - Daily >>>
;Input  PA Matrix File: {mati,filename,"Enter Input  PA Matrix File Name",x,"D:\FSUTMS\D2\NERPM\CUBE\PRELOAD.MAT","Matrix File (*.mat)|*.mat"}
;Output OD Matrix File: {mato,filename,"Enter Output OD Matrix File Name",x,"","Matrix File (*.mat)|*.mat"}
;Output OD Matrix Name: {matname,editbox,"Enter Output Matrix Name",T,"ODTRIPS"}
;;<<End Parameters>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX
FILEI MATI[1] = {MATI.Q}
FILEO MATO[1] = {MATO.Q},
MO=1,NAME={matname}
;   ----- CONVERT 3 P/A MATRICES TO O/D
    MW[1]=(MI.1.1+MI.1.1.T + MI.1.2+MI.1.2.T +
           MI.1.3+MI.1.3.T) * .5
ENDRUN
