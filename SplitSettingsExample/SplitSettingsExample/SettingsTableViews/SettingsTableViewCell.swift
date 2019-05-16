//
//  SettingsRowView.swift
//  SettingsScreenExample
//
//  Created by Pankaj kumar on 30/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak private var roundedView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var arrowImageView: UIImageView!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var toggleOption: UISwitch!
    @IBOutlet weak private var colorViewWidth: NSLayoutConstraint!
        
    var toggleAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius(view: roundedView)
        toggleOption.addTarget(self, action: #selector(toggleClick(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction private func toggleClick(_ sender: Any) {
        toggleAction?()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "settingsChange"), object: nil)
    }
    
    private func setCornerRadius(view: UIView) {
        view.layer.cornerRadius = 6.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0.0
        view.clipsToBounds = true
    }
    
    func setColorViewWidth(value: Float) {
        colorViewWidth.constant = CGFloat(value)
    }
    
    func setBackgroundColor(remainder: Int) {
        var color = UIColor()
        switch remainder {
        case 0:
            color = UIColor().customRedColor
        case 1:
            color = UIColor().customBlueColor
        case 2:
            color = UIColor().customYellowColor
        default:
            print("Unknown")
        }
        roundedView.backgroundColor = color
    }
    
    func hideArrow(isArrow:Bool, isDetail:Bool) {
        arrowImageView.isHidden = isArrow
        detailLabel.isHidden = isDetail
        toggleOption.isHidden = !isArrow
    }
    
    func setTextString(text: String, type: Int) {
        if type == 1 {
            titleLabel.text = text
        } else {
            detailLabel.text = text
        }
    }
    
    func setToggleValue(value: Bool) {
        toggleOption.isOn = value
    }
}

extension UIColor {
    var customRedColor: UIColor {
        return UIColor(red: 251.0/255, green: 58.0/255, blue: 48.0/255, alpha: 1.0)
    }
    var customBlueColor: UIColor {
        return UIColor(red: 21.0/255, green: 122.0/255, blue: 251.0/255, alpha: 1.0)
    }
    var customYellowColor: UIColor {
        return UIColor(red: 253.0/255, green: 149.0/255, blue: 38.0/255, alpha: 1.0)
    }
}
