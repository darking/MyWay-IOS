//
//  ManageDriverVC.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
class ManageDriverVC : UIViewController{
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPairNo: UITextField!
    @IBAction func btnSubmitTouched(sender: AnyObject) {
        if txtUserName.text! == "Ahmad" && txtPairNo.text! == "12345"{
            //if txtUserName.text! == "Zainab" && txtPairNo.text! == "12345"{
            let dest = storyboard?.instantiateViewControllerWithIdentifier("driversList") as! DriversListViewController
            dest.userName = txtUserName.text!
            presentViewController(dest, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Error", message: "Wrong username or password", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}