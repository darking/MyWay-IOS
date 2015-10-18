//
//  ConnectionManager.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/13/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

import Foundation

class ConnectionManager {
    
    /*************** Saving the data locally ***************/
    
    //    struct common {
    //        static let accountsFileName:String = "accounts";
    //        static let accountsFileType:String = "plist";
    //        static var loaded:Bool = false;
    //        static var allAccounts:NSMutableArray = NSMutableArray();
    //        static var filePath:String = "";
    //    }
    //    
    //    func loadAccountValues()->NSMutableArray{
    //        let utils = FileUtils(fileName: ConnectionManager.common.accountsFileName);
    //        utils.fileType = ConnectionManager.common.accountsFileType;
    //        utils.createIfNotExistUnderDocs();
    //        let filePath = utils.docsPath();
    //        ConnectionManager.common.filePath = filePath;
    //        let valuesArray = NSMutableArray(contentsOfFile: filePath);
    //        return valuesArray!;
    //    }
    //    
    //    func loadAccounts(){
    //        let valuesArray = self.loadAccountValues();
    //        var allAccounts:NSMutableArray = NSMutableArray();
    //        for (var i = 0 ; i < valuesArray.count; i++){
    //            var currentElement:NSDictionary = valuesArray.objectAtIndex(i) as! NSDictionary;
    //            allAccounts.addObject(UserInfo(values: currentElement));
    //        }
    //        ConnectionManager.common.loaded = true;
    //        ConnectionManager.common.allAccounts = allAccounts;
    //    }
    //    
    //    
    //    func prepareDate(){
    //        if !ConnectionManager.common.loaded{
    //            self.loadAccounts();
    //        }
    //    }
    //    
    //    func login(username:String, password:String) -> Bool {
    //        self.prepareDate();
    //        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
    //            
    //            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
    //            if currentUser.getUsername() == username {
    //                if currentUser.getPassword() == password {
    //                    return true;
    //                }
    //            }
    //        }
    //        return false;
    //    }
    //    
    //    func isUsernameExist(username:String) -> Bool {
    //        self.prepareDate();
    //        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
    //            
    //            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
    //            if currentUser.getUsername() == username {
    //                return true;
    //            }
    //        }
    //        return false;
    //    }
    //    
    //    func register(newUser:UserInfo) {
    //        var allValues:NSMutableArray = self.loadAccountValues();
    //        allValues.addObject(newUser.toDictionary())
    //        allValues.writeToFile(ConnectionManager.common.filePath, atomically: true);
    //        self.loadAccounts();
    //    }
    //    
    //    func getUserInfo (username:String) -> UserInfo {
    //        self.prepareDate();
    //        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
    //            
    //            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
    //            if currentUser.getUsername() == username {
    //                return currentUser;
    //            }
    //        }
    //        return UserInfo(username: "", password: "", email: "");
    //    }
    //    
    //    func updateUserInfo(user:UserInfo) {
    //        self.prepareDate();
    //        var allValues:NSMutableArray = self.loadAccountValues();
    //        for (var i = 0 ; i < ConnectionManager.common.allAccounts.count; i++){
    //            
    //            var currentUser:UserInfo = ConnectionManager.common.allAccounts.objectAtIndex(i) as! UserInfo;
    //            if currentUser.getUsername() == user.getUsername() {
    //                allValues.replaceObjectAtIndex(i, withObject: user.toDictionary());
    //                break;
    //            }
    //        }
    //        allValues.writeToFile(ConnectionManager.common.filePath, atomically: true);
    //        self.loadAccounts();
    //    }
    
    /*************** Saving the data in the backend server ***************/
    
    func login(username:String, password:String, completionHandler:(validData:Bool) -> ()) {
        var requestBody = "username=" + username + "&password=" + password
        var requestUrl = "\(ConnectionString.holder.URL)/loginUser"
        
        request(requestBody, url: requestUrl) {
            responseData in
            
            var returnValue = true
            
            if responseData.valueForKey("result_code")?.description == "1" {
                returnValue = false
            }
            
            completionHandler(validData: returnValue)
        }
    }
    
    func forgetPassword(username:String) {
        var requestBody = "username=" + username
        var requestUrl = "http://mobile.comxa.com/profile/valid_forget_password.json"
        
        request(requestBody, url: requestUrl) {
            responseData in
        }
    }
    
    func isUsernameExist(username:String, completionHandler:(usernameExist:Bool) -> ()) {
        var requestBody = "username=" + username
        var requestUrl = "\(ConnectionString.holder.URL)/checkUsername"
        
        request(requestBody, url: requestUrl) {
            responseData in
            
            var returnValue = false
            
            if responseData.valueForKey("result_code")?.description == "0" {
                returnValue = true
            }
            
            completionHandler(usernameExist: returnValue)
        }
    }
    
    func register(newUser:UserInfo) {
        var converter = ImageConversion()
        var imagePath = NSBundle.mainBundle().pathForResource("default", ofType: "png")
        
        var imageData = UIImagePNGRepresentation(converter.readImageAtPath(imagePath!))
        var imageBase64Format = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        var requestBody = "username=" + newUser.getUsername() + "&password=" + newUser.getPassword() + "&email=" + newUser.getEmail() + "&profilepicture=" + imageBase64Format
        var requestUrl = "\(ConnectionString.holder.URL)/registerUser"
        
        request(requestBody, url: requestUrl) {
            responseData in
        }
    }
    
    func getUserInfo (username:String, completionHandler:(userInfo:UserInfo) -> ()) {
        var requestBody = "username=" + username
        var requestUrl = "\(ConnectionString.holder.URL)/getUserProfile"
        
        request(requestBody, url: requestUrl) {
            responseData in
            
            var userInfo = responseData["result_data"]![0] as! NSDictionary
            
            var password = (userInfo.valueForKey("password")?.description!)!
            var email = (userInfo.valueForKey("email")?.description!)!
            var profile_picture = (userInfo.valueForKey("profile_picture")?.description!)!
            
            var user = UserInfo(username: username, password: password, email: email)
            
            var imageData = NSData(base64EncodedString: profile_picture, options: .allZeros)
            
            var fileUtils:FileUtils = FileUtils(fileName: username)
            var imagePath:String = fileUtils.docsPath()
            fileUtils.createIfNotExistUnderDocs();
            ImageConversion().writeImage(UIImage(data: imageData!)!, toFile: imagePath)
            
            completionHandler (userInfo:user)
        }
    }
    
    func updateUserInfo(user:UserInfo) {
        var converter = ImageConversion()
        
        var imageData = UIImagePNGRepresentation(converter.readImageAtPath(user.getProfilePictureFilePath()))
        var imageBase64Format = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        var requestBody = "username=" + user.getUsername() + "&password=" + user.getPassword() + "&email=" + user.getEmail() + "&profile_picture=" + imageBase64Format
        var requestUrl = "\(ConnectionString.holder.URL)/updateUserProfile"
        
        request(requestBody, url: requestUrl) {
            responseData in
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func request(requestBody:String, url:String, completionHandler: (responseData:NSDictionary) -> ()) {
        var request = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            println(data)
            completionHandler(responseData: (NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary)!)
        }
    }
    
}