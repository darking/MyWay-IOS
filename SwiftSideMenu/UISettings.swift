//
//  UISettings.swift
//  MyWay
//
//  Created by Adnan Alqazwini on 8/13/15.
//  Copyright (c) 2015 AdnanQaz. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
class UISettings : UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, ENSideMenuDelegate {
    var appSettings:AppSettings = AppSettings();
    
    @IBOutlet weak var chkReport: UISwitch!
    @IBOutlet weak var lblDoneButton: UIButton!
    @IBOutlet weak var lblVoiceLanguage: UILabel!
    @IBOutlet weak var lblChangeButton: UIButton!
    @IBOutlet weak var pckLanguage: UIPickerView!
    @IBOutlet weak var voiceStatus: UISwitch!
    @IBOutlet weak var chkNearbyPOI: UISwitch!
    @IBOutlet weak var chkOverspeed: UISwitch!
    @IBOutlet weak var voiceNotification: UISwitch!
    @IBAction func btnChange(sender: AnyObject) {
        pckLanguage.hidden = false;
        lblDoneButton.hidden = false;
    }
    @IBOutlet weak var showMenu: UIBarButtonItem!
    @IBAction func showMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    @IBAction func chkReports(sender: AnyObject) {
        if chkReport.on == true {
            appSettings.setReports(true);
        } else {
            appSettings.setReports(false);
        }
    }
    @IBAction func chkVoice(sender: AnyObject) {
        changeVoiceSwitch(voiceStatus);
    }
    
    @IBAction func btnDone(sender: AnyObject) {
        pckLanguage.hidden = true;
        lblDoneButton.hidden = true;
        appSettings.setVoiceLanguage(selectedLang!);
        lblVoiceLanguage.text = appSettings.getVoiceLanguage();
    }
    @IBAction func chkNearbyPOI(sender: AnyObject) {
        if chkNearbyPOI.on == true {
            appSettings.setNearbyPOI(true);
        } else {
            appSettings.setNearbyPOI(false);
        }
    }
    @IBAction func chkOverspeed(sender: AnyObject) {
        if chkOverspeed.on == true {
            appSettings.setOverspeed(true);
        } else {
            appSettings.setOverspeed(false);
        }
    }
    var selectedLang:String?;
    var language:[String] = ["العربية","English"];
    override func viewDidLoad() {
        super.viewDidLoad();
        //var motion:CMMotionManager = CMMotionManager();
        //motion.
        println("view did Load : \(appSettings.getVoiceLanguage())");
        pckLanguage.dataSource = self;
        pckLanguage.delegate = self;
        lblDoneButton.hidden = true;
        pckLanguage.hidden = true;
    
        if appSettings.getReports() == true {
            chkReport.on = true;
        } else {
            chkReport.on = false;
        }
        //voiceNotification.on = false;
        if appSettings.getVoice() == true {
            voiceStatus.on = true;
            lblVoiceLanguage.text = appSettings.getVoiceLanguage();
            lblChangeButton.hidden = false;
        } else {
            voiceStatus.on = false;
            lblVoiceLanguage.hidden = true;
            lblChangeButton.hidden = true;
        }
        if appSettings.getNearbyPOI() == true {
            chkNearbyPOI.on = true;
        } else {
            chkNearbyPOI.on = false;
        }
        if appSettings.getOverspeed() == true {
            chkOverspeed.on = true;
        } else {
            chkOverspeed.on = false;
        }
    }
    func changeVoiceSwitch(voiceSwitch:UISwitch) {
        if voiceSwitch.on {
            lblChangeButton.hidden = false;
            lblVoiceLanguage.hidden = false;
            lblVoiceLanguage.text = appSettings.getVoiceLanguage();
            appSettings.setVoice(true);
        } else {
            lblChangeButton.hidden = true;
            lblVoiceLanguage.hidden = true;
            appSettings.setVoice(false);
        }
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count;
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        selectedLang = language[row]
        return selectedLang;
    }
}