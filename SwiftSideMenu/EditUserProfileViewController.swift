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
    private var pickedImage = UIImage()
    
    private let pickerController:UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var profilePicture: UIButton!
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        
        var manager = ConnectionManager()
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        var user = manager.getUserInfo(defaultData.valueForKey("username")!.description)
        
        if manager.isValidEmail(email.text) {
            
            user.setFirstName(firstName.text)
            user.setLastName(lastName.text)
            user.setPhone(phone.text)
            user.setEmail(email.text)
            
            if userDidPickImage {
                
                var fileUtils:FileUtils = FileUtils(fileName: user.getUsername())
                let imagePath:String = fileUtils.docsPath()
                fileUtils.createIfNotExistUnderDocs();
                ImageConversion().writeImage(pickedImage, toFile: imagePath)
                
                user.setUserHasProfile()
                
            }
            
            manager.updateUserInfo(user)
            
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
    }
    
    override func viewDidAppear(animated: Bool) {
        var manager = ConnectionManager()
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        var user = manager.getUserInfo(defaultData.valueForKey("username")!.description)
        
        firstName.text = user.getFirstName()
        lastName.text = user.getLastName()
        username.text = user.getUsername()
        email.text = user.getEmail()
        phone.text = user.getPhone()
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        userDidPickImage = true
        pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage;
        
        profilePicture.setBackgroundImage(pickedImage, forState: UIControlState.Normal)
        profilePicture.setTitle("", forState: UIControlState.Normal)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
