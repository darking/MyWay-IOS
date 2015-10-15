//
//  MoreInfoOfPOI.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MoreInfoOfPOI:UIViewController{
//    var placeName:String = "";
    
//    var DataManagement:POIDataManager = POIDataManager();
    var event:NSDictionary = NSDictionary();
    @IBOutlet var TypeNameOut: UILabel!
    
    @IBOutlet var DetailsOut: UITextView!
    
    @IBOutlet var imageOut: UIImageView!
    
    @IBOutlet var startDateOut: UILabel!
    
    @IBOutlet var endDateOut: UILabel!
    
    @IBAction func sendButton(sender: AnyObject) {
        
        // code to redirect to the map (must send the object of the place im on, of the type PointOfInterest)
        var mapVC:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;

        mapVC.title = event.objectForKey("name") as! NSString as String;
        mapVC.message = event.objectForKey("description") as? String;
        let lat:String = event.objectForKey("latitude") as! String;
        let lng:String = event.objectForKey("longitude") as! String;
        
        let location = CLLocation(latitude: (lat as NSString).doubleValue, longitude: (lng as NSString).doubleValue)
        mapVC.location = location;
        mapVC.lat = lat as String;
        mapVC.long = lng as String;
        //to enable the share button
        mapVC.show = true;
        self.navigationController?.pushViewController(mapVC, animated: true);
        
    }
    
    var imageConv:ImageConversion = ImageConversion();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        place = DataManagement.getDetailsOFPlace(placeName) as NSDictionary;
        
        TypeNameOut.text = event.objectForKey("name") as? String;
        DetailsOut.text = event.objectForKey("description") as! String;
        startDateOut.text = event.objectForKey("startDate") as? String;
        
        endDateOut.text = event.objectForKey("endDate") as? String;
        let imageNames = event.objectForKey("image") as! String;
        
//        to check if there is an image by the user.. it would set it, else it would leave it as the default image that is already set on the storyboard
        //MARK: IMAGE SETTING
        if imageNames != ""{
            if let url = NSURL(string: imageNames) {
                if let data = NSData(contentsOfURL: url){
                    imageOut.contentMode = UIViewContentMode.ScaleAspectFit
                    imageOut.image = UIImage(data: data)
                }
            }

        }
//         yossef - poi - use image name instead of image path
//        let firstImageName = imageNames.firstObject as! String;
        
//
        
    }
}