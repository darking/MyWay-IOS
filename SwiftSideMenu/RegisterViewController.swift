//
//  RegisterViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/13/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private var isKeyboardVisible = false
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    @IBAction func isExist(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        manager.isUsernameExist(username.text) {
            
            usernameExist in
            
            println("username_exist_is  " + usernameExist.description)
            
            if usernameExist {
                self.usernameErrorLabel.hidden = false
            } else {
                self.usernameErrorLabel.hidden = true
            }
            
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        
        var manager = ConnectionManager()
                
        if password.text != confirmPassword.text || manager.isValidEmail(email.text) == false || usernameErrorLabel.hidden == false {
            
            let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            manager.register(UserInfo(username: username.text, password: password.text, email: email.text))
            
            //self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameErrorLabel.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
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