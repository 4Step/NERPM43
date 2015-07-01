; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="{SCENARIO_DIR}\output\XTABSmryFinal.PRN" MSG='Prepare for HEVAL for Nassau County'
FILEI LINKI[1] = "{SCENARIO_DIR}\output\LOADED_HEVAL.NET"
FILEO PRINTO[2] = "{SCENARIO_DIR}\output\PROFILE_NERPM4_Cnty1.TXT"
FILEO LINKO = "{SCENARIO_DIR}\output\LinksCnt1.DBF",
   FORMAT=DBF,include=A,B,DISTANCE,ONE,ATYPE2,FTYPE2,
      LANES,TIME,DAILYCAP,COUNT,SCRN,ZONE,USECODE,LOCATION,
      LANDUSE,CCODE,CGTIME,TOTAL_VOL,TOLL,TWOWAY
FILEO PRINTO[1] = "{SCENARIO_DIR}\output\RMSE_Cnty1.PRN"

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

if(LI.1.COUNTY<>1) delete       ;comment out for county specific evaluation & set county no (1=Nassau, 2=Duval,3=St Johns,
                                 ;                                                            4=Clay, 5=Baker, 6=Putnam)
;if(LI.1.FACILITY_TYPE=70-79,97-98) delete       ;comment out for RMSE without ramps                                                            4=Clay, 5=Baker, 6=Putnam)

;Delete dummy zone facility types (#29) since it will distort heval and/or crosstab stat with a speed of 1 MPH;
;NOTE: Without this, the "analysis" mode HEVAL output will be skewed, since it did not recognize the filtered facility
;      type of 29.
;Note: only valid 29 is mayport bridge link (64273-64589 of DISTANCEFT=2010)
  IF(LI.1.Facility_Type=29) DELETE 



; DUMMY VARIABLES FOR HEVALDBF
ZONE        =1
USECODE     =1
LANDUSE     =1
CCODE       =1
DIRCODE     =1
;
   LOCATION=LI.1.COUNTY
   CGTIME=LI.1.CGTIME{Year}{alt}
   TOTAL_VOL=LI.1.VOLTOTAL{Year}{alt}
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
   TWOWAY=li.1.TWOWAY_{Year}{alt}
   DAILYCAP=li.1.CAPACITY*LNS/CONFAC
   SCRN=sl
   cnty=LI.1.COUNTY

; *SKS-6/28/2008****************************
if ('{ANALYSIS}' = 'YES')
   count=0            ;Important: this will turn-off RMSE, VOL/CONT by FT and AT
                      ;           for "analysis"="YES" mode 
  else
   count=COUNT
endif

;   count   = COUNT    ;selected real counts, not repeated
/*
  if (DIR==1 & FTYPE1<>1); Both sides of freeways get the entire volume in the database
     PSAWDT00=AADT002W/MOCF
  else
     PSAWDT00= 0.5 * AADT002W/MOCF
  endif
*/
   _aK     = COUNT ;All COUNTS
;
; *****************************
;
; initialize arrays and variables
   ARRAY _err=13, _cns=13, _cnt=13, _RGP=13, _vols=13, _volbyft=100, _cntbyft=100
   ARRAY _volbyat=100, _cntbyat=100, _lnkbyft=100, _lnkbyat=100
   ARRAY _volbyftg=100, _volbyatg=100, _cntbyftg=100, _cntbyatg=100
   ARRAY _lnkbyftg=100, _lnkbyatg=100
   ARRAY _volbyLNS=100, _cntbyLNS=100, _lnkbyLNS=100
   ARRAY _volbysl=100, _cntbysl=100, _lnkbysl=100
   ARRAY _volbycnty=100, _cntbycnty=100, _lnkbycnty=100

   _group=(0.0*FACILITY_TYPE)
   _RGP[1]=1, _RGP[2]=5000, _RGP[3]=10000, _RGP[4]=20000, _RGP[5]=30000, _RGP[6]=40000, _RGP[7]=50000,
   _RGP[8]=60000, _RGP[9]=70000, _RGP[10]=80000, _RGP[11]=90000, _RGP[12]=100000, _RGP[13]=500000
   IF (A=1)
     LOOP _iter=1,13
           _err[_iter]=0,_cnt[_iter]=0,_cns[_iter]=0,_vols[_iter]=0
     ENDLOOP
     LOOP _iter=1,99
           _volbyft[_iter]=0, _cntbyft[_iter]=0, _lnkbyft[_iter]=0
           _volbyat[_iter]=0, _cntbyat[_iter]=0, _lnkbyat[_iter]=0
           _volbyftg[_iter]=0, _cntbyftg[_iter]=0, _lnkbyftg[_iter]=0
           _volbyatg[_iter]=0, _cntbyatg[_iter]=0, _lnkbyatg[_iter]=0
           _volbyLNS[_iter]=0, _cntbyLNS[_iter]=0, _lnkbyLNS[_iter]=0
           _volbysl[_iter]=0, _cntbysl[_iter]=0, _lnkbysl[_iter]=0
           _volbycnty[_iter]=0, _cntbycnty[_iter]=0, _lnkbycnty[_iter]=0
     ENDLOOP
   ENDIF
;   FNAME='ROADNAME'
; establish some English sounding variables for the output network
 ;  links=1
 ;  lanemiles=lns*distance
; calculate and compartmentalize
   IF (_aK>0) VOLCNT=TOTAL_VOL/_aK, _TVOL=TOTAL_VOL, NETDIFF=TOTAL_VOL-_aK, ABSDIFF=ABS(NETDIFF), ERRORSQ=NETDIFF^2, PCTDIFF=100*NETDIFF/_aK _group=1
 
;   IF(_aK>0) VOLCNT=TOTAL_VOL/_aK, NETDIFF=TOTAL_VOL-_aK, ABSDIFF=ABS(NETDIFF), ERRORSQ=NETDIFF^2, PCTDIFF=100*NETDIFF/_aK _group=1, _TVOL=TOTAL_VOL
   IF (_aK>5000) _group=2
   IF (_aK>10000) _group=3
   IF (_aK>20000) _group=4
   IF (_aK>30000) _group=5
   IF (_aK>40000) _group=6
   IF (_aK>50000) _group=7
   IF (_aK>60000) _group=8
   IF (_aK>70000) _group=9
   IF (_aK>80000) _group=10
   IF (_aK>90000) _group=11
   IF (_aK>100000) _group=12
   IF (_aK>0) 
   _ERR[_group]=ERRORSQ+_ERR[_group], _CNS[_group]=_aK+_CNS[_group], _CNT[_group]=_CNT[_group]+1, _VOLS[_group]=_TVOL+_VOLS[_group]
   _ERR[13]=ERRORSQ+_ERR[13], _CNS[13]=_aK+_CNS[13], _CNT[13]=_CNT[13]+1, _VOLS[13]=_TVOL+_VOLS[13]
   ENDIF

IF (_aK>0)  
   _volbyft[ft]=_volbyft[ft]+TOTAL_VOL
   _cntbyft[ft]=_cntbyft[ft]+_aK
   _lnkbyft[ft]=_lnkbyft[ft]+1
   _volbyat[at]=_volbyat[at]+TOTAL_VOL
   _cntbyat[at]=_cntbyat[at]+_aK
   _lnkbyat[at]=_lnkbyat[at]+1
   _volbyft[100]=_volbyft[100]+TOTAL_VOL
   _cntbyft[100]=_cntbyft[100]+_aK
   _lnkbyft[100]=_lnkbyft[100]+1
   _volbyat[100]=_volbyat[100]+TOTAL_VOL
   _cntbyat[100]=_cntbyat[100]+_aK

   _lnkbyat[100]=_lnkbyat[100]+1
   _volbyftg[ftg]=_volbyftg[ftg]+TOTAL_VOL
   _cntbyftg[ftg]=_cntbyftg[ftg]+_aK
   _lnkbyftg[ftg]=_lnkbyftg[ftg]+1
   _volbyatg[atg]=_volbyatg[atg]+TOTAL_VOL
   _cntbyatg[atg]=_cntbyatg[atg]+_aK
   _lnkbyatg[atg]=_lnkbyatg[atg]+1
   _volbyftg[100]=_volbyftg[100]+TOTAL_VOL
   _cntbyftg[100]=_cntbyftg[100]+_aK
   _lnkbyftg[100]=_lnkbyftg[100]+1
   _volbyatg[100]=_volbyatg[100]+TOTAL_VOL
   _cntbyatg[100]=_cntbyatg[100]+_aK
   _lnkbyatg[100]=_lnkbyatg[100]+1
   _volbyLNS[LNS]=_volbyLNS[LNS]+TOTAL_VOL
   _cntbyLNS[LNS]=_cntbyLNS[LNS]+_aK
   _lnkbyLNS[LNS]=_lnkbyLNS[LNS]+1
   _volbysl[sl]=_volbysl[sl]+TOTAL_VOL
   _cntbysl[sl]=_cntbysl[sl]+_aK
   _lnkbysl[sl]=_lnkbysl[sl]+1
   _volbyLNS[100]=_volbyLNS[100]+TOTAL_VOL
   _cntbyLNS[100]=_cntbyLNS[100]+_aK
   _lnkbyLNS[100]=_lnkbyLNS[100]+1
   _volbysl[100]=_volbysl[100]+TOTAL_VOL
   _cntbysl[100]=_cntbysl[100]+_aK
   _lnkbysl[100]=_lnkbysl[100]+1
   _volbycnty[cnty]=_volbycnty[cnty]+TOTAL_VOL
   _cntbycnty[cnty]=_cntbycnty[cnty]+_aK
   _lnkbycnty[cnty]=_lnkbycnty[cnty]+1
   _volbycnty[100]=_volbycnty[100]+TOTAL_VOL
   _cntbycnty[100]=_cntbycnty[100]+_aK
   _lnkbycnty[100]=_lnkbycnty[100]+1

endif
CROSSTAB  VAR= _LINKS _LANEMILES, form=12.0c,
    row=FT, range=10-99-10,
    col=LNS, range=1-5-1,6-9
IF (_aK>0)
CROSSTAB  VAR= TOTAL_VOL,_aK, form=12.0c,
    row=FT, range=10-99-10,
    col=AT, range=10-59-10
ENDIF
CROSSTAB  VAR= _LINKS _LANEMILES, form=12.0c,
    row=FTG, range=1-9-1,
    col=LNS, range=1-5-1,6-9
IF (_aK>0)
CROSSTAB  VAR= TOTAL_VOL,_aK, form=12.0c,
    row=FTG, range=1-9-1,
    col=ATG, range=1-5-1
ENDIF

;sks - for computing capacity of the network by FTG and ATG
CROSSTAB  VAR= _LANEMILES, form=14.2c, VAR= _CAPLNMILES, form=14.2c,
    row=FTG, range=1-9-1,1-9,
    col=ATG, range=1-5-1,1-5,
    comp=_CAPLNMILES/_LANEMILES, form=14.2


;CROSSTAB  VAR= _CAPLNMILES, form=14.2c,
;    row=FTG, range=1-9-1,1-9,
;    col=ATG, range=1-5-1,1-5


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
    

;if (count=0) delete

ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY
; a little loop to write out the Percent Root Mean Square Error
LOOP _iter=1,12 

;  set allowable limit ranges
   if (_iter=1) _limit='45 - 55'
   if (_iter=2) _limit='35 - 45'
   if (_iter=3) _limit='27 - 35'
   if (_iter=4) _limit='24 - 27'
   if (_iter=5) _limit='22 - 24'
   if (_iter=6) _limit='20 - 22'
   if (_iter=7) _limit='18 - 20'
   if (_iter=8) _limit='17 - 18'
   if (_iter=9) _limit='16 - 17'
   if (_iter=10) _limit='15 - 16'
   if (_iter=11) _limit='14 - 15'
   if (_iter=12) _limit='LT 14  '
 
  if (_iter=1) print list="*********************************** ROOT MEAN SQUARE ERROR SUMMARY BY VOLUME GROUP ***********************************", printo=1
  if (_cnt[_iter]>0) print,        
 list="%RMSE Vol Grp ",_iter(2.0c)," ",_RGP[_iter](7.0c),"-",_RGP[_iter+1](7.0c),": ",sqrt(_err[_iter]/(_cnt[_iter]-1))/(_cns[_iter]/_cnt[_iter])*100(7.3),"%",
 " Allow_RMSE = ", _limit,"%",
 " VOL=",_vols[_iter](11.0c),
 " CNT=",_cns[_iter](11.0c),
 " VOL/CNT=",(_vols[_iter]/_cns[_iter])(5.2c),
 " N=",_cnt[_iter](5.0CL), PRINTO=1
ENDLOOP
_iter=13

;  set allowable limit ranges
 if (_iter=13) _limit='32 - 39'

 list="%RMSE Vol Grp ",_iter(2.0c)," ",_RGP[1](7.0c),"-",_RGP[_iter](7.0c),": ",sqrt(_err[_iter]/(_cnt[_iter]-1))/(_cns[_iter]/_cnt[_iter])*100(7.3),"%",
 " Allow_RMSE = ", _limit,"%",
 " VOL=",_vols[_iter](11.0c),
 " CNT=",_cns[_iter](11.0c),
 " VOL/CNT=",(_vols[_iter]/_cns[_iter])(5.2c),
 " N=",_cnt[_iter](5.0CL), PRINTO=1

; one for Vol/Cnt by FT 
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ********************** VOLUME AND COUNT SUMMARY BY FACILITY TYPE **********************", PRINTO=1
if (_cntbyft[_iter]>0) print,
 list="Facility Type Summary for FT=",_iter(3.0c),
 " VOL=",_volbyft[_iter](11.0c),
 " CNT=",_cntbyft[_iter](11.0c),
 " VOL/CNT=",(_volbyft[_iter]/_cntbyft[_iter])(5.2c),
 "   N=",_lnkbyft[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by AT
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY AREA TYPE ************************", PRINTO=1
if (_cntbyat[_iter]>0) print,
 list="    Area Type Summary for AT=",_iter(3.0c),
 " VOL=",_volbyat[_iter](11.0c),

 " CNT=",_cntbyat[_iter](11.0c),
 " VOL/CNT=",(_volbyat[_iter]/_cntbyat[_iter])(5.2c),
 "   N=",_lnkbyat[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by FTG 
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ********************** VOLUME AND COUNT SUMMARY BY FACILITY TYPE GROUP*****************", PRINTO=1
if (_cntbyftg[_iter]>0) print,
 list="Facility Type Summary for FTG=",_iter(3.0c),
 " VOL=",_volbyftg[_iter](11.0c),
 " CNT=",_cntbyftg[_iter](11.0c),
 " VOL/CNT=",(_volbyftg[_iter]/_cntbyftg[_iter])(5.2c),
 "   N=",_lnkbyftg[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by ATG
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY AREA TYPE GROUP*******************", PRINTO=1
if (_cntbyatg[_iter]>0) print,
 list="    Area Type Summary for ATG=",_iter(3.0c),
 " VOL=",_volbyatg[_iter](11.0c),

 " CNT=",_cntbyatg[_iter](11.0c),
 " VOL/CNT=",(_volbyatg[_iter]/_cntbyatg[_iter])(5.2c),
 "   N=",_lnkbyatg[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by LNS 
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ********************** VOLUME AND COUNT SUMMARY BY LANES PER DIRECTION*****************", PRINTO=1
if (_cntbyLNS[_iter]>0) print,
 list="Facility Type Summary for LNS=",_iter(3.0c),
 " VOL=",_volbyLNS[_iter](11.0c),
 " CNT=",_cntbyLNS[_iter](11.0c),
 " VOL/CNT=",(_volbyLNS[_iter]/_cntbyLNS[_iter])(5.2c),
 "   N=",_lnkbyLNS[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by SL
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ******************** VOLUME AND COUNT SUMMARY BY SCREENLINE & CUTLINE *******************", PRINTO=1
if (_cntbysl[_iter]>0) print,
 list="    ScrCut Line Summary for SL=",_iter(3.0c),
 " VOL=",_volbysl[_iter](11.0c),
 " CNT=",_cntbysl[_iter](11.0c),
 " VOL/CNT=",(_volbysl[_iter]/_cntbysl[_iter])(5.2c),
 "   N=",_lnkbysl[_iter](5.0c), PRINTO=1
ENDLOOP

; one for Vol/Cnt by County
_iter=0
LOOP _iter=1,100
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY COUNTY *****************************", PRINTO=1
if (_cntbycnty[_iter]>0) print,
 list="    County-wide Smry for Cnty = ",_iter(3.0c),
 " VOL=",_volbycnty[_iter](11.0c),
 " CNT=",_cntbycnty[_iter](11.0c),
 " VOL/CNT=",(_volbycnty[_iter]/_cntbycnty[_iter])(5.2c),
 "   N=",_lnkbycnty[_iter](5.0c), PRINTO=1
ENDLOOP

;GTITLE=' - Nassau County'

if ('{VALIDATE}' = 'YES')           ;Validate Mode
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\nNO",
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\n",'{VALIDATE}',
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}-Nassau',                                                                      ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nNO",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nNO",
           PRINTO=2
endif

if ('{ANALYSIS}' = 'YES')           ;Analysis Mode
    PRINT LIST="&HEVALDBF      HEVAL Input DBF File",
           "\nLNKSCNT.DBF",
           "\n&ANALYSIS      Sets HEVAL to run in analysis mode if (YES)",
           "\n",'{ANALYSIS}',
           "\n&VALIDATE      Sets HEVAL to run in validate mode if (YES)",
           "\nNO",
           "\n&GLTITLE       Specifies title for HEVAL runs using geographic location",
           "\n",'{HEVAL_TITLE}-Nassau',                                                                       ;GTITLE,
           "\n&ASCII         Generates ASCII file (HRLDXY.ASC) with 1-way vol and cap",
           "\nNO",
           "\n&TWOWAY        Generates second ASCII file (HRLDXY2.ASC) with 2-way vol and cap", 
           "\nNO",
           PRINTO=2
endif


ENDPHASE



ENDRUN
