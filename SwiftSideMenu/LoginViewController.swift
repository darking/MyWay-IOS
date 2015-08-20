//
//  LoginViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/13/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
    }
    override func viewDidAppear(animated: Bool) {
        username.text = ""
        password.text = ""
    }
    
    @IBAction func login(sender: AnyObject) {
        var manager = ConnectionManager()
        
        if manager.login(username.text, password: password.text) {
            
            var defaultData = NSUserDefaults.standardUserDefaults()
            
            defaultData.setValue(username.text, forKey: "username")
            defaultData.setBool(true, forKey: "isLoggedin")
            var menuManager = MenuManager();
            menuManager.clearMenu();
            menuManager.addMaptoMenu();
            menuManager.reloadFullMenu();
            menuManager.addRemaining();
            let menuItem = MenuItem.all.menuItems.objectAtIndex(0) as! MenuItem
            let mainStoryboard: UIStoryboard = UIStoryboard(name: menuItem.storyBoardName,bundle: nil)
            var destViewController : UIViewController
            var viewControllerName = menuItem.itemVCIdentifier;
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(viewControllerName) as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            sideMenuController()?.sideMenu?.hideSideMenu();
            
            var tableVC:UITableViewController = sideMenuController()?.sideMenu?.menuViewController as! UITableViewController;
            tableVC.tableView.reloadData();
            
        } else {
            
            let alertController = UIAlertController(title: "Warning", message: "Invalid data", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func reg(sender: AnyObject) {
    }
    
    
    @IBAction func forget(sender: AnyObject) {
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
            return true
    }
}
