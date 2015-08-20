//
//  addHazardReport.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class addHazardReport{
    
    
    let fileName4  = "OnRoadReports.plist";
    let fileName5 = "ConstructionReports.plist";
    var HAZARD:hazardVC = hazardVC();
    
    
    
    func addToHazardList(comment:String){
        
        if( HAZARD.onroadFlag == true)
        {
            let myUtil:FileUtils = FileUtils(fileName: fileName4);
            let filePath:String = myUtil.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
             currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath, atomically: false);
            
            println(filePath);}
            
        else
        {
            
            let myUtil2:FileUtils = FileUtils(fileName: fileName5);
            let filePath2:String = myUtil2.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
             currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath2, atomically: false);
          
            println(filePath2);
            
        }
        
    }
    
    func showAllReports()->NSMutableArray{
        
        let newSetting = NSUserDefaults.standardUserDefaults();
        var result:Bool=newSetting.boolForKey("onroad");
        println(newSetting.boolForKey("onroad"));
        if(result == true)
        {
            let myUtil:FileUtils = FileUtils(fileName: fileName4);
            let filePath:String = myUtil.docsPath();
            
            
            myUtil.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
            println("ONROAD");
            return list;}
            
        else
        {
            
            let myUtil2:FileUtils = FileUtils(fileName: fileName5);
            let filePath2:String = myUtil2.docsPath();
            myUtil2.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath2)!;
            println("CONSTRUCTION");
            return list;
        }
        
    }
    
    

    
    
    
}