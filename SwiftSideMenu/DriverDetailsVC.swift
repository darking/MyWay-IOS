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
        var dayListVC:DaysListTVC = UIStoryboard(name: "Team5_m", bundle: nil).instantiateViewControllerWithIdentifier("DL") as! DaysListTVC;
        
        self.navigationController?.pushViewController(dayListVC, animated: true);
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDriverName.text = SelectDriverReportVC.holder.driverName;
    }
}