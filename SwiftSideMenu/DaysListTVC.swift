//
//  DaysListTVC.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015. All rights reserved.
//


import UIKit
class DaysListTVC:UITableViewController{
    var read:ReadReport = ReadReport();
    var daysArray:NSArray = [];
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysArray.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell();
    
        var dayValue:Data = daysArray.objectAtIndex(indexPath.row) as! Data;
        cell.textLabel?.text = dayValue.day;
        
        return cell;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        var row:Int = indexPath.row;
        var mainStoryboard:UIStoryboard = UIStoryboard(name: "Main5_Report", bundle: nil);
        var vc : MonitorReportVC = mainStoryboard.instantiateViewControllerWithIdentifier("MR") as! MonitorReportVC;
        vc.index = row;
        //self.navigationController?.pushViewController( vc, animated: true)
        self.presentViewController(vc, animated: true, completion: {});
    }
    override func viewDidLoad(){
        super.viewDidLoad();
        daysArray = read.getDays();
    }
    
}