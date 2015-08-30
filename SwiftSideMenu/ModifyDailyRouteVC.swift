//
//  ModifyDailyRouteVC.swift
//  MyWay-IOS
//
//  Created by trn22 on 8/18/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import Foundation
import UIKit
class ModifyDailyRouteVC:UIViewController{
    @IBOutlet weak var DailyRouteLabel: UILabel!
    @IBOutlet weak var DetailLabel: UILabel!
    
    var index = 0;
    
    
    override func viewDidLoad() {
//        AddDailyRouteVC().showAllObjects();
        var row:Int = index;
        var manager:AddDailyRouteVC = AddDailyRouteVC();
        var list:NSMutableArray = manager.showAllObjects();
        
        var values:DailyRouteHolder = list.objectAtIndex(row) as! DailyRouteHolder;
        
        DailyRouteLabel.text = values.name;
        DetailLabel.numberOfLines = 5;
        DetailLabel.text = "From \(values.startDate)\nTo \(values.endDate)"
        println("The value you're looking for is \(values.endDate)");
    }
    
    @IBAction func DeleteBTN(sender: AnyObject) {
        //        AddDailyRouteVC().showAllObjects();
        var row:Int = index;
        var manager:AddDailyRouteVC = AddDailyRouteVC();
        var list:NSMutableArray = manager.showAllReports();
        list.removeObjectAtIndex(index);
        
        list.writeToFile(manager.dailyFilePath(), atomically: true);
        
    }
}