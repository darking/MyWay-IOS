//
//  DriversListViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit

class DriversListVC: UITableViewController , UITableViewDataSource, ENSideMenuDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
    }
    //var userName = ""
    var dataConnection:NSMutableData=NSMutableData();
    var drivers:NSArray = [];
    @IBAction func addDriver(sender: AnyObject) {
        var addUserAlert:UIAlertController = UIAlertController(title: "Add Driver", message: "Please specify driver username/email", preferredStyle: .Alert);
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        addUserAlert.addAction(cancelAction)
        //Create and an option action
        let sendToDriver: UIAlertAction = UIAlertAction(title: "Submit", style: .Default) { action -> Void in
            //Do some other stuff
        }
        addUserAlert.addAction(sendToDriver)
        //Add a text field
        addUserAlert.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            //textField.textColor = UIColor.blueColor()
        }
        
        //Present the AlertController
        self.presentViewController(addUserAlert, animated: true, completion: nil)
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
//        println("print output");
//        println(output);
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
        //println("\(new[4])");
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        println(NSString(data: dataConnection, encoding: NSUTF8StringEncoding));
    
        var valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
            
        drivers = valuesDict.objectForKey("result_data") as! NSArray
        println(drivers);
        self.tableView.reloadData();
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        // Alternative workaround for crash!!
        //dataConnection = NSMutableData();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let allDriversUrl:NSURL?=NSURL(string:"http://mobile.comxa.com/parents/all_drivers.json");
        
        let urlReq:NSURLRequest=NSURLRequest(URL:allDriversUrl!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        println("print Group5 URL in class DriversListVC");
        println(allDriversUrl!);

        //        drivers = read() as NSArray;
//        println(drivers);
//        let path = NSBundle.mainBundle().pathForResource("drivers", ofType: "plist")
//        let data = NSDictionary(contentsOfFile: path!)!
//        drivers = data[userName] as! [String]
        var nib = UINib(nibName: "DriverCustomCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: "driverCustomCell");
       
    }
//    func read()->NSMutableArray{
//        
//        let dataFile:FileUtils = FileUtils(fileName: "drivers.plist");
//        let dataFilePath = dataFile.docsPath();
//        dataFile.createIfNotExistUnderDocs();
//        println(dataFilePath);
//        var newlist = NSMutableArray(contentsOfFile: dataFilePath);
//        return newlist!;
//    }
    override func viewWillAppear(animated: Bool) {
           }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.tableView.reloadInputViews();
        if drivers.count == 0 {
            return 1;
        }
        else {
            //self.tableView.reloadData();
            return drivers.count
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DriverCustomCell = self.tableView.dequeueReusableCellWithIdentifier("driverCustomCell") as! DriverCustomCell;
//        let currentFrame:CGRect = cell.frame;
//        cell = DriverCustomCell(frame: CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.width, currentFrame.height+30));
//        var cell:DriverCustomCell = DriverCustomCell();
        if drivers.count == 0 {
            var cell:UITableViewCell = UITableViewCell();
//            cell.driverName.hidden = true;
//            cell.driverUsername.hidden = true;
//            cell.driverImage.hidden = true;
            cell.textLabel?.text = "No drivers found";
        }
        else {
            //cell.textLabel?.text = (drivers[indexPath.row] as! String);
            var tmp = drivers[indexPath.row]["driver_name"] as! String;
            println(tmp)
            cell.textLabel?.text = "";
            cell.driverName.text = drivers[indexPath.row]["driver_name"] as! String;
            cell.driverName.sizeToFit();
            cell.driverUsername.text = drivers[indexPath.row].valueForKey("driver_username") as! String;
            cell.driverUsername.sizeToFit();
            let driverImageURL:String = drivers[indexPath.row].valueForKey("driver_image") as! String;
            let profileImage:UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: driverImageURL)!)!)!;
            println(cell.frame.height);
            cell.driverImage.image = profileImage;
            
           
        }
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if drivers.count > 0 {
            let index = indexPath.row;
            var redirect:DriverDetailsVC = UIStoryboard(name: "Team5_m", bundle: nil).instantiateViewControllerWithIdentifier("DDVC") as! DriverDetailsVC;
            SelectDriverReportVC.holder.driverName = (drivers[indexPath.row].valueForKey("driver_name") as! String);
            redirect.driverName = SelectDriverReportVC.holder.driverName!;
            self.navigationController?.pushViewController(redirect, animated: true)        }
    }
}