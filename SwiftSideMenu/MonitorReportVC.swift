//
//  MonitorReportVC.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015 mashael. All rights reserved.
//

import Foundation
import UIKit
class MonitorReportVC:UIViewController{
    @IBOutlet weak var DriverNameTF: UITextField!
    
    @IBOutlet weak var DayTF: UITextField!
    @IBOutlet weak var StartLTF: UITextField!
    @IBOutlet weak var EndLTF: UITextField!
    @IBOutlet weak var SpeedTF: UITextField!
    var index = 0;
    var read:ReadReport = ReadReport();
    var daysArray:NSArray = [];
    override func viewDidLoad() {
        daysArray = read.getDays();
        var dayValue:Data = daysArray.objectAtIndex(index) as! Data;
        DayTF.text = dayValue.day;
        StartLTF.text = dayValue.startlocation;
        EndLTF.text = dayValue.endlocation;
        SpeedTF.text = dayValue.speed;
        DriverNameTF.text = SelectDriverReportVC.holder.driverName;
    }
    
    
    
}