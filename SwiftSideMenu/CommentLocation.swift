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
    var reportLocation: CLLocation = CLLocation();
    func valuesDicForComment(comment: String)->NSDictionary{
        var values:NSMutableDictionary = NSMutableDictionary();
        values.setValue(comment, forKey: "comment");
        var lon:String = NSUserDefaults.standardUserDefaults().valueForKey("reportLon") as! String;
        var lat:String = NSUserDefaults.standardUserDefaults().valueForKey("reportLat") as! String;
        values.setValue(lon, forKey: "reportLon");
        values.setValue(lat, forKey: "reportLat");
        
        return values;
    }
    func objectFromDict(values: NSDictionary)->CommentLocation{
        var commentLocation: CommentLocation =  CommentLocation();
        commentLocation.comment = values.objectForKey("comment")as! String;
        var lat: NSString = values.objectForKey("reportLat") as! NSString;
        var lon: NSString = values.objectForKey("reportLon")as! NSString;
        commentLocation.reportLocation = CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
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