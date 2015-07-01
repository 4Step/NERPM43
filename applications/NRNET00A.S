;;<<PROCESS TEMPLATE>><<NETWORK>>;;
;{note1,note,18,"Compare Loaded Tranplan and Voyager Highway Networks"}  Compare Loaded Tranplan and VOYAGER Highway Networks >>>
;Input  Tranplan Highway Network File: {neti1,filename,"Enter Input Tranplan Highway Network File Name",x,"","Network File (*.net)|*.net"}
;Input  Voyager Highway Network File: {neti2,filename,"Enter Input Voyager Highway Network File Name",x,"","Network File (*.net)|*.net"}
;Output Highway Network File:   {neto,filename,"Enter Output Highway Network File Name",x,"","Network File (*.net)|*.net"}
;Criterion For High Volume Links (Trips): {hivol,editbox,"Criterion For High Volume Links (Trips)",N,"1000"}
;Criterion For Link Difference (%): {linkpct,editbox,"Criterion For Link Difference (%)",N,"10"}
;*******************************************************************
;                   NETWORK COMPARISION SCRIPT                     *  
;*******************************************************************
; BY CITILABS, 8/23/01
;
; THIS SCRIPT COMPARES TWO LOADED NETWORK FILES.
; 
; VOLUME ON TRANPLAN NETWORK -- L1.VOLPURP1
; VOLUME ON VOYAGER      NETWORK -- L2.V_1
; VOLUME DIFFERENCES (TP-TN) -- VOL_DIFF1
;
; FREQUENCY OF % DIFFERENCE IN LINK VOLUMES BY VOLUME GROUP IS REPORTED.
; FREQUENCY OF % DIFFERENCE IN LINK VMT     BY ASGN GROUP   IS REPORTED.
; VARIOUS STATISTICS ARE ALSO AVAILABLE IN "PROCESS PHASE SUMMARY" IN PRINT FILE
;

RUN PGM=NETWORK
  NETI={neti1.q}, {neti2.q}
  NETO={neto.q}

  PHASE=LINKMERGE
    ; SET A TEMPORARY VARIABLE 'COUNT' TO ACCUMULATE LINK COUNTS
    COUNT=1  
    VOL_DIFF1=L2.V_1-L1.VOLPURP1
    ; CALCULATE PERCENT DIFFERENCES IN LINK VOLUMES
    ; MIN OUT AT -1000% AND MAX OUT AT 1000%

    VOL_PCTDIFF=MAX(MIN((VOL_DIFF1*100)/MAX(L1.VOLPURP1,0.001),1000),-1000)
    CROSSTAB, VAR=COUNT, ROW=L1.VOLPURP1, RANGE=0-100.0,100.1-500.0,500.1-1000.0,
                                                1000.1-5000.0,5000.1-10000.0,
                                                10000.1-100000,0.0-100000.0,  
                         COL=VOL_PCTDIFF, RANGE=-1000--100.1, -100--50.1, 
                                                -50--20.1, -20--10.1, -10--0.1, 
                                                0.0, 0.1-10, 10.1-20, 20.1-50, 
                                                50.1-100, 100.1-1000,
                                                -10-10.0,-20.0-20,-50.0-50,
                                                -100.0-100,-1000.0-1000
  
    ; CALCULATE PERCENT DIFFERENCES IN VMT
    ; MIN OUT AT -1000% AND MAX OUT AT 1000%
    BASEVHT=ROUND(L1.VOLPURP1*L1.CGSTDTIME/100)  ; SCALE TIME BY 1/100
    TESTVHT=ROUND(L2.V_1*L2.TIME_1)   
    BASEVMT=ROUND(L1.VOLPURP1*L1.DISTANCE/100)   ; SCALE DISTANCE BY 1/100
    TESTVMT=ROUND(L2.V_1*L2.DISTANCE)   
  
    ; ACCUMULATE TOTAL VMT'S AND VHT'S
    _TotalBaseVMT=_TotalBaseVMT+BASEVMT
    _TotalTestVMT=_TotalTestVMT+TESTVMT
    _TotalBaseVHT=_TotalBaseVHT+BASEVHT
    _TotalTestVHT=_TotalTestVHT+TESTVHT
  
    ; KEEP TRACK OF HIGH VOLUME LINKS
    IF (L1.VOLPURP1>={hivol})                   ; HIGH VOLUME (VOL>=HIVOL) LINKS 
	    HiCnt=1                                   ; high volume link count variable
	    _TotHiCnt=_TotHiCnt+HiCnt                 ; total high volume link count 
	    IF (ABS(VOL_PCTDIFF)>{linkpct})                  ; DIFF EXCEEDS {linkpct}% 
	      HiDiffCnt=1                             ; DIFF EXCEEDS {linkpct}% high volume link count variable
	      _TotHiDiffCnt=_TotHiDiffCnt+HiDiffCnt   ; total DIFF EXCEEDS {linkpct}% high volume link count 
	    ENDIF
    ENDIF
  ENDPHASE

  PHASE=SUMMARY
    _TotVMTDiffPct=((_TotalTestVMT/_TotalBaseVMT)-1)*100
    _TotVHTDiffPct=((_TotalTestVHT/_TotalBaseVHT)-1)*100 
    _HiLinkHiDiffPct=_TotHiDiffCnt*100/_TotHiCnt

    _TempStr='***************************************************************'
    list='\n\n\n',_TempStr
    _TempStr='*****                                                     *****'
    list=_TempStr
    _TempStr='*****               COMPARISION RESULTS                   *****'
    list=_TempStr
    _TempStr='*****                                                     *****'
    list=_TempStr
    _TempStr='***************************************************************'
    list=_TempStr,'\n'
    _TempStr='***** The Total VMT is off by '+
             str(_TotVMTDiffPct,5,1)+'%'
    list=_TempStr,'\n'
    _TempStr='***** The Total VHT is off by '+
             str(_TotVHTDiffPct,5,1)+'%'
    list=_TempStr,'\n'
    _TempStr='***** There are '+str(_HiLinkHiDiffPct,5,1)+
             '% of high volume links differ by {linkpct}%'
    list=_TempStr ,'\n'
    _TempStr='***** (The high volume criterion is {hivol} trips.)'
    list=_TempStr,'\n'
    _TempStr='***************************************************************'
    list=_TempStr,'\n\n\n'
    _TempStr=''
  ENDPHASE
ENDRUN


