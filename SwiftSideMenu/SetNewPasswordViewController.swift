//
//  SetNewPasswordViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/18/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class SetNewPasswordViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        if identifier != "submit" {
            return true
        }
        
        if password.text != confirmPassword.text || password.text == "" || confirmPassword.text == "" {
            
            let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return false
            
        } else {
            
            var manager = ConnectionManager()
            
            var defaultData = NSUserDefaults.standardUserDefaults()
            
            var user = manager.getUserInfo(defaultData.valueForKey("username")!.description)
            
            user.setPassword(password.text)
            
            manager.updateUserInfo(user)
            
            return true
        }
        
    }
    
}
