//
//  ViewController.swift
//  Calculator
//
//  Created by Benjamin Cohen Wang on 6/13/15.
//  Copyright (c) 2015 Benjamin Cohen-Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var typingNumber = false
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!

        var welcomeMessage: String
        
        if(typingNumber)
        {
            display.text = display.text! + (digit == "." && display.text!.rangeOfString(".") != nil ? "" : digit)
        }
        else
        {
            display.text = digit
            typingNumber = true
        }
        println("digit = \(digit)");
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if(typingNumber)
        {
            enter()
        }
        switch operation
        {
        case "+": binaryOperation { $0 + $1 }
        case "-": binaryOperation { $1 - $0 }
        case "×": binaryOperation { $0 * $1 }
        case "÷": binaryOperation { $1 / $0 }
        case "√": unaryOperation { sqrt($0) }
        case "sin": unaryOperation { sin($0) }
        case "cos": unaryOperation { cos($0) }
        case "π": displayValue = M_PI
        default: break
        }
        enter()
    }
    
    func binaryOperation(operation: (Double, Double) -> Double)
    {
        if(operandStack.count >= 2)
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        }
    }
    
    func unaryOperation(operation: (Double) -> Double)
    {
        if(operandStack.count >= 1)
        {
            displayValue = operation(operandStack.removeLast())
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        typingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double
    {
        get
        {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set
        {
            display.text = "\(newValue)"
            typingNumber = false
        }
    }
}

