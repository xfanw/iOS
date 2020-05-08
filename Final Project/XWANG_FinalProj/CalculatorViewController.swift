//
//  ViewController.swift
//  XWANG_FinalProj
//
//  Created by Frank Wang on 3/10/20.
//  Copyright © 2020 Frank Wang. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBOutlet weak var Mlabel: UILabel!
    
    @IBOutlet weak var decimal: UIButton!
    
    
    public var outText:String! = ""
    var firstValue = 0
    var secondValue = 0
    var result = 0
    var opPressed = false
    var op:String?
    var memory = 0
    
    var isFloat = false
    var firstValuef : Float = 0.0
    var secondValuef : Float = 0.0
    var resultf : Float = 0.0
    var memoryf : Float = 0.0
    
    @IBAction func inputNumber(_ sender: UIButton) {
        if let title = sender.currentTitle{
            // regular number will append to the output text
            outText += "\(title)"
            label.text = outText
            
        }
    }
    
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        opPressed = true
        if let title = sender.currentTitle{
            // regular number will append to the output text
            op = "\(title)"
        }
        if (isFloat) {
            firstValuef = Float(label.text!) ?? 0.0
        }else{
            firstValue = Int(label.text!) ?? 0
        }
        //reset output text
        outText = ""
 
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        opPressed = false
        
        // press "=" multiple times won't override a value
        if (outText != ""){
            if isFloat {
                secondValuef = Float(label.text!) ?? 0.0
                
                switch op{
                    case "+":
                        resultf = firstValuef + secondValuef
                    case "-":
                        resultf = firstValuef - secondValuef
                    case "*":
                        resultf = firstValuef * secondValuef
                    case "/":
                        resultf = firstValuef / secondValuef
                    default:
                        resultf = firstValuef + secondValuef
                }

                firstValuef = 0.0
                
                outText = ""
                label.text = "\(resultf)"
            } else{
                secondValue = Int(label.text!) ?? 0
                
                switch op{
                    case "+":
                        result = firstValue + secondValue
                    case "-":
                        result = firstValue - secondValue
                    case "*":
                        result = firstValue * secondValue
                    case "/":
                        result = firstValue / secondValue
                    default:
                        result = firstValue + secondValue;
                }

                firstValue = 0
                
                outText = ""
                label.text = "\(result)"
            }
       }
    }
    
    // switch
    @IBAction func changeMode(_ sender: UISwitch) {

        mode.text! = sender.isOn ? "Float Calculator" :"Integer Calculator"
        decimal.isHidden = sender.isOn ? false : true
        isFloat = sender.isOn
        label.text! = sender.isOn ? "0.0" : "0"
        firstValue = 0
        secondValue = 0
        result = 0
        opPressed = false
        
        memory = 0
        
        
        firstValuef = 0.0
        secondValuef = 0.0
        resultf  = 0.0
        memoryf = 0.0
        Mlabel.isHidden = true
    }
    
    // M+, M-, MR, MC
    fileprivate func SetMLabel() {
        if isFloat{
            if memoryf != 0.0{
                Mlabel.isHidden = false
            }
            else{
                Mlabel.isHidden = true
            }
        }else{
            if memory != 0{
                Mlabel.isHidden = false
            }
            else{
                Mlabel.isHidden = true
            }
        }

    }
    
    @IBAction func Mplus(_ sender: UIButton) {
        if isFloat{
            if let text = label.text{
                memoryf = memoryf + (Float(text) ?? 0.0)
            }
        } else {
            if let text = label.text{
                memory = memory + (Int(text) ?? 0)
            }
        }

        SetMLabel()
        outText = ""
    }
    
    @IBAction func Mminus(_ sender: UIButton) {
        if isFloat{
            if let text = label.text{
                memoryf = memoryf - (Float(text) ?? 0.0)
            }
        } else {
            if let text = label.text{
                memory = memory - (Int(text) ?? 0)
            }
        }
        SetMLabel()
        outText = ""
    }
    
    @IBAction func Mrecall(_ sender: UIButton) {
        if isFloat{
            label.text = "\(memoryf)"
        }else{
            label.text = "\(memory)"
        }
        
        outText = ""
        
    }
    
    @IBAction func Mcancel(_ sender: UIButton) {
        memoryf = 0
        memory = 0
        SetMLabel()
        outText = ""
    }
    
    
    @IBAction func Clear(_ sender: UIButton) {
        label.text! = "0"
        outText = ""
    }
    
    @IBAction func ClearAll(_ sender: UIButton) {
        label.text! = "0"
        outText = ""
        if isFloat{
            firstValuef = 0
            secondValuef = 0
            resultf = 0
        }else{
            firstValue = 0
            secondValue = 0
            result = 0
        }

        opPressed = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        modeSwitch.setOn(false, animated: true )
        Mlabel.isHidden = true
        decimal.isHidden = true
        
    }


}

