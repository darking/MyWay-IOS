//
//  AddNewFavoriteVC.swift
//  SwiftSideMenu
//
//  Created by trn17 on 9/30/15.
//
//

import Foundation

import UIKit

class AddNewFavoriteVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var FavoriteName: UITextField!
    
    struct holder {
        static var favLat:String = "";
        static var favLong:String = "";
    }
    
    @IBAction func SetLocationButton(sender: AnyObject) {
        
        
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;

        self.presentViewController(getLocation, animated: true, completion: {});
  
        
    }
    
    
    @IBAction func AddFavButton(sender: AnyObject) {
        
        if (validateAddForm()){
            var alert : UIAlertView = UIAlertView(title: "ALERT!!", message: "Cannot leave mandatory fields empty.",
                delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }
        else{
            //var mpoi:addNewPoint = addNewPoint();
            var favorite:Favorite = Favorite();
            favorite.name = FavoriteName.text;
            favorite.lat = holder.favLat;
            favorite.long = holder.favLong;
            
            
//            var Manager:ManageFavorites = ManageFavorites();
            
            //old code: to add the fav to the plist
//            Manager.addFavoriteToPList(favorite);
            
            //send new fav to web service
//            Manager.addFavorite(favorite);
            var af:AddFavorite = AddFavorite();
            af.addFavorite(favorite);
            
            AddNewFavoriteVC.holder.favLat = "";
            AddNewFavoriteVC.holder.favLong = "";
            //emptying the static holders of the POI
            AddNewPOI.holder.typeName = "";
            AddNewPOI.holder.pointLat = "";
            AddNewPOI.holder.pointLong = "";
            
            //emptying driver's static holder
            DriverDetailsVC.holder.driverLat = 0.0;
            DriverDetailsVC.holder.driverLong = 0.0;
            
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
            var alert : UIAlertView = UIAlertView(title: "Submited !", message: "Favourite have been added.",
                delegate: nil, cancelButtonTitle: "OK");
            alert.show();
            
        }
        
        
    }
    
    
    
    
    func validateAddForm() -> Bool{
        
        if FavoriteName.text == "" {
            return true;
        }
            
        else{
            if holder.favLong == "" || holder.favLat == "" {
                return true;
            }
            
            return false;
        }
        
    }
    
    
    //method to hide keyboard when tapping anywhere
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    
}