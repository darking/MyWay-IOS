//
//  ChagePasswordViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/17/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class ChagePasswordViewController: UIViewController {
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        var user = defaultData.valueForKey("username")?.description
        
        manager.getUserInfo(user!) {
            userInfo in
            
            if self.newPassword.text != self.confirmNewPassword.text || self.oldPassword.text != userInfo.getPassword() || self.newPassword.text == "" || self.confirmNewPassword.text == "" {
                
                let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                
                userInfo.setPassword(self.newPassword.text)
                
                manager.updateUserInfo(userInfo)
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
}