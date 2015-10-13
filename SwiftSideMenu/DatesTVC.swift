//
//  TableViewController.swift
//  DatePickerInStaticCell
//
//  Copyright (c) 2015 appswise.io All rights reserved.
//

import UIKit

class DatesTVC: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBAction func SetDatesButton(sender: AnyObject) {
        
     
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
    
    
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    var startDatePickerVisible = false
    var endDatePickerVisible = false
    var pickerViewVisible = false
    @IBOutlet weak var typeLabel: UILabel!
    var types = ["Business Trip","Personal Tour","Holiday"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    @IBAction func startDateChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        AddNewPOI.holder.startDate = dateFormatter.stringFromDate(sender.date)
//        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        startDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func endDateChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        AddNewPOI.holder.endDate = dateFormatter.stringFromDate(sender.date)
//        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        endDate.text = dateFormatter.stringFromDate(sender.date)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            startDatePickerVisible = !startDatePickerVisible
            tableView.reloadData()
        }
        if indexPath.row == 2 {
            endDatePickerVisible = !endDatePickerVisible
            tableView.reloadData()
        }
        if indexPath.row == 4{
            pickerViewVisible = !pickerViewVisible
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 {
            if !startDatePickerVisible  {
                return 0.0
            }
            return 165.0
        }else if indexPath.row == 3 {
            if !endDatePickerVisible  {
                return 0.0
            }
            return 165.0
            
        }else if indexPath.row == 5 {
            if !pickerViewVisible  {
                return 0.0
            }
            return 165.0
            
        }
        return 44.0
    }
    
    // MARK UIPickerView Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return types[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeLabel.text = types[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
}
