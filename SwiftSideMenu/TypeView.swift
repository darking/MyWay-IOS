//
//  TypeView.swift
//  ex1
//
//  Created by iOS on 8/16/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class TypeView: UITableViewController{
    
    
    var DataManagement:POIDataManager = POIDataManager();
    var info:NSArray = [];
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        
        cell.textLabel?.text = info[indexPath.row] as? String;
        
        return cell
        
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        AddNewPOI.holder.typeName = info[indexPath.row] as! String;
        
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        info = DataManagement.getAllCats();
    }
    
    
}
