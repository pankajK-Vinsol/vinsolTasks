//
//  MasterViewController.swift
//  SplitSettingsExample
//
//  Created by Pankaj kumar on 01/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    private var detailViewController: DetailViewController? = nil
    private let settings = settingsData()
    
    private let settingsArray = [[], ["Airplane Mode", "Wifi", "Bluetooth", "Mobile Data", "Carrier"],
    ["Notifications", "Do Not Disturb"], ["General", "Wallpaper", "Display & Brightness"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSplitView()
        setViewOnDidLoad()
        notificationObserver()
    }
    
    private func setSplitView() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            split.preferredDisplayMode = .allVisible
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    private func setViewOnDidLoad() {
        tableView.register(UINib(nibName: "SettingsHeaderView", bundle: nil), forCellReuseIdentifier: "SettingsHeaderView")
        tableView.register(UINib(nibName: "SettingsSectionHeader", bundle: nil), forCellReuseIdentifier: "SettingsSectionHeader")
        tableView.register(UINib(nibName: "SettingsRowView", bundle: nil), forCellReuseIdentifier: "SettingsRowView")
    }
    
    private func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(valuesEdited), name: NSNotification.Name("settingsChange"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if self.tableView.indexPathForSelectedRow != nil {
                let controller = (segue.destination as! UINavigationController).topViewController
                    as! DetailViewController
                
                controller.detailItem  = "\(String(describing: self.tableView.indexPathForSelectedRow?.section))\(String(describing: self.tableView.indexPathForSelectedRow?.row))"
                controller.navigationItem.leftBarButtonItem =
                    splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton
                    = true
            }
        }
    }
}

//MARK: table view functions
extension MasterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsHeaderView") as! SettingsHeaderView
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSectionHeader") as! SettingsSectionHeader
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 5
        }
        if section == 2 {
            return 2
        }
        if section == 3 {
            return 3
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsRowView", for: indexPath) as! SettingsRowView
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
        
        let titleText = settingsArray[indexPath.section][indexPath.row]
        cell.setTitleText(text: titleText)
        cell.setColorViewWidth(value: 36.0)
        
        if indexPath.section == 1 {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let splitView = self.splitViewController else {
            return
        }
        if splitView.isCollapsed {
            let nextVC: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            nextVC.indexTag = "\(indexPath.section)\(indexPath.row )"
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            if (detailViewController != nil) {
                self.detailViewController!.detailItem = "\(indexPath.section)\(indexPath.row )"
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
