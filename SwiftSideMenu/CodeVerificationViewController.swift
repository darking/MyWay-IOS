//
//  CodeVerificationViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/17/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class CodeVerificationViewController: UIViewController {
    
    @IBOutlet weak var code: UITextField!
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        var manager = ConnectionManager()
        
        if manager.verifyCode(code.text) {
            return true
        } else {
            let alertController = UIAlertController(title: "Warning", message:
                "Invalid code", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return false
        }
    }
    
}
