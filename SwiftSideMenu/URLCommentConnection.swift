//
//  URLCommentConnection.swift
//  SwiftSideMenu
//
//  Created by hebah albuloushi on 10/4/15.
//
//

import Foundation
import UIKit

class URLCommentConnection: UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var dataConnection:NSMutableData=NSMutableData();
    
    func addToCommentList(comment:String,id_report:Int){
    
        var cl:CommentLocation = CommentLocation()
        
        var URLStatement:NSString = cl.urlParams(CommentLocation().valuesDicForComment(comment,id_report: id_report));
        
        URLStatement.dataUsingEncoding(NSUTF8StringEncoding);
        
         var urlStr : NSString = URLStatement.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let Group4Url:NSURL?=NSURL(string:"http://172.16.8.105:8080/MyWayWeb/postTrafficReport?\(urlStr)");
        
        
//        let Group4Url:NSURL?=NSURL(string:"http://172.16.8.105:8080/MyWayWeb/postTrafficReport?");
//        let request = NSMutableURLRequest(URL:Group4Url!);
//        request.HTTPMethod="POST";
//        request.HTTPBody=URLStatement.dataUsingEncoding(NSUTF8StringEncoding);
//        
        let urlReq:NSURLRequest=NSURLRequest(URL:Group4Url!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        println("print Group4 URL in class URLCommentConnection");
        
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
        
    }
}