//
//  TypesOfPOI.swift
//  MyWay-IOS
//
//  Created by trn17 on 8/13/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit

class TypesOfPOI:UITableViewController, NSURLConnectionDataDelegate, NSURLConnectionDelegate  {
    
    @IBAction func toggleAction(sender: AnyObject) {
        toggleSideMenuView();
    }
    
    
    @IBOutlet var SuggestNewButton: UIButton!
    
     var eventsList: NSArray = NSArray();
    
    
    //checks if user is registered before going to the suggest new point screen
    //restricts access to un-registered users
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if NSUserDefaults.standardUserDefaults().boolForKey("isLoggedin"){
            return true;
        }
        else {

            return false;
        }
    }
    
    
    var DataManagement:POIDataManager = POIDataManager();
    var poiTypes:[String] = [];
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poiTypes.count;//will change to the size(count) of the array returned from the server
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell();
        var row = indexPath.row;
        cell.textLabel?.text = poiTypes[row];
        return cell;//should contain types retrieved from the server
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row;
        var mainStoryBoard:UIStoryboard = UIStoryboard(name: "Team3", bundle: nil);
        var nextScreen:SubTypesOfPOI = mainStoryBoard.instantiateViewControllerWithIdentifier("subTypes") as! SubTypesOfPOI;//we use as to customize the returned generic return value of the method
        var tempEventsList: NSMutableArray = NSMutableArray();
        
        var i = 0;
        for var index = 0; index < eventsList.count; ++index {
            var tempEvent: NSDictionary = eventsList[index] as! NSDictionary;
            if tempEvent.valueForKey("category") as! String == poiTypes[row]{
//                tempEventsList.insertObject(Holder.eventsList[index], atIndex: i);
                tempEventsList.addObject(eventsList[index]);
                i++;
            }
        }
        nextScreen.locations = tempEventsList;
        println(poiTypes[row]);
        self.navigationController?.pushViewController(nextScreen, animated: true);
        
        
    }
    
    //to change the text of the suggest new point button to indicate logging in is needed.
    override func viewDidAppear(animated: Bool) {
        
            if NSUserDefaults.standardUserDefaults().boolForKey("isLoggedin"){
                SuggestNewButton.setTitle("Request Event", forState: UIControlState.Normal);
            }
            else {
                SuggestNewButton.setTitle("Request Event (Log in needed!)", forState: UIControlState.Normal);
                
            }
        
        startConnection();
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        poiTypes = DataManagement.getAllCats() as! [String];
        
    }
    
    
    lazy var data = NSMutableData()
    func startConnection(){
        //let urlPath: String = "http://mobile.comxa.com/events/all_events.jsp"
//        let urlPath: String = "http://172.16.8.105:8080/MyWayWeb/viewAllEvents"
        let urlPath: String = "\(ConnectionString.holder.URL)/viewAllEvents"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        data = NSMutableData()//re-initialize the data so it wouldn't be an invalid JSON after i append to it the newer JSON
        connection.start()
    }
    
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        eventsList = jsonResult.valueForKey("result_data") as! NSMutableArray;
        
        
//        println(eventsList);
    }
    
}