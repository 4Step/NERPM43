; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM50\APPLICATIONS\NRMAT00B.PRN" MSG='Output HBW districted est trips'
FILEO PRINTO[5] = "{SCENARIO_DIR}\OUTPUT\hbwFringeEst.prn"
FILEO PRINTO[4] = "{SCENARIO_DIR}\OUTPUT\hbwCBDKNREst.prn"
FILEO PRINTO[3] = "{SCENARIO_DIR}\OUTPUT\hbwKNREst.prn"
FILEO PRINTO[2] = "{SCENARIO_DIR}\OUTPUT\hbwPNREst.prn"
FILEI MATI[1] = "{SCENARIO_DIR}\output\D2DTransitTrip.MAT"
FILEO PRINTO[1] = "{SCENARIO_DIR}\OUTPUT\hbwWalkEst.prn"

zonemsg=100

FILLMW MW[1]=MI.1.1,2,3,4,5

PRINT LIST=I(5.0),MW[1][1](7.0),MW[1][2](7.0),MW[1][3](7.0) ,MW[1][4](7.0) ,MW[1][5](7.0) ,MW[1][6](7.0) ,MW[1][7](7.0) ,
                  MW[1][8](7.0),MW[1][9](7.0),MW[1][10](7.0),MW[1][11](7.0),MW[1][12](7.0),MW[1][13](7.0),MW[1][14](7.0),PRINTO=1
PRINT LIST=I(5.0),MW[2][1](7.0),MW[2][2](7.0),MW[2][3](7.0) ,MW[2][4](7.0) ,MW[2][5](7.0) ,MW[2][6](7.0) ,MW[2][7](7.0) ,
                  MW[2][8](7.0),MW[2][9](7.0),MW[2][10](7.0),MW[2][11](7.0),MW[2][12](7.0),MW[2][13](7.0),MW[2][14](7.0),PRINTO=2
PRINT LIST=I(5.0),MW[3][1](7.0),MW[3][2](7.0),MW[3][3](7.0) ,MW[3][4](7.0) ,MW[3][5](7.0) ,MW[3][6](7.0) ,MW[3][7](7.0) ,
                  MW[3][8](7.0),MW[3][9](7.0),MW[3][10](7.0),MW[3][11](7.0),MW[3][12](7.0),MW[3][13](7.0),MW[3][14](7.0),PRINTO=3
PRINT LIST=I(5.0),MW[4][1](7.0),MW[4][2](7.0),MW[4][3](7.0) ,MW[4][4](7.0) ,MW[4][5](7.0) ,MW[4][6](7.0) ,MW[4][7](7.0) ,
                  MW[4][8](7.0),MW[4][9](7.0),MW[4][10](7.0),MW[4][11](7.0),MW[4][12](7.0),MW[4][13](7.0),MW[4][14](7.0),PRINTO=4
PRINT LIST=I(5.0),MW[5][1](7.0),MW[5][2](7.0),MW[5][3](7.0) ,MW[5][4](7.0) ,MW[5][5](7.0) ,MW[5][6](7.0) ,MW[5][7](7.0) ,
                  MW[5][8](7.0),MW[5][9](7.0),MW[5][10](7.0),MW[5][11](7.0),MW[5][12](7.0),MW[5][13](7.0),MW[5][14](7.0),PRINTO=5

ENDRUN
