//
//  UserProfileViewController.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/16/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func logout(sender: AnyObject) {
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        defaultData.setValue("", forKey: "username")
        defaultData.setBool(false, forKey: "isLoggedin");
        var menuManager = MenuManager();
        menuManager.clearMenu();
        menuManager.addMaptoMenu();
        menuManager.reloadPublicMenu();
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
    }
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var manager = ConnectionManager()
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        manager.getUserInfo(defaultData.valueForKey("username")!.description) {
            userInfo in
            
            self.username.text = userInfo.getUsername()
            self.email.text = userInfo.getEmail()
            
            var converter = ImageConversion()
            self.profilePicture.image = converter.readImageAtPath(userInfo.getProfilePictureFilePath())
        }
        
    }
    
}