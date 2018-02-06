//
//  ViewController.swift
//  Calculator
//
//  Created by Jiaren on 4/2/18.
//  Copyright © 2018 Jiaren. All rights reserved.
//

import UIKit
let maxLength = 10

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!

    var hasOp = false
    let ops = ["+","-","*","/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultLabel.text = ""
    }
    
    
    @IBAction func handleButtonPress(sender: UIButton) {
        var currentText = resultLabel.text!
        let textLabel = sender.titleLabel?.text
        if let text = textLabel {
            switch text {
            case "+", "x", "÷", "-":
                if hasOp {
                    //Already has operator so remove previous one
                    currentText.removeLast()
                }
                
                hasOp = true
                resultLabel.text = "\(currentText)\(text)"
                
            case "=":
                if hasOp {
                    //Last is operator
                    currentText.removeLast()
                    resultLabel.text = "\(currentText)"
                    hasOp = false
                }
                resultLabel.text = "\(calculate(resultLabel.text))"
            default:
                //Number input
                resultLabel.text = "\(currentText)\(text)"
                hasOp = false
                break;
            }
        }
    }
    
    func calculate(_ inputExpression:String?) -> Double{
        var rst = 0.0
        guard var inputStr = inputExpression, !ops.contains(String(inputStr.last!)) else {
            return rst
        }
        
        //Replace 'x' with '*'
        //'÷' with '/'
        inputStr = inputStr.replacingOccurrences(of: "x", with: "*")
        inputStr = inputStr.replacingOccurrences(of: "÷", with: "/")
        
        var rstStr = ""
        
        var tmpNodes = ""
        for char in inputStr {
            if ops.contains(String(char)) {
                //Operator
                if tmpNodes != "" && tmpNodes.range(of: ".") == nil {
                    //Has integer data, so convert to double
                    rstStr += ".0"
                }
                rstStr += String(char)
                tmpNodes = ""
            } else {
                //Numeric
                tmpNodes += String(char)
                rstStr += String(char)
            }
        }
        let newExp = NSExpression(format: rstStr)
        
        if let result = newExp.expressionValue(with: nil, context: nil) as? Double {
            let str = "\(result)"
            if str.count > maxLength {
                //Only display maximum number here
                rst = Double(str.prefix(maxLength)) ?? 0.0
            } else {
                rst = Double(str) ?? 0.0
            }
        }
        
        return rst
    }
    
    @IBAction func clearButtontapped(_ sender: Any) {
        resultLabel.text = ""
    }
}


