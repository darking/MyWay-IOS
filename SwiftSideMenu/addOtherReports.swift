//
//  addOtherReports.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class addOtherReports : UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    
    var dataConnection:NSMutableData=NSMutableData();
    
    let fileName33  = "OthersReports.plist";
 
    var OTHER:otherVC = otherVC();
    
    var location:otherVC=otherVC();
    
    func addToOtherList(comment:String,id_report:Int){
        
      
            let myUtil3:FileUtils = FileUtils(fileName: fileName33);
            let filePath:String = myUtil3.docsPath();
            
            var currentList:NSMutableArray = self.showAllReports();
        
        //sh taleef
        
       var cl:CommentLocation = CommentLocation()
        var URLStatement:NSString = cl.urlParams(CommentLocation().valuesDicForComment(comment,id_report: id_report));
        let Group4Url:NSURL?=NSURL(string:"http://mobile.comxa.com/reports/all_reports.json?\(URLStatement)");
        
        let urlReq:NSURLRequest=NSURLRequest(URL:Group4Url!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        println(Group4Url)
        
        //finish taleef
        println(comment)
        println(id_report)
            currentList.addObject(CommentLocation().valuesDicForComment(comment,id_report: id_report));
        
            currentList.writeToFile(filePath, atomically: false);
            println("I'm trying to know what is saved in current List var");
            println(currentList);
            println("Here its finish ");

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
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        
        println(output);
        
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
        println("\(new[0])")
     
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var valuesDict = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil);
        
    }
    

}
