//
//  getCommentDetails.swift
//  SwiftSideMenu
//
//  Created by hebah albuloushi on 10/1/15.
//
//

import Foundation
import UIKit
import CoreLocation
class getCommentDetails{
    
    var locationManager = CLLocationManager();
    
    
    
    
    
    func SaveCurrentLocation(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.longitude.description, forKey: "lon");
        
    }
    
}