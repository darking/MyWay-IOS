//
//  SpeedClass.swift
//  SwiftSideMenu
//
//  Created by trn22 on 10/1/15.
//
//

import Foundation


import CoreLocation


class SpeedClass:NSObject, CLLocationManagerDelegate{
    var locationManager:CLLocationManager!;
    
    override init() {
        super.init();
        //CoreLocation access
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestAlwaysAuthorization();
        locationManager.startUpdatingLocation();
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var speed  = Int(manager.location.speed.kph)
        var overSpeed = ""
        var stops = 0 ;
        //120 kph Max speed in Kuwait.
        if (speed >= 120){
            overSpeed = "\(Float(CGFloat(speed) / 120.0))";
        }
       
        //if the driver stops 
        if (speed <= 0){
           var lat = locationManager.location.coordinate.latitude;
           var lon = locationManager.location.coordinate.longitude;
           var stopLocation = "\(lat),\(lon)";
            stops++ ;
        }
        
    }
}
