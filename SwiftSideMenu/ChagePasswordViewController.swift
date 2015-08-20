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
        
        var user = manager.getUserInfo(defaultData.valueForKey("username")!.description)
        
        if newPassword.text != confirmNewPassword.text || oldPassword.text != user.getPassword() || newPassword.text == "" || confirmNewPassword.text == "" {
            
            let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            
            user.setPassword(newPassword.text)
            
            manager.updateUserInfo(user)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
