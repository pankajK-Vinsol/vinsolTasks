//
//  ConfigureViewController.swift
//  GridAdditionDeletionAnimation
//
//  Created by Pankaj kumar on 23/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

protocol configureViewDelegate: ViewController {
    func setValues(animate: Double, width: CGFloat, height: CGFloat, itemSpace: CGFloat, lineSpacing: CGFloat)
}

class ConfigureViewController: UIViewController {
    
    var interItemSpace = CGFloat()
    var cellWidth = CGFloat()
    var cellHeight = CGFloat()
    var lineSpace = CGFloat()
    var animationSpeed = Double()
    
    weak var delegate: configureViewDelegate?

    @IBOutlet weak var animateSpeed: UITextField!
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var itemSpace: UITextField!
    @IBOutlet weak var lineSpacing: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewOnLoad()
    }
    
    func setViewOnLoad() {
        animateSpeed.text = "\(animationSpeed)"
        width.text = "\(cellWidth)"
        height.text = "\(cellHeight)"
        itemSpace.text = "\(interItemSpace)"
        lineSpacing.text = "\(lineSpace)"
    }
    
    @IBAction func setValues(_ sender: UIButton) {
        let animateText = animateSpeed.text ?? ""
        let widthText = width.text ?? ""
        let heightText = height.text ?? ""
        let itemSpaceText = itemSpace.text ?? ""
        let lineSpaceText = lineSpacing.text ?? ""
        delegate?.setValues(animate: Double(animateText) ?? 0, width: CGFloat(Double(widthText) ?? 0) , height: CGFloat(Double(heightText) ?? 0), itemSpace: CGFloat(Double(itemSpaceText) ?? 0), lineSpacing: CGFloat(Double(lineSpaceText) ?? 0))
        self.navigationController?.popViewController(animated: true)
    }
    
}
