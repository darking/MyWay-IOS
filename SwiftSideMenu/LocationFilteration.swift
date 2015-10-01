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
//        for (var i = 0 ; i < allReports.count ; i++) {
//            var currentReport: CommentLocation  = CommentLocation().objectFromDict(allReports.objectAtIndex(i) as! NSDictionary);
//            if currentReport.reportLocation.distanceFromLocation(currentLocation) < distance {
//                nearReports.addObject(currentReport);
//            }
//            
//        }
        
        
        for (var i = 0 ; i < allReports.count ; i++) {
            var currentReport: CommentLocation  = CommentLocation().objectFromDict(allReports.objectAtIndex(i) as! NSDictionary);
            //var Time:Int=currentReport.hour;
            
            var getInfo:allCommentVC=allCommentVC();
            var hours=getInfo.AddToArray().valueForKey("hour")
            var days=getInfo.AddToArray().valueForKey("day")
            var years=getInfo.AddToArray().valueForKey("year")
            var defualtTime:Int=NSUserDefaults.standardUserDefaults().valueForKey("hour") as! Int
            var defualtDay:Int=NSUserDefaults.standardUserDefaults().valueForKey("day") as! Int
            var defualtTYear:Int=NSUserDefaults.standardUserDefaults().valueForKey("year") as! Int
            
            //println(" current \(Time)")
            // println("defualt \(defualtTime)")
            var indexTime=hours?.objectAtIndex(i) as! Int
            var indexDay=days?.objectAtIndex(i) as! Int
            var indexYear=years?.objectAtIndex(i) as! Int
            
            if ((currentReport.reportLocation.distanceFromLocation(currentLocation) < distance) && (defualtTime<=indexTime + 2 )
                && (defualtDay==indexDay) && (defualtTYear==indexYear) )
            {
                nearReports.addObject(currentReport);
                
            }
            
            
        }
        println(nearReports)
            
        return nearReports;
        
    
    }


}