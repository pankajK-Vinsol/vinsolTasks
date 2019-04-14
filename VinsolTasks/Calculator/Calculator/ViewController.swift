//
//  ViewController.swift
//  Calculator
//
//  Created by Pankaj kumar on 13/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var inputLabel: UILabel!
    var firstNumber: Int = 0
    var currentOperation: CalculatorOperation? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func updateNumber(_ numberButton: UIButton) {
        let numberTitle = numberButton.currentTitle!
        inputLabel.text = inputLabel.text! + numberTitle
    }
    
    @IBAction func updateOperation(_ operationButton: UIButton) {
        let operationTitle = operationButton.currentTitle!
        currentOperation = CalculatorOperation(from: operationTitle)
        let currentinput = inputLabel.text!
        firstNumber = Int(currentinput)!
        inputLabel.text = ""
    }
    
    @IBAction func performCalculation(_ sender: UIButton) {
        let currentinput = inputLabel.text!
        let secondNumber = Int(currentinput)!
        let finalValue = currentOperation!.apply(to: firstNumber, and: secondNumber)
        inputLabel.text = String(finalValue)
        firstNumber = 0
    }
    
    @IBAction func performCancellation(_ sender: UIButton) {
        inputLabel.text = ""
    }

}

