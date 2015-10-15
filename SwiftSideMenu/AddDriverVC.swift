//
//  ManageDriverVC.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class AddDriverVC:UIViewController{
    
    var otherFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    
    let settings = NSUserDefaults.standardUserDefaults();
    
    @IBOutlet weak var DriverNameLabel: UILabel!
    @IBOutlet weak var PairCodeTF: UITextField!
    @IBOutlet weak var UserNameTF: UITextField!
    var index = 0;
    @IBAction func sumbitBTN(sender: AnyObject) {
        
       
//        let dataFile:FileUtils = FileUtils(fileName: "data.plist");
//        let dataFilePath = dataFile.docsPath();
//        
//        
//        var newList = NSMutableArray(contentsOfFile: dataFilePath);
//        newList?.addObject(UserNameTF.text)

//        newList?.writeToFile(dataFilePath, atomically: false)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        //locationManager.requestAlwaysAuthorization();
        locationManager.requestWhenInUseAuthorization()
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        var c:AllpListController=AllpListController();
        c.AddToArray();
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        currentLocation = locations.last as! CLLocation;
        println("current location is \(currentLocation.description)");
        
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "currentLocation");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
    }
    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
    override func viewDidAppear(animated: Bool) {
        locationManager.startUpdatingLocation();
    }
    @IBAction func BackBtn(sender: AnyObject) {
    }
    @IBOutlet weak var DeleteBtnAction: UIButton!
    @IBAction func DeleteBtn(sender: AnyObject) {
        //Here Is Gonna be the code to delete it from the DataBase
    }
}