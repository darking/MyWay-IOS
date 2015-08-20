//
//  ManagePoints.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation

class ManagePoints {
    
    func read() ->NSMutableArray{
        let dataFile:FileUtils = FileUtils(fileName: "Points.plist");
        let dataFilePath = dataFile.docsPath();
        dataFile.createIfNotExistUnderDocs();
        var newlist = NSMutableArray(contentsOfFile: dataFilePath);
        
        return newlist!;
    }
    
//    func write(point:[String:String]) {//to get info from server and add suggested point to send back to the server..
//        let dataFile:FileUtils = FileUtils(fileName: "Points.plist");
//        let dataFilePath = dataFile.docsPath();
//        println(dataFilePath);
//        var oldData:NSMutableArray = self.read();
//        oldData.addObject(point);
//        oldData.writeToFile(dataFilePath, atomically: false);
//        
//        println(oldData);
//
//    }
    
    func writeToPlist(point:String){
        let dataFile:FileUtils = FileUtils(fileName: "placeDetails.plist");
        let dataFilePath = dataFile.docsPath();
        println(dataFilePath);
        var oldData:NSMutableArray = self.read();
        oldData.addObject(point);
        oldData.writeToFile(dataFilePath, atomically: false);
        
        println(oldData);
        
    }
    
//    func writeToServer(point:String){
//        
//    
//    }
    
}