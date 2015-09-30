//
//  DriversListViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit

class DriversListVC: UITableViewController , UITableViewDataSource, ENSideMenuDelegate {
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
    }
    var userName = ""
    var drivers:NSArray = NSArray();
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
            textField.textColor = UIColor.blueColor()
        }
        
        //Present the AlertController
        self.presentViewController(addUserAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drivers = read() as NSArray;
        
        println(drivers);
        
//        let path = NSBundle.mainBundle().pathForResource("drivers", ofType: "plist")
//        let data = NSDictionary(contentsOfFile: path!)!
//        drivers = data[userName] as! [String]
    }
    func read()->NSMutableArray{
        
        let dataFile:FileUtils = FileUtils(fileName: "drivers.plist");
        let dataFilePath = dataFile.docsPath();
        dataFile.createIfNotExistUnderDocs();
        println(dataFilePath);
        var newlist = NSMutableArray(contentsOfFile: dataFilePath);
        return newlist!;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if drivers.count == 0 {
            return 1;
        }
        else {
        return drivers.count
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("c", forIndexPath: indexPath) as! UITableViewCell
        let cell:UITableViewCell = UITableViewCell();
        if drivers.count == 0 {
            cell.textLabel?.text = "No drivers found";
        }
        else {
            cell.textLabel?.text = (drivers[indexPath.row] as! String);
        }
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if drivers.count > 0 {
            let index = indexPath.row;
            var redirect:DriverDetailsVC = UIStoryboard(name: "Team5_m", bundle: nil).instantiateViewControllerWithIdentifier("DDVC") as! DriverDetailsVC;
            SelectDriverReportVC.holder.driverName = (drivers[indexPath.row] as! String);
            redirect.driverName = SelectDriverReportVC.holder.driverName!;
            self.navigationController?.pushViewController(redirect, animated: true)        }
       
    }
}