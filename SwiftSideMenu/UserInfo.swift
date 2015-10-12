//
//  UserInfo.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/13/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import Foundation

import UIKit

class UserInfo {
    
    private var username:String
    private var password:String
    private var email:String
    
    init (username:String, password:String, email:String) {
        self.username = username
        self.password = password
        self.email = email
    }
    
    init (values: NSDictionary){
        self.username = values.valueForKey("username") as! String;
        self.password = values.valueForKey("password") as! String;
        self.email = values.valueForKey("email") as! String;
    }
    
    func toDictionary()->NSDictionary{
        var values:NSMutableDictionary = NSMutableDictionary();
        values.setObject(self.username, forKey: "username");
        values.setObject(self.password, forKey: "password");
        values.setObject(self.email, forKey: "email");
        return values;
    }
    
    func getUsername() -> String {
        return username
    }
    
    func setUsername(username:String) {
        self.username = username
    }
    
    func getPassword() -> String {
        return password
    }
    
    func setPassword(password:String) {
        self.password = password
    }
    
    func getEmail() -> String {
        return email
    }
    
    func setEmail(email:String) {
        self.email = email
    }
    
    func getProfilePictureFilePath() -> String {
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        var fileUtils:FileUtils = FileUtils(fileName: defaultData.valueForKey("username")!.description)
        
        return fileUtils.docsPath()
    }
    
}