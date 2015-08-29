//
//  ReadReport.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015. All rights reserved.
//

import Foundation
class ReadReport{
    let path =   NSBundle.mainBundle().pathForResource("MonitorReportSample", ofType: "plist");
    
   
    func getDriverInfo()->NSDictionary{
         var list:NSDictionary = NSDictionary(contentsOfFile: path!)!;
        return list.objectForKey("rajo") as! NSDictionary;
    }
    func getDays()->NSArray{
        var dayGetter:NSDictionary = self.getDriverInfo();
        var allKeys:NSArray = dayGetter.allKeys;
        var allDaysObjects:NSMutableArray = NSMutableArray();
        for (var i = 0 ; i < allKeys.count ; i++){
            
            var values:NSDictionary = dayGetter.objectForKey(allKeys.objectAtIndex(i)) as! NSDictionary;
            var day = allKeys.objectAtIndex(i) as! String;
            var date = Data(subDict: values, dayValue: day);
            allDaysObjects.addObject(date);
        }
        return allDaysObjects;
    }
}