FILEO PRINTO[1] = "{SCENARIO_DIR}\output\MCSEED.OUT"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; MCSEED program inputs - AK
; 1 - persons.tem (HBW, HBO and NHB person trip table)
; 2 - profile.mas (for 3+ occupancy factors)
; 3 - mcseed.tem (copy of calib98a.mc3 from input directory)
; outputs
; 1 - mcseed.out
; 2 - ptrips.mc
; 3 - htrips.mc

*REM ***** PRE-MODE ******************
*IF EXIST MCSEED.TEM DEL MCSEED.TEM
*COPY {CATALOG_DIR}\parameters\CALIB98A.MC3 MCSEED.TEM >NUL
*COPY {SCENARIO_DIR}\output\PERSONS.TEM PERSONS.TEM >NUL
*MCSEED
*COPY DISTRIB.OUT+MCSEED.OUT >NUL
*COPY MCSEED.OUT {SCENARIO_DIR}\output\MCSEED.OUT
*DEL MCSEED.OUT
*MOVE PTRIPS.MC {SCENARIO_DIR}\output\PTRIPS.MC
*IF EXIST HTRIPS.MC DEL HTRIPS.MC
*IF EXIST MCSEED.TEM DEL MCSEED.TEM
*IF EXIST PERSONS.TEM DEL PERSONS.TEM

