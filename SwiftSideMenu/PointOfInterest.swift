//
//  PointOfInterest.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import CoreLocation

class PointOfInterest {
    
    var name = "";
    var type = "";
    var description = "";
    var images: NSMutableArray = NSMutableArray();
    var lat = "0.0";
    var long = "0.0";
    var placeLocation:CLLocation = CLLocation();
    
    init (values:NSDictionary){
        
        self.name = values.valueForKey("name") as! String;
        self.type = values.valueForKey("type") as! String;
        self.description = values.valueForKey("description") as! String;
        self.images = values.valueForKey("imageArray") as! NSMutableArray;
        self.long = values.valueForKey("long") as! String;
        self.lat = values.valueForKey("lat") as! String;
        
    }
    
    init(){
        
    }
    
    func toDictionary()->NSDictionary{
        
        var values:NSMutableDictionary = NSMutableDictionary();
        values.setValue(name, forKey: "name");
        values.setValue(type, forKey: "type");
        values.setValue(description, forKey: "description");
        values.setValue(long, forKey: "long");
        values.setValue(lat, forKey: "lat");
        values.setValue(images, forKey: "images");
        return values;
    }
    
    
}