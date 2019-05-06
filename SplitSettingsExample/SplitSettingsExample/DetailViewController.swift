//
//  DetailViewController.swift
//  SplitSettingsExample
//
//  Created by Pankaj kumar on 01/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak private var detailsTableView: UITableView!
    
    var indexTag = "Wi-Fi"
    private let settings = settingsData()
    
    private let networkArray = ["Network1", "Network2", "Network3", "Network4", "Network5"]
    private let carrierArray = ["Carrier1", "Carrier2", "Carrier3", "Carrier4", "Carrier5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setViewOnDidLoad()
        self.navigationItem.title = indexTag
    }
    
    var detailItem: String? {
        didSet {
            self.configureView()
        }
    }
    
    private func setViewOnDidLoad() {
        detailsTableView.register(UINib(nibName: "SettingsHeaderView", bundle: nil), forCellReuseIdentifier: "SettingsHeaderView")
        detailsTableView.register(UINib(nibName: "SettingsSectionHeader", bundle: nil), forCellReuseIdentifier: "SettingsSectionHeader")
        detailsTableView.register(UINib(nibName: "SettingsRowView", bundle: nil), forCellReuseIdentifier: "SettingsRowView")
        detailsTableView.register(UINib(nibName: "DNDSettingsFooter", bundle: nil), forCellReuseIdentifier: "DNDSettingsFooter")
    }
    
    private func configureView() {
        if let detail = self.detailItem {
            indexTag = detail
            self.navigationItem.title = indexTag
            self.detailsTableView.reloadData()
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if indexTag == "Airplane Mode"{
            return 0
        }
        if indexTag == "Wi-Fi" {
            return 2
        }
        if indexTag == "Display & Brightness" {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSectionHeader") as! SettingsSectionHeader
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DNDSettingsFooter") as! DNDSettingsFooter
        var footerText = String()
        if indexTag == "Do Not Disturb" {
            footerText = "When Do Not Disturb is enabled, calls and alerts that arrived will be silenced, and a moon icon will appear in the status bar."
        }
        else if indexTag == "Mobile Data"{
            footerText = "Turn Off Cellular data to restrict all data to Wi-Fi, including email, web browsing and push notifications."
        } else {
            footerText = ""
        }
        cell.setFooterText(data: footerText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if indexTag == "Do Not Disturb" || indexTag == "Mobile Data"{
            return 100.0
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if indexTag == "Wi-Fi" {
            if section == 0 {
                return 1
            }
            return 5
        }
        if indexTag == "Display & Brightness" {
            if section == 0 || section == 3 {
                return 1
            }
            return 2
        }
        if indexTag == "Mobile Data" {
            return 2
        }
        if indexTag == "Carrier" {
            return 5
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "SettingsRowView", for: indexPath) as! SettingsRowView
        cell.selectionStyle = .none
        
        cell.hideAndShowItems(isColorView: true, isArrow: true, isDetail: true, isToggle: false)
        cell.setColorViewWidth(value: 0.0)

        if indexTag == "Wi-Fi" {
            if indexPath.section == 0 {
                cell.setTitleText(text: "Wi-Fi")
                let wifiValue = settings.wifiState ?? false
                cell.setToggleValue(value: wifiValue)
                cell.toggleAction = { [self] in
                    self.settings.defaults.set(!wifiValue, forKey: "wifiState")
                }
            } else if indexPath.section == 1 {
                cell.hideAndShowItems(isColorView: true, isArrow: false, isDetail: true, isToggle: true)
                cell.setTitleText(text: networkArray[indexPath.row])
            }
        }
        if indexTag == "Bluetooth" {
            cell.setTitleText(text: "Bluetooth")
            let bluetoothValue = settings.bluetooth ?? false
            cell.setToggleValue(value: bluetoothValue)
            cell.toggleAction = { [self] in
                self.settings.defaults.set(!bluetoothValue, forKey: "bluetooth")
            }
        }
        if indexTag == "Mobile Data" {
            if indexPath.row == 0 {
                cell.setTitleText(text: "Cellular Data")
                let mobileDataValue = settings.mobileData ?? false
                cell.setToggleValue(value: mobileDataValue)
                cell.toggleAction = { [self] in
                    self.settings.defaults.set(!mobileDataValue, forKey: "mobileData")
                }
            } else {
                cell.setTitleText(text: "Cellular Data Options")
                cell.hideAndShowItems(isColorView: true, isArrow: false, isDetail: false, isToggle: true)
                cell.setDetailText(text: "Roaming On")
            }
        }
        if indexTag == "Carrier" {
            cell.hideAndShowItems(isColorView: true, isArrow: false, isDetail: true, isToggle: true)
            cell.setTitleText(text: carrierArray[indexPath.row])
        }
        if indexTag == "Notifications" {
            cell.setTitleText(text: "Notifications")
            let notifyValue = settings.notificationState ?? false
            cell.setToggleValue(value: notifyValue)
            cell.toggleAction = { [self] in
                self.settings.defaults.set(!notifyValue, forKey: "notificationState")
            }
        }
        if indexTag == "Do Not Disturb" {
            cell.setTitleText(text: "Do Not Disturb")
            let dndValue = settings.dnd ?? false
            cell.setToggleValue(value: dndValue)
            cell.toggleAction = { [self] in
                self.settings.defaults.set(!dndValue, forKey: "dnd")
            }
        }
        if indexTag == "General" {
            cell.hideAndShowItems(isColorView: true, isArrow: true, isDetail: true, isToggle: true)
            cell.setTitleText(text: "This is general screen")
        }
        if indexTag == "Wallpaper" {
            cell.hideAndShowItems(isColorView: true, isArrow: true, isDetail: true, isToggle: true)
            cell.setTitleText(text: "This is wallpaper screen")
        }
        if indexTag == "Display & Brightness" {
            if indexPath.section == 0 {
                cell.setTitleText(text: "Brightness")
            }
            if indexPath.section == 1 {
                cell.hideAndShowItems(isColorView: true, isArrow: false, isDetail: false, isToggle: true)
                if indexPath.row == 0 {
                    cell.setTitleText(text: "Night-Shift")
                    cell.setDetailText(text: "On")
                }
                if indexPath.row == 1 {
                    cell.setTitleText(text: "Auto-Lock")
                    cell.setDetailText(text: "Auto-Lock")
                }
            }
            if indexPath.section == 2 {
                if indexPath.row == 0 {
                    cell.setTitleText(text: "Text Size")
                    cell.hideAndShowItems(isColorView: true, isArrow: false, isDetail: true, isToggle: true)
                }
                if indexPath.row == 1 {
                    cell.setTitleText(text: "Bold Text")
                }
            }
            if indexPath.section == 3 {
                cell.setDetailText(text: "Standard")
                cell.setTitleText(text: "View")
                cell.hideAndShowItems(isColorView: true, isArrow: false, isDetail: false, isToggle: true)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexTag == "Wi-Fi" {
            if indexPath.section == 1 {
                settings.defaults.set(networkArray[indexPath.row], forKey: "wifiName")
            }
        }
        if indexTag == "Carrier" {
            settings.defaults.set(carrierArray[indexPath.row], forKey: "networkName")
        }

        //MARK: user changes settings notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settingsChange"), object: nil)
    }

}

