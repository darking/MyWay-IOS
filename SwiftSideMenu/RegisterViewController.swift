//
//  RegisterViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/13/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, ENSideMenuDelegate {
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    @IBAction func isExist(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        if manager.isUsernameExist(username.text) {
            usernameErrorLabel.hidden = false
        } else {
            usernameErrorLabel.hidden = true
        }
        
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        if password.text != confirmPassword.text || manager.isValidEmail(email.text) == false || usernameErrorLabel.hidden == false {
            
            let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            manager.register(UserInfo(username: username.text, password: password.text, email: email.text))
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameErrorLabel.hidden = true
    }
    
}
