//
//  addAccidentsReport.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//


import Foundation
import UIKit
class addAccidentsReport{
    
    let fileNamee  = "minorAccidentReports.plist";
    let fileName22 = "majorAccidentReports.plist";
    var ACCIDENT:accidentVC=accidentVC();
    
    
    
    func addToAccidentsList(comment:String){
        
        if( ACCIDENT.minorFlag == true)
        {
            let myUtil:FileUtils = FileUtils(fileName: fileNamee);
            let filePath:String = myUtil.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
           currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath, atomically: false);
            // ACCIDENTS.minorFlag=false;
            println(filePath);}
            
        else
        {
            
            let myUtil2:FileUtils = FileUtils(fileName: fileName22);
            let filePath2:String = myUtil2.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
            
            currentList.addObject(CommentLocation().valuesDicForComment(comment));
            currentList.writeToFile(filePath2, atomically: false);
            // ACCIDENTS.majorFlag=false;
            println(filePath2);
            
        }
        
    }
    
    func showAllReports()->NSMutableArray{
        
        let newSetting = NSUserDefaults.standardUserDefaults();
        var result:Bool=newSetting.boolForKey("minor");
        println(newSetting.boolForKey("minor"));
        if(result == true)
        {
            let myUtil:FileUtils = FileUtils(fileName: fileNamee);
            let filePath:String = myUtil.docsPath();
            
            
            myUtil.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
            println("MINOR");
            return list;}
            
        else
        {
            
            let myUtil2:FileUtils = FileUtils(fileName: fileName22);
            let filePath2:String = myUtil2.docsPath();
            myUtil2.createIfNotExistUnderDocs();
            
            var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath2)!;
            println("MAJOR");
            return list;
        }
        
    }
    
    
    
}