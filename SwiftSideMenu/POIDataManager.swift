
//  POIDataManager.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation


class POIDataManager{
    
    func getAllCats()->NSArray{
        
        var fileUtils:FileUtils = FileUtils(fileName:"cat");
        fileUtils.fileType = "plist";
        //        var filePath = fileUtils.bundlePath()!;
        var filePath = fileUtils.docsPath();
        return NSArray(contentsOfFile: filePath+".plist")!;
        
    }
    
    func getPlacesOfCat(catName:String)->NSArray{
        var fileUtils:FileUtils = FileUtils(fileName: "places");
        fileUtils.fileType = "plist";
        //        var filePath = fileUtils.bundlePath();
        var filePath = fileUtils.docsPath();
        var placesValues:NSDictionary = NSDictionary(contentsOfFile: filePath+".plist")!;
        return placesValues.objectForKey(catName) as! NSArray;
    }
    
    
    func getDetailsOFPlace(placeName:String)->NSDictionary{
        var fileUtils:FileUtils = FileUtils(fileName: "placeDetails");
        fileUtils.fileType = "plist";
        //        var filePath = fileUtils.bundlePath();
        var filePath = fileUtils.docsPath();
        var placesValues:NSDictionary = NSDictionary(contentsOfFile: filePath+".plist")!;
        return placesValues.objectForKey(placeName) as! NSDictionary;
    }
    
}