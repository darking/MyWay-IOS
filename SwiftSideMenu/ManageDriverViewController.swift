//
//  ManageDriverViewController.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
class ManageDriverViewController:UITableViewController{
    var index = 0;
//    @IBAction func AddBtn(sender: AnyObject) {
//        
//    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell();
        var row:String = String();
        var section:String = String(indexPath.section);
        var info = ["show","Add"]
        cell.textLabel?.text = "tt"
        return cell
    }
}



