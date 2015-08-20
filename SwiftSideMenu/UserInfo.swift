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
    
    private var firstName:String
    private var lastName:String
    private var username:String
    private var password:String
    private var email:String
    private var phone:String
    private var userHasProfile:String
    
    init (username:String, password:String, email:String) {
        self.firstName = ""
        self.lastName = ""
        self.username = username
        self.password = password
        self.email = email
        self.phone = ""
        self.userHasProfile = "0"
    }
    
    init (values: NSDictionary){
        self.firstName = values.valueForKey("firstName") as! String;
        self.lastName = values.valueForKey("lastName") as! String;
        self.username = values.valueForKey("username") as! String;
        self.password = values.valueForKey("password") as! String;
        self.email = values.valueForKey("email") as! String;
        self.phone = values.valueForKey("phone") as! String;
        self.userHasProfile = values.valueForKey("userHasProfile") as! String;
    }
    
    func toDictionary()->NSDictionary{
        var values:NSMutableDictionary = NSMutableDictionary();
        values.setObject(self.firstName, forKey: "firstName");
        values.setObject(self.lastName, forKey: "lastName");
        values.setObject(self.username, forKey: "username");
        values.setObject(self.password, forKey: "password");
        values.setObject(self.email, forKey: "email");
        values.setObject(self.phone, forKey: "phone");
        values.setObject(self.userHasProfile, forKey: "userHasProfile");
        return values;
    }
    
    func getFirstName() -> String {
        return firstName
    }
    
    func setFirstName(firstName:String) {
        self.firstName = firstName
    }
    
    func getLastName() -> String {
        return lastName
    }
    
    func setLastName(lastName:String) {
        self.lastName = lastName
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
    
    func getPhone() -> String {
        return phone
    }
    
    func setPhone(phone:String) {
        self.phone = phone
    }
    
    func setUserHasProfile() {
        self.userHasProfile = "1"
    }
    
    func getUserHasProfile() -> String {
        return userHasProfile
    }
    
    func getProfilePictureFilePath() -> String {
        
        var defaultData = NSUserDefaults.standardUserDefaults()
        
        var fileUtils:FileUtils = FileUtils(fileName: defaultData.valueForKey("username")!.description)
        
        return fileUtils.docsPath()
    }
    
}