//
//  ConfigureViewController.swift
//  GridAdditionDeletionAnimation
//
//  Created by Pankaj kumar on 23/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

// to avoid strong reference cycles, delegate is decalred with weak reference and to make it a class only protocol for using the weak reference, it is inherited with anyobject.

protocol configureViewDelegate: AnyObject {
    func setValues(animate: Double, width: CGFloat, height: CGFloat, itemSpace: CGFloat, lineSpacing: CGFloat)
}

class ConfigureViewController: UIViewController {
    
    var interItemSpace = CGFloat()
    var cellWidth = CGFloat()
    var cellHeight = CGFloat()
    var lineSpace = CGFloat()
    var animationSpeed = Double()
    
    weak var delegate: configureViewDelegate?

    @IBOutlet weak private var animateSpeed: UITextField!
    @IBOutlet weak private var width: UITextField!
    @IBOutlet weak private var height: UITextField!
    @IBOutlet weak private var itemSpace: UITextField!
    @IBOutlet weak private var lineSpacing: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewOnLoad()
    }
    
    private func setViewOnLoad() {
        animateSpeed.text = "\(animationSpeed)"
        width.text = "\(cellWidth)"
        height.text = "\(cellHeight)"
        itemSpace.text = "\(interItemSpace)"
        lineSpacing.text = "\(lineSpace)"
    }
    
    @IBAction private func setValues(_ sender: UIButton) {
        let animateText = animateSpeed.text ?? ""
        let widthText = width.text ?? ""
        let heightText = height.text ?? ""
        let itemSpaceText = itemSpace.text ?? ""
        let lineSpaceText = lineSpacing.text ?? ""
        
        delegate?.setValues(animate: Double(animateText) ?? 0, width: CGFloat(Double(widthText) ?? 0) , height: CGFloat(Double(heightText) ?? 0), itemSpace: CGFloat(Double(itemSpaceText) ?? 0), lineSpacing: CGFloat(Double(lineSpaceText) ?? 0))
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
