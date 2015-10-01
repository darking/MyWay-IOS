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
    
    
    
    @IBOutlet weak var moderateBtn: UIButton!
    
    @IBOutlet weak var heavyBtn: UIButton!
    
    @IBOutlet weak var standstillBtn: UIButton!
    
    
    var moderateFlag = false ;
    var heavyFalg = false ;
    var standstillFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    
    let settings = NSUserDefaults.standardUserDefaults();
    
    
    @IBOutlet var commentTraffic: UITextField!
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    
    @IBAction func moderateTraffic(sender: AnyObject) {
        moderateFlag = true;
        heavyFalg = false;
        standstillFlag = false;
        settings.setBool(true , forKey: "moderate");
        settings.setBool(false , forKey: "heavy");
        settings.setBool(false , forKey: "standstill");
//        moderateLable.text="Selected";
        heavyLable.text="";
        standLable.text="";
        
        let imageModerate = UIImage(named: "moderateG")
        let imageHeavy = UIImage(named: "heavy")
        let imageStandstill = UIImage(named:"standstill")
        moderateBtn.setImage(imageModerate, forState: UIControlState.Normal)
        heavyBtn.setImage(imageHeavy, forState: UIControlState.Normal)
        standstillBtn.setImage(imageStandstill, forState: UIControlState.Normal)
        
        
    }
    
    @IBAction func heavyTraffic(sender: AnyObject) {
        moderateFlag = false;
        heavyFalg = true;
        standstillFlag = false;
        settings.setBool(true , forKey: "heavy");
        settings.setBool(false , forKey: "moderate");
        settings.setBool(false , forKey: "standstill");
        moderateLable.text="";
//        heavyLable.text="Selected";
        standLable.text="";
        
        
        let imageModerate = UIImage(named: "moderate")
        let imageHeavy = UIImage(named: "heavyG")
        let imageStandstill = UIImage(named:"standstill")
        moderateBtn.setImage(imageModerate, forState: UIControlState.Normal)
        heavyBtn.setImage(imageHeavy, forState: UIControlState.Normal)
        standstillBtn.setImage(imageStandstill, forState: UIControlState.Normal)
        

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
//        standLable.text="Selected";
        
        
        let imageModerate = UIImage(named: "moderate")
        let imageHeavy = UIImage(named: "heavy")
        let imageStandstill = UIImage(named:"standstillG")
        moderateBtn.setImage(imageModerate, forState: UIControlState.Normal)
        heavyBtn.setImage(imageHeavy, forState: UIControlState.Normal)
        standstillBtn.setImage(imageStandstill, forState: UIControlState.Normal)
        

        
    }
    
    
    
    @IBAction func SetLocation(sender: AnyObject) {
        
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
        
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLat");
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLon");
        getLocation.latKey = "reportLat";
        getLocation.lngKey = "reportLon";
        self.presentViewController(getLocation, animated: true, completion: {});
        
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
        if (!moderateFlag && !heavyFalg && !standstillFlag){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please select type of traffic", delegate:nil,cancelButtonTitle:"ok")
            alert.show()

            
            return false;
        }
        else {
            var manager:addTrafficJamReports = addTrafficJamReports();
            manager.TRAFFIC = self;
            
          
            
            if (commentTraffic.text == ""){
                if(moderateFlag){
                    commentTraffic.text = "Caution! there is moderate traffic ahead"
                    
                }
                else if (heavyFalg){
                    commentTraffic.text = "Caution! there is heavy traffic ahead"
                }
                else {
                     commentTraffic.text = "Caution! there is standstill traffic ahead"
                }

            }
            manager.addToTrafficList(commentTraffic.text);
            moderateFlag = false;
            heavyFalg = false;
            standstillFlag = false;
            let imageModerate = UIImage(named: "moderate")
            let imageHeavy = UIImage(named: "heavy")
            let imageStandstill = UIImage(named:"standstill")
            moderateBtn.setImage(imageModerate, forState: UIControlState.Normal)
            heavyBtn.setImage(imageHeavy, forState: UIControlState.Normal)
            standstillBtn.setImage(imageStandstill, forState: UIControlState.Normal)
            commentTraffic.text = "";
            return true;
            
        }
    }
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad();
        moderateLable.text="";
        heavyLable.text="";
        standLable.text="";
        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        var lo:LocationFilteration=LocationFilteration();
        var a:allCommentVC=allCommentVC();
        var objectsArray: NSMutableArray = NSMutableArray();
        objectsArray=a.AddToArray();
        var dis=9.0;
        lo.filterLocations(objectsArray, currentLocation: currentLocation, distance: dis)
        
        
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
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