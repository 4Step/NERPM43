; Script for program NETWORK in file "E:\NERPM50\APPLICATIONS\PNNET00A.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\OUTPUT\PNNET00A.PRN" MSG='Remove Transit -Only links from loaded network hor Highway Evaluation'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PKPreLoad.NET"
FILEO NETO = "{SCENARIO_DIR}\output\PreAssignLOADED_HEVAL.NET"

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

 
;Delete transit-Only non-highway links from loaded network
  IF(LI.1.Facility_Type=49,59,69) DELETE 

    

ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY


ENDPHASE



ENDRUN


; Script for program NETWORK in file "E:\NERPM50\APPLICATIONS\PNNET00C.S"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\PreAssignXtabsmry.PRN" MSG='Prepare for HEVAL for All Area'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\PreAssignLOADED_HEVAL.NET"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PreAssignPROFILE_NERPM4.TXT"
FILEO LINKO = "{SCENARIO_DIR}\output\PreAssignLinksCnt0.DBF",
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


; PILOT Script
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

*REM -- Copy required Input files of HEVAL/RMSE routines to Cube Folder...
*copy /a {SCENARIO_DIR}\output\PreAssignPROFILE_NERPM4.TXT PROFILE.MAS
*copy /a {CATALOG_DIR}\parameters\HESCREEN.SYN HESCREEN.SYN
*copy /a {CATALOG_DIR}\parameters\HELABELS.SYN HELABELS.SYN
*copy /a {CATALOG_DIR}\parameters\HERATES.SYN HERATES.SYN
*copy /a {CATALOG_DIR}\parameters\DATABASE_PK2HR.CTL DATABASE.CTL
*copy /b "{SCENARIO_DIR}\output\PreAssignLinksCnt0.DBF" LnksCnt.DBF

*REM -- Clean the Cube Folder of HEVAL/RMSE outputs from any previous run (if any)...
*if exist HEVAL.OUT del HEVAL.OUT
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC.ASC del HRLDXY2.ASC

*REM -- Run HEVAL/RMSE Routines...
*{CATALOG_DIR}\User.prg\hevaldbf.exe >{SCENARIO_DIR}\output\hevaldbf.LOG

*REM -- Save HEVAL/RMSE outputs from Cube folder to user's output folder...
*if exist HEVAL.OUT copy /a heval.out {SCENARIO_DIR}\output\PreAssignheval-NERPM4.out
*if exist SCRNLINE.ASC copy /a SCRNLINE.ASC {SCENARIO_DIR}\output\PreAssignSCRNLINE-NERPM4.out
*if exist HRLDXY.ASC copy /a HRLDXY.ASC {SCENARIO_DIR}\output\PreAssignHRLDXY-NERPM4.ASC
*if exist HRLDXY2.ASC copy /a HRLDXY2.ASC {SCENARIO_DIR}\output\PreAssignHRLDXY2-NERPM4.ASC

*REM -- Delete HEVAL outputs from Cube folder...
*if exist HEVAL.OUT del heval.out
*if exist SCRNLINE.ASC del SCRNLINE.ASC
*if exist HRLDXY.ASC del HRLDXY.ASC
*if exist HRLDXY2.ASC del HRLDXY2.ASC

*REM -- Clean Cube folder of HEVAL routine Inputs...
*if exist PROFILE.MAS del PROFILE.MAS
*if exist HESCREEN.SYN del HESCREEN.SYN
*if exist HELABELS.SYN del HELABELS.SYN
*if exist HERATES.SYN del HERATES.SYN
*if exist DATABASE.CTL del DATABASE.CTL
*if exist LnksCnt.DBF del LnksCnt.DBF

; End of PILOT Script

RUN PGM="C:\Program Files\Citilabs\Cube\TRCOPY.bat" PARAMETERS='"{SCENARIO_DIR}\output\PreAssignheval-NERPM4.out" "{SCENARIO_DIR}\output\PreAssignHEVAL.PRN" '
ENDRUN

