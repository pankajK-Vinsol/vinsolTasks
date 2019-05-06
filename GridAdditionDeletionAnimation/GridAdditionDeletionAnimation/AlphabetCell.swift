//
//  AlphabetCell.swift
//  GridAdditionDeletionAnimation
//
//  Created by Pankaj kumar on 06/05/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class AlphabetCell: UICollectionViewCell {
    @IBOutlet weak private var alphaLabel: UILabel!
    
    internal func setCellText(textValue: String) {
        alphaLabel.text = textValue
    }
}
