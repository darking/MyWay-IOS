//
//  FavoritesViewController.swift
//  SwiftSideMenu
//
//  Created by trn17 on 9/30/15.
//
//

import Foundation
import UIKit
import CoreLocation

class FavoritesViewController:UITableViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, MyProtocol{

    @IBOutlet var AddNewFavoriteButton: UIBarButtonItem!
 
    
    
    var favesList:NSMutableArray = NSMutableArray();
    var tableViewx = UITableView()
    var showsArray = Array<String>()
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favesList.count == 0{
            return 1;
        } else {
            return favesList.count;//will change to the size(count) of the array returned from the server
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if favesList.count == 0{
            var cell:UITableViewCell = UITableViewCell();
            cell.textLabel?.text = "No Locations found.";
            return cell;
        } else {
            let cellFrame = CGRectMake(0, 0, self.tableView.frame.width, 52.0)
            var retCell = UITableViewCell(frame: cellFrame)
            var textLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 52.0 - 4.0))
            
            textLabel.textColor = UIColor.blackColor()
            var tempFav:NSDictionary = favesList[indexPath.row] as! NSDictionary;
            textLabel.text = tempFav.valueForKey("name") as? String;
            retCell.addSubview(textLabel);
            return retCell;
            
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
        
    {
        
        return 52.0
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 64.0
        }
        return 32.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if favesList.count == 0{
            //does nothing when clicked
        } else {
            
            var mapVC:ShowOnMapVC = UIStoryboard(name: "reqLocaiton", bundle: nil).instantiateViewControllerWithIdentifier("ShowOnMapVC") as! ShowOnMapVC;
            var tempFav:NSDictionary = favesList[indexPath.row] as! NSDictionary;
            mapVC.title = tempFav.valueForKey("name") as? String;
//            mapVC.message = "test desc"; //temporary info MUST CHANGE
            let lat:NSString = tempFav.valueForKey("latitude") as! NSString;
            let lng:NSString = tempFav.valueForKey("longitude") as! NSString;
            
            let location = CLLocation(latitude: (lat as NSString).doubleValue, longitude: (lng as NSString).doubleValue)
            mapVC.location = location;
            mapVC.lat = lat as String;
            mapVC.long = lng as String;
            //to enable the share button
            mapVC.show = true;
            self.navigationController?.pushViewController(mapVC, animated: true);
            
        }
        
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        if favesList.count == 0 {
            let suggestNew = UITableViewRowAction(style: .Normal, title: "Add Some!") { action, index in
                println("clicked..")
                
            }
            
            suggestNew.backgroundColor = UIColor.grayColor()
            return [suggestNew]
        }
        else {
            let sendToMap = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
                println("delete button tapped")
                var Manager:ManageFavorites = ManageFavorites();
                Manager.favoritesVC = self;
                var favorite:Favorite = Favorite();
                var tempFav:NSDictionary = self.favesList[indexPath.row] as! NSDictionary;
                favorite.name = tempFav.valueForKey("name") as! String;
                favorite.lat = tempFav.valueForKey("latitude") as! String;
                favorite.long = tempFav.valueForKey("longitude") as! String;
//                Manager.deleteFavorite(favorite);
                //MARK: delete favorite
                //after calling the deletefavorite method we need to reload the page so the changes are shown
                var df:DeleteFavorite = DeleteFavorite();
                df.deleteFavorite(favorite);
                self.favesList.removeObject(indexPath.row);
                self.tableView.reloadData();
                //to reload the page information when i go back to it from the add
            }
            
            sendToMap.backgroundColor = UIColor.redColor()
            return [sendToMap]
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
   
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
//        favesList = manageFavs.showAllFavorites() as NSArray;
        
        //get/set the values of the faves by calling the getAllFavorites method in ManageFavorites class
        var manageFavs:ManageFavorites = ManageFavorites();
        manageFavs.favoritesVC = self;
        manageFavs.startConnection();
        self.tableView.reloadData();

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        var manageFavs:ManageFavorites = ManageFavorites();
//        manageFavs.favoritesVC = self;
//        manageFavs.startConnection();
        
        self.tableView.reloadData();//to reload the page information when i go back to it from the add
        
        tableView = UITableView(frame: self.view.frame)
        tableView.separatorColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setFavsData(favs: NSArray) {
        favesList = favs as! NSMutableArray;
        self.tableView.reloadData();//to reload the page information when i go back to it from the add
    }
}