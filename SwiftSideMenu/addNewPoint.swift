//
//  addNewPoint.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/18/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation

class addNewPoint{
    
    let placeDetails  = "placeDetails.plist";
    let places  = "places.plist";
    
    var newPoi:AddNewPOI = AddNewPOI();
    
    func poiFilePath()->String{
        let myUtil3:FileUtils = FileUtils(fileName: placeDetails);
        let filePath:String = myUtil3.docsPath();
        return filePath;
    }
    
    func addpointii(newR: PointOfInterest){
        self.addPointToPlaces(newR);
        self.addPointToPointDetails(newR);
    }
    func addPointToPlaces(newR: PointOfInterest){
        
        let myUtil3:FileUtils = FileUtils(fileName: places);
        let filePath:String = myUtil3.docsPath();
        var allCats:NSMutableDictionary = NSMutableDictionary(contentsOfFile: filePath)!;
        var allPlaces:NSMutableArray = allCats.objectForKey(newR.type) as! NSMutableArray;
        
        allPlaces.addObject(newR.name);
        allCats.setValue(allPlaces, forKey: newR.type);
        
        allCats.writeToFile(filePath, atomically: true);
        
        
    }
    
    func addPointToPointDetails(newR: PointOfInterest){
        let myUtil3:FileUtils = FileUtils(fileName: placeDetails);
        let filePath:String = myUtil3.docsPath();
        
        var currentList:NSMutableDictionary = showAllLocationDetails();
        currentList.setValue(newR.toDictionary(), forKey: newR.name);
        currentList.writeToFile(filePath, atomically: true);
    }
    
    func showOneLocation(pointName:String)->PointOfInterest{
        
        var values:NSMutableDictionary = showAllLocationDetails().objectForKey(pointName) as! NSMutableDictionary;
        values.setValue(pointName, forKey: "name");
        var newPoint:PointOfInterest = PointOfInterest(values: values);
        return newPoint;
    }
    
    //func showAllLocations() ->NSMutableArray{
    //    var allDetails = showAllLocationDetails();
    //    var allObjects:NSMutableArray = NSMutableArray();
    //    var keyList:NSArray = allDetails.allKeys;
    //
    //
    //
    //    for (var i = 0 ; i < allDetails.count ; i++){
    //        var currentDict:NSDictionary = allDetails.objectAtIndex(i) as NSDictionary;
    //        allObjects.addObject(PointOfInterest(values: currentDict));
    //    }
    //    return allObjects;
    //}
    func showAllLocationDetails()->NSMutableDictionary{
        
        let newSetting = NSUserDefaults.standardUserDefaults();
        let myUtil3:FileUtils = FileUtils(fileName: placeDetails);
        let filePath:String = myUtil3.docsPath();
        println(filePath);
        myUtil3.createIfNotExistUnderDocs();
        var list:NSMutableDictionary = NSMutableDictionary(contentsOfFile: filePath)!;
        
        return list;
    }
}