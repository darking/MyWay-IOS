//
//  addTrafficJamReports.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//


import Foundation
import UIKit
class addTrafficJamReports{
    
    let fileName  = "ModerateTraffic.plist";
    let fileName2 = "HeavyTraffic.plist";
    let fileName3 = "StandstillTraffic.plist";
    var TRAFFIC:trafficVC = trafficVC();
    
    
    
    func addToTrafficList(comment:String,id_report: Int){
        
       
        var cl:CommentLocation = CommentLocation()
        var URLStatement:NSString = cl.urlParams(CommentLocation().valuesDicForComment(comment,id_report: id_report));
        let Group4Url:NSURL?=NSURL(string:"http://mobile.comxa.com/reports/all_reports.json?\(URLStatement)");
        
        let urlReq:NSURLRequest=NSURLRequest(URL:Group4Url!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        println(Group4Url)
        
        //finish taleef
        println(comment)
        println(id_report)
        
        println("I'm trying to know what is saved in current List var");
        println("Here its finish ");
        
    
    }
    }