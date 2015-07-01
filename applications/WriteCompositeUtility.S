                                                                                 
      print list='\n\n********************************************************************************************', printo=1                     
      print list=' Access Type: ',ACC(1.0),'. ',ACC_NAME, printo=1                                                                                
      print list='********************************************************************************************','\n' printo=1                     
      print list='\n\nPercent walk at Production zone               ',(ZI.1.PCWPRD@PERIOD@[I] * 0.01),printo=1                                    
      print list='Percent walk at Attraction zone               ',(ZI.1.PCWPRD@PERIOD@[J] * 0.01),printo=1                                        
      print list='Value of CBD dummy at attraction end (1 or 0)                                      ',ZI.1.CBD_DUMMY[J],printo=1                 
      print list='Value of EXURBAN dummy at production end (1 or 0)                                  ',ZI.1.EXU_DUMMY[I],printo=1                 
      print list='Value of EXURBAN dummy at attraction end (1 or 0)                                  ',ZI.1.EXU_DUMMY[J],printo=1                 
                                                                                                                                                  
      print list='\n\n\nElements used in Drive Alone disutility calculations: ***************************', printo=1                              
      print list='In-Vehicle time                                                                    ',MW[3][J],printo=1                          
      print list='In-Vehicle time including time equivalent cost of tolls                            ',MW[4][J],printo=1                          
      print list='Out of Vehicle time (Terminal time at production-end)                              ',ZI.1.TERMTIME[I],printo=1                  
      print list='Out of Vehicle time (Terminal time at attraction-end)                              ',ZI.1.TERMTIME[J],printo=1                  
      print list='Parking Cost                                                                       ',ZI.1.@PRK@[J],printo=1                     
      print list='Highway Distance (in miles)                                                        ',MW[2][J],printo=1                          
      print list='Highway Toll (in $)                                                                ',MW[1][J],printo=1                          
      print list='Drive alone common disutility, scaled                                            ',MW[301][J](12.4),printo=1                    
      print list='Drive alone composite disutility, ', Market_Name[1], '                 ',MW[401][J](12.4),printo=1                              
      print list='Drive alone composite disutility, ', Market_Name[2], '                 ',MW[421][J](12.4),printo=1                              
      print list='Drive alone composite disutility, ', Market_Name[3], '                 ',MW[441][J](12.4),printo=1                              
      print list='Drive alone composite disutility, ', Market_Name[4], '                 ',MW[461][J](12.4),printo=1                              
      print list='Drive alone composite disutility, ', Market_Name[5], '                 ',MW[481][J](12.4),printo=1                              
      print list='Drive alone composite disutility, ', Market_Name[6], '                 ',MW[501][J](12.4),printo=1                              
      print list='Drive alone composite disutility, ', Market_Name[7], '                 ',MW[521][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in Shared Ride 2 disutility calculations: ***************************', printo=1                            
      print list='In-Vehicle time                                                                    ',MW[7][J],printo=1                          
      print list='In-Vehicle time including time equivalent cost of tolls                            ',MW[8][J],printo=1                          
      print list='In-Vehicle time savings by using HOV lanes                                         ',MAX((MW[7][J]-MW[3][J]), 0),printo=1       
      print list='Out of Vehicle time (Terminal time at production-end)                              ',ZI.1.TERMTIME[I],printo=1                  
      print list='Out of Vehicle time (Terminal time at attraction-end)                              ',ZI.1.TERMTIME[J],printo=1                  
      print list='Parking Cost                                                                       ',ZI.1.@PRK@[J],printo=1                     
      print list='Highway Distance (in miles)                                                        ',MW[6][J],printo=1                          
      print list='Highway Toll (in $)                                                                ',MW[5][J],printo=1                          
      print list='Shared ride 2 common disutility, scaled                                          ',MW[302][J](12.4),printo=1                    
      print list='Shared ride 2 composite disutility, ', Market_Name[1], '               ',MW[402][J](12.4),printo=1                              
      print list='Shared ride 2 composite disutility, ', Market_Name[2], '               ',MW[422][J](12.4),printo=1                              
      print list='Shared ride 2 composite disutility, ', Market_Name[3], '               ',MW[442][J](12.4),printo=1                              
      print list='Shared ride 2 composite disutility, ', Market_Name[4], '               ',MW[462][J](12.4),printo=1                              
      print list='Shared ride 2 composite disutility, ', Market_Name[5], '               ',MW[482][J](12.4),printo=1                              
      print list='Shared ride 2 composite disutility, ', Market_Name[6], '               ',MW[502][J](12.4),printo=1                              
      print list='Shared ride 2 composite disutility, ', Market_Name[7], '               ',MW[522][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in Shared Ride 3+ disutility calculations: ***************************', printo=1                           
      print list='In-Vehicle time                                                                    ',MW[7][J],printo=1                          
      print list='In-Vehicle time including time equivalent cost of tolls                            ',MW[8][J],printo=1                          
      print list='In-Vehicle time savings by using HOV lanes                                         ',MAX((MW[7][J]-MW[3][J]), 0),printo=1       
      print list='Out of Vehicle time (Terminal time at production-end)                              ',ZI.1.TERMTIME[I],printo=1                  
      print list='Out of Vehicle time (Terminal time at attraction-end)                              ',ZI.1.TERMTIME[J],printo=1                  
      print list='Parking Cost                                                                       ',ZI.1.@PRK@[J],printo=1                     
      print list='Highway Distance (in miles)                                                        ',MW[6][J],printo=1                          
      print list='Occupancy rate for 2+ car market                                                   ',@OCC3@,printo=1                            
      print list='Highway Toll (in $)                                                                ',MW[5][J],printo=1                          
      print list='Shared ride 2+ common disutility, scaled                                         ',MW[303][J](12.4),printo=1                    
      print list='Shared ride 2+ composite disutility, ', Market_Name[1], '              ',MW[403][J](12.4),printo=1                              
      print list='Shared ride 2+ composite disutility, ', Market_Name[2], '              ',MW[423][J](12.4),printo=1                              
      print list='Shared ride 2+ composite disutility, ', Market_Name[3], '              ',MW[443][J](12.4),printo=1                              
      print list='Shared ride 2+ composite disutility, ', Market_Name[4], '              ',MW[463][J](12.4),printo=1                              
      print list='Shared ride 2+ composite disutility, ', Market_Name[5], '              ',MW[483][J](12.4),printo=1                              
      print list='Shared ride 2+ composite disutility, ', Market_Name[6], '              ',MW[503][J](12.4),printo=1                              
      print list='Shared ride 2+ composite disutility, ', Market_Name[7], '              ',MW[523][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in Walk Bus disutility calculations: ***************************', printo=1                                 
      print list='In-Vehicle time (Bus)                                                              ',MW[24][J],printo=1                         
      print list='In-Vehicle time (PRJ Bus)                                                          ',MW[25][J],printo=1                         
      print list='In-Vehicle time (Circulator)                                                       ',MW[26][J],printo=1                         
      print list='In-Vehicle time (Rail)                                                             ',(MW[27][J]+MW[28][J]),printo=1             
      print list='In-Vehicle time (Project Mode)                                                     ',MW[30][J],printo=1                         
      print list='Out of Vehicle time (Walk)                                                         ',MW[21][J],printo=1                         
      print list='Out of Vehicle time (Transfer Walk)                                                ',MW[23][J],printo=1                         
      print list='Out of Vehicle time (IWAIT)                                                        ',MW[32][J],printo=1                         
      print list='Out of Vehicle time (XWAIT)                                                        ',MW[33][J],printo=1                         
      print list='Number of transfers                                                                ',MW[31][J],printo=1                         
      print list='Transit Fare (in cents)                                                            ',MW[34][J],printo=1                         
      print list='Walk Bus common disutility, scaled                                               ',MW[304][J](12.4),printo=1                    
      ;print list='Walk access dummy (added to the utility)                                           ',walk_acc_dum,printo=1                     
      print list='Walk Bus composite disutility, ', Market_Name[1], '                    ',MW[404][J](12.4),printo=1                              
      print list='Walk Bus composite disutility, ', Market_Name[2], '                    ',MW[424][J](12.4),printo=1                              
      print list='Walk Bus composite disutility, ', Market_Name[3], '                    ',MW[444][J](12.4),printo=1                              
      print list='Walk Bus composite disutility, ', Market_Name[4], '                    ',MW[464][J](12.4),printo=1                              
      print list='Walk Bus composite disutility, ', Market_Name[5], '                    ',MW[484][J](12.4),printo=1                              
      print list='Walk Bus composite disutility, ', Market_Name[6], '                    ',MW[504][J](12.4),printo=1                              
      print list='Walk Bus composite disutility, ', Market_Name[7], '                    ',MW[524][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in Walk Prj disutility calculations: ***************************', printo=1                                 
      print list='In-Vehicle time (Bus)                                                              ',MW[44][J],printo=1                         
      print list='In-Vehicle time (PRJ Bus)                                                          ',MW[45][J],printo=1                         
      print list='In-Vehicle time (Circulator)                                                       ',MW[46][J],printo=1                         
      print list='In-Vehicle time (Rail)                                                             ',(MW[47][J]+MW[48][J]),printo=1             
      print list='In-Vehicle time (Project Mode)                                                     ',MW[50][J],printo=1                         
      print list='Out of Vehicle time (Walk)                                                         ',MW[41][J],printo=1                         
      print list='Out of Vehicle time (Transfer Walk)                                                ',MW[43][J],printo=1                         
      print list='Out of Vehicle time (IWAIT)                                                        ',MW[52][J],printo=1                         
      print list='Out of Vehicle time (XWAIT)                                                        ',MW[53][J],printo=1                         
      print list='Number of transfers                                                                ',MW[51][J],printo=1                         
      print list='Transit Fare (in cents)                                                            ',MW[54][J],printo=1                         
      print list='Walk Prj common disutility, scaled                                               ',MW[305][J](12.4),printo=1                    
      ;print list='Walk access dummy (added to the utility)                                           ',walk_acc_dum,printo=1                     
      print list='Walk Prj composite disutility, ', Market_Name[1], '                    ',MW[405][J](12.4),printo=1                              
      print list='Walk Prj composite disutility, ', Market_Name[2], '                    ',MW[525][J](12.4),printo=1                              
      print list='Walk Prj composite disutility, ', Market_Name[3], '                    ',MW[445][J](12.4),printo=1                              
      print list='Walk Prj composite disutility, ', Market_Name[4], '                    ',MW[465][J](12.4),printo=1                              
      print list='Walk Prj composite disutility, ', Market_Name[5], '                    ',MW[485][J](12.4),printo=1                              
      print list='Walk Prj composite disutility, ', Market_Name[6], '                    ',MW[505][J](12.4),printo=1                              
      print list='Walk Prj composite disutility, ', Market_Name[7], '                    ',MW[525][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in PNR Bus disutility calculations: ***************************', printo=1                                  
      print list='In-Vehicle time (Bus)                                                              ',MW[64][J],printo=1                         
      print list='In-Vehicle time (PRJ Bus)                                                          ',MW[65][J],printo=1                         
      print list='In-Vehicle time (Circulator)                                                       ',MW[66][J],printo=1                         
      print list='In-Vehicle time (Rail)                                                             ',(MW[67][J]+MW[68][J]),printo=1             
      print list='In-Vehicle time (Project Mode)                                                     ',MW[70][J],printo=1                         
      print list='Out of Vehicle time (Walk)                                                         ',MW[61][J],printo=1                         
      print list='Out of Vehicle time (Auto access time in IVT min - weighted)                       ',MW[62][J],printo=1                         
      print list='Out of Vehicle time (Transfer Walk)                                                ',MW[63][J],printo=1                         
      print list='Out of Vehicle time (IWAIT)                                                        ',MW[72][J],printo=1                         
      print list='Out of Vehicle time (XWAIT)                                                        ',MW[73][J],printo=1                         
      print list='Number of transfers                                                                ',MW[71][J],printo=1                         
      print list='Transit Fare (in cents)                                                            ',MW[74][J],printo=1                         
      print list='Parking cost at PNR location (in cents)                                            ',MW[291][J],printo=1                        
      print list='Terminal time at PNR location                                                      ',MW[292][J],printo=1                        
      print list='PNR Bus common disutility, scaled                                                ',MW[306][J](12.4),printo=1                    
      ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1                     
      print list='PNR Bus composite disutility, ', Market_Name[1], '                     ',MW[406][J](12.4),printo=1                              
      print list='PNR Bus composite disutility, ', Market_Name[2], '                     ',MW[426][J](12.4),printo=1                              
      print list='PNR Bus composite disutility, ', Market_Name[3], '                     ',MW[446][J](12.4),printo=1                              
      print list='PNR Bus composite disutility, ', Market_Name[4], '                     ',MW[466][J](12.4),printo=1                              
      print list='PNR Bus composite disutility, ', Market_Name[5], '                     ',MW[486][J](12.4),printo=1                              
      print list='PNR Bus composite disutility, ', Market_Name[6], '                     ',MW[506][J](12.4),printo=1                              
      print list='PNR Bus composite disutility, ', Market_Name[7], '                     ',MW[526][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in PNR Prj disutility calculations: ***************************', printo=1                                  
      print list='In-Vehicle time (Bus)                                                              ',MW[84][J],printo=1                         
      print list='In-Vehicle time (PRJ Bus)                                                          ',MW[85][J],printo=1                         
      print list='In-Vehicle time (Circulator)                                                       ',MW[86][J],printo=1                         
      print list='In-Vehicle time (Rail)                                                             ',(MW[87][J]+MW[88][J]),printo=1             
      print list='In-Vehicle time (Project Mode)                                                     ',MW[90][J],printo=1                         
      print list='Out of Vehicle time (Walk)                                                         ',MW[81][J],printo=1                         
      print list='Out of Vehicle time (Auto access time in IVT min - weighted)                       ',MW[82][J],printo=1                         
      print list='Out of Vehicle time (Transfer Walk)                                                ',MW[83][J],printo=1                         
      print list='Out of Vehicle time (IWAIT)                                                        ',MW[92][J],printo=1                         
      print list='Out of Vehicle time (XWAIT)                                                        ',MW[93][J],printo=1                         
      print list='Number of transfers                                                                ',MW[91][J],printo=1                         
      print list='Transit Fare (in cents)                                                            ',MW[94][J],printo=1                         
      print list='Parking cost at PNR location (in cents)                                            ',MW[295][J],printo=1                        
      print list='Terminal time at PNR location                                                      ',MW[296][J],printo=1                        
      print list='PNR Prj common disutility, scaled                                                ',MW[307][J](12.4),printo=1                    
      ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1                     
      print list='PNR Prj composite disutility, ', Market_Name[1], '                     ',MW[407][J](12.4),printo=1                              
      print list='PNR Prj composite disutility, ', Market_Name[2], '                     ',MW[427][J](12.4),printo=1                              
      print list='PNR Prj composite disutility, ', Market_Name[3], '                     ',MW[447][J](12.4),printo=1                              
      print list='PNR Prj composite disutility, ', Market_Name[4], '                      ',MW[467][J](12.4),printo=1                             
      print list='PNR Prj composite disutility, ', Market_Name[5], '                     ',MW[487][J](12.4),printo=1                              
      print list='PNR Prj composite disutility, ', Market_Name[6], '                     ',MW[507][J](12.4),printo=1                              
      print list='PNR Prj composite disutility, ', Market_Name[7], '                     ',MW[527][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in KNR Bus disutility calculations: ***************************', printo=1                                  
      print list='In-Vehicle time (Bus)                                                              ',MW[64][J],printo=1                         
      print list='In-Vehicle time (PRJ Bus)                                                          ',MW[65][J],printo=1                         
      print list='In-Vehicle time (Circulator)                                                       ',MW[66][J],printo=1                         
      print list='In-Vehicle time (Rail)                                                             ',(MW[67][J]+MW[108][J]),printo=1            
      print list='In-Vehicle time (Project Mode)                                                     ',MW[70][J],printo=1                         
      print list='Out of Vehicle time (Walk)                                                         ',MW[61][J],printo=1                         
      print list='Out of Vehicle time (Auto access time in IVT min)                                  ',MW[62][J],printo=1                         
      print list='Out of Vehicle time (Transfer Walk)                                                ',MW[63][J],printo=1                         
      print list='Out of Vehicle time (IWAIT)                                                        ',MW[62][J],printo=1                         
      print list='Out of Vehicle time (XWAIT)                                                        ',MW[73][J],printo=1                         
      print list='Transit Fare (in cents)                                                            ',MW[74][J],printo=1                         
      print list='Terminal time at KNR location                                                      ',MW[293][J],printo=1                        
      print list='KNR Bus common disutility, scaled                                                ',MW[308][J](12.4),printo=1                    
      ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1                     
      print list='KNR Bus composite disutility, ', Market_Name[1], '                     ',MW[408][J](12.4),printo=1                              
      print list='KNR Bus composite disutility, ', Market_Name[2], '                     ',MW[428][J](12.4),printo=1                              
      print list='KNR Bus composite disutility, ', Market_Name[3], '                     ',MW[448][J](12.4),printo=1                              
      print list='KNR Bus composite disutility, ', Market_Name[4], '                     ',MW[468][J](12.4),printo=1                              
      print list='KNR Bus composite disutility, ', Market_Name[5], '                     ',MW[488][J](12.4),printo=1                              
      print list='KNR Bus composite disutility, ', Market_Name[6], '                     ',MW[508][J](12.4),printo=1                              
      print list='KNR Bus composite disutility, ', Market_Name[7], '                     ',MW[528][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in KNR Prj disutility calculations: ***************************', printo=1                                  
      print list='In-Vehicle time (Bus)                                                              ',MW[84][J],printo=1                         
      print list='In-Vehicle time (PRJ Bus)                                                          ',MW[85][J],printo=1                         
      print list='In-Vehicle time (Circulator)                                                       ',MW[86][J],printo=1                         
      print list='In-Vehicle time (Rail)                                                             ',(MW[87][J]+MW[128][J]),printo=1            
      print list='In-Vehicle time (Project Mode)                                                     ',MW[90][J],printo=1                         
      print list='Out of Vehicle time (Walk)                                                         ',MW[81][J],printo=1                         
      print list='Out of Vehicle time (Auto access time in IVT min)                                  ',MW[82][J],printo=1                         
      print list='Out of Vehicle time (Transfer Walk)                                                ',MW[83][J],printo=1                         
      print list='Out of Vehicle time (IWAIT)                                                        ',MW[82][J],printo=1                         
      print list='Out of Vehicle time (XWAIT)                                                        ',MW[93][J],printo=1                         
      print list='Number of transfers                                                                ',MW[91][J],printo=1                         
      print list='Transit Fare (in cents)                                                            ',MW[94][J],printo=1                         
      print list='Terminal time at KNR location                                                      ',MW[297][J],printo=1                        
      print list='KNR Prj common disutility, scaled                                                ',MW[309][J](12.4),printo=1                    
      ;print list='Auto access dummy (added to the utility)                                           ',auto_acc_dum,printo=1                     
      print list='KNR Prj composite disutility, ', Market_Name[1], '                     ',MW[409][J](12.4),printo=1                              
      print list='KNR Prj composite disutility, ', Market_Name[2], '                     ',MW[429][J](12.4),printo=1                              
      print list='KNR Prj composite disutility, ', Market_Name[3], '                     ',MW[449][J](12.4),printo=1                              
      print list='KNR Prj composite disutility, ', Market_Name[4], '                     ',MW[469][J](12.4),printo=1                              
      print list='KNR Prj composite disutility, ', Market_Name[5], '                     ',MW[489][J](12.4),printo=1                              
      print list='KNR Prj composite disutility, ', Market_Name[6], '                     ',MW[509][J](12.4),printo=1                              
      print list='KNR Prj composite disutility, ', Market_Name[7], '                     ',MW[529][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in Non-Motorized Walk disutility calculations: *****************', printo=1                                 
      print list='WalkDist1 (in miles)                                                               ',MW[12][J],printo=1                         
      print list='WalkDist2 (in miles)                                                               ',MW[13][J],printo=1                         
      print list='Walk disutility                                                                  ',MW[310][J](12.4),printo=1                    
      print list='Walk composite disutility, ', Market_Name[1], '                        ',MW[410][J](12.4),printo=1                              
      print list='Walk composite disutility, ', Market_Name[2], '                        ',MW[430][J](12.4),printo=1                              
      print list='Walk composite disutility, ', Market_Name[3], '                        ',MW[450][J](12.4),printo=1                              
      print list='Walk composite disutility, ', Market_Name[4], '                        ',MW[470][J](12.4),printo=1                              
      print list='Walk composite disutility, ', Market_Name[5], '                        ',MW[490][J](12.4),printo=1                              
      print list='Walk composite disutility, ', Market_Name[6], '                        ',MW[510][J](12.4),printo=1                              
      print list='Walk composite disutility, ', Market_Name[7], '                        ',MW[530][J](12.4),printo=1                              
                                                                                                                                                  
      print list='\n\n\nElements used in Non-Motorized Bike disutility calculations: *****************', printo=1                                 
      print list='BikeDist1 (in miles)                                                               ',MW[12][J],printo=1                         
      print list='BikeDist2 (in miles)                                                               ',MW[13][J],printo=1                         
      print list='Bike disutility                                                                  ',MW[311][J](12.4),printo=1                    
      print list='Bike composite disutility, ', Market_Name[1], '                        ',MW[411][J](12.4),printo=1                              
      print list='Bike composite disutility, ', Market_Name[2], '                        ',MW[431][J](12.4),printo=1                              
      print list='Bike composite disutility, ', Market_Name[3], '                        ',MW[451][J](12.4),printo=1                              
      print list='Bike composite disutility, ', Market_Name[4], '                        ',MW[471][J](12.4),printo=1                              
      print list='Bike composite disutility, ', Market_Name[5], '                        ',MW[491][J](12.4),printo=1                              
      print list='Bike composite disutility, ', Market_Name[6], '                        ',MW[511][J](12.4),printo=1                              
      print list='Bike composite disutility, ', Market_Name[7], '                        ',MW[531][J](12.4),printo=1                              
                                                                                                                                                  
      ;print list='PNR parkcost                                                                       ',(COEFF(1,23)/COEFF(1,1))*MW[292]          
      ;print list='termtime difference betn PNR and KNR                                               ',(COEFF(1,3)/COEFF(1,1))*(-mw[293]+mw[294])
      ;print list='see this',(MW[62]-({InflationFare}*(COEFF(1,23)/COEFF(1,1))*MW[292])+(COEFF(1,3)/COEFF(1,1))*(-mw[293]+mw[294]))               
                                                                                                                                                 
                                                                                                                                        
                                                                                                                                       
                                                                                                                                      
                                                                                                                                               
                                                                                                                                               