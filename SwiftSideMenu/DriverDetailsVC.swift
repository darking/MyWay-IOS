//
//  DriverDetailsViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit

class DriverDetailsVC: UIViewController {
    
    @IBOutlet weak var lblDriverName: UILabel!
    var driverName = "";
    
    @IBAction func btnViewReports(sender: AnyObject) {
        var dayListVC:DaysListTVC = UIStoryboard(name: "Main5_Report", bundle: nil).instantiateViewControllerWithIdentifier("DL") as! DaysListTVC;
        
        self.presentViewController(dayListVC, animated: true, completion: {});
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDriverName.text = SelectDriverReportVC.holder.driverName;
    }
}