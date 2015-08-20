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
    func dailyFilePath()->String{
        let myUtil3:FileUtils = FileUtils(fileName: fileName33);
        let filePath:String = myUtil3.docsPath();
        return filePath;
    }
    func addDailyRoute(newR: DailyRouteHolder){
        let myUtil3:FileUtils = FileUtils(fileName: fileName33);
        let filePath:String = myUtil3.docsPath();
        var currentList:NSMutableArray = self.showAllReports();
        currentList.addObject(newR.toDictionary());
        currentList.writeToFile(filePath, atomically: true);
    }
    func showAllObjects() ->NSMutableArray{
        var allDicts = self.showAllReports();
        var allObjects:NSMutableArray = NSMutableArray();
        for (var i = 0 ; i < allDicts.count ; i++){
            var currentDict:NSDictionary = allDicts.objectAtIndex(i) as! NSDictionary;
            allObjects.addObject(DailyRouteHolder(values: currentDict));
        }
        return allObjects;
    }
    func showAllReports()->NSMutableArray{
        let newSetting = NSUserDefaults.standardUserDefaults();
        let myUtil3:FileUtils = FileUtils(fileName: fileName33);
        let filePath:String = myUtil3.docsPath();
        println(filePath);
        myUtil3.createIfNotExistUnderDocs();
        var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
        return list;
    }
}