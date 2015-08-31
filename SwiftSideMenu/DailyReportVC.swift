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
    
    private var isKeyboardVisible = false
    
    @IBOutlet weak var DailyRouteNameTF: UITextField!
    @IBOutlet weak var DatePiker: UIDatePicker!
    @IBOutlet weak var StartLocationTF: UITextField!
    @IBOutlet weak var EndLocationTF: UITextField!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    var startTimeFlag:Bool = false;
    var endTimeFlag:Bool = false;
    @IBAction func showEndPicker(sender: AnyObject) {
        DatePiker.hidden = false;
        startTimeFlag = false;
        endTimeFlag = true;
        doneBtn.hidden = false;
    }
  
    @IBAction func showStartPicker(sender: AnyObject) {
        DatePiker.hidden = false;
        startTimeFlag = true;
        endTimeFlag = false;
        doneBtn.hidden = false;
    }
    @IBAction func btnDone(sender: AnyObject) {
        if startTimeFlag == true {
            lblStartTime.text = self.dataPickerChanged(DatePiker);
        } else if endTimeFlag == true {
            lblEndTime.text = self.dataPickerChanged(DatePiker);
        }
        doneBtn.hidden = true;
    }
    
    var DailyFlag = false;
    var locationManager = CLLocationManager();
    var currentLocation:CLLocation = CLLocation();
    let settings = NSUserDefaults.standardUserDefaults();

    @IBAction func submit(sender: AnyObject) {
        
        if (DailyRouteNameTF.text == ""){

        }
        else{
            var date:String = dataPickerChanged(DatePiker);
            var manager:AddDailyRouteVC = AddDailyRouteVC();
            var dr:DailyRouteHolder = DailyRouteHolder();
            dr.name = "\(DailyRouteNameTF.text)";
            dr.startDate = "\(lblStartTime.text!)";
            dr.endDate = "\(lblEndTime.text!)";
            dr.fromLocation = NSUserDefaults.standardUserDefaults().valueForKey("Current") as! String;
//            println(dr.fromLocation)
            manager.addDailyRoute(dr);
            manager.Daily = self;
            DailyRouteNameTF.text = "";
            DailyFlag = false;
            self.navigationController?.popViewControllerAnimated(true);
        
        }
    }
    
    func dataPickerChanged(DatePiker:UIDatePicker) ->String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var strDate = "\(dateFormatter.stringFromDate(DatePiker.date))"
        return strDate;
    }
    
    @IBOutlet weak var doneBtn: UIButton!
 override func viewDidLoad() {
    super.viewDidLoad();
    DatePiker.hidden = true;
    doneBtn.hidden = true;
    //locationManager.requestAlwaysAuthorization();
    locationManager.requestWhenInUseAuthorization()
    locationManager.location;
    NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
    NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
     NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "Current");
    locationManager.startUpdatingLocation();
    
    
    var c:AllpListController=AllpListController();
    c.AddToArray();
    
    
    DatePiker.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
}
    
func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
    currentLocation = locations.last as! CLLocation;
//    println("current location is \(currentLocation.description)");
    
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if isKeyboardVisible == false {
            
            self.view.frame.origin.y -= 220
            
            isKeyboardVisible = true
        }
        
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        
        if isKeyboardVisible == true {
            
            self.view.frame.origin.y += 220
            
            isKeyboardVisible = false
            
        }
        
    }
    
}
