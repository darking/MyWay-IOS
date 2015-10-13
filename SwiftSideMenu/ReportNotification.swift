//
//  ReportNotification.swift
//  SwiftSideMenu
//
//  Created by trn23 on 9/30/15.
//
//

import Foundation

import UIKit


// function that checks if the speed + 120

class ReportNotification {
    
    func notify() {
        var speedC:SpeedClass = SpeedClass();
        var speed = speedC.locationManager.location.speed.kph;
        if (speed > 120){
            let  newReportadd = [
                "speed"  : "\(speed)"
            ]
            //create the url with NSURL
            let url = NSURL(string: "link of our server which we don t have")
            //create the session object
            var session = NSURLSession.sharedSession()
            //now create the NSMutableRequest object using the url object
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST" //set http method as POST
            var err: NSError?
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(Data(), options: nil, error: &err) // pass dictionary to nsdata object and set it as request body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            //create dataTask using the session object to send data to the server
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                println("Response: \(response)")
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)")
                var err: NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    println(err!.localizedDescription)
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: '\(jsonStr)'")
                } else {
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        // the parsedJSON is here
                        var success = parseJSON["success"] as? Int
                        println("Succes: \(success)")
                    } else {
                        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Error could not parse JSON: \(jsonStr)")
                    }
                }
            })
            task.resume()
        }
    }
}