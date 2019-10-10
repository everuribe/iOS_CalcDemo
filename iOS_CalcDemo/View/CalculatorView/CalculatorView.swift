//
//  CalculatorView.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit

class CalculatorView: UIView {
    ///Delegate used to perform and storage required for the calculations.
    var delegate: CalculationStoreDelegate?
    
    ///Label showing the current equation
    let currentEquationLabel: UILabel = {
        let l: UILabel = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.textAlignment = .right
        l.textColor = .white
        l.text = ""
        return l
    }()
    
    ///Label showing current input/output
    let ioLabel: UILabel = {
        let l: UILabel = UILabel()
        l.font = .systemFont(ofSize: 40, weight: .semibold)
        l.textAlignment = .right
        l.textColor = .white
        l.text = ""
        return l
    }()
    
    ///View showing all calculator buttons
    private lazy var buttonGrid: ButtonGrid = ButtonGrid(delegate: self)
    
    ///Determines if user just entered one of the following operations: add, subtract, multiply, divide
    var performedFunction: Bool = false
    
    ///Operation to be performed once calculation is called
    var operationToPerform: CalcFunction?
    
    ///Numbers saved as double to perform operations.
    var numbersToOperate: [Double] = []
    var shouldResetInputIfEnterNewNumber: Bool = false
    
    required init() {
        super.init(frame: .zero)
        
        addSubview(buttonGrid)
        addSubview(ioLabel)
        addSubview(currentEquationLabel)
        
        setConstraints()
    }
    
    private func setConstraints(){
        buttonGrid.translatesAutoresizingMaskIntoConstraints = false
        ioLabel.translatesAutoresizingMaskIntoConstraints = false
        currentEquationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentEquationLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        currentEquationLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        currentEquationLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        currentEquationLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        ioLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        ioLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        ioLabel.topAnchor.constraint(equalTo: self.currentEquationLabel.bottomAnchor, constant: 20).isActive = true
        ioLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonGrid.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        buttonGrid.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonGrid.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        buttonGrid.topAnchor.constraint(equalTo: self.ioLabel.bottomAnchor, constant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
