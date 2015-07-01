; Part of Mode choice script
; This is a report section to write out:
; 1. Write DEBUG Report
; 2. Write MODECHOICE Report

                                                                                                                                                                                                                                                           
                                                                                                                                          
   print list='MODE CHOICE TRACE @PURP@-@PERIOD@','\n\n',printo=1                                                                         
   print list='-- @DATE.RUNDATE@     ',printo=1                                                                                           
   print list='-- @TIME.RUNTIME@     ','\n\n',printo=1                                                                                    
   print list='Transit Modeling Update DEMO \n\nSelected Interchange for Tracing:    ',{SelOrigin}(4.0),'-',{SelDest}(4.0),'\n\n',printo=1
   print list='PURPOSE -                   @PURP@  ',printo=1                                                                             
   print list='SKIMS/PERIOD                @PERIOD@',printo=1                                                                             
                                                                                                                                          
   print list='\n\nCoefficients                ',printo=1                                                                                 
   print list='       IVTT                                 ',COEFF_IVTT(7.4),printo=1                                                     
   print list='       OVT                                  ',COEFF_OVT(7.4),printo=1                                                      
   print list='       AAT                                  ',COEFF_AAT(7.4),printo=1                                                      
   print list='       XFER                                 ',COEFF_XFER(7.4),printo=1                                                     
   print list='       COST ', MARKET_NAME[1],'  ',COEFF_COST[1](7.4),printo=1                                                             
   print list='       COST ', MARKET_NAME[2],'  ',COEFF_COST[2](7.4),printo=1                                                             
   print list='       COST ', MARKET_NAME[3],'  ',COEFF_COST[3](7.4),printo=1                                                             
   print list='       COST ', MARKET_NAME[4],'  ',COEFF_COST[4](7.4),printo=1                                                             
   print list='       COST ', MARKET_NAME[5],'  ',COEFF_COST[5](7.4),printo=1                                                             
   print list='       COST ', MARKET_NAME[6],'  ',COEFF_COST[6](7.4),printo=1                                                             
   print list='       COST ', MARKET_NAME[7],'  ',COEFF_COST[7](7.4),printo=1                                                             
   PRINT LIST='       DUM_CBD_WALK                         ',COEFF_DCBD_WALK(7.4),printo=1                                                
   PRINT LIST='       DUM_CBD_PNR                          ',COEFF_DCBD_PNR(7.4),printo=1                                                 
   PRINT LIST='       DUM_CBD_KNR                          ',COEFF_DCBD_KNR(7.4),printo=1                                                 
                                                                                                                                          
   print list='\n\nNesting Coefficients      ',printo=1                                                                                   
   print list='       Level 1 (pmode)                      ',NC_1(7.4),printo=1                                                           
   print list='       Level 2 (trn access)                 ',NC_2(7.4),printo=1                                                           
                                                                                                                                          
  LOOP _m=1,@MARKETS@                                                                                                                     
   print list='\n\nConstants ', MARKET_NAME[_m],printo=1                                                                                  
   print list='       Auto                                ',K_AUT[_m](8.4),printo=1                                                       
   print list='       Shared Ride                         ',K_SR[_m](8.4),printo=1                                                        
   print list='       Shared Ride 3+                      ',K_SR3[_m](8.4),printo=1                                                       
   print list='       Transit                             ',K_TRN[_m](8.4),printo=1                                                       
   print list='       Drive to Transit                    ',K_TDRV[_m](8.4),printo=1                                                      
   print list='       KNR to Transit                      ',K_TKNR[_m](8.4),printo=1                                                      
   print list='       Non Motorized                       ',K_NMOT[_m](8.4),printo=1                                                      
   print list='       Bike                                ',K_BIKE[_m](8.4),printo=1                                                      
  ENDLOOP                                                                                                                                 
                                                                                                                                          
   print list='\n\nConstants (mode-specific)           ',printo=1                                                                         
   print list='       Express bus                         ',K_EXP(8.4),printo=1                                                           
   print list='       Urban rail                          ',K_UR(8.4),printo=1                                                            
   print list='       Commuter rail                       ',K_CR(8.4),printo=1                                                            
                                                                                                                                          
   print list='\n\nParameters used in utility calculations:            ', printo=1                                                        
   print list='       Highway Operating Cost (cents/mi)      ',{hwyopcost}(5.3),printo=1                                                  
   print list='       CTOLL Multiplier (toll to time)        ',{CTOLL}(5.3),printo=1                                                      
   print list='       Value of ZAPZERO                       ',{ZAPZERO}(5.3),printo=1                                                    
   print list='       Auto Occupancy 3+ (HBW)                ',{oc3vhbw}(5.3),printo=1                                                    
   print list='       Auto Occupancy 3+ (HBNW)               ',{oc3vhbnw}(5.3),printo=1                                                   
   print list='       Inflation factor - Tolls               ',{InflationToll}(5.3),printo=1                                              
   print list='       Inflation factor - Auto Op Cost        ',{InflationAOC}(5.3),printo=1                                               
   print list='       Inflation factor - Parking Cost        ',{InflationParkCost}(5.3),printo=1                                          
   print list='       Inflation factor - Transit Fare        ',{InflationFare}(5.3),printo=1                                              
   print list='       Auto Access Auto Occupancy Factor      ',{OCCPNRAccess}(5.3),printo=1                                               
   print list='       Times are in minutes. Costs are in cents. ',printo=1                                                                
                                                                                                                                          
                                                                                                         
                                                                                                                                          
                                                                                                                                          
    ; Echo to Mode Choice summary file                                                                                                    
   PRINT LIST="\f+++++++++ MODE XCHOICE SUMMARY +++++++++\n" PRINTO=2                                                                     
   PRINT LIST='-- @DATE.RUNDATE@     ','-- @TIME.RUNTIME@     ','\n',PRINTO=2                                                             
   PRINT LIST="{SCENARIO_FULLNAME}" PRINTO=2                                                                                              
   PRINT LIST="{SCENARIO_SHORTNAME}\n" PRINTO=2                                                                                           
   PRINT LIST='PURPOSE -           @PURP@  ',printo=2                                                                                     
   PRINT LIST='SKIMS/PERIOD        @PERIOD@',printo=2                                                                                     
   PRINT LIST='\n\nCoefficients                ',printo=2                                                                                 
   PRINT LIST='       IVTT                                        ',COEFF_IVTT(7.4),printo=2                                              
   PRINT LIST='       OVT                                         ',COEFF_OVT(7.4),printo=2                                               
   PRINT LIST='       AAT                                         ',COEFF_AAT(7.4),printo=2                                               
   PRINT LIST='       XFER                                        ',COEFF_XFER(7.4),printo=2                                              
   print list='       COST ', MARKET_NAME[1],'  ',COEFF_COST[1](7.4),printo=2                                                             
   print list='       COST ', MARKET_NAME[2],'  ',COEFF_COST[2](7.4),printo=2                                                             
   print list='       COST ', MARKET_NAME[3],'  ',COEFF_COST[3](7.4),printo=2                                                             
   print list='       COST ', MARKET_NAME[4],'  ',COEFF_COST[4](7.4),printo=2                                                             
   print list='       COST ', MARKET_NAME[5],'  ',COEFF_COST[5](7.4),printo=2                                                             
   print list='       COST ', MARKET_NAME[6],'  ',COEFF_COST[6](7.4),printo=2                                                             
   print list='       COST ', MARKET_NAME[7],'  ',COEFF_COST[7](7.4),printo=2                                                             
   PRINT LIST='       DUM_CBD_WALK                                ',COEFF_DCBD_WALK(7.4),printo=2                                         
   PRINT LIST='       DUM_CBD_PNR                                 ',COEFF_DCBD_PNR(7.4),printo=2                                          
   PRINT LIST='       DUM_CBD_KNR                                 ',COEFF_DCBD_KNR(7.4),printo=2                                          
                                                                                                                                          
   print list='\n\nNesting Coeffcients     ',printo=2                                                                                     
   print list='       Level 1 (pmode)                             ',NC_1(7.4),printo=2                                                    
   print list='       Level 2 (trn access)                        ',NC_2(7.4),printo=2                                                    
                                                                                                                                          
  LOOP _m=1,@MARKETS@                                                                                                                     
   print list='\n\nConstants ', MARKET_NAME[_m],printo=2                                                                                  
   print list='       Auto                                     ',K_AUT[_m](8.4),printo=2                                                  
   print list='       Shared Ride                              ',K_SR[_m](8.4),printo=2                                                   
   print list='       Shared Ride 3+                           ',K_SR3[_m](8.4),printo=2                                                  
   print list='       Transit                                  ',K_TRN[_m](8.4),printo=2                                                  
   print list='       Drive to Transit                         ',K_TDRV[_m](8.4),printo=2                                                 
   print list='       KNR to Transit                           ',K_TKNR[_m](8.4),printo=2                                                 
   print list='       Non Motorized                            ',K_NMOT[_m](8.4),printo=2                                                 
   print list='       Bike                                     ',K_BIKE[_m](8.4),printo=2                                                 
  ENDLOOP                                                                                                                                 
                                                                                                                                          
   print list='\n\nConstants (mode-specific)           ',printo=2                                                                         
   print list='       Express bus                              ',K_EXP(8.4),printo=2                                                      
   print list='       Urban rail                               ',K_UR(8.4),printo=2                                                       
   print list='       Commuter rail                            ',K_CR(8.4),printo=2                                                       
                                                                                                                                          
   PRINT LIST='\n\nParameters used in utility calculations:            ', printo=2                                                        
   PRINT LIST='       Highway Operating Cost (cents/mi)           ',{hwyopcost}(5.3),printo=2                                             
   PRINT LIST='       CTOLL Multiplier (toll to time)             ',{CTOLL}(5.3),printo=2                                                 
   PRINT LIST='       Value of ZAPZERO                            ',{ZAPZERO}(5.3),printo=2                                               
   PRINT LIST='       Auto Occupancy 3+ (HBNW)                    ',{oc3vhbnw}(5.3),printo=2                                              
   PRINT LIST='       Auto Occupancy 3+ (NHB)                     ',{oc3vnhb}(5.3),printo=2                                               
   PRINT LIST='       Inflation factor - Tolls                    ',{InflationToll}(5.3),printo=2                                         
   PRINT LIST='       Inflation factor - Auto Op Cost             ',{InflationAOC}(5.3),printo=2                                          
   PRINT LIST='       Inflation factor - Parking Cost             ',{InflationParkCost}(5.3),printo=2                                     
   PRINT LIST='       Inflation factor - Transit Fare             ',{InflationFare}(5.3),printo=2                                         
   PRINT LIST='       Auto Access Auto Occupancy Factor           ',{OCCPNRAccess}(5.3),printo=2                                          
   PRINT LIST='       Times are in minutes.                       ',printo=2                                                              
   PRINT LIST='       Costs are in cents.                         ',printo=2                                                              
                                                                                                                                         
                                                                                                                                                                                                                                     