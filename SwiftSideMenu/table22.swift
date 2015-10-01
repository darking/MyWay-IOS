//
//  table22.swift
//  day6-task2
//
//  Created by iOS on 8/11/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class table22:UITableViewController{

    var index = 0;
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let dataFile:FileUtils = FileUtils(fileName: "data.plist")
//        
//        let dataFilePath = dataFile.docsPath();
//        
//        dataFile.createIfNotExistUnderDocs();
//        
//        var currentList:NSMutableArray = NSMutableArray(contentsOfFile: dataFilePath)!;
//        
        return 1;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
//        let dataFile:FileUtils = FileUtils(fileName: "data.plist")
//        
//        let dataFilePath = dataFile.docsPath();
//        
//        dataFile.createIfNotExistUnderDocs();
//        
//        var currentList:NSMutableArray = NSMutableArray(contentsOfFile: dataFilePath)!;

        
        

        
        var cell:UITableViewCell = UITableViewCell()
        var row:String = String()
        var section:String = String(indexPath.section)

    
        
        

        //cell.textLabel?.text = currentList.objectAtIndex(indexPath.row) as! String;
        
        return cell
    }
    
    

    
}



//2015-08-31 20:00:04.176 GMapsDemo[8811:369726] Google Maps SDK for iOS version: 1.10.19729.0
//[place_id: ChIJoVHqvj82xT8R0u3Yks1rcnQ, formatted_address: Kuwait, types: (
//country,
//political
//), address_components: (
//{
//"long_name" = Kuwait;
//"short_name" = KW;
//types =         (
//country,
//political
//);
//}
//), geometry: {
//bounds =     {
//northeast =         {
//lat = "30.1036993";
//lng = "48.4304579";
//};
//southwest =         {
//lat = "28.5244463";
//lng = "46.55303989999999";
//};
//};
//location =     {
//lat = "29.31166";
//lng = "47.481766";
//};
//"location_type" = APPROXIMATE;
//viewport =     {
//northeast =         {
//lat = "30.1037061";
//lng = "48.4304579";
//};
//southwest =         {
//lat = "28.5244463";
//lng = "46.55303989999999";
//};
//};
//}]
//fatal error: Array index out of range

