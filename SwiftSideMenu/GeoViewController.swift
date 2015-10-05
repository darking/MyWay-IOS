//
//  GeoViewController.swift
//  SwiftSideMenu
//
//  Created by Abdullah Al Mashmoum on 10/4/15.
//
//

import UIKit
import ArcGIS
import GoogleMaps

////The map service
//let kMapServiceURL = "http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"

////The geocode service
let kGeoLocatorURL = "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer"


let kMapServiceURL = "http://gis.paci.gov.kw/paci/rest/services/iOSBasemap/MapServer"

//let kGeoLocatorURL = "http://kuwaitportal.paci.gov.kw/arcgisportal/rest/services/Hosted/PACIGeocoder"

class GeoViewController: UIViewController, AGSCalloutDelegate, AGSLocatorDelegate, UISearchBarDelegate, ENSideMenuDelegate {
    
    @IBOutlet weak var mapView:AGSMapView!
    @IBOutlet weak var searchBar:UISearchBar!
    var graphicsLayer:AGSGraphicsLayer!
    var locator:AGSLocator!
    var calloutTemplate:AGSCalloutTemplate!
    var selectedGraphic:AGSGraphic!
    
    @IBAction func toggleMenu(sender: AnyObject) {
        toggleSideMenuView();
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the delegate on the mapView so we get notifications for user interaction with the callout
        self.mapView.callout.delegate = self
        
        //create an instance of a tiled map service layer
        //Add it to the map view
        let serviceUrl = NSURL(string: kMapServiceURL)
        let tiledMapServiceLayer = AGSTiledMapServiceLayer(URL: serviceUrl)
        self.mapView.addMapLayer(tiledMapServiceLayer, withName:"World Street Map")
        
        //create the graphics layer that the geocoding result
        //will be stored in and add it to the map
        self.graphicsLayer = AGSGraphicsLayer()
        self.mapView.addMapLayer(self.graphicsLayer, withName:"Graphics Layer")
        
        //set the text and detail text based on 'Name' and 'Descr' fields in the results
        //create the callout template, used when the user displays the callout
        self.calloutTemplate = AGSCalloutTemplate()
        self.calloutTemplate.titleTemplate = "${Match_addr}"
        self.calloutTemplate.detailTemplate = "${Place_addr}"
        self.graphicsLayer.calloutDelegate = self.calloutTemplate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGeocoding() {
        //clear out previous results
        self.graphicsLayer.removeAllGraphics()
        
        //create the AGSLocator with the geo locator URL
        //and set the delegate to self, so we get AGSLocatorDelegate notifications
        self.locator = AGSLocator(URL: NSURL(string: kGeoLocatorURL))
        self.locator.delegate = self
        
        //Note that the "*" for out fields is supported for geocode services of
        //ArcGIS Server 10 and above
        let parameters = AGSLocatorFindParameters()
        parameters.text = self.searchBar.text
        parameters.outSpatialReference = self.mapView.spatialReference
        parameters.outFields = ["*"]
        self.locator.findWithParameters(parameters)
    }
    
    //MARK: - AGSCalloutDelegate
    
    func didClickAccessoryButtonForCallout(callout: AGSCallout!) {
        
        self.selectedGraphic = callout.representedObject as! AGSGraphic
        
        //The user clicked the callout button, so display the complete set of results
        self.performSegueWithIdentifier("ResultsSegue", sender: self)
    }
    
    //MARK - AGSLocatorDelegate
    
    func locator(locator: AGSLocator!, operation op: NSOperation!, didFind results: [AnyObject]!) {
        //check and see if we didn't get any results
        if results == nil || results.count == 0 {
            //show alert if we didn't get results
            UIAlertView(title: "No Results", message: "No Results Found By Locator", delegate: nil, cancelButtonTitle: "OK").show()
        }
        else
        {
            //loop through all candidates/results and add to graphics layer
            for candidate in results as! [AGSLocatorFindResult] {
                
                //get the location from the candidate
                let pt = candidate.graphic.geometry as! AGSPoint
                
                //create a marker symbol to use in our graphic
                let marker = AGSPictureMarkerSymbol(imageNamed: "BluePushpin")
                marker.offset = CGPointMake(9,16)
                marker.leaderPoint = CGPointMake(-9, 11)
                
                candidate.graphic.symbol = marker
                
                //add the graphic to the graphics layer
                self.graphicsLayer.addGraphic(candidate.graphic)
                
                if results.count == 1 {
                    //we have one result, center at that point
                    self.mapView.centerAtPoint(pt, animated:false)
                    
                    // set the width of the callout
                    self.mapView.callout.width = 250
                    
                    //show the callout
                    self.mapView.callout.showCalloutAtPoint(candidate.graphic.geometry as! AGSPoint, forFeature: candidate.graphic, layer:candidate.graphic.layer, animated:true)
                }
                
            }
            
            //if we have more than one result, zoom to the extent of all results
            if results.count > 1 {
                self.mapView.zoomToEnvelope(self.graphicsLayer.fullEnvelope, animated:true)
            }
        }
        
    }
    
    func locator(locator: AGSLocator!, operation op: NSOperation!, didFailToFindWithError error: NSError!) {
        //The location operation failed, display the error
        UIAlertView(title: "Locator failed", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //hide the callout
        self.mapView.callout.hidden = true
        
        //First, hide the keyboard, then starGeocoding
        searchBar.resignFirstResponder()
        self.startGeocoding()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //hide the keyboard
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ResultsSegue" {
            let controller = segue.destinationViewController as! GeoResultsViewController
            controller.results = self.selectedGraphic.allAttributes()
        }
    }
}
