; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Store MPO and County of TAZs in DBF File'
FILEO RECO[1] = "{SCENARIO_DIR}\output\mpocounty.dbf",
fields=taz,mpo,county
FILEI RECI = "{SCENARIO_DIR}\output\mpocounty.dat",
taz=1-5,mpo=6-10,county=11-15

RO.TAZ=RI.TAZ
ro.mpo=ri.mpo
ro.county=ri.county
write reco=1



ENDRUN
