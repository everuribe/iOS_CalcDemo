//
//  CalcEntryCell.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit
class CalcEntryCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textLabel?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textLabel?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textLabel?.backgroundColor = .clear
        
        textLabel?.textAlignment = .right
        textLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        textLabel?.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
