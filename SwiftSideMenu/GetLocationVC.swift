//
//      ationVC.swift
//  SwiftSideMenu
//
//  Created by Abdullah Al Mashmoum on 8/20/15.
//  Copyright (c) 2015 Evgeny Nazarov. All rights reserved.
//

import UIKit
import GoogleMaps

class GetLocationVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, ENSideMenuDelegate {
    
    
    var latKey:String = ""
    var lngKey:String = ""
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    var mapTasks = MapTasks()
    
    var locationMarker: GMSMarker!
    
    var originMarker: GMSMarker!
    
    var destinationMarker: GMSMarker!
    
    var routePolyline: GMSPolyline!
    
    var markersArray: Array<GMSMarker> = []
    
    var waypointsArray: Array<String> = []
    
    var travelMode = TravelModes.driving
    
    @IBOutlet weak var viewMap: GMSMapView!
    

    override func viewDidLoad() {
        
        
        var camera = GMSCameraPosition.cameraWithLatitude(29.363, longitude: 47.984, zoom: 12)
        
        viewMap.camera = camera
        
        viewMap.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        viewMap.settings.compassButton = true;
        viewMap.settings.myLocationButton = true;
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let currentLocation = locations.last as! CLLocation
        println(currentLocation)
        println(currentLocation.coordinate.latitude)
        //lblLongLat.text = String(stringInterpolationSegment: currentLocation.coordinate.latitude)
        
//        var circleCenter = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude)
//        var circ = GMSCircle(position: circleCenter, radius: 1000)
//        
//        circ.fillColor = UIColor(red: 0.0, green: 0.35, blue: 0, alpha: 0.05)
//        circ.strokeColor = UIColor.greenColor()
//        circ.strokeWidth = 5
//        circ.map = viewMap
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            viewMap.myLocationEnabled = true
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 12.0)
            viewMap.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }

    
    func retrieveMarkerInfo(var lat:Double, var lng:Double) {
        println("Marker lat: \(lat), Market lng: \(lng)")
        var coor:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
        
        self.setupLocationMarker(coor)
    
    
        let settings = NSUserDefaults.standardUserDefaults()
        settings.setValue(lat, forKey: "coor")
        
//        settings.setValue(lat, forKey: "coorLat");
//        settings.setValue(lng, forKey: "coorLng");
        
    }
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
        if locationMarker != nil {
            locationMarker.map = nil
        }
        
        locationMarker = GMSMarker(position: coordinate)
        locationMarker.map = viewMap
        
        locationMarker.title = mapTasks.fetchedFormattedAddress
        locationMarker.appearAnimation = kGMSMarkerAnimationPop
        locationMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        locationMarker.opacity = 0.75
        
        locationMarker.flat = true
        locationMarker.snippet = "The best place on earth."
    }
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        //println("function mapView runs")
        
        var markerCoorLat:Double
        var markerCoorLng:Double
        
        markerCoorLat = coordinate.latitude
        markerCoorLng = coordinate.longitude
        
//        latKey = String(format:"%f", markerCoorLat)
//        lngKey = String(format:"%f", markerCoorLng)
        
        retrieveMarkerInfo(markerCoorLat, lng: markerCoorLng)
        

        NSUserDefaults.standardUserDefaults().setValue(String(format:"%f", markerCoorLat), forKey: latKey)
        NSUserDefaults.standardUserDefaults().setValue(String(format:"%f", markerCoorLng), forKey: lngKey)
        
        //MARK: Static Coordinates
        
        //setting the coordinates in the static vars in addnewpoi class
        AddNewPOI.holder.pointLat = String(format:"%f", markerCoorLat);
        AddNewPOI.holder.pointLong = String(format:"%f", markerCoorLng);
        
        //to set the coordinate to the favorites point
        AddNewFavoriteVC.holder.favLat = String(format:"%f", markerCoorLat);
        AddNewFavoriteVC.holder.favLong = String(format:"%f", markerCoorLng);
        
        //Set location for driver class
        DriverDetailsVC.holder.driverLat = markerCoorLat;
        DriverDetailsVC.holder.driverLong = markerCoorLng;
        
        println("static point var set, lat: " + AddNewPOI.holder.pointLat + " long: " + AddNewPOI.holder.pointLong);
        
        println("static fav var set, lat: " + AddNewFavoriteVC.holder.favLat + " long: " + AddNewFavoriteVC.holder.favLong);
        
        println("static driver var set, lat: " + "\(DriverDetailsVC.holder.driverLat)" + " long: " + "\(DriverDetailsVC.holder.driverLong)");
        
        //MARK: sending the coordinates to the server
        if (DriverDetailsVC.SettingDriverDestination.settingDriverDestination == true) {
            println("SENDING: Driver's coordinates!!!!");
            
            var submitDest:DriverSetDestinationDao = DriverSetDestinationDao();
            var lon = ("\(coordinate.longitude)");
            var lat = ("\(coordinate.latitude)");
            var driverName = DriverBean.driverHolder.driverUsername
            var setLatLon = "&lat=" + (lat as String) + "&lon=" + (lon as String)
            
            var requestBody = "userName=" + driverName! + setLatLon //+ self.userInput!.text;
            var requestUrl = ConnectionString.holder.URL + "/setDriverDestination"
            submitDest.request(requestBody, url: requestUrl, completionHandler: {
                
                responseData in
                
            })
            
            AddNewFavoriteVC.holder.favLat = "";
            AddNewFavoriteVC.holder.favLong = "";
            //emptying the static holders of the POI
            AddNewPOI.holder.typeName = "";
            AddNewPOI.holder.pointLat = "";
            AddNewPOI.holder.pointLong = "";
            
            //emptying driver's static holder
            DriverDetailsVC.holder.driverLat = 0.0;
            DriverDetailsVC.holder.driverLong = 0.0;
            
        }
        
        self.dismissViewControllerAnimated(true, completion: {})

        if let polyline = routePolyline {
            let positionString = String(format: "%f", coordinate.latitude) + "," + String(format: "%f", coordinate.longitude)
            waypointsArray.append(positionString)
            
           // recreateRoute()
             clearRoute()
            
            
            
        }
    }
    
//    func; recreateRoute() {
//        if let polyline = routePolyline {
//            clearRoute()
//            
//            mapTasks.getDirections(mapTasks.originAddress, destination: mapTasks.destinationAddress, waypoints: waypointsArray, travelMode: travelMode, completionHandler: { (status, success) -> Void in
//                
//                if success {
//                    println("did enter recreate route sucess status")
//                    self.configureMapAndMarkersForRoute()
//                    self.drawRoute()
//                    self.displayRouteInfo()
//                }
//                else {
//                    println("did NOT enter recreate route sucess status")
//                    println(status)
//                }
//            })
//        }
//    }

    func clearRoute() {
        originMarker.map = nil
        destinationMarker.map = nil
        routePolyline.map = nil
        
        originMarker = nil
        destinationMarker = nil
        routePolyline = nil
        
        if markersArray.count > 0 {
            for marker in markersArray {
                marker.map = nil
            }
            
            markersArray.removeAll(keepCapacity: false)
        }
    }
    
  func getCurrentLocation() -> (Double,Double) {
  
         let myLoc: String = "\(self.locationManager.location.coordinate.latitude),\(self.locationManager.location.coordinate.longitude)"
    
    println("my current location is: \(myLoc)")
    
        return (self.locationManager.location.coordinate.latitude,self.locationManager.location.coordinate.longitude)
    }
    
}
