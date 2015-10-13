//
//  DriverReportCustomTVC.swift
//  SwiftSideMenu
//
//  Created by Adnan Alqazwini on 10/1/15.
//
//

import UIKit

class DriverReportCustomTVC: UITableViewCell {

    @IBOutlet weak var reportImage: UIImageView!;
    @IBOutlet weak var reportReason: UILabel!;
    @IBOutlet weak var reportDate: UILabel!;
    @IBOutlet weak var reportTime: UILabel!;
    
    @IBOutlet weak var reportLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
