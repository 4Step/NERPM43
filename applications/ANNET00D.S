; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=NETWORK PRNFILE="D:\FSUTMS\D2\NERPM\CUBE\ANNET00D.PRN"
FILEO LINKO = "D:\FSUTMS\D2\NERPM\CUBE\ANNET00A.DAT",
   FORMAT=DBF,include=A,B,DISTANCE,DIRCODE,AREA_TYPE,FACILITY,
      NUM_LANES,TIME,CAPACITY,COUNT,SCREENLINE,ZONE,USECODE,COUNTY,
      LANDUSE,CCODE,CGTIME,TOTAL_VOL,TOLL
FILEO PRINTO[1] = "D:\FSUTMS\D2\NERPM\CUBE\ANNET00E.PRN"
FILEI LINKI[1] = "{SCENARIO_DIR}\LOADED.NET"

; =========================================================
; LINKMERGE PHASE
; =========================================================
PHASE=LINKMERGE

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
;
; *****************************
;
   count   = COUNT    ;selected real counts, not repeated
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
   ARRAY _err=13, _cns=13, _cnt=13, _RGP=13, _volbyft=100, _cntbyft=100
   ARRAY _volbyat=100, _cntbyat=100, _lnkbyft=100, _lnkbyat=100
   ARRAY _volbyftg=100, _volbyatg=100, _cntbyftg=100, _cntbyatg=100
   ARRAY _lnkbyftg=100, _lnkbyatg=100
   ARRAY _volbyLNS=100, _cntbyLNS=100, _lnkbyLNS=100
   ARRAY _volbysl=100, _cntbysl=100, _lnkbysl=100
   _group=(0.0*FACILITY_TYPE)
   _RGP[1]=1, _RGP[2]=5000, _RGP[3]=10000, _RGP[4]=20000, _RGP[5]=30000, _RGP[6]=40000, _RGP[7]=50000,
   _RGP[8]=60000, _RGP[9]=70000, _RGP[10]=80000, _RGP[11]=90000, _RGP[12]=100000, _RGP[13]=500000
   IF (A=1)
     LOOP _iter=1,13
           _err[_iter]=0,_cnt[_iter]=0,_cns[_iter]=0
     ENDLOOP
     LOOP _iter=1,99
           _volbyft[_iter]=0, _cntbyft[_iter]=0, _lnkbyft[_iter]=0
           _volbyat[_iter]=0, _cntbyat[_iter]=0, _lnkbyat[_iter]=0
           _volbyftg[_iter]=0, _cntbyftg[_iter]=0, _lnkbyftg[_iter]=0
           _volbyatg[_iter]=0, _cntbyatg[_iter]=0, _lnkbyatg[_iter]=0
           _volbyLNS[_iter]=0, _cntbyLNS[_iter]=0, _lnkbyLNS[_iter]=0
           _volbysl[_iter]=0, _cntbysl[_iter]=0, _lnkbysl[_iter]=0

     ENDLOOP
   ENDIF
;   FNAME='ROADNAME'
; establish some English sounding variables for the output network
   links=1
   lanemiles=lns*distance
; calculate and compartmentalize 
   IF(_aK>0) VOLCNT=TOTAL_VOL/_aK, NETDIFF=TOTAL_VOL-_aK, ABSDIFF=ABS(NETDIFF), ERRORSQ=NETDIFF^2, PCTDIFF=100*NETDIFF/_aK _group=1
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
   _ERR[_group]=ERRORSQ+_ERR[_group], _CNS[_group]=_aK+_CNS[_group], _CNT[_group]=_CNT[_group]+1
   _ERR[13]=ERRORSQ+_ERR[13], _CNS[13]=_aK+_CNS[13], _CNT[13]=_CNT[13]+1
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

endif
CROSSTAB  VAR= LINKS LANEMILES, form=12.0c,
    row=FT, range=10-99-10,
    col=LNS, range=1-5-1,6-9
IF (_aK>0)
CROSSTAB  VAR= TOTAL_VOL,_aK, form=12.0c,
    row=FT, range=10-99-10,
    col=AT, range=10-59-10
ENDIF
CROSSTAB  VAR= LINKS LANEMILES, form=12.0c,
    row=FTG, range=1-9-1,
    col=LNS, range=1-5-1,6-9
IF (_aK>0)
CROSSTAB  VAR= TOTAL_VOL,_aK, form=12.0c,
    row=FTG, range=1-9-1,
    col=ATG, range=1-5-1
ENDIF

;if (count=0) delete

ENDPHASE

; =========================================================
; SUMMARY REPORTING
; =========================================================
PHASE=SUMMARY
; a little loop to write out the Percent Root Mean Square Error
LOOP _iter=1,12  
  if (_iter=1) print list="*********************** ALL COUNT ROOT MEAN SQUARE ERROR SUMMARY ***********************", printo=1
  if (_cnt[_iter]>0) print,        
 list="  Percent RMSE for Volume Group ",_iter(2.0c)," ",_RGP[_iter](7.0c),"-",_RGP[_iter+1](7.0c),": ",sqrt(_err[_iter]/_cnt[_iter])/(_cns[_iter]/_cnt[_iter])*100(5.1),"%,                      N=",_cnt[_iter](5.0CL), PRINTO=1
ENDLOOP
_iter=13
 list="  Percent RMSE for Volume Group ",_iter(2.0c)," ",_RGP[1](7.0c),"-",_RGP[_iter](7.0c),": ",sqrt(_err[_iter]/_cnt[_iter])/(_cns[_iter]/_cnt[_iter])*100(5.1),"%,                      N=",_cnt[_iter](5.0CL), PRINTO=1

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
  if (_iter=1) print list="\n","\n ************************* VOLUME AND COUNT SUMMARY BY SCREENLINE*******************", PRINTO=1
if (_cntbysl[_iter]>0) print,
 list="    Area Type Summary for SL=",_iter(3.0c),
 " VOL=",_volbysl[_iter](11.0c),
 " CNT=",_cntbysl[_iter](11.0c),
 " VOL/CNT=",(_volbysl[_iter]/_cntbysl[_iter])(5.2c),
 "   N=",_lnkbysl[_iter](5.0c), PRINTO=1
ENDLOOP


ENDPHASE



ENDRUN
