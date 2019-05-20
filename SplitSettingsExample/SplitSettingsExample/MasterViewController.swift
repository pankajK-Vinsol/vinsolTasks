//
//  MasterViewController.swift
//  SplitSettingsExample
//
//  Created by Pankaj kumar on 01/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UISearchResultsUpdating {

    private var detailViewController: DetailViewController? = nil
    private var defaults = UserDefaults.standard
    
    private let settingsArray = [["Airplane Mode", "Wi-Fi", "Bluetooth", "Mobile Data", "Carrier"],
    ["Notifications", "Do Not Disturb"], ["General", "Wallpaper", "Display & Brightness"]]
    
    private let tableData = ["Airplane Mode", "Wi-Fi", "Bluetooth", "Mobile Data", "Carrier",
    "Notifications", "Do Not Disturb", "General", "Wallpaper", "Display & Brightness"]
    
    private let settingsDictionaryData = [["Airplane Mode": [[]], "Wi-Fi": [["Wi-Fi"],["Network1", "Network2", "Network3", "Network4", "Network5"]], "Bluetooth": [["Bluetooth"]], "Mobile Data": [["Cellular Data", "Cellular Data Options"]], "Carrier": [["Carrier1", "Carrier2", "Carrier3", "Carrier4", "Carrier5"]]], ["Notifications": [["Notifications"]], "Do Not Disturb": [["Do Not Disturb"]]], ["General": [["This is general screen"]], "Wallpaper": [["This is wallpaper screen"]], "Display & Brightness": [["Brightness"], ["Night-Shift", "Auto-Lock"], ["Text-Size", "Bold Text"], ["View"]]]]
    
    private var filteredTableData = [String]()
    private var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewOnDidLoad()
        setSplitView()
        setSearchController()
    }
    
    private func setViewOnDidLoad() {
        tableView.register(UINib(nibName: "SettingsHeaderView", bundle: nil), forCellReuseIdentifier: "SettingsHeaderView")
        tableView.register(UINib(nibName: "SettingsSectionHeader", bundle: nil), forCellReuseIdentifier: "SettingsSectionHeader")
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        notificationObserver()
    }
    
    private func setSplitView() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            split.preferredDisplayMode = .allVisible
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    private func setSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.placeholder = "Settings"
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        tableView.reloadData()
    }
    
    private func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(valuesEdited), name: NSNotification.Name("settingsChange"), object: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.tableView.reloadData()
    }
}

//MARK: table view functions
extension MasterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if resultSearchController.isActive {
            return 1
        }
        return settingsArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if resultSearchController.isActive {
            return nil
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSectionHeader") as! SettingsSectionHeader
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if resultSearchController.isActive {
            return 0
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  resultSearchController.isActive {
            return filteredTableData.count
        }
        return settingsArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.selectionStyle = .none
        
        let remainder = indexPath.row % 3
        cell.setBackgroundColor(remainder: remainder)
        cell.hideArrow(isArrow: false, isDetail: true)
        cell.setColorViewWidth(value: 36.0)
        
        if resultSearchController.isActive {
            cell.setTextString(text: filteredTableData[indexPath.row], type: 1)
            return cell
        } else {
            let titleText = settingsArray[indexPath.section][indexPath.row]
            cell.setTextString(text: titleText, type: 1)
            
            if indexPath.section == 0 {
                cell.hideArrow(isArrow: false, isDetail: false)
                switch indexPath.row {
                case 0:
                    cell.hideArrow(isArrow: true, isDetail: true)
                    let airplaneValue = defaults.bool(forKey: "airplaneMode")
                    cell.setToggleValue(value: airplaneValue)
                    cell.toggleAction = { [unowned self] in
                        self.defaults.set(!airplaneValue, forKey: "airplaneMode")
                    }
                case 1:
                    let wifiName = defaults.string(forKey: "wifiName") ?? ""
                    cell.setTextString(text: wifiName, type: 2)
                case 2:
                    let bluetooth = defaults.bool(forKey: "bluetooth")
                    if bluetooth {
                        cell.setTextString(text: "On", type: 2)
                    } else {
                        cell.setTextString(text: "Off", type: 2)
                    }
                case 4:
                    let networkName = defaults.string(forKey: "networkName") ?? ""
                    cell.setTextString(text: networkName, type: 2)
                default:
                    break
                }
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let splitView = self.splitViewController else {
            return
        }
        
        let nextVC: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if resultSearchController.isActive {
            nextVC.indexTag = filteredTableData[indexPath.row]
        } else {
            nextVC.indexTag = settingsArray[indexPath.section][indexPath.row]
        }
        
        var matchedData = [[String]]()
        for settingsData in settingsDictionaryData {
            for settingsKey in settingsData.keys {
                if settingsKey == nextVC.indexTag {
                    matchedData = settingsData.first(where: { $0.key == nextVC.indexTag })?.value ?? [[String]]()
                }
            }
        }
        
        if splitView.isCollapsed {
            nextVC.detailsArray = matchedData
            if !matchedData[0].isEmpty {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else {
            if detailViewController != nil {
                self.detailViewController?.detailsArray = matchedData
                if resultSearchController.isActive {
                    self.detailViewController?.detailItem = filteredTableData[indexPath.row]
                } else {
                    self.detailViewController?.detailItem = settingsArray[indexPath.section][indexPath.row]
                }
            }
        }
    }
}

extension MasterViewController {
    //MARK: value changed notification action
    @objc private func valuesEdited(notification: NSNotification) {
        tableView.reloadData()
    }
}
