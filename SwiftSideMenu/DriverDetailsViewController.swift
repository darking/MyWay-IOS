//
//  DriverDetailsViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit

class DriverDetailsViewController: UIViewController {

    @IBOutlet weak var lblDtiverName: UILabel!
    var driverName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDtiverName.text = driverName
    }
}
