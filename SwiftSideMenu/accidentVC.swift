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
    
    
    @IBOutlet weak var minorLable: UILabel!
    
    @IBOutlet weak var majorLable: UILabel!
    
    var minorFlag=false;
    var majorFlag=false;
    let settings = NSUserDefaults.standardUserDefaults();

    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    @IBOutlet var commentAccident: UITextField!
    
    @IBOutlet weak var minorbtn: UIButton!
    
    
    @IBOutlet weak var majorbtn: UIButton!
    
    @IBAction func minorAccident(sender: AnyObject) {
        majorFlag = false;
        minorFlag = true;
        settings.setBool(true , forKey: "minor");
//        minorLable.text="Selected";
        majorLable.text="";
        let imageMinor = UIImage(named: "MinorG")
        let imageMajor = UIImage(named: "Major")
        majorbtn.setImage(imageMajor, forState: UIControlState.Normal)
        minorbtn.setImage(imageMinor, forState: UIControlState.Normal)
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
//        majorLable.text="Selected";
        
        let imageMinor = UIImage(named: "Minor")
        let imageMajor = UIImage(named: "MajorG")
        majorbtn.setImage(imageMajor, forState: UIControlState.Normal)
        minorbtn.setImage(imageMinor, forState: UIControlState.Normal)
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
//        if (commentAccident.text == ""){
//            return false;
//        }
        
        if (minorFlag==false && majorFlag==false){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please select type of accident", delegate:nil,cancelButtonTitle:"ok")
            alert.show()
            return false;
        }
       
        else {
            var manager:addAccidentsReport = addAccidentsReport();
            manager.ACCIDENT = self;
            
            
            if (commentAccident.text == ""){
                if(minorFlag){
                    commentAccident.text = "Caution! there is a minor accident ahead"
                    
                }
                else {
                    commentAccident.text = "Caution! there is a major accident ahead"

                }
            }
            manager.addToAccidentsList(commentAccident.text);
            commentAccident.text = "";
            minorFlag = false;
            majorFlag = false;
            let imageMinor = UIImage(named: "Minor")
            let imageMajor = UIImage(named: "Major")
            majorbtn.setImage(imageMajor, forState: UIControlState.Normal)
            minorbtn.setImage(imageMinor, forState: UIControlState.Normal)
            return true;
            
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        minorLable.text="";
        majorLable.text="";
        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        
//        currentLocation = locations.last as! CLLocation;
//        println("current location is \(currentLocation.description)");
//        
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "currentLocation");
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
//    }
    
    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
    override func viewDidAppear(animated: Bool) {
        locationManager.startUpdatingLocation();
    }

}


