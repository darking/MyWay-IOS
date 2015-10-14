//
//  Driver.swift
//  Driver
//
//  Created by Zainab H H J on 10/4/15.
//  Copyright © 2015 Zainab H H J. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ParentDataManager {
    
    func loadNewMessages(result : (AnyObject) -> Void){
        let url = NSURL(string: "")!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data , response , error -> Void in
            let json: AnyObject? =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil);
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                result(json!)
            })
        })
        task.resume()
    }
    func sendRequestToDriver(parentID:String , driverID:String) {
        let data = NSMutableDictionary()
        data["parentUserName"] = parentID
        data["driverID"] = driverID
        var json:NSData?
            json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted, error: nil);
        if let j = json {
            let url = NSURL(string: "")!
            let req = NSMutableURLRequest(URL: url)
            req.HTTPMethod = "POST"
            req.HTTPBody = j
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(req)
            task.resume()
        }
    }
}
class DriverDataManager: NSObject , CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        send(newLocation)
    }
    func loadNewMessages(result : (AnyObject) -> Void){
        let url = NSURL(string: "")!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data , response , error -> Void in
            let json: AnyObject? =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil);
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                result(json!)
            })
        })
        task.resume()
    }
    func acceptParent(parentID:String , driverID:String) {
        let data = NSMutableDictionary()
        data["parentID"] = parentID
        data["driverID"] = driverID
        var json:NSData?
        json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted, error: nil);
        if let j = json {
            let url = NSURL(string: "")!
            let req = NSMutableURLRequest(URL: url)
            req.HTTPMethod = "POST"
            req.HTTPBody = j
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(req)
            task.resume()
        }
    }
    func send(location:CLLocation) {
        let data = NSMutableDictionary()
        data["batteryLevel"] = "\(UIDevice.currentDevice().batteryLevel)"
        data["location"] = "\(location.coordinate.latitude)-\(location.coordinate.longitude)"
        var json:NSData?
        json =  NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted, error: nil);
        if let j = json {
            let url = NSURL(string: "")!
            let req = NSMutableURLRequest(URL: url)
            req.HTTPMethod = "POST"
            req.HTTPBody = j
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(req)
            task.resume()
        }
    }
}