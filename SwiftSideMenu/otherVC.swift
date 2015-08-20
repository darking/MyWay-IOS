//
//  otherVC.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class otherVC:ViewController{
    
    
    var otherFlag = false;
    var locationManager = CLLocationManager();
   
    var currentLocation:CLLocation = CLLocation();
   
    let settings = NSUserDefaults.standardUserDefaults();
   
    
    @IBOutlet var commentOther: UITextField!
    
    @IBAction func otherReport(sender: AnyObject) {
        otherFlag = true;
        settings.setBool(true , forKey: "other");
    }
   
    
    @IBAction func sendReport(sender: AnyObject) {
//        var manager:addOtherReports = addOtherReports();
//        manager.OTHER = self;
//        manager.addToOtherList(commentOther.text);
//        commentOther.text = "";
//        
//        otherFlag = false;
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (commentOther.text == ""){
            return false;
            
        }
        
        else {
            var manager:addOtherReports = addOtherReports();
            manager.OTHER = self;
            manager.addToOtherList(commentOther.text);
            commentOther.text = "";
            
            otherFlag = false;
            
            return true ;
            
        }
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        var c:allCommentVC=allCommentVC();
        c.AddToArray();
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
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
