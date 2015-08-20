//
//  DriversListViewController.swift
//  MyWay-IOS
//
//  Created by Zainab H J on 8/14/15.
//  Copyright (c) 2015 PIFSS. All rights reserved.
//

import UIKit

class DriversListViewController: UIViewController , UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var userName = ""
    var drivers:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("drivers", ofType: "plist")
        let data = NSDictionary(contentsOfFile: path!)!
        drivers = data[userName] as! [String]
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("c", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = drivers[indexPath.row]
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! DriverDetailsViewController
        let index = table.indexPathForSelectedRow()?.row
        if let ix = index {
            dest.driverName = drivers[ix]
        }
    }
}
