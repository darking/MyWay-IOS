//
//  ForgetPasswordViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/17/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        var manager = ConnectionManager()
        
        if manager.isUsernameExist(username.text) {
            
            if identifier == "email" {
                manager.sendCodeViaEmail(username.text)
            } else if identifier == "sms" {
                manager.sendCodeViaSms(username.text)
            }
            
            return true
            
        } else {
            
            let alertController = UIAlertController(title: "Warning", message:
                "Invalid username", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
            return false
            
        }
        
    }
    
}
