//
//  Share.swift
//  SwiftSideMenu
//
//  Created by trn17 on 10/4/15.
//
//

import Foundation
class Share {
    var latitude = "";
    var longitude = "";
    func sharing(cager: AnyObject) {
        
        
        var test = "https://www.google.ae/maps/@\(latitude),\(longitude),12z?hl=en";
        
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [test], applicationActivities: nil)
        
        
        // change calling control to self when calling from the same controller
        
        
        cager.presentViewController(activityViewController, animated: true, completion: nil)
        
        
    }
    
}