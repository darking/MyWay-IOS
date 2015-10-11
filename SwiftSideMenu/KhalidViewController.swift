//
//  ViewController.swift
//  GMapsDemo
//
//  Created by Gabriel Theodoropoulos on 29/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import GoogleMaps

class KhalidViewController: UIViewController,CLLocationManagerDelegate {


    
    var locationMarker: GMSMarker!
    
    @IBOutlet weak var viewMap: GMSMapView!
    
        var showAlertWithMessage = ""
    
    @IBOutlet weak var bbFindAddress: UIBarButtonItem!
    
    @IBOutlet weak var lblInfo: UILabel!
    
    
   
    

    var mapTasks = KhalidMapTasks()
    
     
    //locationManager property will be used to ask for the user’s permission to keep track of his location
    var locationManager = CLLocationManager()
    
    //so we know whether the user’s current position was spotted on the map or not
    var didFindMyLocation = false
    
    //checking for the status of the user if his current location is on or not
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            viewMap.myLocationEnabled = true
        }
    }

    //current location appear on the map once the user’s position has been spotted
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
            viewMap.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //creating a map view and give it a defult location
       // let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(29.378586, longitude: 47.990341, zoom: 8.0)
        //viewMap.camera = camera
        
        
        
        locationManager.delegate = self
        //calling the method for asking the user for enabling his current location
        locationManager.requestWhenInUseAuthorization()
        //making the object viewMap know the change of the user location
      //  viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New,context:nil)

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
    
    
    
    // MARK: IBAction method implementation
    
    @IBAction func changeMapType(sender: AnyObject) {
        
        //code to change map type
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeNormal
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeTerrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeHybrid
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
        locationMarker = GMSMarker(position: coordinate)
        locationMarker.map = viewMap
//        locationMarker.title = mapTasks.fetchedFormattedAddress
//        locationMarker.appearAnimation = kGMSMarkerAnimationPop
//        locationMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
//        locationMarker.opacity = 0.75
//        locationMarker.flat = true
//        locationMarker.snippet = "The best place on earth."
//        if locationMarker != nil {
//            locationMarker.map = nil
//        }
        
        
    }
    
    
    
    //mashmom start
    @IBAction func findAddress(sender: AnyObject) {

        

        self.khalod()
        
        
    
    }
  
    
    
    func khalod() {
        
        // the alert object which will show the text in alert will show when the user click in the left tool bar button
        let addressAlert = UIAlertController(title: "Address Finder", message: "Type the address you want to find:", preferredStyle: UIAlertControllerStyle.Alert)
        
        addressAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Address?"
        }
        
        //alert box when clicking on find
        let findAction = UIAlertAction(title: "Find Address", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            
            let address = (addressAlert.textFields![0] as! UITextField).text as String
            
            self.mapTasks.geocodeAddress(address, withCompletionHandler: { (status, success) -> Void in
                if !success {
                    println(status)
                    
                    
                    
                    
                    
                    
                    if status == "ZERO_RESULTS" {
                        let alertController = UIAlertController(title: "iOScreator", message:
                            "The location could not be found.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                    
                }
                else {
                    
                    //core code
                    let actionSheet = UIAlertController(title: "Founded Location", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    
                    
                    
                    
                    for var x = 0; x < self.mapTasks.Results.count; ++x{
                        
                        
                        
                        //var of dictionaty of address_componets from response
                        
                        //let locationName =  self.mapTasks.Results[x]["address_components"] as! Dictionary<NSObject, AnyObject>
                        
                        // var of dictionary of geometry from response
                        let locationCordinates =  self.mapTasks.Results[x]["geometry"] as! Dictionary<NSObject, AnyObject>;
                        //var from lat co from response
                        let latCo = ((locationCordinates["location"] as! Dictionary<NSObject, AnyObject>)["lat"]as! NSNumber).doubleValue
                        //var from lng co from response
                        let longCo = ((locationCordinates["location"] as! Dictionary<NSObject, AnyObject>)["lng"]as! NSNumber).doubleValue
                        
                        
                        
                        
                        
                        
                        var longName = self.mapTasks.Results[x]["formatted_address"] as! String
                        
                        //var shortName = self.mapTasks.Results[x]["types"] as! String
                        
                        let normalMapTypeAction = UIAlertAction(title: "\(longName)", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
                            
                            let coordinate = CLLocationCoordinate2D(latitude: latCo, longitude: longCo)
                            
                            self.viewMap.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 6.0)
                            
                            self.setupLocationMarker(coordinate);
                            
                            
                            
                        }
                        actionSheet.addAction(normalMapTypeAction)
                        
                    }
                    //core code end
                    //
                    //                    let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
                    //                        self.viewMap.mapType = kGMSTypeTerrain
                    //                    }
                    //
                    //                    let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
                    //                        self.viewMap.mapType = kGMSTypeHybrid
                    //                    }
                    
                    let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
                        
                    }
                    
                    
                    //                    actionSheet.addAction(terrainMapTypeAction)
                    //                    actionSheet.addAction(hybridMapTypeAction)
                    actionSheet.addAction(cancelAction)
                    
                    self.presentViewController(actionSheet, animated: true, completion: nil)
                    
                    
                    
                    
                }
                
            })
            
        }
        //alert box when clicking on close
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        
        //adding the alter box to aler handler obj
        addressAlert.addAction(findAction)
        addressAlert.addAction(closeAction)
        //adding the alert handler to viewcontroller
        
        
        
        presentViewController(addressAlert, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        func showAlertWithMessage(message: String) {
            let alertController = UIAlertController(title: "GMapsDemo", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
                
            }
            
            alertController.addAction(closeAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        

        
    }
    
    
    
    
    
    @IBAction func createRoute(sender: AnyObject) {
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func changeTravelMode(sender: AnyObject) {
    
    }
    
    
    
}

