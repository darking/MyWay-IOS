//
//  DriverDetailsViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit

class DriverDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblDriverName: UILabel!
    var driverName = "";
    
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var reportsTable: UITableView!
    @IBOutlet weak var lblDriverLocation: UILabel!
    @IBOutlet weak var lblBatteryStatus: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "DriverReportCustomCell", bundle: nil);
        var reportTableView:UITableView!;
        self.reportsTable.registerNib(nib, forCellReuseIdentifier: "reportCustomCell");
        lblDriverName.text = SelectDriverReportVC.holder.driverName;
        driverImage.image = UIImage.self(named: "chauffer.png");
        //if drivers gps is off then:
        lblDriverLocation.text = "GPS Currently off!";
        lblDriverLocation.sizeToFit();
        // else
        // getLocation from web services
        //Read battery percntage from driver's phone
        lblBatteryStatus.text = "50%";
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DriverReportCustomTVC =  self.reportsTable.dequeueReusableCellWithIdentifier("reportCustomCell")  as! DriverReportCustomTVC;
        cell.imageView?.image = UIImage(named: "chauffer.png");
        
        return cell;
    }
    
   
}