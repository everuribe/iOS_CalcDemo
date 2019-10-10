//
//  CalculationDelegate.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import Foundation

protocol CalculationStoreDelegate {
    var calcStorage: PastCalculations? { get set }
    func saveData()
    func clearData()
}
