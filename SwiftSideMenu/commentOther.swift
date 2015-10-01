//
//  commentOther.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class commentOther:UITableViewController ,CLLocationManagerDelegate{
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var manager:addOtherReports = addOtherReports();
        return manager.showAllReports().count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var row:Int = indexPath.row;
        var manager:addOtherReports = addOtherReports();
        var list:NSMutableArray = manager.showAllReports();
        
        var cell:UITableViewCell = UITableViewCell();
        var values:NSDictionary = list.objectAtIndex(row) as! NSDictionary;
        println(values.objectForKey("log"));
        cell.textLabel?.text = values.objectForKey("comment") as! String;
        cell.textLabel?.numberOfLines = 5;
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row:Int = indexPath.row;
        var manager:addOtherReports = addOtherReports ();
        var list:NSMutableArray = manager.showAllReports();
        var values:NSDictionary = list.objectAtIndex(row) as! NSDictionary;
        var report:CommentLocation = CommentLocation().objectFromDict(values);
        
        var showMap:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
        showMap.title = "other";
        showMap.message = report.comment;
        
        
        //showMap.location = report.reportLocation;
        
        //MASHMOUM ebra
      //  var laa = GetLocationVC.getCurrentLocation().0
        //var lnn = GetLocationVC.getCurrentLocation().1
        let (latitud, longitud) =  GetLocationVC().getCurrentLocation()
       
        //var myCLL:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
        var myCLL:CLLocation = CLLocation(latitude: (NSUserDefaults.standardUserDefaults().valueForKey("lat") as! NSString).doubleValue , longitude: (NSUserDefaults.standardUserDefaults().valueForKey("lon") as! NSString).doubleValue)
        showMap.location = myCLL
        //./MASHMOUM
        
        self.navigationController?.pushViewController(showMap, animated: true);
    }
    

}
