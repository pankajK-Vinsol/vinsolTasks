//
//  SettingsRowView.swift
//  SettingsScreenExample
//
//  Created by Pankaj kumar on 30/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class SettingsRowView: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var toggleOption: UISwitch!
    @IBOutlet weak var colorViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius(view: roundedView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCornerRadius(view: UIView) {
        view.layer.cornerRadius = 6.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0.0
        view.clipsToBounds = true
    }
    
}
