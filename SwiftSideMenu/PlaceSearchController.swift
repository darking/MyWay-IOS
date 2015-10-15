//
//  ViewController.swift
//  GooglePlacesSearchController
//
//  Created by Dmitry Shmidt on 6/28/15.
//  Copyright (c) 2015 Dmitry Shmidt. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PlaceSearchViewController: UIViewController {
    let GoogleMapsAPIServerKey = "AIzaSyBwebzVhw8q4SRVaWN6eBqMUy9T3M1StDM"

    @IBAction func searchAddress(sender: UIBarButtonItem) {
        
//        let controller = GooglePlacesSearchController(
//            apiKey: GoogleMapsAPIServerKey,
//            placeType: PlaceType.Address
//        )
        
       // Or ff you want to use autocompletion for specific coordinate and radius (in meters)
                let coord = CLLocationCoordinate2D(latitude: 29.3761011, longitude: 47.9643757)
             let   controller = GooglePlacesSearchController(
                    apiKey: GoogleMapsAPIServerKey,
                    placeType: PlaceType.All,
                    coordinate: coord,
                    radius: 500
                )
        
        controller.didSelectGooglePlace { (place) -> Void in
            println(place.description)
            
            //Dismiss Search
            controller.active = false
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
}