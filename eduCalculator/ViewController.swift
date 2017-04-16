//
//  ViewController.swift
//  eduCalculator
//
//  Created by Thomas Couacault on 12/04/2017.
//  Copyright © 2017 Thomas Couacault. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelCurrentOperation: UILabel!
    @IBOutlet weak var labelDisplay: UILabel!
    var displayIsNull: Bool = true
    var calculator: Calculator = Calculator()
    
    private var displayValue: Double {
        get {
            return Double(labelDisplay.text!)!
        }
        set {
            labelDisplay.text = String(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if displayIsNull && sender.currentTitle! != "0" {
            if sender.currentTitle! == "." {
                labelDisplay.text = "0."
            } else {
                labelDisplay.text = sender.currentTitle!
            }
            displayIsNull = false
        } else if !displayIsNull {
            if (labelDisplay.text!.range(of: ".") == nil && sender.currentTitle == ".") || (sender.currentTitle != ".") {
                labelDisplay.text = labelDisplay.text! + sender.currentTitle!
            }
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        labelCurrentOperation.text = (sender.currentTitle == "=") ? nil : sender.currentTitle!
        calculator.setOperand(displayValue)
        calculator.performOperation(sender.currentTitle!)
        if let result = calculator.result {
            displayValue = result
        }
        displayIsNull = true
    }
    
    @IBAction func clearDisplay(_ sender: UIButton) {
        labelDisplay.text = "0"
        displayIsNull = true
        labelCurrentOperation.text = nil
    }
    
}

