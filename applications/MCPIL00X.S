; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
 Wait4Files Files=NERPM1.script.end, NERPM2.script.end, NERPM3.script.end,
   NERPM4.script.end, NERPM5.script.end, NERPM6.script.end,                                 
   NERPM7.script.end, NERPM8.script.end, NERPM9.script.end,                                 
   NERPM10.script.end, NERPM11.script.end, NERPM12.script.end,                              
   NERPM13.script.end, NERPM14.script.end, NERPM15.script.end,                              
   NERPM16.script.end,                                                
printfiles=MERGE, checkReturnCode=T   
*Cluster NERPM 1-16 Close Exit

; *Cluster NERPM 1-%NUMBER_OF_PROCESSORS% Close Exit
