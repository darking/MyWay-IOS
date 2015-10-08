//
//  ManageFavorites.swift
//  SwiftSideMenu
//
//  Created by trn17 on 9/30/15.
//
//


import Foundation

class ManageFavorites: NSObject, NSURLConnectionDataDelegate, NSURLConnectionDelegate {
    let favs  = "favoriteList.plist";
    var favoritesVC: MyProtocol = FavoritesViewController();
    var callerForPins: MyProtocol = mainViewController();
    
    var list:NSMutableArray = NSMutableArray();
    lazy var data = NSMutableData()
    
    
    func addFavorite(newFav: Favorite){
        
        let urlPath: String = "http://mobile.comxa.com/fav/add_fav.json"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST";
        
        var username = NSUserDefaults.standardUserDefaults().stringForKey("username")!;
        var bodyData = "username=\(username)&name=\(newFav.name)&latitude=\(newFav.lat)&longitude=\(newFav.long)";
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        
    }
    
    func deleteFavorite(newFav: Favorite){
        let urlPath: String = "http://mobile.comxa.com/fav/delete_fav.json"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST";
        
        var username = NSUserDefaults.standardUserDefaults().stringForKey("username")!;
        var bodyData = "username=\(username)&name=\(newFav.name)";
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
    
    
    func startConnection(){
        let urlPath: String = "http://mobile.comxa.com/fav/all_favs.json"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST";
        
        var username = NSUserDefaults.standardUserDefaults().stringForKey("username")!;
        var bodyData = "username=\(username)";
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);

        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        //        data = NSMutableData()//re-initialize the data so it wouldn't be an invalid JSON after i append to it the newer JSON
        //        connection.start()
    }
    
    
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        list = jsonResult.valueForKey("result_data") as! NSMutableArray;
        
        // To check if the request was successful
        var tempNumber = jsonResult.valueForKey("result_code") as! NSNumber;
        var submitted = "\(tempNumber)";
        println("result code: "+submitted);
        if submitted == "1" {
            var alert : UIAlertView = UIAlertView(title: "Could Not Preform Action.", message: "Try again later.",
                delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        } else {
            
            //send the list to the class that called it
            //        var favoritesVC: FavoritesViewController = FavoritesViewController();
            
            favoritesVC.setFavsData(list);
            callerForPins.setFavsData(list);
            
        }
        println(list);
    }
    
    
    
    
    
}