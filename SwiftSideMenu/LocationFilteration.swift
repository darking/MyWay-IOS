//
//  LocationFilteration.swift
//  Post Report
//
//  Created by hebah albuloushi on 8/17/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import CoreLocation

class LocationFilteration{
    
    
    
    func filterLocations(allReports: NSMutableArray, currentLocation:CLLocation, distance:Double) ->NSArray{
        var nearReports: NSMutableArray = NSMutableArray();
        for (var i = 0 ; i < allReports.count ; i++) {
            var currentReport: CommentLocation  = CommentLocation().objectFromDict(allReports.objectAtIndex(i) as! NSDictionary);
            if currentReport.reportLocation.distanceFromLocation(currentLocation) < distance {
                nearReports.addObject(currentReport);
            }
            
        }
        println(nearReports)
            
        return nearReports;
        
    
    }


}