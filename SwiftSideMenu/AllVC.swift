//
//  AllVC.swift
//  Post Report
//
//  Created by hebah albuloushi on 8/16/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation

class allCommentVC {

    var o:addOtherReports=addOtherReports();
    var minor:addAccidentsReport=addAccidentsReport();
    var construction:addHazardReport=addHazardReport();
    var standstill:addTrafficJamReports=addTrafficJamReports();
    var objectsArray: NSMutableArray = NSMutableArray();
    
    
    
    func AddToArray()->NSMutableArray
    {
    
        var othersArray:NSMutableArray = self.readArrayFromFile("OthersReports.plist");
        objectsArray.addObjectsFromArray(othersArray as [AnyObject]);
        var minor:NSMutableArray = self.readArrayFromFile("minorAccidentReports.plist");
        
        objectsArray.addObjectsFromArray(minor as [AnyObject]);
        
        
        var major:NSMutableArray = self.readArrayFromFile("majorAccidentReports.plist");
        
        objectsArray.addObjectsFromArray(major as [AnyObject]);

        
        var onroad:NSMutableArray = self.readArrayFromFile("OnRoadReports.plist");
        
        objectsArray.addObjectsFromArray(onroad as [AnyObject]);
        
        var construction:NSMutableArray = self.readArrayFromFile("ConstructionReports.plist");
        
        objectsArray.addObjectsFromArray(construction as [AnyObject]);
        
        var moderate:NSMutableArray = self.readArrayFromFile("ModerateTraffic.plist");
        
        objectsArray.addObjectsFromArray(moderate as [AnyObject]);

        
        var heavy:NSMutableArray = self.readArrayFromFile("HeavyTraffic.plist");
        
        objectsArray.addObjectsFromArray(heavy as [AnyObject]);
        
        var standStill:NSMutableArray = self.readArrayFromFile("standstillTraffic.plist");
        
        objectsArray.addObjectsFromArray(standStill as [AnyObject]);
        for v in objectsArray
        {
            
            println("\(v)");
            
        }
    
        return objectsArray;
    }
    
    
//    for values in dictionies{
//    objectsArray.addObject(CommentLocation().objectFromDict(values as! NSDictionary));
    
    
    func readArrayFromFile(fileToRead:String)->NSMutableArray{
        let myUtil:FileUtils = FileUtils(fileName:fileToRead);
        let filePath:String = myUtil.docsPath();
        myUtil.createIfNotExistUnderDocs();
        var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
        return list;
    }
}
