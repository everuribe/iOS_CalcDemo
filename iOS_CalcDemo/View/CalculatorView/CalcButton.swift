//
//  CalcButton.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit

class CalcButton: UIButton {
    private let function: CalcFunction
    var delegate: CalcButtonDelegate?
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                highlightButton()
            } else {
                resetColor()
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    required init(function: CalcFunction) {
        self.function = function
        super.init(frame: .zero)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        self.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        setLabel()
        setColors()
        setConstraints()
    }
    
    @objc private func handleTap() {
        delegate?.handleButtonTap(function: self.function)
    }
    
    private func highlightButton() {
        if function != .equal {
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
            })
        }
    }
    
    private func resetColor() {
        if function != .equal {
            if FunctionsToHighlight.contains(function){
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
                })
            } else {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundColor = UIColor.clear
                })
            }
        }
    }
    
    private func setConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    private func setColors(){
        if FunctionsToHighlight.contains(function) {
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
        } else if function == .equal {
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = UIColor.systemOrange
        } else {
            self.setTitleColor(.white, for: .normal)
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1.5
        }
    }
    
    private func setLabel(){
        switch function {
        case .one:
            self.setTitle("1", for: .normal)
        case .two:
            self.setTitle("2", for: .normal)
        case .three:
            self.setTitle("3", for: .normal)
        case .four:
            self.setTitle("4", for: .normal)
        case .five:
            self.setTitle("5", for: .normal)
        case .six:
            self.setTitle("6", for: .normal)
        case .seven:
            self.setTitle("7", for: .normal)
        case .eight:
            self.setTitle("8", for: .normal)
        case .nine:
            self.setTitle("9", for: .normal)
        case .zero:
            self.setTitle("0", for: .normal)
        case .clear:
            self.setTitle("C", for: .normal)
        case .signSwitch:
            self.setTitle("±", for: .normal)
        case .percent:
            self.setTitle("%", for: .normal)
        case .divide:
            self.setTitle("÷", for: .normal)
        case .multiply:
            self.setTitle("x", for: .normal)
        case .subtract:
            self.setTitle("-", for: .normal)
        case .add:
            self.setTitle("+", for: .normal)
        case .equal:
            self.setTitle("=", for: .normal)
        case .square:
            self.setTitle("x²", for: .normal)
        case .decimal:
            self.setTitle(".", for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
