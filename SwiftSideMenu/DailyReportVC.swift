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
    
    @IBOutlet weak var DailyRouteNameTF: UITextField!
    @IBOutlet weak var EndDatePiker: UIDatePicker!
    @IBOutlet weak var DatePiker: UIDatePicker!
    @IBOutlet weak var StartLocationTF: UITextField!
    @IBOutlet weak var EndLocationTF: UITextField!
    
    var DailyFlag = false;
    var locationManager = CLLocationManager();
    var currentLocation:CLLocation = CLLocation();
    let settings = NSUserDefaults.standardUserDefaults();
    
    @IBAction func submit(sender: AnyObject) {
        if (DailyRouteNameTF.text == ""){
            
        } else {
            var date:String = dataPickerChanged(DatePiker);
            var endDate:String = dataPickerChanged(EndDatePiker);
            var manager:AddDailyRouteVC = AddDailyRouteVC();
            var dr:DailyRouteHolder = DailyRouteHolder();
            dr.name = "\(DailyRouteNameTF.text)";
            dr.startDate = "\(date)";
            dr.endDate = "\(endDate)";
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
        dateFormatter.dateFormat = "dd-yyyy HH:mm"
        var strDate = "\(dateFormatter.stringFromDate(DatePiker.date))"
        return strDate;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        locationManager.requestAlwaysAuthorization();
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "Current");
        locationManager.startUpdatingLocation();
        var c:AllpListController=AllpListController();
        c.AddToArray();
        DatePiker.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
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
}