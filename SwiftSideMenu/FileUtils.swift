//
//  FileUtils.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
class FileUtils{
    var fileName:String;
    var fileType:String?;
    init (fileName:String){
        self.fileName = fileName;
    }
    init (fileName:String, withType fileType:String){
        self.fileName = fileName;
        self.fileType = fileType;
    }
    func bundlePath()->String?{
        return NSBundle.mainBundle().pathForResource(fileName, ofType: fileType);
    }
    private func fileWithExt()->String?{
        return fileName+"."+fileType!;
    }
    func docsPath()->String{
        let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL;
        let destinationUrl = documentsUrl.URLByAppendingPathComponent(fileName);
        return destinationUrl.path!;
    }
    func existsUnderDocs()->Bool{
        let fileExists = NSFileManager.defaultManager().fileExistsAtPath(self.docsPath());
        return fileExists;
    }
    func createIfNotExistUnderDocs(){
        let fileExists = NSFileManager.defaultManager().fileExistsAtPath(self.docsPath());
        if fileExists {
            return;
        }
        NSFileManager.defaultManager().createFileAtPath(self.docsPath(), contents: nil, attributes: nil);
        NSArray().writeToFile(self.docsPath(), atomically: true);
    }
    func removeFromDocs(){
        NSFileManager.defaultManager().removeItemAtPath(self.docsPath(), error: nil);
    }
}