//
//  DailyRouteViewController.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
class DailyRouteViewController:UITableViewController {
    
//    var mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
//    var vc : AddDailyRouteVC = mainStoryboard.instantiateViewControllerWithIdentifier("AddForm") as AddDailyRouteVC;
//    self.navigationController?.pushViewController( vc, animated: true)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        CMMotionManager.st
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var manager:AddDailyRouteVC = AddDailyRouteVC();
        return manager.showAllReports().count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var row:Int = indexPath.row;
        var manager:AddDailyRouteVC = AddDailyRouteVC();
        var list:NSMutableArray = manager.showAllReports();
        
        var cell:UITableViewCell = UITableViewCell();
        var values:NSDictionary = list.objectAtIndex(row) as NSDictionary;
        println(values.objectForKey("log"));
        cell.textLabel?.text = values.objectForKey("comment") as? String;
        cell.textLabel?.numberOfLines = 5;
        
        return cell;
    }
    
    
    
}

