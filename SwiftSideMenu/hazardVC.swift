//
//  hazardVC.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class hazardVC:ViewController{
    
    
    @IBOutlet weak var constructionLable: UILabel!
    
    
    @IBOutlet weak var onRoadLable: UILabel!
    
    var onroadFlag = false;
    var constructionFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    let settings = NSUserDefaults.standardUserDefaults();
   
    @IBOutlet var commentHazard: UITextField!
    
    @IBAction func construction(sender: AnyObject) {
        onroadFlag = false;
        constructionFlag = true;
        settings.setBool(true , forKey: "construction");
         settings.setBool(false , forKey: "onroad");
        constructionLable.text="Selected";
        onRoadLable.text="";
    }
    
    
    
    @IBAction func onRoad(sender: AnyObject) {
        onroadFlag = true;
        constructionFlag = false;
        settings.setBool(true , forKey: "onroad");
         settings.setBool(false , forKey: "construction");
        constructionLable.text="";
        onRoadLable.text="Selected";
    }
    
    
    @IBAction func sendReport(sender: AnyObject) {
        
//        var manager:addHazardReport = addHazardReport();
//        manager.HAZARD = self;
//        manager.addToHazardList(commentHazard.text);
//        commentHazard.text = "";
//        
//        onroadFlag = false;
//        constructionFlag = false;
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (commentHazard.text == ""){
            return false;
            
        }
        
        else {
            var manager:addHazardReport = addHazardReport();
            manager.HAZARD = self;
            manager.addToHazardList(commentHazard.text);
            commentHazard.text = "";
            
            onroadFlag = false;
            constructionFlag = false;
            return true;
            
        }
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        commentHazard.text = "";
    }
    
    override func viewDidLoad() {
         super.viewDidLoad();
        constructionLable.text="";
        onRoadLable.text="";
        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
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