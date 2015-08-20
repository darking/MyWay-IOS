//
//  ImageConversion.swift
//  MyWayUserProfile
//
//  Created by Omar Alobaid on 8/18/15.
//  Copyright (c) 2015 alobaid.co. All rights reserved.
//

//ENJOY

import Foundation

import UIKit



class ImageConversion{
    
    
    
    
    
    func writeImage(image:UIImage, toFile filePath:String){
        
        
        
        var handler:NSFileHandle = NSFileHandle(forWritingAtPath: filePath)!;
        
        handler.writeData(UIImagePNGRepresentation(image));
        
        
        
    }
    
    
    
    func readImageAtPath(filePath:String)->UIImage{
        
        var handler:NSFileHandle = NSFileHandle(forReadingAtPath: filePath)!;
        
        var image:UIImage = UIImage(data: handler.readDataToEndOfFile())!;
        
        return image;
        
        
        
    }
    
    
    
}