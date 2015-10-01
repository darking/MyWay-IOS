//
//  addOtherReports.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class addOtherReports{
    
    
    let fileName33  = "OthersReports.plist";
 
    var OTHER:otherVC = otherVC();
    
    var location:otherVC=otherVC();
    
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
            println("OTHER");
            return list;
        
    
    }

}
