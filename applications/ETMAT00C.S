; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX PRNFILE="C:\NERPM43_Delivered\APPLICATIONS\ETMAT00C.PRN" MSG='Process to develop JaxPort Freight Truck Od tables'
FILEI MATI[1] = "{Catalog_Dir}\output_SWM\EC2030_SWM\nerpm4ttx.mat"
FILEO RECO[2] = "{Catalog_Dir}\output_SWM\EC2030_SWM\FTE_TT.DBF",
   fields=az,bz,tr
FILEO RECO[1] = "{Catalog_Dir}\output_SWM\EC2030_SWM\FTE.DBF",
   fields=z,FTE
FILEI LOOKUPI[1] = "{Catalog_Dir}\input_SWM\EC2030_SWM\JAXPORT.DBF"
FILEO MATO[1] = "{Catalog_Dir}\output_SWM\EC2030_SWM\JAX_PORTS.MAT",
mo=1,name=Port_trk_veh


Array prod=zones,attr=zones,jport=zones
Array zt=99,TE=99,HFR=99,IFR=99,JFR=99,TYP=99,Htrp=99,Itrp=99,Iterm=99

LOOKUP LOOKUPI=1,
       NAME=JaxPort,
         LOOKUP[1]=INDEX, RESULT=ZONE,
         LOOKUP[2]=INDEX, RESULT=TRIPENDS,
         LOOKUP[3]=INDEX, RESULT=HWY_FRAC,
         LOOKUP[4]=INDEX, RESULT=IM_FRAC,
         LOOKUP[5]=INDEX, RESULT=TYPE,
       FAIL[1]=-1,FAIL[2]=-1,FAIL[3]=-1
;ZONE     = FLSWM (JAX extract 1-508) TAZ
;TRIPENDS = daily port truck units
;HWY_FRAC = fraction of port trip ends that leave the port area by truck
;IM_FRAC  = fraction of trucks leaving the port bound to intermodal terminals for type 1
;IM_FRAC  = fraction of trucks leaving the ports bound to this intermodal terminal for type 2 (file sum for type 2 must total 1.00)
;TYPE     = 1=port, 2= intermodal yard

if(i=1)
loop k=1,99
  zt[k]=JaxPort(1,k)
  if(zt[k]=-1) break
  numports=k
  TE[k]=JaxPort(2,k)
  HFR[k]=JaxPort(3,k)
  IFR[k]=JaxPort(4,k)
  TYP[k]=JaxPort(5,k)
  Htrp[k]=TE[k]*HFR[k]*(1-IFR[k])
  Itrp[k]=TE[k]*HFR[k]*IFR[k]
  Htsum=Htsum+Htrp[k]    ; highway trips
  Itsum=Itsum+Itrp[k]    ; trips to intermodal yards
  if(TYP[k]=2)
     nim=nim+1 ; number of intermodal facilities
     JFR[nim]=IFR[k]
     Iterm[nim]=zt[k]
     imftot=imftot+IFR[k]
  endif
  dex=zt[k]
  if(TYP[k]=1) jport[dex]=1
endloop
if(imftot<>1.0 & imftot<>1.0)
   print list='\n\n**************************** FATAL ERROR **************************'
   print list='IM_FRAC for TYPE=2 must total 1.0 or 0.0 but sums to ',imftot(5.2)
   print list='*******************************************************************\n\n'
   ABORT
endif
endif

mw[3]=mi.1.1.T

; find ports
/*
isport=0
loop k=1,numports
  if(TYP[k]=1 & i=ZT[k]) isport=1
endloop
if(isport=1)
*/ 
   mw[1]=mi.1.1/1.5  ;PCE_HT=1.5
   mw[2]= mw[3]/1.5  ;PCE_HT=1.5
;endif

/*
Jloop
  if(jport[j]=1) 
      mw[1]=mi.1.1/1.5  ;PCE_HT=1.5
      mw[2]= mw[3]/1.5  ;PCE_HT=1.5
  endif
endJloop
*/

;z=i
FTE=rowsum(1)+rowsum(2)
isport=0
loop k=1,numports
  if(i=ZT[k]) isport=1
endloop
if(isport=0) 
   attr[i]=FTE
   SA=SA+FTE
endif
;
write reco=1

if(i=zones)

loop p=1,numports
  if(TYP[p]=1)
     factor=Htrp[p]/SA
     loop k=1,zones
         attr1=attr[k]*factor
         isim=0
         loop n=1,nim
             if(Iterm[n]=k)attr1=JFR[n]*Itrp[p]
         endloop
         az=zt[p]
         bz=k
         tr=attr1
         if(tr>0) write reco=2
         alltr=alltr+attr1
     endloop
  endif
endloop

endif

ENDRUN
