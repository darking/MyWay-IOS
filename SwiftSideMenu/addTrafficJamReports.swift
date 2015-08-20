//
//  addTrafficJamReports.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//


import Foundation
import UIKit
class addTrafficJamReports{
    
    let fileName  = "ModerateTraffic.plist";
    let fileName2 = "HeavyTraffic.plist";
    let fileName3 = "StandstillTraffic.plist";
    var TRAFFIC:trafficVC = trafficVC();
    
    
    
    func addToTrafficList(comment:String){
        let newSetting = NSUserDefaults.standardUserDefaults();
        
        if( TRAFFIC.moderateFlag == true)
        {
            let myUtil:FileUtils = FileUtils(fileName: fileName);
            let filePath:String = myUtil.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
            currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath, atomically: false);
            
            println(filePath);}
            
        else if (TRAFFIC.heavyFalg == true)
        {
            
            let myUtil2:FileUtils = FileUtils(fileName: fileName2);
            let filePath2:String = myUtil2.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
            currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath2, atomically: false);
            
            println(filePath2);
            
        }
        else {
            let myUtil3:FileUtils = FileUtils(fileName: fileName3);
            let filePath3:String = myUtil3.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
            currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath3, atomically: false);
           
            println(filePath3);
        }
        
    }
    
    func showAllReports()->NSMutableArray{
        
        let newSetting = NSUserDefaults.standardUserDefaults();
        var result:Bool=newSetting.boolForKey("moderate");
        println(newSetting.boolForKey("heavy"));
        println(newSetting.boolForKey("moderate"));
        println(newSetting.boolForKey("standstill"));
       
        if(result == true)
        {
            let myUtil:FileUtils = FileUtils(fileName: fileName);
            let filePath:String = myUtil.docsPath();
            
            
            myUtil.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
            println("MODERATE");
            return list;
        }
        else if  newSetting.boolForKey("heavy")==true{
            let myUtil2:FileUtils = FileUtils(fileName: fileName2);
            let filePath2:String = myUtil2.docsPath();
            
            
            myUtil2.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath2)!;
            println("HEAVY");
            return list;
            
        }
        else {
            let myUtil3:FileUtils = FileUtils(fileName: fileName3);
            let filePath3:String = myUtil3.docsPath();
            
            
            myUtil3.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath3)!;
            println("STANDSTILL");
            return list;
            
        }
    
    }
    
}