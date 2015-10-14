//
//  DriverSetDestinationDao.swift
//  SwiftSideMenu
//
//  Created by Adnan Alqazwini on 10/14/15.
//
//

import Foundation
class DriverSetDestinationDao:NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    var dataConnection:NSMutableData=NSMutableData();
    var destination:NSArray = [];
//    override init(){
//        super.init()
        //let setDestinationUrl:NSURL?=NSURL(string:"http://172.16.8.105:8080/MyWayWeb/setDriverDestination?userName=omar&lat=30&lon=44");
        //lat
        //lon
//        let settings = NSUserDefaults.standardUserDefaults();
//        var requestBody = parRequestBody//"userName=omar&lat=30&lon=44" //+ self.userInput!.text;
//        var requestUrl = parRequestUrl//"http://192.168.1.9:8080/MyWayWeb/setDriverDestination"
//
//        self.request(requestBody, url: requestUrl) {
//            
//            responseData in
//            
//        }

        //let urlReq:NSURLRequest=NSURLRequest(URL:dashboardUrl!);
        //let connection:NSURLConnection?=NSURLConnection(request: urlReq, delegate: self, startImmediately: true);
//    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var valuesDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataConnection, options: nil, error: nil) as! NSDictionary;
        destination = valuesDict.objectForKey("result_data") as! NSArray
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        dataConnection.appendData(data)
        let output = NSString(data: data, encoding: NSUTF8StringEncoding);
        var new:[String] = output?.componentsSeparatedByString(",") as! [String];
    }
    func request(requestBody:String, url:String, completionHandler: (responseData:NSData) -> ()) {
        var request = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) in
            println(data)
        }
    }

}