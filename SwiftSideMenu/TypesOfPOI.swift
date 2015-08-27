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
    
    
    @IBOutlet var SuggestNewButton: UIButton!
    
    
    //checks if user is registered before going to the suggest new point screen
    //restricts access to un-registered users
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if NSUserDefaults.standardUserDefaults().boolForKey("isLoggedin"){
            return true;
        }
        else {

            return false;
        }
    }
    
    
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
    
    //to change the text of the suggest new point button to indicate logging in is needed.
    override func viewDidAppear(animated: Bool) {
        
            if NSUserDefaults.standardUserDefaults().boolForKey("isLoggedin"){
                SuggestNewButton.setTitle("Suggest New Point", forState: UIControlState.Normal);
            }
            else {
                SuggestNewButton.setTitle("Suggest New Point (Log in needed!)", forState: UIControlState.Normal);
                
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        poiTypes = DataManagement.getAllCats() as! [String];
        
    }
}