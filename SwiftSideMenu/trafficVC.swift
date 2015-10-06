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

        let imageModerate = UIImage(named: "moderateG")
        let imageHeavy = UIImage(named: "heavy")
        let imageStandstill = UIImage(named:"standStill")
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

        let imageModerate = UIImage(named: "moderate")
        let imageHeavy = UIImage(named: "heavyG")
        let imageStandstill = UIImage(named:"standStill")
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
 
        let imageModerate = UIImage(named: "moderate")
        let imageHeavy = UIImage(named: "heavy")
        let imageStandstill = UIImage(named:"standStillG")
        moderateBtn.setImage(imageModerate, forState: UIControlState.Normal)
        heavyBtn.setImage(imageHeavy, forState: UIControlState.Normal)
        standstillBtn.setImage(imageStandstill, forState: UIControlState.Normal)
    
        
    }
    
    
    
    @IBAction func sendTrafficReport(sender: AnyObject) {
        
        
        var alert : UIAlertView = UIAlertView(title: "thank you", message:"Thank you for your cooperation", delegate:nil,cancelButtonTitle:"ok")
        alert.show()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (!moderateFlag && !heavyFalg && !standstillFlag){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please select type of traffic", delegate:nil,cancelButtonTitle:"ok")
            alert.show()

            
            return false;
        }
        else {
            
            var adding:URLCommentConnection = URLCommentConnection();
           
            
          
            
            if (commentTraffic.text == ""){
                if(moderateFlag){
                    commentTraffic.text = "Caution! there is moderate traffic ahead"
//                     manager.addToTrafficList(commentTraffic.text,id_report: 3);
                    adding.addToCommentList(commentTraffic.text,id_report: 4);
                    
                }
                else if (heavyFalg){
                    commentTraffic.text = "Caution! there is heavy traffic ahead"
                    // manager.addToTrafficList(commentTraffic.text,id_report: 5);
                      adding.addToCommentList(commentTraffic.text,id_report: 5);
                }
                else {
                     commentTraffic.text = "Caution! there is standstill traffic ahead"
                     //manager.addToTrafficList(commentTraffic.text,id_report: 6);
                      adding.addToCommentList(commentTraffic.text,id_report: 6);
                }

            }
            
            else
            {
                if(moderateFlag){
                    
                   // manager.addToTrafficList(commentTraffic.text,id_report: 3);
                      adding.addToCommentList(commentTraffic.text,id_report: 4);
                    
                }
                else if (heavyFalg){
                  
                   // manager.addToTrafficList(commentTraffic.text,id_report: 4);
                      adding.addToCommentList(commentTraffic.text,id_report: 5);
                }
                else {
                    
                   // manager.addToTrafficList(commentTraffic.text,id_report: 5);
                      adding.addToCommentList(commentTraffic.text,id_report: 6);
                }
            }
            
           
            moderateFlag = false;
            heavyFalg = false;
            standstillFlag = false;
            let imageModerate = UIImage(named: "moderate")
            let imageHeavy = UIImage(named: "heavy")
            let imageStandstill = UIImage(named:"standStill")
            moderateBtn.setImage(imageModerate, forState: UIControlState.Normal)
            heavyBtn.setImage(imageHeavy, forState: UIControlState.Normal)
            standstillBtn.setImage(imageStandstill, forState: UIControlState.Normal)
            commentTraffic.text = "";
            var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
            NSUserDefaults.standardUserDefaults().setValue(NSUserDefaults.standardUserDefaults().valueForKey("lat"), forKey: "reportLat");
            NSUserDefaults.standardUserDefaults().setValue(NSUserDefaults.standardUserDefaults().valueForKey("lon"), forKey: "reportLon");
            getLocation.latKey = "reportLat";
            getLocation.lngKey = "reportLon";
            return true;
            
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad();

        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(locationManager.location.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        println("hebbbbbbbbbbbbb \(locationManager.location)")
        
        //******* Testing locationFilteration ****************
        var lo:LocationFilteration=LocationFilteration();
        
        var objectsArray: NSMutableArray = NSMutableArray();
        

    }

     override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
    override func viewDidAppear(animated: Bool) {
        locationManager.startUpdatingLocation();
    }
}