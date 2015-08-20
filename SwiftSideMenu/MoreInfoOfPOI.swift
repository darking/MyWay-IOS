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
    var placeName:String = "";
    var DataManagement:POIDataManager = POIDataManager();
    var place:NSDictionary = NSDictionary();
    @IBOutlet var TypeNameOut: UILabel!
    
    @IBOutlet var DetailsOut: UITextView!
    
    @IBOutlet var imageOut: UIImageView!
    
    
    @IBAction func sendButton(sender: AnyObject) {
        
        // code to redirect to the map (must send the object of the place im on, of the type PointOfInterest)
        var mapVC:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
        mapVC.title = placeName;
        mapVC.message = place.objectForKey("description") as! String;
        let lat:String = place.objectForKey("lat") as! String;
        let lng:String = place.objectForKey("long") as! String;
        
        let location = CLLocation(latitude: (lat as NSString).doubleValue, longitude: (lat as NSString).doubleValue)
        mapVC.location = location;
        self.navigationController?.pushViewController(mapVC, animated: true);
        
    }
    
    var imageConv:ImageConversion = ImageConversion();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        place = DataManagement.getDetailsOFPlace(placeName) as NSDictionary;
        
        TypeNameOut.text = placeName;
        DetailsOut.text = place.objectForKey("description") as! NSString as String;
        
        let imageNames:NSArray = place.objectForKey("images") as! NSArray;
        
        // yossef - poi - use image name instead of image path
        let firstImageName = imageNames.firstObject as! String;
        var fileUtils = FileUtils(fileName: firstImageName);
        imageOut.image = imageConv.readImageAtPath(fileUtils.docsPath()) ;
        
    }
}