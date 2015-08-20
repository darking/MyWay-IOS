//
//  FileCopier.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/18/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation

class FileCopier{
    
    func copyArrayFile(fileName:String){
        
        
        var bundlePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist");
        var fileUtils = FileUtils(fileName: fileName, withType: "plist");
        fileUtils.fileType = "plist";
        
        var docsPath = fileUtils.docsPath()+".plist";
        
        var list = NSArray(contentsOfFile: bundlePath!);
        list?.writeToFile(docsPath, atomically: true);
        
        
    }
    func copyDictionaryFile(fileName:String){
        var bundlePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist");
        var fileUtils = FileUtils(fileName: fileName);
        fileUtils.fileType = "plist";
        
        var docsPath = fileUtils.docsPath()+".plist";
        
        var list = NSDictionary(contentsOfFile: bundlePath!);
        list?.writeToFile(docsPath, atomically: true);
    }
    
}