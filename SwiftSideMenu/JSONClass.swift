//
//  JSONClass.swift
//  SwiftSideMenu
//
//  Created by trn22 on 10/1/15.
//
//
import UIKit

class JSONClass: UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
     var data = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startConnection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startConnection(){
        let urlPath: String = "http://binaenaleyh.net/dusor/"
        var url: NSURL = NSURL(string: urlPath)!;
        var request: NSURLRequest = NSURLRequest(URL: url);
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!;
        connection.start()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        self.data.appendData(data)
    }
    
    func buttonAction(sender: UIButton!){
        startConnection()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        println(jsonResult)
    }
}