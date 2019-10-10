//
//  Double+convertToString.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import Foundation

//Used to quickly format double to string using scientific formatting
extension Double {
    func convertToString() -> String{
        return String(format: "%g", self)
    }
}
