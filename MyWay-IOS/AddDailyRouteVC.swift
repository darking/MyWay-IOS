//
//  AddDailyRouteVC.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/17/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation

class AddDailyRouteVC{
    let fileName33  = "DailyReports.plist";
    
    var Daily:DailyReportVC = DailyReportVC();
    
    var location:DailyReportVC=DailyReportVC();
    
    func addToList(comment:String){
        
        
        let myUtil3:FileUtils = FileUtils(fileName: fileName33);
        let filePath:String = myUtil3.docsPath();
        
        var currentList:NSMutableArray = self.showAllReports();
        
        currentList.addObject(CommentLocation().valuesDicForComment(comment));
        currentList.writeToFile(filePath, atomically: false);
        
        println(filePath);
        
        
        
    }
    
    func showAllReports()->NSMutableArray{
        
        let newSetting = NSUserDefaults.standardUserDefaults();
        
        let myUtil3:FileUtils = FileUtils(fileName: fileName33);
        let filePath:String = myUtil3.docsPath();
        
        
        myUtil3.createIfNotExistUnderDocs();
        
        var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
        println("Daily Report");
        return list;
        
        
    }

}