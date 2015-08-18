//
//  AddMonitorReport.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/17/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
class AddMonitorReport{
    
    let fileName33  = "ParentMonitorReports.plist.plist";
    
    var Monitor:AddMonitorReportVC = AddMonitorReportVC();
    
    var location:AddMonitorReportVC = AddMonitorReportVC();
    
    func addToOtherList(comment:String){
        
        
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
        println("Monitor Report");
        return list;
        
        
    }
}