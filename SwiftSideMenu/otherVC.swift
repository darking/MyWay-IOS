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
    
    private var isKeyboardVisible = false
    
    var otherFlag = false;
    var locationManager = CLLocationManager();
   
    var currentLocation:CLLocation = CLLocation();
   
    let settings = NSUserDefaults.standardUserDefaults();
   
    
    @IBOutlet var commentOther: UITextField!
    
    @IBAction func otherReport(sender: AnyObject) {
        otherFlag = true;
        settings.setBool(true , forKey: "other");
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    @IBAction func sendReport(sender: AnyObject) {
//        var manager:addOtherReports = addOtherReports();
//        manager.OTHER = self;
//        manager.addToOtherList(commentOther.text);
//        commentOther.text = "";
//        
//        otherFlag = false;
        
    }
    
    
    
    @IBAction func SetLcation(sender: AnyObject) {
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
        
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLat");
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLon");
        getLocation.latKey = "reportLat";
        getLocation.lngKey = "reportLon";
        self.presentViewController(getLocation, animated: true, completion: {});
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
        //locationManager.requestAlwaysAuthorization();
        locationManager.requestWhenInUseAuthorization()
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        var c:allCommentVC=allCommentVC();
        c.AddToArray();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
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
    
    func keyboardWillShow(sender: NSNotification) {
        
        if isKeyboardVisible == false {
            
            self.view.frame.origin.y -= 80
            
            isKeyboardVisible = true
        }
        
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        
        if isKeyboardVisible == true {
            
            self.view.frame.origin.y += 80
            
            isKeyboardVisible = false
            
        }
        
    }

}
