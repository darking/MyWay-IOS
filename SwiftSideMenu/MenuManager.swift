//
//  MenuManager.swift
//  SwiftSideMenu
//
//  Created by Adnan Alqazwini on 8/19/15.
//  Copyright (c) 2015 Evgeny Nazarov. All rights reserved.
//

import Foundation

class MenuManager {
    var item:MenuItem = MenuItem();
    func reloadPublicMenu() {
        item = MenuItem();
        item.itemTitle = "Log In";
        item.itemVCIdentifier = "LogIn";
        item.storyBoardName = "Team2";
        MenuItem.all.menuItems.addObject(item);
    }
    func reloadFullMenu() {
        
        item = MenuItem();
        item.itemTitle = "Profile";
        item.itemVCIdentifier = "UserProfile";
        item.storyBoardName = "Team2";
        MenuItem.all.menuItems.addObject(item);
        
        // Everything goes between this to the Logout button
        item = MenuItem();
        item.itemTitle = "Settings";
        item.itemVCIdentifier = "Team5_Settings";
        item.storyBoardName = "Team5";
        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Parent Monitor";
        item.itemVCIdentifier = "ManageDriver";
        item.storyBoardName = "Team5_m";
        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Daily Route";
        item.itemVCIdentifier = "Daily_Route_Team5";
        item.storyBoardName = "Team5_m";
        MenuItem.all.menuItems.addObject(item);
        
        //Here goes the Logout button
        //            item = MenuItem();
        //            item.itemTitle = "Logout";
        //            item.itemVCIdentifier = "UserProfile";
        //            item.storyBoardName = "Team2";
        //            MenuItem.all.menuItems.addObject(item);
    }
    func clearMenu() {
        MenuItem.all.menuItems.removeAllObjects();
    }
    func addMaptoMenu() {
        //var item:MenuItem = MenuItem();
        item.itemTitle = "Map";
        item.itemVCIdentifier = "mainVC";
        item.storyBoardName = "Main_1";
        MenuItem.all.menuItems.addObject(item);
    }
    func addRemaining () {
        item = MenuItem();
        item.itemTitle = "Points of Interest";
        item.itemVCIdentifier = "CategorisView";
        item.storyBoardName = "Team3";
        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Reports";
        item.itemVCIdentifier = "Report";
        item.storyBoardName = "Main_4";
        MenuItem.all.menuItems.addObject(item);
    }
}