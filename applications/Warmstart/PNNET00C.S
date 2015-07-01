; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="C:\NERPM43\APPLICATIONS\WARMSTART\PreAssignXtabsmry.PRN" MSG='Prepare for HEVAL for All Area'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PreAssignLOADED_HEVAL.NET"
FILEO PRINTO[2] = "{Scenario_Dir}\output\PreAssignPROFILE_NERPM4.TXT"
FILEO LINKO = "{Scenario_Dir}\output\PreAssignLinksCnt0.DBF",
   FORMAT=DBF,include=A,B,DISTANCE,ONE,ATYPE2,FTYPE2,
      LANES,TIME,PK2HRCAP,COUNT,SCRN,ZONE,USECODE,LOCATION,
      LANDUSE,CCODE,CGTIME,TOTAL_VOL,TOLL,TWOWAY

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

;if(LI.1.COUNTY<>6) delete       ;comment out for county specific evaluation & set county no (1=Nassau, 2=Duval,3=St Johns,
                                 ;                                                            4=Clay, 5=Baker, 6=Putnam)
;if(LI.1.FACILITY_TYPE=70-79,97-98) delete       ;comment out for RMSE without ramps                                                            4=Clay, 5=Baker, 6=Putnam)

;Delete dummy zone facility types (#29) since it will distort heval and/or crosstab stat with a speed of 1 MPH;
;Note: only valid 29 is (mayport bridge link (64273-64589 of DISTANCEFT=2010)
  IF(LI.1.Facility_Type=29) DELETE 



; DUMMY VARIABLES FOR HEVALDBF
ZONE        =1
USECODE     =1
LANDUSE     =1
CCODE       =1
DIRCODE     =1
;
   LOCATION=LI.1.COUNTY
   CGTIME=LI.1.TIME_1
   TOTAL_VOL=LI.1.V_1
   ft=LI.1.FACILITY_TYPE
   FACILITY=LI.1.FACILITY_TYPE
   at=LI.1.AREA_TYPE
   LNS=LI.1.NUM_LANES
   ftg=INT(LI.1.FACILITY_TYPE/10)
   atg=INT(LI.1.AREA_TYPE/10)
   sl=LI.1.SCREENLINE


;sks-Fill crosstab variables
   if (!(ft=50-59))
     _caplnmiles=li.1.CAPACITY*li.1.DISTANCE*LI.1.NUM_LANES
     _orgtimehr=li.1.time/60
     _cgtimehr=cgtime/60
     _distmile=li.1.distance
     _lanemiles=lns*distance
     _orgspd=_distmile/_orgtimehr
     _links=1

    else
     _caplnmiles=0.0
     _orgtimehr=0.0
     _cgtimehr=0.0
     _distmile=0.0
     _lanemiles=0.0
     _orgspd=0.0
     _links=1
   endif 



;
;   ANODE=li.1.A
;   BNODE=li.1.B
   ONE=DIRCODE
   ATYPE2=at
   FTYPE2=ft
   LANES=LNS
;   USE=USECODE
;   CONSTRUCT=CCODE
;   CONG_TIME=CGTIME
;   MODELVOL=TOTAL_VOL
;   COST=li.1.TOLL

;sks-Revised to 0.50 assuming more congestion in future years:  confacpk=0.582    ; using peak hour factor from HH survey - jeff
  confacpk=0.50

   TWOWAY=li.1.TWOWAY_{Year}{alt}
  

   PK2HRCAP=li.1.CAPACITY*LNS/CONFACPK    ; Pre-assignment  2-hour AMpeak capacity
                                          
   SCRN=sl
   cnty=LI.1.COUNTY

;void count for this 2-hour evaluation
  count=0

;
; *****************************
;
; initialize arrays and variables
;sks - for computing capacity of the network by FTG and ATG
CROSSTAB  VAR= _LANEMILES, form=14.2c, VAR= _CAPLNMILES, form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_CAPLNMILES/_LANEMILES, form=14.2


;sks - for computing original Speed the network by FTG and ATG
CROSSTAB  VAR=_distmile form=14.2c, VAR=_orgtimehr form=14.2c, VAR=_orgspd form=14.2c,VAR=_links form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_distmile/_orgtimehr, form=14.2,
    comp=_orgspd/_links, form=14.2

;CROSSTAB  VAR= orgtimehr, form=14.2c,
;    row=FTG, range=1-9-1,1-9,
;    col=ATG, range=1-5-1,1-5


;sks - for computing Congested Speed the network by FTG and ATG
CROSSTAB  VAR=_distmile form=14.2c, VAR=_cgtimehr form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_distmile/_cgtimehr, form=14.2
    


ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY
; a little loop to write out the Percent Root Mean Square Error

;----SKS (9/7/2008)---Write Profile for HEVAL-NERPM4-All Counties data 
; Preassignment Always run in Analysis mode.
;GTITLE=' - ALL SIX COUNTIES'

if ('{VALIDATE}' = 'NO')      ;Preassign HEVAL always in Analysis mode since no peak count
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\nYES",
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\nNO",
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}',"- PreAssignment HEVAL in Analysis Mode",                                                                      ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nYES",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nYES",
           PRINTO=2
endif

if ('{VALIDATE}' = 'YES')     ;Preassign HEVAL always in Analysis mode since no peak count
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\nYES",
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\nNO",
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}',"- PreAssignment HEVAL in Alalysis Mode",                                                                       ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nYES",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nYES",
           PRINTO=2
endif


ENDPHASE



ENDRUN
