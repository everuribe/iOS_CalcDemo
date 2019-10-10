//
//  PastCalcsTable.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit

class HistoryView: UIView {
    var storageDelegate: CalculationStoreDelegate?
    
    let tableView: UITableView = UITableView()
    
    private lazy var clearButton: UIButton = {
        let b: UIButton = UIButton()
        b.setTitle("Clear history", for: .normal)
        b.backgroundColor = UIColor.clear
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1.5
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(clearHistory), for: .touchUpInside)
        b.clipsToBounds = true
        b.layer.cornerRadius = buttonHeight/2
        b.isHidden = true
        return b
    }()
    
    //Background image presented on tableView in custom situations.
    private let backgroundImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "historyTabNote")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let reusableIdentifier: String = "calc"
    private let buttonHeight: CGFloat = 55
    
    init() {
        super.init(frame: .zero)
        
        addSubview(tableView)
        addSubview(clearButton)

        setupTable()
        setConstraints()
    }
    
    private func setupTable() {
        tableView.register(CalcEntryCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundView = backgroundImageView
        tableView.backgroundView?.contentMode = .scaleAspectFit
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: 10).isActive = true
        
        clearButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        clearButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    @objc private func clearHistory() {
        storageDelegate?.clearData()
        tableView.reloadData()
        clearButton.isHidden = true
        backgroundImageView.isHidden = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = storageDelegate?.calcStorage?.calculations?.count {
            if count == 0 {
                clearButton.isHidden = true
                backgroundImageView.isHidden = false
            } else {
                clearButton.isHidden = false
                backgroundImageView.isHidden = true
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! CalcEntryCell
        cell.textLabel?.text = storageDelegate?.calcStorage?.calculations?[indexPath.row] ?? "Error loading calc"
//        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
