//
//  EditUserProfileViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/16/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class EditUserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var userDidPickImage = false
    private var isKeyboardVisible = false
    private var pickedImage = UIImage()
    
    private let pickerController:UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var profilePicture: UIButton!
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        var user = defaultData.valueForKey("username")?.description
        
        if manager.isValidEmail(email.text) {
            
            manager.getUserInfo(user!) {
                userInfo in
                
                userInfo.setEmail(self.email.text)
                
                if self.userDidPickImage {
                    
                    var fileUtils:FileUtils = FileUtils(fileName:user!)
                    var imagePath:String = fileUtils.docsPath()
                    fileUtils.createIfNotExistUnderDocs();
                    ImageConversion().writeImage(self.pickedImage, toFile: imagePath)
                    
                }
                
                manager.updateUserInfo(userInfo)
            }
            
            self.dismissViewControllerAnimated(false, completion: nil)
            
        } else {
            
            let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func profilePictureAction(sender: AnyObject) {
        pickerController.allowsEditing = false
        pickerController.sourceType = .PhotoLibrary
        
        presentViewController(pickerController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var manager = ConnectionManager()
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        var user = defaultData.valueForKey("username")?.description
        
        manager.getUserInfo(user!) {
            userInfo in
            
            self.username.text = userInfo.getUsername()
            self.email.text = userInfo.getEmail()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        userDidPickImage = true
        pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage;
        
        profilePicture.setBackgroundImage(pickedImage, forState: UIControlState.Normal)
        profilePicture.setTitle("", forState: UIControlState.Normal)
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
}