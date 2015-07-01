; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

endif


EndDistributeMULTISTEP

Wait4Files Files=NERPM4Dist1.script.end, NERPM4Dist2.script.end,
           CheckReturnCode=1, PrintFiles=SAVE

