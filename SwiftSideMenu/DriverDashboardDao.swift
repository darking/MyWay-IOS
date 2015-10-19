//
//  DriverDashboardDao.swift
//  SwiftSideMenu
//
//  Created by Adnan Alqazwini on 10/14/15.
//
//

import Foundation
class DriverDashboardDao:NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var dataConnection:NSData=NSData();
    var dashboard:NSArray = [];
    override init(){
        super.init()
        println("This is the driver's name: \(DriverBean.driverHolder.driverUsername!)")
        
        let dashboardUrl:NSURL?=NSURL(string:ConnectionString.holder.URL + "/getDriverDashBoard?driverUserName=" + DriverBean.driverHolder.driverUsername!);
        println(dashboardUrl);
        let urlReq:NSURLRequest=NSURLRequest(URL:dashboardUrl!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        let valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
        dashboard = valuesDict.objectForKey("result_data") as! NSArray
        
        println("Hello haha \(dashboard)")
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
      
        dataConnection = data

        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
    }
}