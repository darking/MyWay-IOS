//
//  DriverList.swift
//  SwiftSideMenu
//
//  Created by Adnan Alqazwini on 10/6/15.
//
//

import Foundation

class DriverList:NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var dataConnection:NSMutableData=NSMutableData();
    func getReportList()
    {
        
        let Group5Url:NSURL?=NSURL(string:"http://mobile.comxa.com/parents/all_drivers.json");
        
        let urlReq:NSURLRequest=NSURLRequest(URL:Group5Url!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        println("print Group5 URL in class ListAllReports");
        
        println(Group5Url);
        
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        println("print output");
        println(output);
        
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
        println("\(new[0])")
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var valuesDict = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil);
        
        
        println(valuesDict?.objectForKey("comment"));
        println("valuesDict");
        println(valuesDict);
        //CommentLocation.dictionariesToObjects(valuesDict);
        //callerMap.gotReports(valuesDict);
        
    }

}