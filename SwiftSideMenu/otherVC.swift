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
    
    
    @IBOutlet weak var otherBtn: UIButton!

    @IBOutlet var commentOther: UITextField!
    
    @IBAction func otherReport(sender: AnyObject) {
        otherFlag = true;
        settings.setBool(true , forKey: "other");
        
        let imageOther = UIImage(named:"otherG")
        otherBtn.setImage(imageOther, forState: UIControlState.Normal)
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    @IBAction func sendReport(sender: AnyObject) {

        
        var alert : UIAlertView = UIAlertView(title: "thank you", message:"Thank you for your corboration", delegate:nil,cancelButtonTitle:"ok")
        alert.show()
        
       
    }
 
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (!otherFlag){
            var alert : UIAlertView = UIAlertView(title: "Oops!", message:"Please click on the icon", delegate:nil,cancelButtonTitle:"ok")
            alert.show()
            return false;
            
        }
        
        else {
            var manager:addOtherReports = addOtherReports();
            var adding:URLCommentConnection = URLCommentConnection();
            manager.OTHER = self;
            if (commentOther.text == ""){
                commentOther.text = "caution! there is somthing on the road";
            }
//             manager.addToOtherList(commentOther.text,id_report: 1);
            adding.addToCommentList(commentOther.text,id_report: 1);
            commentOther.text = "";
            otherFlag = false;
            
            let imageOther = UIImage(named:"other")
            otherBtn.setImage(imageOther, forState: UIControlState.Normal)
           
                 var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
                   NSUserDefaults.standardUserDefaults().setValue(NSUserDefaults.standardUserDefaults().valueForKey("lat"), forKey: "reportLat");
                    NSUserDefaults.standardUserDefaults().setValue(NSUserDefaults.standardUserDefaults().valueForKey("lon"), forKey: "reportLon");
                  getLocation.latKey = "reportLat";
                  getLocation.lngKey = "reportLon";
            
                        return true ;
            
            
        }
    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad();
//      locationManager.requestAlwaysAuthorization();
        locationManager.requestWhenInUseAuthorization()
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
