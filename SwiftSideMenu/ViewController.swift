//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 03.08.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ENSideMenuDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        
        
        
        
//        let menuItem = MenuItem.all.menuItems.objectAtIndex(2) as! MenuItem
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: menuItem.storyBoardName,bundle: nil)
//        var destViewController : UIViewController
//        var viewControllerName = menuItem.itemVCIdentifier;
//        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(viewControllerName) as! UIViewController
//        
//        //        switch (indexPath.row) {
//        //        case 0:
//        //            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController1") as! UIViewController
//        //            break
//        //        case 1:
//        //            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController2")as! UIViewController
//        //            break
//        //        case 2:
//        //            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController3")as! UIViewController
//        //            break
//        //        default:
//        //            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4") as! UIViewController
//        //            break
//        //        }
//        sideMenuController()?.setContentViewController(destViewController)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true
    }
}

