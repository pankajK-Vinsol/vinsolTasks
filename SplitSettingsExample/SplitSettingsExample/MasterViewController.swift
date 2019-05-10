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
    private let settings = SettingsData()
    
    private let settingsArray = [["Airplane Mode", "Wi-Fi", "Bluetooth", "Mobile Data", "Carrier"],
    ["Notifications", "Do Not Disturb"], ["General", "Wallpaper", "Display & Brightness"]]
    
    private let tableData = ["Airplane Mode", "Wi-Fi", "Bluetooth", "Mobile Data", "Carrier",
    "Notifications", "Do Not Disturb", "General", "Wallpaper", "Display & Brightness"]
    
    private var filteredTableData = [String]()
    private var resultSearchController = UISearchController()
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSplitView()
        setViewOnDidLoad()
        setSearchController()
        notificationObserver()
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
    
    private func setSplitView() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            split.preferredDisplayMode = .allVisible
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    private func setViewOnDidLoad() {
        tableView.register(UINib(nibName: "SettingsHeaderView", bundle: nil), forCellReuseIdentifier: "SettingsHeaderView")
        tableView.register(UINib(nibName: "SettingsSectionHeader", bundle: nil), forCellReuseIdentifier: "SettingsSectionHeader")
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    private func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(valuesEdited), name: NSNotification.Name("settingsChange"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("settingsChange"), object: nil)
    }
    
}

//MARK: table view functions
extension MasterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if resultSearchController.isActive {
            return 1
        }
        return 3
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
        } else {
            return settingsArray[section].count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.selectionStyle = .none
        
        var viewColor = UIColor()
        if indexPath.row % 3 == 2 {
            viewColor = UIColor(red: 253.0/255, green: 149.0/255, blue: 38.0/255, alpha: 1.0)
        } else if indexPath.row % 3 == 1 {
            viewColor = UIColor(red: 21.0/255, green: 122.0/255, blue: 251.0/255, alpha: 1.0)
        } else {
            viewColor = UIColor(red: 251.0/255, green: 58.0/255, blue: 48.0/255, alpha: 1.0)
        }
        
        cell.setBackgroundColor(color: viewColor)
        cell.hideAndShowItems(isColorView: false, isArrow: false, isDetail: true, isToggle: true)
        cell.setColorViewWidth(value: 36.0)
        
        if resultSearchController.isActive {
            cell.setTitleText(text: filteredTableData[indexPath.row])
            return cell
        } else {
            let titleText = settingsArray[indexPath.section][indexPath.row]
            cell.setTitleText(text: titleText)
            
            if indexPath.section == 0 {
                if indexPath.row == 3 {
                    cell.hideAndShowItems(isColorView: false, isArrow: false, isDetail: true, isToggle: true)
                } else {
                    cell.hideAndShowItems(isColorView: false, isArrow: false, isDetail: false, isToggle: true)
                }
                if indexPath.row == 0 {
                    cell.hideAndShowItems(isColorView: false, isArrow: true, isDetail: true, isToggle: false)
                    
                    let airplaneValue = settings.airplaneMode ?? false
                    cell.setToggleValue(value: settings.airplaneMode ?? false)
                    
                    cell.toggleAction = { [self] in
                        self.settings.defaults.set(!airplaneValue, forKey: "airplaneMode")
                    }
                }
                if indexPath.row == 1 {
                    let wifiValue = settings.wifiState ?? false
                    if wifiValue {
                        cell.setDetailText(text: settings.wifiName ?? "")
                    } else {
                        cell.setDetailText(text: "")
                    }
                }
                if indexPath.row == 2 {
                    let bluetooth = settings.bluetooth ?? false
                    if bluetooth {
                        cell.setDetailText(text: "On")
                    } else {
                        cell.setDetailText(text: "Off")
                    }
                }
                if indexPath.row == 4 {
                    cell.setDetailText(text: settings.networkName ?? "")
                }
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let splitView = self.splitViewController else {
            return
        }
 
        if splitView.isCollapsed {
            let nextVC: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            if (resultSearchController.isActive) {
                nextVC.indexTag = filteredTableData[indexPath.row]
            } else {
                nextVC.indexTag = settingsArray[indexPath.section][indexPath.row]
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            if (detailViewController != nil) {
                if (resultSearchController.isActive) {
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
