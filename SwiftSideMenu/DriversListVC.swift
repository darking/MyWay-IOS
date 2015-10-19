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
    var dataConnection:NSMutableData=NSMutableData();
    var drivers:NSArray = [];
    var userInput:UITextField?;

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
            let settings = NSUserDefaults.standardUserDefaults();
            var requestBody = "parentUserName=pifss" + "&driverIdentifier=aba" //+ self.userInput!.text;
            var requestUrl = ConnectionString.holder.URL + "/addUserDriver"
            
            self.request(requestBody, url: requestUrl) {
                
                responseData in
                
            }
        }
        addUserAlert.addAction(sendToDriver)
        //Add a text field
        addUserAlert.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            //textField.textColor = UIColor.blueColor()
            self.userInput = textField;
            //println("here i will print userInput");
            
        }
        
        //Present the AlertController
        self.presentViewController(addUserAlert, animated: true, completion: nil)
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
        }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
         var valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
        println(valuesDict);
        drivers = valuesDict.objectForKey("result_data") as! NSArray
        println("here i will print drivers");
        println(drivers);
        self.tableView.reloadData();
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        // Alternative workaround for crash!!
        //dataConnection = NSMutableData();
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var driverSetDes:DriverSetDestinationDao = DriverSetDestinationDao();
        //driverSetDest
        var thisUser:String = "ahmed"
        let allDriversUrl:NSURL?=NSURL(string:ConnectionString.holder.URL + "/getUserDrivers?parentUserName=" + thisUser);
        println(allDriversUrl);
        let urlReq:NSURLRequest=NSURLRequest(URL:allDriversUrl!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);

        var nib = UINib(nibName: "DriverCustomCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: "driverCustomCell");
       
    }

    override func viewWillAppear(animated: Bool) {
           }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        if drivers.count == 0 {
            var cell:UITableViewCell = UITableViewCell();

            cell.textLabel?.text = "No drivers found";
        }
        else {
            var tmp = drivers[indexPath.row]["driver_username"] as! String;
            println(tmp)
            cell.textLabel?.text = "";
            cell.driverName.text = drivers[indexPath.row]["driver_username"] as! String;
            cell.driverName.sizeToFit();
            //Change to email later
            cell.driverUsername.text = drivers[indexPath.row].valueForKey("driver_email") as! String;
            cell.driverImage.image = UIImage(named:"chauffer");
            cell.driverUsername.sizeToFit();
//            let driverImageURL:String = drivers[indexPath.row].valueForKey("driver_image") as! String;
//            let profileImage:UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: driverImageURL)!)!)!;
//            println(cell.frame.height);
//            cell.driverImage.image = profileImage;
        }
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if drivers.count > 0 {
            let index = indexPath.row;
            var redirect:DriverDetailsVC = UIStoryboard(name: "Team5_m", bundle: nil).instantiateViewControllerWithIdentifier("DDVC") as! DriverDetailsVC;
            DriverBean.driverHolder.driverUsername = drivers[indexPath.row].valueForKey("driver_username") as! String!;
            DriverBean.driverHolder.driverEmail = drivers[indexPath.row].valueForKey("driver_email") as! String;
//            DriverBean.driverHolder.driverImageURL = drivers[indexPath.row].valueForKey("driver_image") as! String;
            
            self.navigationController?.pushViewController(redirect, animated: true)        }
    }
    func request(requestBody:String, url:String, completionHandler: (responseData:NSData) -> ()) {
        var request = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) in
            println(data)
        }
    }
}