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
        let imageConstruction = UIImage(named: "constructionG")
        let imageOnRoad = UIImage(named:"OnRoad")
        constructionBtn.setImage(imageConstruction, forState: UIControlState.Normal)
        onRoadBtn.setImage(imageOnRoad, forState: UIControlState.Normal)
 
        
    }

    @IBAction func onRoad(sender: AnyObject) {
        onroadFlag = true;
        constructionFlag = false;
        settings.setBool(true , forKey: "onroad");
         settings.setBool(false , forKey: "construction");

        let imageConstruction = UIImage(named: "construction")
        let imageOnRoad = UIImage(named:"OnRoadG")
        constructionBtn.setImage(imageConstruction, forState: UIControlState.Normal)
        onRoadBtn.setImage(imageOnRoad, forState: UIControlState.Normal)

        
    }
    
    
    @IBAction func sendReport(sender: AnyObject) {
        

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (!onroadFlag && !constructionFlag){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please select type of hazard", delegate:nil,cancelButtonTitle:"ok")
            alert.show()

            return false;
            
        }
        
        else {
            var manager:addHazardReport = addHazardReport();
            var adding:URLCommentConnection = URLCommentConnection();
            manager.HAZARD = self;
            
            
            
            if (commentHazard.text == ""){
                if(constructionFlag){
                    commentHazard.text = "Caution! there is a construction ahead"
                    //manager.addToHazardList(commentHazard.text,id_report: 2);
                    adding.addToCommentList(commentHazard.text,id_report: 2);
                    
                }
                else if(onroadFlag){
                    commentHazard.text = "Caution! there is an on road hazard ahead"
                    //manager.addToHazardList(commentHazard.text,id_report: 3);
                    adding.addToCommentList(commentHazard.text,id_report: 3);
                }
                
            }
            
            else
            {
            
                if(constructionFlag){
               
                    //manager.addToHazardList(commentHazard.text,id_report: 2);
                    adding.addToCommentList(commentHazard.text,id_report: 2);
                    
                }
                else if(onroadFlag){
                    
                   // manager.addToHazardList(commentHazard.text,id_report: 3);
                    adding.addToCommentList(commentHazard.text,id_report: 3);
                }
            }
            
            onroadFlag = false;
            constructionFlag = false;
            let imageConstruction = UIImage(named: "construction")
            let imageOnRoad = UIImage(named:"OnRoad")
            constructionBtn.setImage(imageConstruction, forState: UIControlState.Normal)
            onRoadBtn.setImage(imageOnRoad, forState: UIControlState.Normal)
            commentHazard.text = "";
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
        
        var c:allCommentVC=allCommentVC();
        c.AddToArray();
    }

    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
    override func viewDidAppear(animated: Bool) {
        locationManager.startUpdatingLocation();
    }
}