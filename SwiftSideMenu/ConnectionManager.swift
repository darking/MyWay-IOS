//
//  ConnectionManager.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/13/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import Foundation

class ConnectionManager {
    
    struct common {
        static let accountsFileName:String = "accounts";
        static let accountsFileType:String = "plist";
        static var loaded:Bool = false;
        static var allAccounts:NSMutableArray = NSMutableArray();
        static var filePath:String = "";
    }
    func loadAccountValues()->NSMutableArray{
        let utils = FileUtils(fileName: ConnectionManager.common.accountsFileName);
        utils.fileType = ConnectionManager.common.accountsFileType;
        utils.createIfNotExistUnderDocs();
        let filePath = utils.docsPath();
        ConnectionManager.common.filePath = filePath;
        let valuesArray = NSMutableArray(contentsOfFile: filePath);
        return valuesArray!;
    }
    func loadAccounts(){
        let valuesArray = self.loadAccountValues();
        var allAccounts:NSMutableArray = NSMutableArray();
        for (var i = 0 ; i < valuesArray.count; i++){
            var currentElement:NSDictionary = valuesArray.objectAtIndex(i) as! NSDictionary;
            allAccounts.addObject(UserInfo(values: currentElement));
        }
        ConnectionManager.common.loaded = true;
        ConnectionManager.common.allAccounts = allAccounts;
    }
    
    
    func prepareDate(){
        if !ConnectionManager.common.loaded{
            self.loadAccounts();
        }
    }
    func login(username:String, password:String) -> Bool {
        self.prepareDate();
        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
            
            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
            if currentUser.getUsername() == username {
                if currentUser.getPassword() == password {
                    return true;
                }
            }
        }
        return false;
    }
    
    func isUsernameExist(username:String) -> Bool {
        self.prepareDate();
        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
            
            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
            if currentUser.getUsername() == username {
                return true;
            }
        }
        return false;
    }
    
    func register(newUser:UserInfo) {
        var allValues:NSMutableArray = self.loadAccountValues();
        allValues.addObject(newUser.toDictionary())
        allValues.writeToFile(ConnectionManager.common.filePath, atomically: true);
        self.loadAccounts();
    }
    
    func getUserInfo (username:String) -> UserInfo {
        self.prepareDate();
        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
            
            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
            if currentUser.getUsername() == username {
                return currentUser;
            }
        }
        return UserInfo(username: "", password: "", email: "");
    }
    
    func updateUserInfo(user:UserInfo) {
        self.prepareDate();
        var allValues:NSMutableArray = self.loadAccountValues();
        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
            
            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
            if currentUser.getUsername() == user.getUsername() {
                allValues.replaceObjectAtIndex(i, withObject: user.toDictionary());
                break;
            }
        }
        allValues.writeToFile(ConnectionManager.common.filePath, atomically: true);
        self.loadAccounts();
    }
    
    func sendCodeViaSms(username:String) {
        
    }
    
    func sendCodeViaEmail(username:String) {
        
    }
    
    func verifyCode (code:String) -> Bool {
        return true;
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
}
