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
    let driverdash:DriverDashboard = DriverDashboard();
    @IBOutlet weak var lblDriverName: UILabel!
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
            //var driverDestination:CLLocation = CLLocation(latitude: 29.282064, longitude: 47.994);
            //Zahraa st 305 (29.282064 , 47.994)
            
            var lat:NSString = driverdash.dashboard[0].valueForKey!("driver_currentLat") as! NSString;
            
            var lon:NSString = driverdash.dashboard[0].valueForKey!("driver_currentLon") as! NSString;
            showMap.location = CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue);
            
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
//        driverImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: DriverBean.driverHolder.driverImageURL!)!)!)!;
        let allReportsUrl:NSURL?=NSURL(string:"\(ConnectionString.holder.URL)/getAllDriverReports?driverUserName=" + DriverBean.driverHolder.driverUsername!);
        println(DriverBean.driverHolder.driverUsername!);
        let urlReq:NSURLRequest=NSURLRequest(URL:allReportsUrl!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        
        reportsTable.reloadData();
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
        println(driverdash.dashboard);
        var lat:String = driverdash.dashboard[0].valueForKey("driver_currentLat") as! String;
        var lon:String = driverdash.dashboard[0].valueForKey("driver_currentLon") as! String;
        lblDriverLocation.text = lat + ", " + lon;
        lblDriverLocation.sizeToFit();
        lblBatteryStatus.text = (driverdash.dashboard[0].valueForKey("report_battaryStatus") as! String) + "%";
        if DriverDetailsVC.SettingDriverDestination.settingDriverDestination == true {
            println("\(DriverDetailsVC.SettingDriverDestination.getSentDriverLatLong())");
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
        println("This should be the date: " + (reports[indexPath.row].valueForKey("report_date") as! String));
        cell.reportDate?.text = "Date: " + (reports[indexPath.row].valueForKey("report_date") as! String);
        cell.reportDate.sizeToFit();
        cell.reportLocation?.text = "Location: " + (reports[indexPath.row].valueForKey("report_lon") as! String) + ", " + (reports[indexPath.row].valueForKey("report_lat") as! String);
        cell.reportLocation.sizeToFit();
        cell.sizeToFit();
        
        return cell;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110;
    }
    struct SettingDriverDestination {
        static var settingDriverDestination = false;
        static var lat:CLLocationDegrees?;
        static var long:CLLocationDegrees?;
        static func setSentDriverLatLong(driverLatLong:CLLocationCoordinate2D){
            self.lat = driverLatLong.latitude;
            self.long = driverLatLong.longitude;
        }
        static func getSentDriverLatLong() -> CLLocationCoordinate2D {
            var sentLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat!, longitude: long!);
            return sentLocation;
            
        }
    }
   
}
