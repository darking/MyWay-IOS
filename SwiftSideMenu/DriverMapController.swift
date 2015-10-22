//
//  DriverMapController.swift
//  SwiftSideMenu
//
//  Created by hebah albuloushi on 10/21/15.
//
//

import UIKit
import GoogleMaps

class DriverMapController: UIViewController {

    var mapTasks = MapTasks()
    
    var locationMarker: GMSMarker!
    
    var originMarker: GMSMarker!
    
    var destinationMarker: GMSMarker!
    
    var routePolyline: GMSPolyline!
    
 @IBOutlet weak var viewMap: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DriverLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func DriverLocation(){
        
        let marker = GMSMarker(position: CLLocationCoordinate2DMake(29.3627462, 47.9811932))
        marker.map = viewMap
        marker.icon = GMSMarker.markerImageWithColor(UIColor.yellowColor())
        
    viewMap.camera = GMSCameraPosition.cameraWithLatitude(29.3627462, longitude: 47.9811932, zoom: 12)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
