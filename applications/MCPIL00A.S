; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
*if exist MODE.OUT del MODE.OUT
*if exist MODE.ERR del MODE.ERR
*if exist HTWORK.{ALT}{YEAR} del HTWORK.{ALT}{YEAR}
*if exist HTNWORK.{ALT}{YEAR} del HTNWORK.{ALT}{YEAR}
*if exist HTNHB.{ALT}{YEAR} del HTNHB.{ALT}{YEAR}
*{USERPRG}\MPREPGNL2
*COPY {GNLINPUT} TRNPLN.IN
*CALL TRANPLAN
