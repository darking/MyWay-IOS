//
//  DriverDetailsViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit
import GoogleMaps
class DriverDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var reports:NSArray = [];
    var dataConnection:NSMutableData=NSMutableData();
    
    @IBOutlet weak var lblDriverName: UILabel!
    //let settingDriverDestination = true;
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var reportsTable: UITableView!
    @IBOutlet weak var lblDriverLocation: UILabel!
    @IBOutlet weak var lblBatteryStatus: UILabel!
    @IBOutlet weak var lblDriverEmail: UILabel!
    
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
            let (latitud, longitud) =  GetLocationVC().getCurrentLocation();
            self.presentViewController(showMap, animated: true, completion: {});
        }
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
        reports = valuesDict.objectForKey("result_data") as! NSArray
        self.reportsTable.reloadData();
        reportsTable.estimatedRowHeight = 44.0;
        reportsTable.rowHeight = UITableViewAutomaticDimension;
        // Alternative workaround for crash!!
        //dataConnection = NSMutableData();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "DriverReportCustomCell", bundle: nil);
        var reportTableView:UITableView!;
        self.reportsTable.registerNib(nib, forCellReuseIdentifier: "reportCustomCell");
        
        lblDriverName.text = DriverBean.driverHolder.driverUsername;
        lblDriverName.sizeToFit();
        lblDriverEmail.text = DriverBean.driverHolder.driverEmail;
        lblDriverEmail.sizeToFit();
        driverImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: DriverBean.driverHolder.driverImageURL!)!)!)!;
        //if drivers gps is off then:
        lblDriverLocation.text = "GPS Currently off!";
        lblDriverLocation.sizeToFit();
        // else
        // getLocation from web services
        //Read battery percntage from driver's phone
        lblBatteryStatus.text = "50%";
        let allReportsUrl:NSURL?=NSURL(string:"http://mobile.comxa.com/parents/driver_report.json");
        
        let urlReq:NSURLRequest=NSURLRequest(URL:allReportsUrl!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (DriverDetailsVC.SettingDriverDestination.settingDriverDestination == true) {
        var notifyNewDestinationSet:UIAlertController = UIAlertController(title: "Destination Set", message: "Your desired destination has been set to the driver!", preferredStyle: .Alert);
        let okay:UIAlertAction = UIAlertAction(title: "Okay", style: .Default){ action -> Void in
                //Do some other stuff
            };
            notifyNewDestinationSet.addAction(okay);
        self.presentViewController(notifyNewDestinationSet, animated: true, completion: nil);
        DriverDetailsVC.SettingDriverDestination.settingDriverDestination = false;
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DriverReportCustomTVC =  self.reportsTable.dequeueReusableCellWithIdentifier("reportCustomCell")  as! DriverReportCustomTVC;
        cell.reportReason?.text = reports[indexPath.row].valueForKey("report_reason") as! String;
        cell.reportReason.sizeToFit();
        cell.reportTime?.text = "Time: " + (reports[indexPath.row].valueForKey("report_time") as! String);
        cell.reportTime.sizeToFit();
        cell.reportDate?.text = "Date: " + (reports[indexPath.row].valueForKey("report_date") as! String);
        cell.reportDate.sizeToFit();
        cell.reportLocation?.text = "Location: " + (reports[indexPath.row].valueForKey("report_location") as! String);
        cell.reportLocation.sizeToFit();
        cell.sizeToFit();
        
        return cell;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110;
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