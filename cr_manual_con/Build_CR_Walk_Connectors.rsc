
Macro "Build_CR_Walk_Connectors"
    
    
    // 
    RunMacro("G30 File Close All")
    
    // Path and file settings
    scenario_path   = "C:\\projects\\JTA\\CR_trips_by_stn\\shapeFiles\\tcad\\"
    taz_DBD         = scenario_path + "Zones.dbd"
    crStn_DBD       = scenario_path + "CR_Stations.dbd"  
    centroid_DBD    = scenario_path + "Centroids.dbd" 
    cc_DBD          = scenario_path + "CentroidConnectors.dbd"
    
    temp_intersection_file = scenario_path +"temp_buffers.dbd"
    accessLink_output = scenario_path +"CR_Manual_Walk_Connectors.NTL"
    
    tcad_cube_scalar = 3    
/*    
    // Turn on trace    
    trace_debug     = 0                                  // 1 = turn on trace 
    trace_nodes     = {34345, 34124, 34069, 2252, 5445}  // node number 
    trace_output    = "trace_intersections_links.txt"          // Trace output
       
    // TRACE: output
    if (trace_debug = 1) then do
       traceFile    = scenario_path + "\\"+trace_output
       fptr = OpenFile(traceFile, "w")
       WriteLine(fptr, "====== Trace on Intersection Computation =======" )
    end
*/
    
    // Open taz in map     
    map = RunMacro("G30 new map",taz_DBD, "False")
    // SetMapProjection(null, "nad83:903", {"units=us-ft"}) // this should address the 
    area_layer = GetMapLayers(map,"Area")
    zone_lyr = area_layer[1][1]  
    
    // Add station node layer to map                               
    crLayers=GetDBLayers(crStn_DBD)                                 
    cr_lyr = AddLayer(map,crLayers[1],crStn_DBD,crLayers[1])   

    // Add Centroid layer to map  
    centLayers=GetDBLayers(centroid_DBD)                                 
    cen_lyr = AddLayer(map,centLayers[1],centroid_DBD,centLayers[1])                    
                      
    // Create buffer around commuter rail stations and add it to map
    SetLayer(cr_lyr)
    commuter_stations = "CR_Stns_Selection"
    n_stns = SelectByQuery(commuter_stations,"Several", "SELECT * Where STOPNODE >= "+ String(90000))
    SetSelectDisplay("True")
    
    buffer_size = 1.2 * tcad_cube_scalar
    buffer_name = "buffers"
    CreateBuffers(temp_intersection_file, buffer_name,{commuter_stations},"Value",{buffer_size},{{"Interior","Separate"},{"Exterior","Separate"}})
    NewLayer = GetDBLayers(temp_intersection_file)
    buffer_lyr = AddLayer(map,buffer_name,temp_intersection_file,NewLayer[1])
    list_of_buffers = GetDataVector(buffer_lyr+"|", "ENTITY ID",)    
    
    // For each buffer
    for b = 1 to list_of_buffers.length do
      SetLayer(buffer_lyr)   
      selected_buffer = SelectByQuery("buffer_selection","Several", "SELECT * Where [ENTITY ID] = " + String(list_of_buffers[b]) )
    
      // Select zones touching the station buffer
      SetLayer(zone_lyr)
      SetSelectInclusion("Intersecting")
      n_zones = SelectByVicinity("zone_Selection", "Several", buffer_lyr+"|buffer_selection", 0.0, {"Inclusion","Intersecting"})
      SetSelectDisplay("True")   
        
      // Select centroids inside the zones                                                  
      SetLayer(cen_lyr)                                                                            
      n_cents = SelectByVicinity("Cent_Selection", "Several", zone_lyr+"|zone_Selection", 0.0)
      SetSelectDisplay("True")
      
      // Select station inside the buffer
      SetLayer(cr_lyr)
      SetSelectInclusion("Intersecting")                                                                                        
      n_station = SelectByVicinity("Station_Selection", "Several", buffer_lyr+"|buffer_selection", 0.0, {"Inclusion","Intersecting"})
      
      // Add some highway layer (line layer) to build walk access connectors
      // hwyLayers  = GetDBLayers(cc_DBD)                         
      // line_lyr = AddLayer(map,hwyLayers[2],cc_DBD,hwyLayers[2])
      
      // List of zones, stns for which connectors need to be built
      // dim zones[n_cents], CR_stns[n_stns]
      zone_ids = GetDataVector(cen_lyr+"|Cent_Selection", "ID",  )
      zone_taz = GetDataVector(cen_lyr+"|Cent_Selection", "N",  )
      zone_lat = GetDataVector(cen_lyr+"|Cent_Selection", "Latitude",  )
      zone_lon = GetDataVector(cen_lyr+"|Cent_Selection", "Longitude",  )
      
      cr_ids  = GetDataVector(cr_lyr+"|Station_Selection", "ID",  )     
      cr_node  = GetDataVector(cr_lyr+"|Station_Selection", "STOPNODE",  ) 
      cr_lat = GetDataVector(cr_lyr+"|Station_Selection", "Latitude",  )
      cr_lon = GetDataVector(cr_lyr+"|Station_Selection", "Longitude",  )     
      
      // Loop over each centroid and build connectors to CR stations   
      // SetLayer(line_lyr)          
      for z = 1 to n_zones do
         // Get zone coord
         // SetLayer(cen_lyr)
         // zone_coord = GetPoint(zone_ids[z])
         zone_coord = Coord(zone_lon[z], zone_lat[z])
         
         for c = 1 to n_station do
            // Get stn coord
            // SetLayer(cr_lyr)
            // stn_coord = GetPoint(cr_ids[c])
            stn_coord = Coord(cr_lon[c], cr_lat[c])
            
            // Compute distance
            dist = GetDistance(zone_coord, stn_coord)
            cap_dist = Min(dist,1.0)
            time = 60 * cap_dist/3.5
            
            // Less than 1.5 Mile
            //if(dist <= 1.5) then do
               
               // Add walk connector
               // new_id = AddLink({zone_coord, stn_coord}, , )
               
               // Write out csv file
               if (b=1 & z=1 & c=1) then do
                 accessFile    = accessLink_output
                 fptr = OpenFile(accessFile, "w") 
                 WriteLine(fptr, ';;<<PT>>;;')
               end
               WriteLine(fptr,"NT LEG = " + String(zone_taz[z]) + "-" + String(cr_node[c]) + " MODE= 7 COST= " + String(time) + " DIST= " + String(cap_dist) + " ONEWAY=T")
               WriteLine(fptr,"NT LEG = " + String(cr_node[c])  + "-" + String(zone_taz[z])+ " MODE= 14 COST= " + String(time) + " DIST= " + String(cap_dist) + " ONEWAY=T")
               if (b=list_of_buffers.length & z=n_zones & c=n_station) then CloseFile(fptr)
               
           // end
         end
      end
    end
    RunMacro("G30 File Close All")
    ShowMessage("It's Done")    
    
EndMacro