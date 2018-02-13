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
    @IBOutlet weak var optionalLabel: UILabel!
    
    var hasOp = false
    let ops = ["+","-","*","/"]
    var precedences = [String: Int]()  //operator precedence dictionary
    var questionStartIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultLabel.text = ""
        precedences["+"] = 1
        precedences["-"] = 1
        precedences["x"] = 2
        precedences["÷"] = 2
        
        optionalLabel.text = ""
        resultLabel.text = ""
    }
    
    
    @IBAction func handleButtonPress(sender: UIButton) {
        if resultLabel.text == "Ready" {
            optionalLabel.text = ""
            resultLabel.text = ""
        }
        
        var currentText = resultLabel.text!
        var currentOptionalText = optionalLabel.text!
        
        let textLabel = sender.titleLabel?.text
        if let text = textLabel {
            switch text {
            case "+", "x", "÷", "-":
                if hasOp {
                    //Already has operator so remove previous one
                    currentText.removeLast()
                    currentOptionalText.removeLast()
                    currentOptionalText.removeLast()
                    currentOptionalText.removeLast()
                    currentOptionalText.removeLast()
                }
                
                hasOp = true
                resultLabel.text = "\(currentText)\(text)"
                
                //Process  optional display
                if let lastChar = currentOptionalText.last {
                    let prevpreced = precedences[String(lastChar)] ?? -1
                    if let _ = currentOptionalText.range(of: "?")  {
                        //Already has placeholder
                        if prevpreced != -1 {
                            if precedences["\(text)"]! > prevpreced {
                                //Previous operator precedence is greater so swap position
                                currentOptionalText.removeLast()
                                currentOptionalText += "\(text)" + " \(String(lastChar))"
                             }
                        }
                        
                        optionalLabel.text = currentOptionalText
                    } else {
                        if prevpreced != -1 {
                            if precedences["\(text)"]! > prevpreced {
                                //Previous operator precedence is greater so swap position
                                currentOptionalText.removeLast()
                                currentOptionalText += "? \(text)" + " \(String(lastChar))"
                                optionalLabel.text = currentOptionalText
                            } else {
                                optionalLabel.text = "\(currentOptionalText) ? \(text)"
                            }
                        } else {
                            optionalLabel.text = "\(currentOptionalText) ? \(text)"
                        }
                        questionStartIndex = -1
                    }
                } else {
                    optionalLabel.text = " ? \(text)"  //For empty string
                    questionStartIndex = -1
                }

            case "=":
                if hasOp {
                    //Last is operator
                    currentText.removeLast()
                    resultLabel.text = "\(currentText)"
                    hasOp = false
                  }
                resultLabel.text = "\(calculate(resultLabel.text))"
                optionalLabel.text = resultLabel.text
                questionStartIndex = -1

            default:
                //Number input
                resultLabel.text = "\(currentText)\(text)"
                
                if let quesRange = currentOptionalText.range(of: "?")  {
                    //Already has placeholder
                    questionStartIndex = currentOptionalText.distance(from: currentOptionalText.startIndex, to: quesRange.lowerBound)
                    
                    //Replace the ? with number
                    let start = currentOptionalText.index(currentOptionalText.startIndex, offsetBy: questionStartIndex);
                    let end = currentOptionalText.index(currentOptionalText.startIndex, offsetBy: questionStartIndex + 1);
                    currentOptionalText.replaceSubrange(start..<end, with: text)
                    optionalLabel.text = currentOptionalText
                    //Progress to next position
                    questionStartIndex += 1
                } else if questionStartIndex > -1 {
                    //More digit
                    currentOptionalText.insert(text[text.startIndex], at: currentOptionalText.index(currentOptionalText.startIndex, offsetBy: questionStartIndex))
                    
                    optionalLabel.text = currentOptionalText
                    //Progress to next position
                    questionStartIndex += 1
                } else {
                    //Simple append the text
                    optionalLabel.text = "\(currentOptionalText)\(text)"
                }
                
                
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
        resultLabel.text = "Ready"
        optionalLabel.text = "Ready"
    }
}


