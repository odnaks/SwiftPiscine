//
//  ViewController.swift
//  day00
//
//  Created by Dremora Restless on 11/23/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

enum Operations {
    case plus
    case minus
    case devide
    case multiply
}

class ViewController: UIViewController {
    
    @IBOutlet weak var fieldLabel: UILabel!
    
    private var operation: Operations?
    
    private var currentNumber: Double = 0
    private var firstNumber: Double = 0
    
    private var newInput: Bool = true
    
    private func showNumber(_ number: Double) {
        let isInteger = number.truncatingRemainder(dividingBy: 1.0) == 0.0
        fieldLabel.text = isInteger ? String(format: "%.0f", number) : String(format: "%.3f", number)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldLabel.text = "0"
        newInput = true
    }
    
    //AC
    @IBAction func clickAC(_ sender: Any) {
        print("click AC button")
        fieldLabel.text = "0"
//        finalNumber = 0
        newInput = true
        currentNumber = 0
    }
    
    //NEG
    @IBAction func clickNEG(_ sender: Any) {
        print("click NEG button")
        currentNumber = -currentNumber
        showNumber(currentNumber)
    }
    
    // ÷
    @IBAction func clickDevide(_ sender: Any) {
        print("click ÷ button")
        
        newInput = true
        operation = .devide
        firstNumber = currentNumber
    }
    
    // x
    @IBAction func clickMultiply(_ sender: Any) {
        print("click x button")
        
        newInput = true
        operation = .multiply
        firstNumber = currentNumber
    }
    
    // -
    @IBAction func clickMinus(_ sender: Any) {
        print("click - button")
        
        newInput = true
        operation = .minus
        firstNumber = currentNumber
    }
    
    // +
    @IBAction func clickPlus(_ sender: Any) {
        print("click + button")
        
        newInput = true
        operation = .plus
        firstNumber = currentNumber
    }
    
    // =
    @IBAction func clickEqual(_ sender: Any) {
        print("click = button")
        
        newInput = true
        guard let operation = operation else {return}
        switch operation {
            case .devide:
                print("devide: \(firstNumber) / \(currentNumber)")
                currentNumber = firstNumber / currentNumber
            case .plus:
                print("plus: \(firstNumber) + \(currentNumber)")
                currentNumber = firstNumber + currentNumber
            case .minus:
                print("minus: \(firstNumber) - \(currentNumber)")
                currentNumber = firstNumber - currentNumber
            case .multiply:
                print("multiply: \(firstNumber) * \(currentNumber)")
                currentNumber = firstNumber * currentNumber
        }

        showNumber(currentNumber)
        firstNumber = currentNumber
        self.operation = nil
    }
    
    // 0
    @IBAction func clickZero(_ sender: Any) {
        print("click 0 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput || text == "0"{
            newText = "0"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "0"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 1
    @IBAction func clickOne(_ sender: Any) {
        print("click 1 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "1"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "1"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 2
    @IBAction func clickTwo(_ sender: Any) {
        print("click 2 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "2"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "2"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 3
    @IBAction func clickThree(_ sender: Any) {
        print("click 3 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "3"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "3"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 4
    @IBAction func clickFour(_ sender: Any) {
        print("click 4 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "4"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "4"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 5
    @IBAction func clickFive(_ sender: Any) {
        print("click 5 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "5"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "5"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 6
    @IBAction func clickSix(_ sender: Any) {
        print("click 6 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "6"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "6"
        }
        
        print("newText = \(newText)")
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 7
    @IBAction func clickSeven(_ sender: Any) {
        print("click 7 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "7"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "7"
        }
        
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 8
    @IBAction func clickEight(_ sender: Any) {
        print("click 8 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "8"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "8"
        }
        
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
    // 9
    @IBAction func clickNine(_ sender: Any) {
        print("click 9 button")
        
        guard let text = fieldLabel.text, text.count < 8 || newInput else { return }
        var newText = ""
        if newInput {
            newText = "9"
            newInput = false
        } else {
            newText = fieldLabel!.text! + "9"
        }
        
        guard let newCurrentNumber = Double(newText) else {return}
        fieldLabel.text = newText
        currentNumber = newCurrentNumber
        print("currentNumber = \(currentNumber)")
    }
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
