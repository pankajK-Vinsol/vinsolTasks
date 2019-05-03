//
//  DetailViewController.swift
//  SplitSettingsExample
//
//  Created by Pankaj kumar on 01/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    var indexTag: String = "11"
    var pageTitle = ""
    let settings = settingsData()
    
    let networkArray = ["Network1", "Network2", "Network3", "Network4", "Network5"]
    let carrierArray = ["Carrier1", "Carrier2", "Carrier3", "Carrier4", "Carrier5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setViewOnDidLoad()
    }
    
    var detailItem: String? {
        didSet {
            self.configureView()
        }
    }
    
    func setViewOnDidLoad() {
        detailsTableView.register(UINib(nibName: "SettingsHeaderView", bundle: nil), forCellReuseIdentifier: "SettingsHeaderView")
        detailsTableView.register(UINib(nibName: "SettingsSectionHeader", bundle: nil), forCellReuseIdentifier: "SettingsSectionHeader")
        detailsTableView.register(UINib(nibName: "SettingsRowView", bundle: nil), forCellReuseIdentifier: "SettingsRowView")
        detailsTableView.register(UINib(nibName: "DNDSettingsFooter", bundle: nil), forCellReuseIdentifier: "DNDSettingsFooter")
    }
    
    func configureView() {
        self.navigationItem.title = pageTitle
        if let detail = self.detailItem {
            indexTag = detail
            self.detailsTableView.reloadData()
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if indexTag == "10" || indexTag == "00"{
            return 0
        }
        if indexTag == "11" {
            return 2
        }
        if indexTag == "32" {
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
        if indexTag == "21" {
            cell.footerLabel.text = "When Do Not Disturb is enabled, calls and alerts that arrived will be silenced, and a moon icon will appear in the status bar."
        }
        else if indexTag == "13"{
            cell.footerLabel.text = "Turn Off Cellular data to restrict all data to Wi-Fi, including email, web browsing and push notifications."
        } else {
            cell.footerLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if indexTag == "21" || indexTag == "13"{
            return 100.0
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if indexTag == "11" {
            if section == 0 {
                return 1
            }
            return 5
        }
        if indexTag == "32" {
            if section == 0 || section == 3{
                return 1
            }
            return 2
        }
        if indexTag == "13" {
            return 2
        }
        if indexTag == "14" {
            return 5
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "SettingsRowView", for: indexPath) as! SettingsRowView
        cell.selectionStyle = .none
        
        cell.colorViewWidth.constant = 0.0
        cell.roundedView.isHidden = true
        cell.toggleOption.isHidden = false
        cell.arrow.isHidden = true
        cell.detail.isHidden = true
        
        if indexTag == "11" {
            if indexPath.section == 0 {
                cell.title.text = "Wi-Fi"
                cell.toggleOption.setOn(settings.wifiState ?? false, animated: true)
            } else if indexPath.section == 1 {
                cell.toggleOption.isHidden = true
                cell.arrow.isHidden = false
                cell.title.text = networkArray[indexPath.row]
            }
        }
        if indexTag == "12" {
            cell.title.text = "Bluetooth"
            cell.toggleOption.setOn(settings.bluetooth ?? false, animated: true)
        }
        if indexTag == "13" {
            if indexPath.row == 0 {
                cell.title.text = "Cellular Data"
                cell.toggleOption.setOn(settings.mobileData ?? false, animated: true)
            } else {
                cell.title.text = "Cellular Data Options"
                cell.toggleOption.isHidden = true
                cell.arrow.isHidden = false
                cell.detail.isHidden = false
                cell.detail.text = "Roaming On"
            }
        }
        if indexTag == "14" {
            cell.toggleOption.isHidden = true
            cell.arrow.isHidden = false
            cell.title.text = carrierArray[indexPath.row]
        }
        if indexTag == "20" {
            cell.title.text = "Notifications"
            cell.toggleOption.setOn(settings.notificationState ?? false, animated: true)
        }
        if indexTag == "21" {
            cell.title.text = "Do Not Disturb"
            cell.toggleOption.setOn(settings.dnd ?? false, animated: true)
        }
        if indexTag == "30" {
            cell.toggleOption.isHidden = true
            cell.title.text = "This is general screen"
        }
        if indexTag == "31" {
            cell.toggleOption.isHidden = true
            cell.title.text = "This is wallpaper screen"
        }
        if indexTag == "32" {
            if indexPath.section == 0 {
                cell.title.text = "Brightness"
            }
            if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.toggleOption.isHidden = true
                    cell.arrow.isHidden = false
                    cell.title.text = "Night-Shift"
                    cell.detail.isHidden = true
                    cell.detail.text = "On"
                }
                if indexPath.row == 1 {
                    cell.toggleOption.isHidden = true
                    cell.arrow.isHidden = false
                    cell.title.text = "Auto-Lock"
                    cell.detail.isHidden = true
                    cell.detail.text = "5 minutes"
                }
            }
            if indexPath.section == 2 {
                if indexPath.row == 0 {
                    cell.toggleOption.isHidden = true
                    cell.arrow.isHidden = false
                    cell.title.text = "Text Size"
                }
                if indexPath.row == 1 {
                    cell.title.text = "Bold Text"
                }
            }
            if indexPath.section == 3 {
                cell.toggleOption.isHidden = true
                cell.arrow.isHidden = false
                cell.title.text = "View"
                cell.detail.isHidden = true
                cell.detail.text = "Standard"
            }
        }
        cell.toggleOption.addTarget(self, action: #selector(setValues(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexTag == "11" {
            if indexPath.section == 1 {
                settings.defaults.set(networkArray[indexPath.row], forKey: "wifiName")
            }
        }
        if indexTag == "14" {
            settings.defaults.set(carrierArray[indexPath.row], forKey: "networkName")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settingsChange"), object: nil)
    }

}

@objc extension DetailViewController {
    func setValues(_ sender: UISwitch) {
        if indexTag == "11" {
            if sender.isOn {
                settings.defaults.set(true, forKey: "wifiState")
            } else {
                settings.defaults.set(false, forKey: "wifiState")
            }
        }
        if indexTag == "12" {
            if sender.isOn {
                settings.defaults.set(true, forKey: "bluetooth")
            } else {
                settings.defaults.set(false, forKey: "bluetooth")
            }
        }
        if indexTag == "13" {
            if sender.isOn {
                settings.defaults.set(true, forKey: "mobileData")
            } else {
                settings.defaults.set(false, forKey: "mobileData")
            }
        }
        if indexTag == "20" {
            if sender.isOn {
                settings.defaults.set(true, forKey: "notificationState")
            } else {
                settings.defaults.set(false, forKey: "notificationState")
            }
        }
        if indexTag == "21" {
            if sender.isOn {
                settings.defaults.set(true, forKey: "dnd")
            } else {
                settings.defaults.set(false, forKey: "dnd")
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settingsChange"), object: nil)
    }
}
