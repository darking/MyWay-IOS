//
//  KeyboardViewController.swift
//  
//
//  Created by Abduallah Al Mashmoum on 8/29/15.
//
//

import UIKit

class KeyboardViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func handleKeyboardWillShow(notification: NSNotification){
        
        let userInfo = notification.userInfo
        
        if let info = userInfo{
            /* Get the duration of the animation of the keyboard for when it
            gets displayed on the screen. We will animate our contents using
            the same animation duration */
            let animationDurationObject =
            info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
            
            let keyboardEndRectObject =
            info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            var animationDuration = 0.0
            var keyboardEndRect = CGRectZero
            
            animationDurationObject.getValue(&animationDuration)
            keyboardEndRectObject.getValue(&keyboardEndRect)
            
            let window = UIApplication.sharedApplication().keyWindow
            
            /* Convert the frame from window's coordinate system to
            our view's coordinate system */
            keyboardEndRect = view.convertRect(keyboardEndRect, fromView: window)
            
            /* Find out how much of our view is being covered by the keyboard */
            let intersectionOfKeyboardRectAndWindowRect =
            CGRectIntersection(view.frame, keyboardEndRect);
            
            /* Scroll the scroll view up to show the full contents of our view */
            UIView.animateWithDuration(animationDuration, animations: {[weak self] in
                
                self!.scrollView.contentInset = UIEdgeInsets(top: 0,
                    left: 0,
                    bottom: intersectionOfKeyboardRectAndWindowRect.size.height,
                    right: 0)
                
                self!.scrollView.scrollRectToVisible(self!.textField.frame,
                    animated: false)
                
                })
        }
        
    }
    
    func handleKeyboardWillHide(sender: NSNotification){
        
        let userInfo = sender.userInfo
        
        if let info = userInfo{
            let animationDurationObject =
            info[UIKeyboardAnimationDurationUserInfoKey]
                as! NSValue
            
            var animationDuration = 0.0;
            
            animationDurationObject.getValue(&animationDuration)
            
            UIView.animateWithDuration(animationDuration, animations: {
                [weak self] in
                self!.scrollView.contentInset = UIEdgeInsetsZero
                })
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self,
            selector: "handleKeyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        center.addObserver(self,
            selector: "handleKeyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
}
