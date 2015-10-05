//
//  CommentLocation.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/17/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//


import Foundation
import CoreLocation

class CommentLocation{
    
    var comment:String = "";
    var username:String = "";
    var reportTypeId:Int=0;
    var reportLocation: CLLocation = CLLocation();
    var values:NSMutableDictionary = NSMutableDictionary();
    
    
    func valuesDicForComment(comment: String,id_report: Int)->NSDictionary{
        
       
        var lon:String = NSUserDefaults.standardUserDefaults().valueForKey("lon") as! String;
        var lat:String = NSUserDefaults.standardUserDefaults().valueForKey("lat") as! String;
        username = NSUserDefaults.standardUserDefaults().valueForKey("username") as! String;
        
        
        values.setValue(comment, forKey: "comment");
        values.setValue(username, forKey: "username");
        values.setValue(id_report, forKey: "reportTypeId");
        values.setValue(lon, forKey: "lon");
        values.setValue(lat, forKey: "lat");

        return values;
        
    }
    
    func urlParams(dict:NSDictionary)->NSString{
        var lat: NSString = dict.objectForKey("lat")as! NSString;
        var lon: NSString = dict.objectForKey("lon") as! NSString;
        var comment: NSString = dict.objectForKey("comment") as! NSString;
        var reportTypeId: Int = dict.objectForKey("reportTypeId")as! Int;
        var urlUsername:String = dict.objectForKey("username") as! String;
        
        var urlStatement:NSString = "report_id=\(reportTypeId)&report_comments=\(comment)&report_lat=\(lat)&report_log=\(lon)&username=\(urlUsername)"
        
        println(urlStatement);
        
        return urlStatement;
        
        
    }
    
    func objectFromDict(values: NSDictionary)->CommentLocation{
        var commentLocation: CommentLocation =  CommentLocation();
        commentLocation.comment = values.objectForKey("comment") as! String;
        var lat: NSString = values.objectForKey("lat")as! NSString;
        var lon: NSString = values.objectForKey("lon") as! NSString;
        var reportTypeId: Int = values.objectForKey("reportTypeId") as! Int;
        commentLocation.username=values.objectForKey("username") as! String;
        commentLocation.reportTypeId=reportTypeId as Int;
        commentLocation.reportLocation=CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
        println("Tring to know what is in the commentLocation")
        println(commentLocation)
        return commentLocation
    }
    
    func dictionariesToObjects(dictionies: NSArray) -> NSMutableArray{
        
        var objectsArray: NSMutableArray = NSMutableArray();
        for values in dictionies{
            objectsArray.addObject(CommentLocation().objectFromDict(values as! NSDictionary));
        }
        
        return objectsArray;
    }
    
    

    
}