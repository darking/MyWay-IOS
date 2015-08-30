//
//  hazardVC.swift
//  Post Report
//
//  Created by trn15 on 8/15/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation



class hazardVC: UIViewController ,UITextFieldDelegate {
    
    private var isKeyboardVisible = false
    
    @IBOutlet weak var constructionLable: UILabel!
    
    
    @IBOutlet weak var onRoadLable: UILabel!
    
    var onroadFlag = false;
    var constructionFlag = false;
    var locationManager = CLLocationManager();
    
    var currentLocation:CLLocation = CLLocation();
    let settings = NSUserDefaults.standardUserDefaults();

  //***********************
    
     @IBOutlet weak var scrollView: UIScrollView!
    
//    var scrollView: UIScrollView!
    
//    func textViewDidBeginEditing(textView: UITextView) {
//        self.scrollView.setContentOffset(CGPointMake(0, textView.frame.origin.y-75), animated: true)
//    }
//    
//    func textViewDidEndEditing(textView: UITextView) {
//        self.scrollView.setContentOffset(CGPointMake(0, -textView.frame.origin.y+75), animated: true)
//    }
    
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        commentHazard.resignFirstResponder()
//        return true
//    }
//    
//    func handleKeyboardWillShow(notification: NSNotification){
//        
//        let userInfo = notification.userInfo
//        
//        if let info = userInfo{
//            /* Get the duration of the animation of the keyboard for when it
//            gets displayed on the screen. We will animate our contents using
//            the same animation duration */
//            let animationDurationObject =
//            info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
//            
//            let keyboardEndRectObject =
//            info[UIKeyboardFrameEndUserInfoKey] as! NSValue
//            
//            var animationDuration = 0.0
//            var keyboardEndRect = CGRectZero
//            
//            animationDurationObject.getValue(&animationDuration)
//            keyboardEndRectObject.getValue(&keyboardEndRect)
//            
//            let window = UIApplication.sharedApplication().keyWindow
//            
//            /* Convert the frame from window's coordinate system to
//            our view's coordinate system */
//            keyboardEndRect = view.convertRect(keyboardEndRect, fromView: window)
//            
//            /* Find out how much of our view is being covered by the keyboard */
//            let intersectionOfKeyboardRectAndWindowRect =
//            CGRectIntersection(view.frame, keyboardEndRect);
//            
//            /* Scroll the scroll view up to show the full contents of our view */
//            UIView.animateWithDuration(animationDuration, animations: {[weak self] in
//                
//                self!.scrollView.contentInset = UIEdgeInsets(top: 0,
//                    left: 0,
//                    bottom: intersectionOfKeyboardRectAndWindowRect.size.height,
//                    right: 0)
//                
//                self!.scrollView.scrollRectToVisible(self!.commentHazard.frame,
//                    animated: false)
//                
//                })
//        }
//        
//    }
//    
//    func handleKeyboardWillHide(sender: NSNotification){
//        
//        let userInfo = sender.userInfo
//        
//        if let info = userInfo{
//            let animationDurationObject =
//            info[UIKeyboardAnimationDurationUserInfoKey]
//                as! NSValue
//            
//            var animationDuration = 0.0;
//            
//            animationDurationObject.getValue(&animationDuration)
//            
//            UIView.animateWithDuration(animationDuration, animations: {
//                [weak self] in
//                self!.scrollView.contentInset = UIEdgeInsetsZero
//                })
//        }
//        
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        
//        super.viewDidAppear(animated)
//        
//        let center = NSNotificationCenter.defaultCenter()
//        
//        center.addObserver(self,
//            selector: "handleKeyboardWillShow:",
//            name: UIKeyboardWillShowNotification,
//            object: nil)
//        
//        center.addObserver(self,
//            selector: "handleKeyboardWillHide:",
//            name: UIKeyboardWillHideNotification,
//            object: nil)
//        
//        locationManager.startUpdatingLocation();
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//        
//    }
    
    /***************************/
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
   
    @IBOutlet var commentHazard: UITextField!
    
    @IBAction func construction(sender: AnyObject) {
        onroadFlag = false;
        constructionFlag = true;
        settings.setBool(true , forKey: "construction");
         settings.setBool(false , forKey: "onroad");
        constructionLable.text="Selected";
        onRoadLable.text="";
    }
    
    
    @IBAction func SetLocation(sender: AnyObject) {
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
        
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLat");
        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "reportLon");
        getLocation.latKey = "reportLat";
        getLocation.lngKey = "reportLon";
        self.presentViewController(getLocation, animated: true, completion: {});
    }
    
    @IBAction func onRoad(sender: AnyObject) {
        onroadFlag = true;
        constructionFlag = false;
        settings.setBool(true , forKey: "onroad");
         settings.setBool(false , forKey: "construction");
        constructionLable.text="";
        onRoadLable.text="Selected";
    }
    
    
    @IBAction func sendReport(sender: AnyObject) {
        
//        var manager:addHazardReport = addHazardReport();
//        manager.HAZARD = self;
//        manager.addToHazardList(commentHazard.text);
//        commentHazard.text = "";
//        
//        onroadFlag = false;
//        constructionFlag = false;
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (commentHazard.text == ""){
            return false;
            
        }
        
        else {
            var manager:addHazardReport = addHazardReport();
            manager.HAZARD = self;
            manager.addToHazardList(commentHazard.text);
            commentHazard.text = "";
            
            onroadFlag = false;
            constructionFlag = false;
            return true;
            
        }
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        commentHazard.text = "";
    }
    
    override func viewDidLoad() {
         super.viewDidLoad();
        constructionLable.text="";
        onRoadLable.text="";
        //locationManager.requestAlwaysAuthorization();
        locationManager.requestWhenInUseAuthorization()
        locationManager.location;
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
        
        locationManager.startUpdatingLocation();
        println("current location is \(currentLocation.description)");
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        currentLocation = locations.last as! CLLocation;
        println("current location is \(currentLocation.description)");
        
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.description, forKey: "currentLocation");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.latitude.description, forKey: "lat");
        NSUserDefaults.standardUserDefaults().setValue(currentLocation.coordinate.longitude.description, forKey: "lon");
    }
    
    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
//    override func viewDidAppear(animated: Bool) {
//        locationManager.startUpdatingLocation();
//    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if isKeyboardVisible == false {
            
            self.view.frame.origin.y -= 80
            
            isKeyboardVisible = true
        }
        
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        
        if isKeyboardVisible == true {
            
            self.view.frame.origin.y += 80
            
            isKeyboardVisible = false
            
        }
        
    }

}

