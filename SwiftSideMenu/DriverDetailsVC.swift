//
//  DriverDetailsViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit
import GoogleMaps
class DriverDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblDriverName: UILabel!
    var driverName = "";
    //let settingDriverDestination = true;
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var reportsTable: UITableView!
    @IBOutlet weak var lblDriverLocation: UILabel!
    @IBOutlet weak var lblBatteryStatus: UILabel!
    @IBAction func btnSetDestination(sender: AnyObject) {
        println("\(DriverDetailsVC.SettingDriverDestination.settingDriverDestination)");
        if (DriverDetailsVC.SettingDriverDestination.settingDriverDestination == false) {
            DriverDetailsVC.SettingDriverDestination.settingDriverDestination = true;
            var showMap:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
            showMap.title = "Set Driver Destination";
            showMap.message = "Please select a location to send to the driver";
            var driverDestination:CLLocation = CLLocation(latitude: 29.282064, longitude: 47.994);
            //Zahraa st 305 (29.282064 , 47.994)
            
            showMap.location = driverDestination;
            let (latitud, longitud) =  GetLocationVC().getCurrentLocation()
            
            self.presentViewController(showMap, animated: true, completion: {});
        }
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "DriverReportCustomCell", bundle: nil);
        var reportTableView:UITableView!;
        self.reportsTable.registerNib(nib, forCellReuseIdentifier: "reportCustomCell");
        lblDriverName.text = SelectDriverReportVC.holder.driverName;
        driverImage.image = UIImage.self(named: "chauffer.png");
        //if drivers gps is off then:
        lblDriverLocation.text = "GPS Currently off!";
        lblDriverLocation.sizeToFit();
        // else
        // getLocation from web services
        //Read battery percntage from driver's phone
        lblBatteryStatus.text = "50%";
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (DriverDetailsVC.SettingDriverDestination.settingDriverDestination == true) {
        var notifyNewDestinationSet:UIAlertController = UIAlertController(title: "Destination Set", message: "Your desired destination has been set to the driver!", preferredStyle: .Alert);
            let okay:UIAlertAction = UIAlertAction(title: "Okay", style: .Default){ action -> Void in
                //Do some other stuff
            }
;            notifyNewDestinationSet.addAction(okay);
        self.presentViewController(notifyNewDestinationSet, animated: true, completion: nil);
        DriverDetailsVC.SettingDriverDestination.settingDriverDestination = false;
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DriverReportCustomTVC =  self.reportsTable.dequeueReusableCellWithIdentifier("reportCustomCell")  as! DriverReportCustomTVC;
        cell.imageView?.image = UIImage(named: "chauffer.png");
        
        return cell;
    }
    struct SettingDriverDestination {
        static var settingDriverDestination = false;
        
        static func setDriverLatLong(driverLatLong:CLLocationCoordinate2D) -> CLLocation {
            let lat = driverLatLong.latitude;
            let long = driverLatLong.longitude;
            
            let driverLatLong:CLLocation = CLLocation(latitude: lat, longitude: long);
            
            return driverLatLong;
        }
        
    }
   
}