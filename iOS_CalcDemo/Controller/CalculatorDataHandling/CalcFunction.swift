//
//  CalcFunction.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import Foundation

enum CalcFunction: CaseIterable {
    case clear, square, percent, divide,
        seven, eight, nine, multiply,
        four, five, six, subtract,
        one, two, three, add,
        signSwitch, zero, decimal, equal
}

var FunctionsToHighlight: [CalcFunction] = [.clear, .percent, .divide, .multiply, .subtract, .add, .square]
