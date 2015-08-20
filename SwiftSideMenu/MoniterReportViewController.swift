//
//  MoniterReportViewController.swift
//  IOSProject
//
//  Created by Latifa Bourisli on 8/18/15.
//  Copyright (c) 2015 mashael. All rights reserved.
//



//this is the first view controller to choose the driver and the day to show all the reports related to that day
import Foundation
import UIKit
import CoreLocation
class MoniterReportViewController:UIViewController {
//    var index = 0;
//    var locationManager = CLLocationManager();
//    var currentLocation:CLLocation = CLLocation();
//    let settings = NSUserDefaults.standardUserDefaults();
//    var MonitorFlag = false;
//      
//    
//    
//    func numberOfDays()->String{
//        
//        
//        let cal = NSCalendar.currentCalendar()
//        
//        let unit:NSCalendarUnit = .CalendarUnitDay
//        
//        let components = cal.components(unit, fromDate: FromDate.date, toDate: ToDate.date, options: nil)
//        var difday = "\(components)"
//        println(components)
//        return difday;
//    }
//    
//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
//            var value:NSComparisonResult = FromDate.date.compare(ToDate.date);
//            if value.rawValue == 0{
//                Data.Holder.Moniter.Name = NameInput.text;
//                Data.Holder.Moniter.FormD = FromDate.date.description;
//                Data.Holder.Moniter.ToD = ToDate.date.description;
//                return true;
//            }
//        if (NameInput.text == ""){
//            return false;
//        }
//        else{
//            var date:String = dataPickerChanged(FromDate);
//            var endDae:String = dataPickerChanged(ToDate);
//            var manager:AddMonitorReport = AddMonitorReport();
//            var dr:Data = Data();
//            numberOfDays();
//            dr.Name = "\(NameInput.text)";
//            dr.FromD = "\(date)";
//            dr.ToD = "\(endDate)";
//            dr.location = NSUserDefaults.standardUserDefaults().valueForKey("Current") as String;
//            //            println(dr.fromLocation)
//            manager.addMonitorRoute(dr);
//            manager.Daily = self;
//            NameInput.text = "";
//            MonitorFlag = false;
//            self.navigationController?.popViewControllerAnimated(true);
//            return true;
//            
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad();
//        locationManager.requestAlwaysAuthorization();
//        locationManager.location;
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "Current");
//        locationManager.startUpdatingLocation();
//        
//
//        var c:AllpListController=AllpListController();
//        c.AddToArray();
//    }
//    func dataPickerChanged(DatePiker:UIDatePicker) ->String {
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        var strDate = "\(dateFormatter.stringFromDate(DatePiker.date))"
//        return strDate;
//    }
//
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
//        currentLocation = locations.last as CLLocation;
//        //    println("current location is \(currentLocation.description)");
//        
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "currentLocation");
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
//        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
//    }
//    
//    override func viewDidDisappear(animated: Bool) {
//        locationManager.stopUpdatingLocation();
//    }
//    override func viewDidAppear(animated: Bool) {
//        locationManager.startUpdatingLocation();
//    }

    
    
}
