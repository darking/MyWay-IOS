//
//  DailyRouteHolder.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/18/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation

class DailyRouteHolder{
    var name:String = ""
    var startDate:String = ""
    var endDate:String = ""
    var fromLocation:String = ""
    var toLocation:String = ""
    
    init (values:NSDictionary){
        self.name = values.valueForKey("name") as! String;
        self.startDate = values.valueForKey("startDate") as! String;
        self.endDate = values.valueForKey("endDate") as! String;
        self.fromLocation = values.valueForKey("fromLocation") as! String;
        //self.toLocation = values.valueForKey("toLocation") as String;
    }
    init(){
        
    }
    func toDictionary()->NSDictionary{
        var values:NSMutableDictionary = NSMutableDictionary();
        values.setValue(name, forKey: "name");
        values.setValue(startDate, forKey: "startDate");
        values.setValue(endDate, forKey: "endDate");
        values.setValue(fromLocation, forKey: "fromLocation");
        values.setValue(toLocation, forKey: "toLocation");
        return values;
    }
}