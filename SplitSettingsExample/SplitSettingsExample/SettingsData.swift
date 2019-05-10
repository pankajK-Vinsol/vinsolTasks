//
//  SettingsData.swift
//  SplitSettingsExample
//
//  Created by Pankaj kumar on 01/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import Foundation

struct SettingsData {
    
    let defaults: UserDefaults = UserDefaults.standard
    
    var airplaneMode: Bool? {
        get {
            guard let airplane = defaults.object(forKey: "airplaneMode") as? Bool else {
                return nil
            }
            return airplane
        }
        set {
            defaults.set(newValue, forKey: "airplaneMode")
            defaults.synchronize()
        }
    }
    
    var wifiState: Bool? {
        get {
            guard let wifi = defaults.object(forKey: "wifiState") as? Bool else {
                return nil
            }
            return wifi
        }
        set {
            defaults.set(newValue, forKey: "wifiState")
            defaults.synchronize()
        }
    }
    
    var wifiName: String? {
        get {
            guard let wifiName = defaults.object(forKey: "wifiName") as? String else {
                return nil
            }
            return wifiName
        }
        set {
            defaults.set(newValue, forKey: "wifiName")
            defaults.synchronize()
        }
    }
    
    var bluetooth: Bool? {
        get {
            guard let bluetooth = defaults.object(forKey: "bluetooth") as? Bool else {
                return nil
            }
            return bluetooth
        }
        set {
            defaults.set(newValue, forKey: "bluetooth")
            defaults.synchronize()
        }
    }
    
    var mobileData: Bool? {
        get {
            guard let mobileData = defaults.object(forKey: "mobileData") as? Bool else {
                return nil
            }
            return mobileData
        }
        set {
            defaults.set(newValue, forKey: "mobileData")
            defaults.synchronize()
        }
    }
    
    var notificationState: Bool? {
        get {
            guard let notificationState = defaults.object(forKey: "notificationState") as? Bool else {
                return nil
            }
            return notificationState
        }
        set {
            defaults.set(newValue, forKey: "notificationState")
            defaults.synchronize()
        }
    }
    
    var dnd: Bool? {
        get {
            guard let dnd = defaults.object(forKey: "dnd") as? Bool else {
                return nil
            }
            return dnd
        }
        set {
            defaults.set(newValue, forKey: "dnd")
            defaults.synchronize()
        }
    }
    
    var networkName: String? {
        get {
            guard let networkName = defaults.object(forKey: "networkName") as? String else {
                return nil
            }
            return networkName
        }
        set {
            defaults.set(newValue, forKey: "networkName")
            defaults.synchronize()
        }
    }
}
