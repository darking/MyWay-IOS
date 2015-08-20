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
class DailyRouteViewController:UITableViewController, ENSideMenuDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
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
        return manager.showAllObjects().count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row:Int = indexPath.row;
        var mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        var vc : ModifyDailyRouteVC = mainStoryboard.instantiateViewControllerWithIdentifier("MDRVC") as! ModifyDailyRouteVC;
        vc.index = row;
        self.navigationController?.pushViewController( vc, animated: true)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var row:Int = indexPath.row;
        var manager:AddDailyRouteVC = AddDailyRouteVC();
        var list:NSMutableArray = manager.showAllObjects();
        var cell:UITableViewCell = UITableViewCell();
        var values:DailyRouteHolder = list.objectAtIndex(row) as! DailyRouteHolder;
        cell.textLabel?.text = values.name;
        cell.textLabel?.numberOfLines = 5;
        return cell;
    }
}

