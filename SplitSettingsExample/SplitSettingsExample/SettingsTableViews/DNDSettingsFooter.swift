//
//  DNDSettingsFooter.swift
//  SplitSettingsExample
//
//  Created by Pankaj kumar on 03/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class DNDSettingsFooter: UITableViewCell {

    @IBOutlet weak private var footerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFooterText(data: String) {
        footerLabel.text = data
    }
    
}
