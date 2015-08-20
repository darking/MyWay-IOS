//
//  SubTypesOfPOI.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class SubTypesOfPOI:UITableViewController, UITableViewDataSource, UITableViewDelegate{
    
    var DataManagement:POIDataManager = POIDataManager();
    var tableViewx = UITableView()
    var showsArray = Array<String>()
    
    var type:String = "";
    
    var locations:[String] = [];
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locations.count == 0 {
            return 1;
        }
        else{
            return locations.count;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if locations.count != 0 {
            let cellFrame = CGRectMake(0, 0, self.tableView.frame.width, 52.0)
            var retCell = UITableViewCell(frame: cellFrame)
            var textLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 52.0 - 4.0))
            
            textLabel.textColor = UIColor.blackColor()
            textLabel.text = locations[indexPath.row];
            retCell.addSubview(textLabel);
            return retCell;
        }
        else {
            var cell:UITableViewCell = UITableViewCell();
            cell.textLabel?.text = "No Locations found.";
            return cell;
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        
    {
        
        return 52.0
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if locations.count == 0 {
            //doesnt do anything
        }
        else {
            var row = indexPath.row;
            var mainStoryBoard:UIStoryboard = UIStoryboard(name: "Team3", bundle: nil);
            var nextScreen:MoreInfoOfPOI = mainStoryBoard.instantiateViewControllerWithIdentifier("MoreInfoOfPOI") as! MoreInfoOfPOI;//we use as to customize the returned generic return value of the method
            nextScreen.placeName = locations[row];
            self.navigationController?.pushViewController(nextScreen, animated: true);
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 64.0
        }
        return 32.0
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        if locations.count == 0 {
            let suggestNew = UITableViewRowAction(style: .Normal, title: "Suggest Some!") { action, index in
                println("clicked..")
                //                var alert : UIAlertView = UIAlertView(title: "ALERT!!", message: "TEST TEST.",
                //                    delegate: nil, cancelButtonTitle: "OK");
                //                alert.show();
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
                
            }
            
            suggestNew.backgroundColor = UIColor.orangeColor()
            return [suggestNew]
        }
        else {
            let sendToMap = UITableViewRowAction(style: .Normal, title: "Send To Map") { action, index in
                println("send button tapped")
                var mapVC:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
                
//                let placeName = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.textLabel?.text;
//                var place = self.DataManagement.getDetailsOFPlace(placeName!) as NSDictionary;
//                mapVC.title = place.objectForKey("name") as! String;
//                mapVC.message = place.objectForKey("description") as! String;
//                let lat:String = place.objectForKey("lat") as! String;
//                let lng:String = place.objectForKey("long") as! String;
//                
//                let location = CLLocation(latitude: (lat as NSString).doubleValue, longitude: (lat as NSString).doubleValue)
//                mapVC.location = location;
//                self.navigationController?.pushViewController(mapVC, animated: true);
                
            }
            
            sendToMap.backgroundColor = UIColor.orangeColor()
            return [sendToMap]
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView = UITableView(frame: self.view.frame)
        tableView.separatorColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
        
        locations = DataManagement.getPlacesOfCat(type) as! [String];
        //        self.view.addSubview(tableView)
    }
}