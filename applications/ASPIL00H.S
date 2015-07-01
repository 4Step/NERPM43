; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


if ({linkconsolidate}=1)

*Copy {SCENARIO_DIR}\output\UNLOADED.NET {SCENARIO_DIR}\output\UNLOADED.SAV
*Copy {CATALOG_DIR}\parameters\TCARDS.PEN {SCENARIO_DIR}\output\TCARDS.SAV

*Cube  "{SCENARIO_DIR}\input\LINKCONSOLIDATE.CTL"  /Command  /CloseWhenDone  /Minimize  /NoSplash

*DEL {SCENARIO_DIR}\output\UNLOADED.NET
*DEL {CATALOG_DIR}\parameters\TCARDS.PEN
*Copy {SCENARIO_DIR}\output\CON_TCARDS.PEN {CATALOG_DIR}\parameters\TCARDS.PEN

*REN {SCENARIO_DIR}\output\CON_UNLOADED.NET {SCENARIO_DIR}\output\UNLOADED.NET

else

endif
