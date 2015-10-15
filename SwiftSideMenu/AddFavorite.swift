//
//  AddFavorite.swift
//  SwiftSideMenu
//
//  Created by trn17 on 10/14/15.
//
//

import Foundation

class AddFavorite: NSObject, NSURLConnectionDataDelegate, NSURLConnectionDelegate {
    let favs  = "favoriteList.plist";
    var favoritesVC: MyProtocol = FavoritesViewController();
    
    lazy var data = NSMutableData()
    
    
    func addFavorite(newFav: Favorite){
        
//        let urlPath: String = "http://172.16.8.105:8080/MyWayWeb/addFavorite"
        let urlPath: String = "\(ConnectionString.holder.URL)/addFavorite"

        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST";
        
        var username = NSUserDefaults.standardUserDefaults().stringForKey("username")!;
        var bodyData = "username=\(username)&name=\(newFav.name)&latitude=\(newFav.lat)&longitude=\(newFav.long)";
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var err: NSError
        
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        println("jsonResult:\(jsonResult)");
        
        
    }

    
}