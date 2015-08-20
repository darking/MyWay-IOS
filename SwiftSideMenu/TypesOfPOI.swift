//
//  TypesOfPOI.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class TypesOfPOI:UITableViewController {
    
    @IBAction func toggleAction(sender: AnyObject) {
        toggleSideMenuView();
    }
    
    @IBAction func AddNewButton(sender: AnyObject) {
        
        
        
    }
    
    //checks if user is registered before going to the suggest screen
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if NSUserDefaults.standardUserDefaults().boolForKey("isLoggedin"){
            return true;
        }
        else {
//            var alert : UIAlertView = UIAlertView(title: "Access Denied!", message: "Please log in or register to suggest a point.",
//                delegate: nil, cancelButtonTitle: "OK");
//            alert.show();
            
            return false;
        }
    }
    
    
    //    var poiTypesNames:[String] = ["Malls","Gas stations","Hospitals"];
    //    var poiTypes:[String:[String]] = ["Malls":["360","Ave."], "Gas stations":["alfa","Oula"], "Hospitals":["AlSalam", "AlHady", "Royal"]];
    
    
    var DataManagement:POIDataManager = POIDataManager();
    var poiTypes:[String] = [];
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poiTypes.count;//will change to the size(count) of the array returned from the server
    }
    
    //        override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //            var sectionHeaderView = NSBundle.mainBundle().loadNibNamed("PlanCellSectionHeader", owner: nil, options: nil)
    //
    //            return "";
    //        }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell();
        var row = indexPath.row;
        cell.textLabel?.text = poiTypes[row];
        return cell;//should contain types retrieved from the server
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row;
        var mainStoryBoard:UIStoryboard = UIStoryboard(name: "Team3", bundle: nil);
        var nextScreen:SubTypesOfPOI = mainStoryBoard.instantiateViewControllerWithIdentifier("subTypes") as! SubTypesOfPOI;//we use as to customize the returned generic return value of the method
        nextScreen.type = poiTypes[row];
        println(poiTypes[row]);
        self.navigationController?.pushViewController(nextScreen, animated: true);
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        poiTypes = DataManagement.getAllCats() as! [String];
        
    }
}