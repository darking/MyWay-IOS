//
//  trafficVC.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class trafficVC:ViewController{
    
    
    @IBOutlet weak var moderateLable: UILabel!
    
    
    @IBOutlet weak var heavyLable: UILabel!
    
    
    @IBOutlet weak var standLable: UILabel!
    
    var moderateFlag = false ;
    var heavyFalg = false ;
    var standstillFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    
    let settings = NSUserDefaults.standardUserDefaults();
    
    
    @IBOutlet var commentTraffic: UITextField!
    
    
    @IBAction func moderateTraffic(sender: AnyObject) {
        moderateFlag = true;
        heavyFalg = false;
        standstillFlag = false;
        settings.setBool(true , forKey: "moderate");
        settings.setBool(false , forKey: "heavy");
        settings.setBool(false , forKey: "standstill");
        moderateLable.text="Selected";
        heavyLable.text="";
        standLable.text="";
        
    }
    
    @IBAction func heavyTraffic(sender: AnyObject) {
        moderateFlag = false;
        heavyFalg = true;
        standstillFlag = false;
        settings.setBool(true , forKey: "heavy");
        settings.setBool(false , forKey: "moderate");
        settings.setBool(false , forKey: "standstill");
        moderateLable.text="";
        heavyLable.text="Selected";
        standLable.text="";
    }
    
    @IBAction func standstillTraffic(sender: AnyObject) {
        moderateFlag = false;
        heavyFalg = false;
        standstillFlag = true;
        settings.setBool(true , forKey: "standstill");
        settings.setBool(false , forKey: "heavy");
        settings.setBool(false , forKey: "moderate");
        moderateLable.text="";
        heavyLable.text="";
        standLable.text="Selected";
    }
    
    
    @IBAction func sendTrafficReport(sender: AnyObject) {
        //
        //        var manager:addTrafficJamReports = addTrafficJamReports();
        //        manager.TRAFFIC = self;
        //        manager.addToTrafficList(commentTraffic.text);
        //        commentTraffic.text = "";
        //
        //        moderateFlag = false;
        //        heavyFalg = false;
        //        standstillFlag = false;
        
        
        //
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (commentTraffic.text == ""){
            return false;
        }
        else {
            var manager:addTrafficJamReports = addTrafficJamReports();
            manager.TRAFFIC = self;
            manager.addToTrafficList(commentTraffic.text);
            commentTraffic.text = "";
            
            moderateFlag = false;
            heavyFalg = false;
            standstillFlag = false;
            return true;
            
        }
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        commentTraffic.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        moderateLable.text="";
        heavyLable.text="";
        standLable.text="";
        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        var lo:LocationFilteration=LocationFilteration();
        var a:allCommentVC=allCommentVC();
        var objectsArray: NSMutableArray = NSMutableArray();
        objectsArray=a.AddToArray();
        var dis=9.0;
        lo.filterLocations(objectsArray, currentLocation: currentLocation, distance: dis)
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        currentLocation = locations.last as! CLLocation;
        println("current location is \(currentLocation.description)");
        
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "currentLocation");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
    }
    
    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
    override func viewDidAppear(animated: Bool) {
        locationManager.startUpdatingLocation();
    }
}