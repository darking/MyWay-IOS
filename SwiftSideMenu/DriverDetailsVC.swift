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
//    var dataConnection:NSMutableData=NSMutableData();
    var dataConnection:NSData = NSData();
//    let driverdash:DriverDashboard = DriverDashboard();
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var reportsTable: UITableView!
    @IBOutlet weak var lblDriverLocation: UILabel!
    @IBOutlet weak var lblBatteryStatus: UILabel!
    @IBOutlet weak var lblDriverEmail: UILabel!
    
    struct holder {
        static var driverLat:Double = 0.0;
        static var driverLong:Double = 0.0;
    }
    
    @IBAction func btnSetDestination(sender: AnyObject) {
        //println("\(DriverDetailsVC.SettingDriverDestination.settingDriverDestination)");
        if (DriverDetailsVC.SettingDriverDestination.settingDriverDestination == false) {
           
            DriverDetailsVC.SettingDriverDestination.settingDriverDestination = true;
//
//            var showMap:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
//            
//            showMap.title = "Set Driver Destination";
//            //var driverDestination:CLLocation = CLLocation(latitude: 29.282064, longitude: 47.994);
//            //Zahraa st 305 (29.282064 , 47.994)
//            
//            var lat:NSString = driverdash.dashboard[0].valueForKey!("driver_currentLat") as! NSString;
//            
//            var lon:NSString = driverdash.dashboard[0].valueForKey!("driver_currentLon") as! NSString;
//            showMap.location = CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue);
//            
//            self.presentViewController(showMap, animated: true, completion: {});
            
            
            var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
             self.presentViewController(getLocation, animated: true, completion: {});
            
                    }
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        //dataConnection.appendData(data)
        dataConnection = data;
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        //println(data)
        //println(output)
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
        reports = valuesDict.objectForKey("result_data") as! NSArray
        //println(reports)
        self.reportsTable.reloadData();
        reportsTable.estimatedRowHeight = 44.0;
        reportsTable.rowHeight = UITableViewAutomaticDimension;
        // Alternative workaround for crash!!
        //dataConnection = NSMutableData();
    }
    override func viewWillAppear(animated: Bool) {
        let allReportsUrl:NSURL?=NSURL(string:"\(ConnectionString.holder.URL)/getAllDriverReports?driverUserName=" + DriverBean.driverHolder.driverUsername!);
        //println(allReportsUrl);
        let urlReq:NSURLRequest=NSURLRequest(URL: allReportsUrl!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 5);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        reportsTable.reloadData();
        let driverdash:DriverDashboardDao = DriverDashboardDao();
        //println(driverdash.dashboard[0]);
//        var lat = driverdash.dashboard[0].valueForKey("driver_currentLat") as! String;
//        var lon = driverdash.dashboard[0].valueForKey("driver_currentLon") as! String;
//        lblDriverLocation.text = lat + ", " + lon ;
//        lblDriverLocation.sizeToFit();
        lblBatteryStatus.text = (driverdash.dashboard[0].valueForKey("report_battaryStatus") as! String) + "%";
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "DriverReportCustomCell", bundle: nil);
        var reportTableView:UITableView!;
        self.reportsTable.registerNib(nib, forCellReuseIdentifier: "reportCustomCell");
        
        lblDriverName.text = DriverBean.driverHolder.driverUsername;
        println("Driver's username from driver details: \(DriverBean.driverHolder.driverUsername!)")
        lblDriverName.sizeToFit();
        lblDriverEmail.text = DriverBean.driverHolder.driverEmail;
        lblDriverEmail.sizeToFit();
        driverImage.image = UIImage(named:"chauffer");
        
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
        //println(driverdash.dashboard);
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
        println((reports[indexPath.row].valueForKey("report_lon") as! String) + ", " + (reports[indexPath.row].valueForKey("report_lat") as! String));
        cell.reportLocation.sizeToFit();
        if (reports[indexPath.row].valueForKey("report_reason") as! String == "Overspeed") {
            cell.reportImage.image = UIImage(named: "speedkph");
        } else if (reports[indexPath.row].valueForKey("report_reason") as! String == "Stopped") {
            cell.reportImage.image = UIImage(named: "stop");
        }
        
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
        static var gettingReportCoordinate = false;
        static var reportLocationAtIndexLat:Double = 0.0;
        static var reportLocationAtIndexLon:Double = 0.0;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //////////////
        //////////////
        println(reports[indexPath.row].valueForKey("report_lat")!)
        DriverDetailsVC.SettingDriverDestination.reportLocationAtIndexLat = (reports[indexPath.row].valueForKey("report_lat") as! NSString).doubleValue;
        println(reports[indexPath.row].valueForKey("report_lon")!)
        DriverDetailsVC.SettingDriverDestination.reportLocationAtIndexLon = (reports[indexPath.row].valueForKey("report_lon") as! NSString).doubleValue;
        
        DriverDetailsVC.SettingDriverDestination.gettingReportCoordinate = true;
        
        var showMap:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
        
        showMap.title = "Driver Report Location";
        //var driverDestination:CLLocation = CLLocation(latitude: 29.282064, longitude: 47.994);
        //Zahraa st 305 (29.282064 , 47.994)
        
        var repLat:Double = DriverDetailsVC.SettingDriverDestination.reportLocationAtIndexLat;
        
        var repLon:Double = DriverDetailsVC.SettingDriverDestination.reportLocationAtIndexLon;
        showMap.location = CLLocation(latitude: repLat, longitude: repLon);
        
        self.navigationController?.pushViewController(showMap, animated: true);

        

    }
}
