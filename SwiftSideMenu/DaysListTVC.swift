//
//  DaysListTVC.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015. All rights reserved.
//


import UIKit
class DaysListTVC:UITableViewController, ENSideMenuDelegate {
    var read:ReadReport = ReadReport();
    var daysArray:NSArray = [];
    
    @IBAction func menuButton(sender: AnyObject) {
        toggleSideMenuView();
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if daysArray.count == 0{
            return 1;
        } else {
            return daysArray.count;
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell();
        
        if daysArray.count == 0 {
            cell.textLabel?.text = "No available reports.";
        } else {
            var dayValue:Data = daysArray.objectAtIndex(indexPath.row) as! Data;
            cell.textLabel?.text = dayValue.day;
        }
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        var row:Int = indexPath.row;
        var mainStoryboard:UIStoryboard = UIStoryboard(name: "Team5_m", bundle: nil);
        var vc : MonitorReportVC = mainStoryboard.instantiateViewControllerWithIdentifier("MR") as! MonitorReportVC;
        vc.index = row;
        //self.navigationController?.pushViewController( vc, animated: true)
        
        self.navigationController?.pushViewController(vc, animated: true);
    }
    override func viewDidLoad(){
        super.viewDidLoad();
   //     daysArray = read.getDays();
    }
    
}