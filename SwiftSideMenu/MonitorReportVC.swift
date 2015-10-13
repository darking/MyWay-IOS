//
//  MonitorReportVC.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015. All rights reserved.
//

import Foundation
import UIKit
class MonitorReportVC:UIViewController, ENSideMenuDelegate{
    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView();
    }
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var DayTF: UITextField!
    @IBOutlet weak var StartLTF: UITextField!
    @IBOutlet weak var EndLTF: UITextField!
    @IBOutlet weak var SpeedTF: UITextField!
    var index = 0;
    var read:ReadReport = ReadReport();
    var daysArray:NSArray = [];
    //Add Back button
    var backButton:UIBarButtonItem = UIBarButtonItem();
    override func viewDidLoad() {
//        self.backButton = UIBarButtonItem(title: "Back", style: , target: <#AnyObject?#>, action: "back")
//        daysArray = read.getDays();
//        var dayValue:Data = daysArray.objectAtIndex(index) as! Data;
//        DayTF.text = dayValue.day;
//        StartLTF.text = dayValue.startlocation;
//        EndLTF.text = dayValue.endlocation;
//        SpeedTF.text = dayValue.speed;
//        lblDriverName.text = SelectDriverReportVC.holder.driverName;
//    }
//    func back() {
//        var goBack:DaysListTVC = UIStoryboard(name: "", bundle: nil)
    }
    
    
}