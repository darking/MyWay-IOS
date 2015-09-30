//
//  AppSettings.swift
//  MyWay
//
//  Created by Adnan Alqazwini on 8/13/15.
//  Copyright (c) 2015 AdnanQaz. All rights reserved.
//

import Foundation


class AppSettings {
//    private var voice:Bool?;
//    private var voiceLanguage:String?;
//    private var nearbyPOI:Bool?;
//    private var overSpeed:Bool?;
    
    let settings = NSUserDefaults.standardUserDefaults();
    func getReports() -> Bool {
        return settings.boolForKey("reportNotification");
    }
    func setReports(report:Bool) {
        settings.setBool(report, forKey: "reportNotification");
    }
    func getVoice() ->Bool {
        return settings.boolForKey("voiceNotification");
    }
    func setVoice(voice:Bool) {
        
        settings.setBool(voice, forKey: "voiceNotification");
    }
    func getVoiceLanguage() ->String {
        if settings.stringForKey("voiceLanguage") == nil {
            return "Value not set yet!";
        }
        return settings.stringForKey("voiceLanguage")!;
    }
    func setVoiceLanguage(voiceLanguage:String) {
        settings.setValue(voiceLanguage, forKey: "voiceLanguage");
    }
    func getNearbyPOI() ->Bool {
        return settings.boolForKey("nearbyPOI");
    }
    func setNearbyPOI(nearbyPOI:Bool) {
        settings.setBool(nearbyPOI, forKey: "nearbyPOI");
    }
    func getOverspeed() ->Bool {
        return settings.boolForKey("overspeed");
    }
    func setOverspeed(overspeed:Bool) {
        settings.setBool(overspeed, forKey: "overspeed")
    }
    func getLoggedIn() ->Bool {
        return settings.boolForKey("loggedIn");
    }
    func setLoggedIn(loggedIn:Bool) {
        settings.setBool(loggedIn, forKey: "loggedIn");
        
    }
}