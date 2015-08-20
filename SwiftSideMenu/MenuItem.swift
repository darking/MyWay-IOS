//
//  MenuItem.swift
//  SwiftSideMenu
//
//  Created by Ahmed on 8/17/15.
//  Copyright (c) 2015 PiTechnologies. All rights reserved.
//

import Foundation


class MenuItem{

    

    var itemTitle:String = "";
    var itemVCIdentifier = "";
    var storyBoardName = "Main";
    
    struct all{
        static var menuItems:NSMutableArray = NSMutableArray();
        var allNames:[String] = ["User Profile","Share","View Daily Routes","Manage Daily Routes","View Parental Report","Manage Drivers","Points of Interest","Destinations","View Traffic Reports","Post Traffic Report"];
    }
    

}