//
//  SelectDriverReportVC.swift
//  IOSProject
//
//  Created by trn22 on 8/20/15.
//  Copyright (c) 2015. All rights reserved.
//

import Foundation
import UIKit
class SelectDriverReportVC:UIViewController, ENSideMenuDelegate{
    @IBOutlet weak var nTF: UITextField!
    
    @IBOutlet weak var ChooseDateReportPiker: UIDatePicker!
    var read:ReadReport = ReadReport();
    var daysArray:NSArray = [];
    var index = 0;
    struct holder {
        static var driverName:String?;
    }
    
    @IBAction func toggleAction(sender: AnyObject) {
        toggleSideMenuView();
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        daysArray = read.getDays();
       
    }
    override func viewDidAppear(animated: Bool) {
         nTF.text = "\(holder.driverName)"
    }
    func dataPickerChanged(DatePiker:UIDatePicker) ->String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var strDate = "\(dateFormatter.stringFromDate(DatePiker.date))"
        return strDate;
        
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "viewDays" {
        var flag:Bool = false;
        var dayValue:Data = Data();
        var date:String = dataPickerChanged(ChooseDateReportPiker);
        for (var i = 0; i < daysArray.count; i++) {
            dayValue = daysArray.objectAtIndex(i) as! Data;
            if date == dayValue.day  {
                return true;
            }
        }
        if flag == false {
            var alert : UIAlertView = UIAlertView(title: "ALERT!!", message: "The Day that you have choosen is Invalid Choose Again",
                delegate: nil, cancelButtonTitle: "OK");
            alert.show();
            return false;
            }

        }else {
        return true;
    }
    }
}