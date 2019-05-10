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
    
    func setBackgroundColor(color: UIColor) {
        roundedView.backgroundColor = color
    }
    
    func hideAndShowItems(isColorView: Bool, isArrow:Bool, isDetail: Bool, isToggle: Bool) {
        roundedView.isHidden = isColorView
        arrowImageView.isHidden = isArrow
        detailLabel.isHidden = isDetail
        toggleOption.isHidden = isToggle
    }
    
    func setTitleText(text: String) {
        titleLabel.text = text
    }
    
    func setDetailText(text: String) {
        detailLabel.text = text
    }
    
    func setToggleValue(value: Bool) {
        toggleOption.isOn = value
    }
    
    func setColorViewWidth(value: Float) {
        colorViewWidth.constant = CGFloat(value)
    }
    
}
