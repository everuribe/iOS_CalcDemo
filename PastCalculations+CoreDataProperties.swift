//
//  PastCalculations+CoreDataProperties.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//
//

import Foundation
import CoreData


extension PastCalculations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PastCalculations> {
        return NSFetchRequest<PastCalculations>(entityName: "PastCalculations")
    }

    @NSManaged public var calculations: [String]?

}
