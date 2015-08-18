//
//  DailyReportVC.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/17/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class DailyReportVC:UIViewController{
    @IBOutlet weak var StartTimeTF: UITextField!
    @IBOutlet weak var EndTimeTF: UITextField!
    @IBOutlet weak var DailyRouteNameTF: UITextField!
    
    @IBOutlet weak var DatePiker: UIDatePicker!
    @IBOutlet weak var StartLocationTF: UITextField!
    @IBOutlet weak var EndLocationTF: UITextField!
  
    var DailyFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    
    let settings = NSUserDefaults.standardUserDefaults();


    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (DailyRouteNameTF.text == ""){
          
                
            return false;
                
            
        }
            
        else {
            var date:String = dataPickerChanged(DatePiker);
            var manager:AddDailyRouteVC = AddDailyRouteVC();
            manager.Daily = self;
            manager.addToList(DailyRouteNameTF.text);
            manager.addToList(StartTimeTF.text);
            manager.addToList(EndTimeTF.text);
            manager.addToList(date);
            
            DailyRouteNameTF.text = "";
            StartTimeTF.text = "";
            EndTimeTF.text = "";
           
            
            DailyFlag = false;
            
            return true ;
            
        }
        
    }
    
    
    func dataPickerChanged(DatePiker:UIDatePicker) ->String {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = "\(dateFormatter.stringFromDate(DatePiker.date))"
        return strDate;
        
    }
 override func viewDidLoad() {
    super.viewDidLoad();
    locationManager.requestAlwaysAuthorization();
    locationManager.location;
    NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
    NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
    
    locationManager.startUpdatingLocation();
    println("current location is \(currentLocation.description)");
    
    var c:AllpListController=AllpListController();
    c.AddToArray();
    
    
    DatePiker.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
}
func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
    currentLocation = locations.last as CLLocation;
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
