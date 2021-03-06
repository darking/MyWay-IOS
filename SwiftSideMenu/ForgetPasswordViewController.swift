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
    
    @IBAction func resetPasswordAction(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        manager.isUsernameExist(username.text, completionHandler: { (usernameExist) -> () in
            
            if usernameExist {
                
                manager.forgetPassword(self.username.text)
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else {
                
                let alertController = UIAlertController(title: "Warning", message:
                    "Invalid username", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            
        })
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
}