//
//  AllpListController.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/17/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
class AllpListController{
    var daily:AddDailyRouteVC=AddDailyRouteVC();
    var objectsArray: NSMutableArray = NSMutableArray();
    func AddToArray()->NSMutableArray
    {
        var pm:NSMutableArray = self.readArrayFromFile("ParentMonitorReports.plist");
        objectsArray.addObjectsFromArray(pm as [AnyObject]);
        var dr:NSMutableArray = self.readArrayFromFile("DailyRoutes.plist");
        objectsArray.addObjectsFromArray(dr as [AnyObject]);
//        for v in objectsArray
//        {
//            println("\(v)");
//        }
        return objectsArray;
    }
    func readArrayFromFile(fileToRead:String)->NSMutableArray{
        let myUtil:FileUtils = FileUtils(fileName:fileToRead);
        let filePath:String = myUtil.docsPath();
        myUtil.createIfNotExistUnderDocs();
        var list:NSMutableArray = NSMutableArray(contentsOfFile: filePath)!;
        return list;
    }
}