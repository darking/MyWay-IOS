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
        item.itemTitle = "Login";
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
//        item = MenuItem();
//        item.itemTitle = "Settings";
//        item.itemVCIdentifier = "Team5_Settings";
//        item.storyBoardName = "Team5";
//        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Parent Monitor";
        item.itemVCIdentifier = "DLVC";
        item.storyBoardName = "Team5_m";
        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Daily Route";
        item.itemVCIdentifier = "DailyRouteVC";
        item.storyBoardName = "Team5_m";
        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Post Report";
        item.itemVCIdentifier = "Report";
        item.storyBoardName = "Main_4";
        MenuItem.all.menuItems.addObject(item);
        
        item = MenuItem();
        item.itemTitle = "Favorites";
        item.itemVCIdentifier = "favoritesList";
        item.storyBoardName = "Team3.storyboard.favorites";
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
        item.itemTitle = "MyWay Events";
        item.itemVCIdentifier = "CategorisView";
        item.storyBoardName = "Team3";
        MenuItem.all.menuItems.addObject(item);
        
        //
        item = MenuItem();
        item.itemTitle = "Points of Interest";
        item.itemVCIdentifier = "poiVC";
        item.storyBoardName = "POI";
        MenuItem.all.menuItems.addObject(item);
        
//        item = MenuItem();
//        item.itemTitle = "Keyboard";
//        item.itemVCIdentifier = "keyboard";
//        item.storyBoardName = "keyboard";
//        MenuItem.all.menuItems.addObject(item);
        
//        item = MenuItem();
//        item.itemTitle = "Digital Address";
//        item.itemVCIdentifier = "GeoVC";
//        item.storyBoardName = "GeoMash";
//        MenuItem.all.menuItems.addObject(item);
        
        //
        
       
    }
}