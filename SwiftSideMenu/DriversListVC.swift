//
//  DriversListVC.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015 mashael. All rights reserved.
//

import Foundation
import UIKit
class DriverListVC:UITableViewController{
   
    
    var DataManagement:ReadReport = ReadReport();
  
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        
        cell.textLabel?.text = "rajo"
        
        return cell
        
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
       SelectDriverReportVC.holder.driverName = "rajo"
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
   
    }
    

}