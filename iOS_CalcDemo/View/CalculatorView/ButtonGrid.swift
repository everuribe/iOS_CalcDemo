//
//  ButtonGrid.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit

class ButtonGrid: UIStackView {
    ///Keeps track of currentRow to add new button to
    private var currentRow: UIStackView?
    
    private let buttonsPerRow: Int = 4
    private let buttonSize: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 100 : 65
    
    required init(delegate: CalcButtonDelegate) {
        super.init(frame: .zero)
            
        let calcFunctions: [CalcFunction] = CalcFunction.allCases
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.distribution = .equalSpacing
        
        var count: Int = 0
        currentRow = createRow()
        
        for function in calcFunctions {

            let button: CalcButton = CalcButton(function: function)
            button.delegate = delegate
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            
            currentRow!.addArrangedSubview(button)
            count += 1
            if count == 4 {
                self.addArrangedSubview(currentRow!)
                currentRow = createRow()
                count = 0
            }
        }
    }
    
    ///Creates new UIStackView row to add buttons to
    private func createRow() -> UIStackView {
        let row = UIStackView(arrangedSubviews: [])
        row.translatesAutoresizingMaskIntoConstraints = false
        row.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        row.axis = .horizontal
        row.distribution = .equalSpacing
        return row
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
