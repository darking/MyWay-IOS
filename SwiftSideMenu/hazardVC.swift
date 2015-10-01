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
    
    
    @IBOutlet weak var constructionBtn: UIButton!
    

    @IBOutlet weak var onRoadBtn: UIButton!
    
    
    var onroadFlag = false;
    var constructionFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    let settings = NSUserDefaults.standardUserDefaults();
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
   
    @IBOutlet var commentHazard: UITextField!
    
    @IBAction func construction(sender: AnyObject) {
        onroadFlag = false;
        constructionFlag = true;
        settings.setBool(true , forKey: "construction");
         settings.setBool(false , forKey: "onroad");
//        constructionLable.text="Selected";
        onRoadLable.text="";
        
        let imageConstruction = UIImage(named: "constructionG")
        let imageOnRoad = UIImage(named:"OnRoad")
        constructionBtn.setImage(imageConstruction, forState: UIControlState.Normal)
        onRoadBtn.setImage(imageOnRoad, forState: UIControlState.Normal)

        
        
        
    }
    
    
    @IBAction func SetLocation(sender: AnyObject) {
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
        
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLat");
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLon");
        getLocation.latKey = "reportLat";
        getLocation.lngKey = "reportLon";
        self.presentViewController(getLocation, animated: true, completion: {});
    }
    
    @IBAction func onRoad(sender: AnyObject) {
        onroadFlag = true;
        constructionFlag = false;
        settings.setBool(true , forKey: "onroad");
         settings.setBool(false , forKey: "construction");
        constructionLable.text="";
//        onRoadLable.text="Selected";
        
        let imageConstruction = UIImage(named: "construction")
        let imageOnRoad = UIImage(named:"OnRoadG")
        constructionBtn.setImage(imageConstruction, forState: UIControlState.Normal)
        onRoadBtn.setImage(imageOnRoad, forState: UIControlState.Normal)

        
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
        if (!onroadFlag && !constructionFlag){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please select type of hazard", delegate:nil,cancelButtonTitle:"ok")
            alert.show()

            return false;
            
        }
        
        else {
            var manager:addHazardReport = addHazardReport();
            manager.HAZARD = self;
            
            
            
            if (commentHazard.text == ""){
                if(constructionFlag){
                    commentHazard.text = "Caution! there is a construction ahead"
                    
                }
                else if(onroadFlag){
                    commentHazard.text = "Caution! there is an on road hazard ahead"
                }
                
            }
            manager.addToHazardList(commentHazard.text);
            onroadFlag = false;
            constructionFlag = false;
            let imageConstruction = UIImage(named: "construction")
            let imageOnRoad = UIImage(named:"OnRoad")
            constructionBtn.setImage(imageConstruction, forState: UIControlState.Normal)
            onRoadBtn.setImage(imageOnRoad, forState: UIControlState.Normal)
            commentHazard.text = "";
            return true;
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
         super.viewDidLoad();
        constructionLable.text="";
        onRoadLable.text="";
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