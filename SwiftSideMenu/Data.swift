//
//  Data.swift
//  IOSProject
//
//  Created by Latifa Bourisli on 8/18/15.
//  Copyright (c) 2015 mashael. All rights reserved.
//

import Foundation
class Data {
    
    init (subDict:NSDictionary, dayValue:String){
        self.day = dayValue;
        self.startlocation = subDict.valueForKey("startlocation") as! String;
        self.endlocation = subDict.valueForKey("endlocation") as! String;
        self.speed = subDict.valueForKey("speed") as! String;
       
    }
    
    init(){
        
    }
    
    
    func toDictionary()->NSDictionary{
        var values:NSMutableDictionary = NSMutableDictionary();
        var subDict:NSMutableDictionary = NSMutableDictionary();
        subDict.setValue(startlocation, forKey: "startlocation");
        subDict.setValue(endlocation, forKey: "endlocation");
        subDict.setValue(speed, forKey: "speed")
        values.setValue(subDict, forKey: day);
        
        return values;
    }
    
    
    
    
    var day = "";
    var Name = "";
    var startlocation = "";
    var endlocation = " aludailya";
    var FTime = "3:00am";
    var TTime = "4:00am";
    var speed = "";
    
}