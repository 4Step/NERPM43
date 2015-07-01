LOOP per = 1, 2, 1

; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

    IF (per ==1)
     todToken = 'PK'
     hwySkim = 'PRELSKIMS.MAT'
    ElseIF(per ==2)
     todToken = 'OP'
     hwySkim = 'FHSKIMS.MAT'
    EndIF
   
    
    
; End of PILOT Script

; Script for program MATRIX in file "C:\NERPM43\APPLICATIONS\TRMAT00A.S"
;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="{SCENARIO_DIR}\output\createDriveToSkywaySkims.PRN"
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\DriveToSkyway.dat"
FILEO MATO[2] = "{SCENARIO_DIR}\output\@todToken@_DRV_SKYWAY_ZONES.MAT",
MO=11,Name= PNRZONE
FILEO MATO[1] = "{SCENARIO_DIR}\output\@todToken@_DRV_SKYWAY.MAT",
MO=1-10,Name= Toll,Distance,WtTime,WlkTime,SkyTime,Xfers,IWait,Xwait,Fare,TotalTime
FILEI MATI[2] = "{SCENARIO_DIR}\output\TSKIM_@todToken@_SKYWAY_Walk_{Alt}{year}.MAT"
FILEI MATI[1] = "{SCENARIO_DIR}\output\@hwySkim@"
    
    ; zones = 2578
    
    ; Loop by pnr lots and get the least time pnr location
    Array pnr=6, pathTime=6, skyTime=6
    pnr[1]=766, pnr[2]=767, pnr[3]=726, pnr[4]=677, pnr[5]=665, pnr[6]=739
    
    ; Loop by JZONES and get least cost path
    JLOOP
      ; Initialize variables for each JZone
      pathTime[1]=9999, pathTime[2]=9999, pathTime[3]=9999, pathTime[4]=9999, pathTime[5]=9999, pathTime[6]=9999
      skyTime[1]=0, skyTime[2]=0, skyTime[3]=0, skyTime[4]=0, skyTime[5]=0, skyTime[6]=0
      ; leastTime  = 9999
      chosenPnr = 0
      
        ; Get the origin-to-pnr and pnr-to-destination travel time
        skyTime[1] = MATVAL(2,4,pnr[1],J,0)
        skyTime[2] = MATVAL(2,4,pnr[2],J,0)
        skyTime[3] = MATVAL(2,4,pnr[3],J,0)
        skyTime[4] = MATVAL(2,4,pnr[4],J,0)
        skyTime[5] = MATVAL(2,4,pnr[5],J,0)
        skyTime[6] = MATVAL(2,4,pnr[6],J,0)
        
        ; pathtime = drive-to-pnr hwy time + trn walk time + skyway IVTT
        IF (skyTime[1] > 0) 
            pathTime[1] = MATVAL(1,3,I,pnr[1],0) + MATVAL(2,1,pnr[1],J,0) + MATVAL(2,4,pnr[1],J,0)
        ENDIF
        IF (skyTime[2] > 0) 
           pathTime[2] = MATVAL(1,3,I,pnr[2],0) + MATVAL(2,1,pnr[2],J,0) + MATVAL(2,4,pnr[2],J,0)
        ENDIF
        IF (skyTime[3] > 0) 
           pathTime[3] = MATVAL(1,3,I,pnr[3],0) + MATVAL(2,1,pnr[3],J,0) + MATVAL(2,4,pnr[3],J,0)
        ENDIF
        IF (skyTime[4] > 0) 
           pathTime[4] = MATVAL(1,3,I,pnr[4],0) + MATVAL(2,1,pnr[4],J,0) + MATVAL(2,4,pnr[4],J,0)
        ENDIF
        IF (skyTime[5] > 0) 
           pathTime[5] = MATVAL(1,3,I,pnr[5],0) + MATVAL(2,1,pnr[5],J,0) + MATVAL(2,4,pnr[5],J,0)
        ENDIF
        IF (skyTime[6] > 0) 
           pathTime[6] = MATVAL(1,3,I,pnr[6],0) + MATVAL(2,1,pnr[6],J,0) + MATVAL(2,4,pnr[6],J,0)
        ENDIF
        
        ; Compute total time if there is a walk to skyway path from that pnr station
        leastTime = min(pathTime[1],pathTime[2],pathTime[3],pathTime[4],pathTime[5],pathTime[6])
        
        ; Record the lowest cost pnr lot
        IF (leastTime == pathTime[1]) chosenPnr = 1
        IF (leastTime == pathTime[2]) chosenPnr = 2
        IF (leastTime == pathTime[3]) chosenPnr = 3
        IF (leastTime == pathTime[4]) chosenPnr = 4
        IF (leastTime == pathTime[5]) chosenPnr = 5
        IF (leastTime == pathTime[6]) chosenPnr = 6
        
        ; Fillin the least cost path values in the matrix
        IF (chosenPnr >0 & leastTime > 0 & leastTime != 9999)
          MW[1] = MATVAL(1,1,I,pnr[chosenPnr],0)   ; Toll cost
          MW[2] = MATVAL(1,2,I,pnr[chosenPnr],0)   ; Distance (hwy only, we don't have distance in trn skim)            
          MW[3] = MATVAL(1,4,I,pnr[chosenPnr],0)   ; Weighted Hwy Time
          MW[4] = MATVAL(2,1,pnr[chosenPnr],J,0)   ; Walk Time
          MW[5] = MATVAL(2,4,pnr[chosenPnr],J,0)   ; Skyway Time
          MW[6] = MATVAL(2,11,pnr[chosenPnr],J,0)  ; Number of xfers
          MW[7] = MATVAL(2,12,pnr[chosenPnr],J,0)  ; Inital waitime
          MW[8] = MATVAL(2,13,pnr[chosenPnr],J,0)  ; Xfer waitime
          MW[9] = MATVAL(2,14,pnr[chosenPnr],J,0)  ; Fare
          MW[10] = leastTime                       ; Time (drive+ walk+ skyway) 
          MW[11] = pnr[chosenPnr]                  ; Get the Choosen PNR lot(zone)
        ENDIF
    
      
      ; Trace for selected I-J pair (I= 1, J = 767)
      IF (I== 1 & J == 1) print form =15.4,list=  'I'(6),'J'(6),'Lot'(4),'pnr'(4),'PT1'(12),'PT2'(12),'PT3'(12),'PT4'(12),'PT5'(12),'PT6'(12), FILE = "C:\NERPM43\APPLICATIONS\DRIVETOSKYWAY.DAT"
      IF (I== 767 & J == 688) print form =15.4,list= I(6), J(6), chosenPnr(4), pnr[chosenPnr](4), 
                                                   pathTime[1](12.4), pathTime[2](12.4), pathTime[3](12.4), 
                                                   pathTime[4](12.4), pathTime[5](12.4), pathTime[6](12.4), 
 FILE = "C:\NERPM43\APPLICATIONS\DRIVETOSKYWAY.DAT"
    
    ENDJLOOP
    
ENDRUN


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.


; End of PILOT Script

ENDLOOP

