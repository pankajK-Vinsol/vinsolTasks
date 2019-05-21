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
    
    var indexTag = "Airplane Mode"
    private var defaults = UserDefaults.standard
    var detailsArray = [[String]]()
    
    private let footerDnd = "When Do Not Disturb is enabled, calls and alerts that arrived will be silenced, and a moon icon will appear in the status bar."
    private let footerCellularData = "Turn Off Cellular data to restrict all data to Wi-Fi, including email, web browsing and push notifications."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setViewOnDidLoad()
        self.navigationItem.title = indexTag
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("settingsChange"), object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var detailItem: String? {
        didSet {
            self.configureView()
        }
    }
    
    private func setViewOnDidLoad() {
        detailsTableView.register(UINib(nibName: "SettingsSectionHeader", bundle: nil), forCellReuseIdentifier: "SettingsSectionHeader")
        detailsTableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
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
        return detailsArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSectionHeader") as! SettingsSectionHeader
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DNDSettingsFooter") as! DNDSettingsFooter
        var footerText: String {
            switch indexTag {
            case "Do Not Disturb":
                return footerDnd
            case "Mobile Data":
                return footerCellularData
            default:
                return ""
            }
        }
        cell.setFooterText(data: footerText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if indexTag == "Do Not Disturb" || indexTag == "Mobile Data"{
            return 100.0
        } else if section == detailsArray.count - 1 {
            return 1.0
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.selectionStyle = .none
        cell.hideArrow(isArrow: true, isDetail: true)
        cell.setColorViewWidth(value: 0.0)
        cell.setTextString(text: detailsArray[indexPath.section][indexPath.row], type: 1)
        
        let cell2 : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell2.textLabel?.text = detailsArray[indexPath.section][indexPath.row]
        cell2.textLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        cell2.selectionStyle = .none
        
        switch indexTag {
        case "Wi-Fi":
            if indexPath.section == 0 {
                let wifiValue = defaults.bool(forKey: "wifiState")
                cell.setToggleValue(value: wifiValue)
                cell.toggleAction = { [unowned self] in
                    self.defaults.set(!wifiValue, forKey: "wifiState")
                }
            } else if indexPath.section == 1 {
                if detailsArray[indexPath.section][indexPath.row] == defaults.string(forKey: "wifiName") {
                    cell2.accessoryType = UITableViewCell.AccessoryType.checkmark
                }
                return cell2
            }
        case "Bluetooth":
            let bluetoothValue = defaults.bool(forKey: "bluetooth")
            cell.setToggleValue(value: bluetoothValue)
            cell.toggleAction = { [unowned self] in
                self.defaults.set(!bluetoothValue, forKey: "bluetooth")
            }
        case "Mobile Data":
            if indexPath.row == 0 {
                let mobileDataValue = defaults.bool(forKey: "mobileData")
                cell.setToggleValue(value: mobileDataValue)
                cell.toggleAction = { [unowned self] in
                    self.defaults.set(!mobileDataValue, forKey: "mobileData")
                }
            } else {
                cell.hideArrow(isArrow: false, isDetail: false)
                cell.setTextString(text: "Roaming On", type: 2)
            }
        case "Notifications":
            let notifyValue = defaults.bool(forKey: "notificationState")
            cell.setToggleValue(value: notifyValue)
            cell.toggleAction = { [unowned self] in
                self.defaults.set(!notifyValue, forKey: "notificationState")
            }
        case "Do Not Disturb":
            let dndValue = defaults.bool(forKey: "dnd")
            cell.setToggleValue(value: dndValue)
            cell.toggleAction = { [unowned self] in
                self.defaults.set(!dndValue, forKey: "dnd")
            }
        case "Display & Brightness":
            cell.hideArrow(isArrow: false, isDetail: false)
            if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.setTextString(text: "On", type: 2)
                }
            } else if indexPath.section == 2 {
                if indexPath.row == 0 {
                    cell.setTextString(text: "Medium", type: 2)
                } else {
                    cell.setTextString(text: "Enabled", type: 2)
                }
            }
        case "General", "Wallpaper":
            cell.hideArrow(isArrow: false, isDetail: true)
        case "Carrier":
            if detailsArray[indexPath.section][indexPath.row] == defaults.string(forKey: "networkName") {
                cell2.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
            return cell2
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexTag == "Wi-Fi" {
            if indexPath.section == 1 {
                let wifiValue = defaults.bool(forKey: "wifiState")
                if wifiValue {
                    defaults.set(detailsArray[indexPath.section][indexPath.row], forKey: "wifiName")
                } else {
                    defaults.set("", forKey: "wifiName")
                }
                self.navigationController?.popViewController(animated: true)
            }
        } else if indexTag == "Carrier" {
            defaults.set(detailsArray[indexPath.section][indexPath.row], forKey: "networkName")
            self.navigationController?.popViewController(animated: true)
        }
        self.detailsTableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settingsChange"), object: nil)
    }

}

