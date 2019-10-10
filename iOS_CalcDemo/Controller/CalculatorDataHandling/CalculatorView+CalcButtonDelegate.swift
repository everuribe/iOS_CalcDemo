//
//  CalculatorView+CalcButtonDelegate.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit

//MARK: BUTTON TAP HANDLING
extension CalculatorView: CalcButtonDelegate {
    ///Switch to determine method to perform when button is tapped
    func handleButtonTap(function: CalcFunction) {
        switch function {
        case .clear:
            resetAll()
        case .square:
            performSquare()
        case .percent:
            performPercent()
        case .divide:
            performOperation(operatorText: "÷", operatorType: .divide)
        case .seven:
            updateTextWith(number: "7")
        case .eight:
            updateTextWith(number: "8")
        case .nine:
            updateTextWith(number: "9")
        case .multiply:
            performOperation(operatorText: "×", operatorType: .multiply)
        case .four:
            updateTextWith(number: "4")
        case .five:
            updateTextWith(number: "5")
        case .six:
            updateTextWith(number: "6")
        case .subtract:
            performOperation(operatorText: "-", operatorType: .subtract)
        case .one:
            updateTextWith(number: "1")
        case .two:
            updateTextWith(number: "2")
        case .three:
            updateTextWith(number: "3")
        case .add:
            performOperation(operatorText: "+", operatorType: .add)
        case .signSwitch:
            performSignSwitch()
        case .zero:
            updateTextWith(number: "0")
        case .decimal:
            updateTextWithDecimal()
        case .equal:
            performEquality()
        }
    }
    
    private func updateTextWithDecimal(){
        if let text: String = ioLabel.text {
            if !text.isEmpty {
                if shouldResetInputIfEnterNewNumber {
                    resetAll()
                    ioLabel.text = "0."
                } else if !text.contains(".") {
                    if !performedFunction {
                        
                        ioLabel.text = text + "."
                        
                    } else {
                        currentEquationLabel.text = text
                        ioLabel.text = "0."
                        performedFunction = false
                    }
                }
            } else {
                ioLabel.text = "0."
            }
        }
    }
    
    private func performSquare(){
        if var text: String = ioLabel.text {
            if !text.isEmpty {
                if performedFunction {
                    text.remove(at: text.index(before: text.endIndex))
                    ioLabel.text = text
                    performedFunction = false
                }
                if var double: Double = Double(text) {
                    double = pow(double, 2)
                    
                    ioLabel.text = double.convertToString()
                    
                    currentEquationLabel.text = text + "²="
                    shouldResetInputIfEnterNewNumber = true
                    storeCalculation()
                } else {
                    var double: Double = numbersToOperate[0]
                    double = pow(double, 2)
                    
                    ioLabel.text = double.convertToString()
                    
                    currentEquationLabel.text = text + "²="
                    shouldResetInputIfEnterNewNumber = true
                    storeCalculation()
                }
            }
        }
    }
    
    private func performPercent(){
        if var text: String = ioLabel.text {
            if !text.isEmpty {
                if shouldResetInputIfEnterNewNumber {
                    shouldResetInputIfEnterNewNumber = false
                }
                if performedFunction {
                    text.remove(at: text.index(before: text.endIndex))
                    ioLabel.text = text
                    performedFunction = false
                }
                if var double: Double = Double(text) {
                    double = double*0.01
                    ioLabel.text = "\(double)"
                    currentEquationLabel.text = text + "%="
                    storeCalculation()
                }
            }
        }
    }
    
    private func performSignSwitch(){
        if var text: String = ioLabel.text {
            if !text.isEmpty {
                if shouldResetInputIfEnterNewNumber {
                    shouldResetInputIfEnterNewNumber = false
                }
                if performedFunction {
                    text.remove(at: text.index(before: text.endIndex))
                    ioLabel.text = text
                    performedFunction = false
                }
                if var double: Double = Double(text) {
                    double = -double
                    
                    ioLabel.text = double.convertToString()
                    currentEquationLabel.text = ""
                } else {
                    var double: Double = numbersToOperate[0]
                    double = -double
                    
                    ioLabel.text = double.convertToString()
                    currentEquationLabel.text = text + ""
                }
            }
        }
    }

    private func updateTextWith(number: String){
        if let text: String = ioLabel.text {
            if !text.isEmpty {
                if !performedFunction {
                    if shouldResetInputIfEnterNewNumber {
                        resetAll()
                        ioLabel.text = number
                    } else {
                        if number == "0" {
                            if let double: Double = Double(text) {
                                if !(double == 0) {
                                    ioLabel.text = text + "0"
                                }
                            }
                        } else {
                            ioLabel.text = text + number
                        }
                    }
                } else {
                    currentEquationLabel.text = text
                    ioLabel.text = number
                    performedFunction = false
                }
            } else {
                ioLabel.text = number
            }
        }
    }
    
    private func performOperation(operatorText: String, operatorType: CalcFunction){
        if var text: String = ioLabel.text {
            if !text.isEmpty {
                if shouldResetInputIfEnterNewNumber {
                    shouldResetInputIfEnterNewNumber = false
                }
                if !performedFunction {
                    if operationToPerform != nil {
                        performEquality()
                        
                        if let newText: String = ioLabel.text {
                            if let double: Double = Double(newText){
                                numbersToOperate.append(double)
                                ioLabel.text = newText + operatorText
                                performedFunction = true
                            }
                        }
                    } else {
                        if numbersToOperate.isEmpty {
                            if let double: Double = Double(text){
                                numbersToOperate.append(double)
                                
                                text = double.convertToString()
                                
                                ioLabel.text = text + operatorText
                                performedFunction = true
                            }
                        } else {
                            ioLabel.text = text + operatorText
                            performedFunction = true
                        }
                    }
                } else {
                    ioLabel.text = text.dropLast() + operatorText
                }

                operationToPerform = operatorType
            }
        }
    }
    
    private func performEquality(){
        if operationToPerform != nil {
            if let text: String = ioLabel.text, let currentEquationText: String = currentEquationLabel.text {
                if !text.isEmpty {
                    if let double: Double = Double(text){
                        numbersToOperate.append(double)
                        currentEquationLabel.text = currentEquationText + text + "="
                        
                        performCalculation()
                    }
                }
            }
        }
    }
    
    private func performCalculation(){
        if numbersToOperate.count == 2, let function = operationToPerform {
            var result: Double?
            
            if function == .add {
                result = numbersToOperate[0]+numbersToOperate[1]
            } else if function == .subtract {
                result = numbersToOperate[0]-numbersToOperate[1]
            } else if function == .multiply {
                result = numbersToOperate[0]*numbersToOperate[1]
            } else if function == .divide {
                result = numbersToOperate[0]/numbersToOperate[1]
            }
            
            if let r: Double = result {
                ioLabel.text = r.convertToString()
                resetNumberAndOperator()
                shouldResetInputIfEnterNewNumber = true
                numbersToOperate.append(r)
                
                storeCalculation()
            }
        }
    }
    
    ///Handles storing calculations in history Core Data object if it exists and is connected.
    private func storeCalculation(){
        let calcToStore: String = currentEquationLabel.text! + ioLabel.text!
        if let d: CalculationStoreDelegate = delegate {
            if let storage = d.calcStorage{
                if storage.calculations == nil{
                    storage.calculations = [calcToStore]
                } else {
                    storage.calculations?.append(calcToStore)
                }
                d.saveData()
            }
        }
    }
    
    private func resetNumberAndOperator(){
        operationToPerform = nil
        numbersToOperate = []
    }
    
    ///Reset properties keeping track of current calculations
    private func resetAll(){
        shouldResetInputIfEnterNewNumber = false
        performedFunction = false
        resetNumberAndOperator()
        currentEquationLabel.text = ""
        ioLabel.text = ""
    }
}
