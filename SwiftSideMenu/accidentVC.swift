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

        let imageMinor = UIImage(named: "MinorG")
        let imageMajor = UIImage(named: "Major")
        majorbtn.setImage(imageMajor, forState: UIControlState.Normal)
        minorbtn.setImage(imageMinor, forState: UIControlState.Normal)
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    


    @IBAction func majorAccident(sender: AnyObject) {
        
        minorFlag = false;
        majorFlag = true;
        settings.setBool(false, forKey: "minor");

        let imageMinor = UIImage(named: "Minor")
        let imageMajor = UIImage(named: "MajorG")
        majorbtn.setImage(imageMajor, forState: UIControlState.Normal)
        minorbtn.setImage(imageMinor, forState: UIControlState.Normal)
    }

   @IBAction func sendAccidentReport(sender: AnyObject) {
    
    
    var alert : UIAlertView = UIAlertView(title: "thank you", message:"Thank you for your cooperation", delegate:nil,cancelButtonTitle:"ok")
    alert.show()
    
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
     
        if (minorFlag==false && majorFlag==false){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please select type of accident", delegate:nil,cancelButtonTitle:"ok")
            alert.show()
            return false;
        }
       
        else {
            
            var adding:URLCommentConnection = URLCommentConnection();
            
            
            
            if (commentAccident.text == ""){
                if(minorFlag){
                    commentAccident.text = "Caution! there is a minor accident ahead"
                    //manager.addToAccidentsList(commentAccident.text,id_report: 6);
                      adding.addToCommentList(commentAccident.text,id_report: 7);
                    
                }
                else {
                    commentAccident.text = "Caution! there is a major accident ahead"
                    //manager.addToAccidentsList(commentAccident.text,id_report: 7);
                    adding.addToCommentList(commentAccident.text,id_report: 8);
                }
            }
            
            else
            {
                if(minorFlag){
                    
                  
                    adding.addToCommentList(commentAccident.text,id_report: 7);
                    
                }
                else {
                    
             
                    adding.addToCommentList(commentAccident.text,id_report: 8);
                    
                }
            
            }

            commentAccident.text = "";
            minorFlag = false;
            majorFlag = false;
            let imageMinor = UIImage(named: "Minor")
            let imageMajor = UIImage(named: "Major")
            majorbtn.setImage(imageMajor, forState: UIControlState.Normal)
            minorbtn.setImage(imageMinor, forState: UIControlState.Normal)
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
    }
  
    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
    override func viewDidAppear(animated: Bool) {
        locationManager.startUpdatingLocation();
    }

}


