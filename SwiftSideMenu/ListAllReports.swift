//
//  ListAllReports.swift
//  SwiftSideMenu
//
//  Created by hebah albuloushi on 10/5/15.
//
//

import Foundation


class ListAllReports:NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    var callerMap: mainViewController = mainViewController();
    var dataConnection:NSMutableData=NSMutableData();
    func getReportList()
    {
        
        let Group4Url:NSURL?=NSURL(string:"http://mobile.comxa.com/reports/all_reports.json");
        
        let urlReq:NSURLRequest=NSURLRequest(URL:Group4Url!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        println("print Group4 URL in class ListAllReports");
        
        println(Group4Url);
        
        
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