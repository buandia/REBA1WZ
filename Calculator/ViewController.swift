//
//  ViewController.swift
//  Calculator
//
//  Created by buandia on 7/13/16.
//  Copyright © 2016 Sergey Ishenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var displayResultLabel: UILabel!
    var isTyping = false
    var isDotPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value  = "\(newValue)"
            let arrayValue  = value.componentsSeparatedByString(".")
            
            if arrayValue[1] == "0" {
                displayResultLabel.text = arrayValue[0]
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            isTyping = false
        }
    }

    @IBAction func numberPressed(sender: UIButton) {
        let number =  sender.currentTitle!
        
        if isTyping {
            if displayResultLabel.text?.characters.count < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else if isDotPlaced {
            displayResultLabel.text = displayResultLabel.text! + number
            isTyping = true
        } else  {
            displayResultLabel.text = number
            isTyping = true
        }
    }
    
    @IBAction func twoOperandsPressed(sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        isTyping = false
        isDotPlaced = false
    }
    
    @IBAction func equalSignPressed(sender: UIButton) {
        if isTyping {
            secondOperand = currentInput
        }
        
        isDotPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        isTyping = false
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        isTyping = false
        isDotPlaced = false
        operationSign = ""
    }
    
    
    @IBAction func plusMinusButtonPressed(sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentButtonPressed(sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        isTyping = false
    }
    
    @IBAction func squareRootButtonPressed(sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(sender: UIButton) {
        if isTyping && !isDotPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
        } else if !isTyping && !isDotPlaced {
            displayResultLabel.text = "0."
        }
        isDotPlaced = true
    }
}

