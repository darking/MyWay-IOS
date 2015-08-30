//
//  commentMajorAccident.swift
//  post Report
//
//  Created by trn15 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class accidentVC:ViewController{
    
    
    private var isKeyboardVisible = false
    
    @IBOutlet weak var minorLable: UILabel!
    
    @IBOutlet weak var majorLable: UILabel!
    
    var minorFlag=false;
    var majorFlag=false;
    let settings = NSUserDefaults.standardUserDefaults();

    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    @IBOutlet var commentAccident: UITextField!
    
    
    @IBAction func minorAccident(sender: AnyObject) {
        majorFlag = false;
        minorFlag = true;
        settings.setBool(true , forKey: "minor");
        minorLable.text="Selected";
        majorLable.text="";
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    @IBAction func lo(sender: AnyObject) {
        
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
        
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLat");
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLon");
        getLocation.latKey = "reportLat";
        getLocation.lngKey = "reportLon";
        self.presentViewController(getLocation, animated: true, completion: {});
        
        
    }

    @IBAction func majorAccident(sender: AnyObject) {
        
        minorFlag = false;
        majorFlag = true;
        settings.setBool(false, forKey: "minor");
        minorLable.text="";
        majorLable.text="Selected";
    }

   @IBAction func sendAccidentReport(sender: AnyObject) {
        
//        var manager:addAccidentsReport = addAccidentsReport();
//        manager.ACCIDENT = self;
//        manager.addToAccidentsList(commentAccident.text);
//        commentAccident.text = "";
//        
//        minorFlag = false;
//        majorFlag = false;
//       
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (commentAccident.text == ""){
            return false;
        }
        else {
            var manager:addAccidentsReport = addAccidentsReport();
            manager.ACCIDENT = self;
            manager.addToAccidentsList(commentAccident.text);
            commentAccident.text = "";
            
            minorFlag = false;
            majorFlag = false;
            return true;
            
        }
    
    }



    @IBAction func cancel(sender: AnyObject) {
        commentAccident.text = "";
    }


    override func viewDidLoad() {
        super.viewDidLoad();
        minorLable.text="";
        majorLable.text="";
        //locationManager.requestAlwaysAuthorization();
        locationManager.requestWhenInUseAuthorization()
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
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


