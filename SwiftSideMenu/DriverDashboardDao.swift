//
//  DriverDashboardDao.swift
//  SwiftSideMenu
//
//  Created by Adnan Alqazwini on 10/14/15.
//
//

import Foundation
class DriverDashboard:NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var dataConnection:NSMutableData=NSMutableData();
    var dashboard:NSArray = [];
    override init(){
        super.init()
        println("This is the driver's name: \(DriverBean.driverHolder.driverUsername)")
        println(ConnectionString.holder.URL + "/getDriverDashBoard?driverUserName=" + DriverBean.driverHolder.driverUsername!)
        let dashboardUrl:NSURL?=NSURL(string:ConnectionString.holder.URL + "/getDriverDashBoard?driverUserName=" + DriverBean.driverHolder.driverUsername!);
        let urlReq:NSURLRequest=NSURLRequest(URL:dashboardUrl!);
        let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
        }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
        dashboard = valuesDict.objectForKey("result_data") as! NSArray
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
    }
}