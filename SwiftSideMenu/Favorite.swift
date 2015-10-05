//
//  Favorite.swift
//  SwiftSideMenu
//
//  Created by trn17 on 9/30/15.
//
//

import Foundation

class Favorite {
    
    var name = "";
   
    var lat = "0.0";
    var long = "0.0";

    init (values:NSDictionary){
        
        self.name = values.valueForKey("name") as! String;
        
        self.long = values.valueForKey("long") as! String;
        self.lat = values.valueForKey("lat") as! String;
        
    }
    
    init(){
        
    }
    
    func toDictionary()->NSDictionary{
        
        var values:NSMutableDictionary = NSMutableDictionary();
        values.setValue(name, forKey: "name");
        
        values.setValue(long, forKey: "long");
        values.setValue(lat, forKey: "lat");

        return values;
    }
    
}