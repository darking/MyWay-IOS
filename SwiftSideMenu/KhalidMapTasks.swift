//
//  MapTasks.swift
//  GMapsDemo
//
//  Created by iOS on 8/30/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import Foundation
import GoogleMaps


class KhalidMapTasks:NSObject {
    
    
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    //disconry of location from result from respose
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    //name of the address var
    var fetchedFormattedAddress: String!
    //var for longituded from respon
    var fetchedAddressLongitude: Double!
    //var for latitude from respons
    var fetchedAddressLatitude: Double!
    
     //this is the varibe wich will have all info retreved from google server
     var  Results : Array<Dictionary<NSObject, AnyObject>> = Array();

    
    
    //intializer function to intilaaize an object of this class in other classes
    override init() {
        super.init()
        
    }
    
    //The first parameter is the address we want to spot to the map. The second parameter is a completion handler that will be called once we have received and processed the response data.
    func geocodeAddress(address: String!, withCompletionHandler completionHandler: ((status: String, success: Bool) -> Void)) {
         //first make sure that a valid address has been given:
        if let lookupAddress = address {
            var geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            geocodeURLString = geocodeURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            let geocodeURL = NSURL(string: geocodeURLString)
           
            
            //after we have the data taken back from the API, we convert it from the JSON format to a dictionary object
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let geocodingResultsData = NSData(contentsOfURL: geocodeURL!)
                
                var error: NSError?
                let dictionary: Dictionary<NSObject, AnyObject> = NSJSONSerialization.JSONObjectWithData(geocodingResultsData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! Dictionary<NSObject, AnyObject>
                
                //error handler
                if (error != nil) {
                    println(error)
                    completionHandler(status: "", success: false)
                }
                    
                else {
                    // Get the response status.
                    let status = dictionary["status"] as! String
                    //if the status of the resonse is ok take the first value and save it
                    if status == "OK" {
                        
                       self.Results = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>;
                        
                        let allResults = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>
                    
                        self.lookupAddressResults = allResults[0]
                            
                        // Keep the most important values.
                        self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address"] as! String
                        
                        let geometry = allResults[0]["geometry"]as! Dictionary<NSObject, AnyObject>
                        
                        self.fetchedAddressLongitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lng"] as! NSNumber).doubleValue
                        
                        self.fetchedAddressLatitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lat"]as! NSNumber).doubleValue
                        
                        var position = CLLocationCoordinate2DMake(((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lat"]as! NSNumber).doubleValue, ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lng"] as! NSNumber).doubleValue)

                        
                        completionHandler(status: status, success: true)
                    }
                    else {
                        completionHandler(status: status, success: false)
                    }
                }
            })
        }
        else {
            completionHandler(status: "No valid address.", success: false)
        }
        
    }
    
    
    
}