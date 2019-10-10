//
//  TabControl.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © 2019 Ever Uribe. All rights reserved.
//

import UIKit

class TabControl: UIView {
    var delegate: TabControlDelegate?
    
    ///First tab button.
    private let calculatorTab: UIButton = {
        let b: UIButton = UIButton()
        b.setTitle("Calculator", for: .normal)
        b.setTitleColor(.orange, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        b.addTarget(self, action: #selector(switchTabs), for: .touchUpInside)
        return b
    }()
    
    ///Second tab button.
    private let historyTab: UIButton = {
        let b: UIButton = UIButton()
        b.setTitle("History", for: .normal)
        b.setTitleColor(.lightGray, for: .normal)
        b.addTarget(self, action: #selector(switchTabs), for: .touchUpInside)
        return b
    }()
    
    ///Tab bar stretching across TabControl
    private lazy var tabBar: UIView = {
        let v: UIView = UIView()
        v.backgroundColor = .lightGray
        v.clipsToBounds = true
        v.layer.cornerRadius = tabBarHeight/2
        return v
    }()
    
    ///Indicator on tab bar indicating the current tab.
    private lazy var selectedTabIndicator: UIView = {
        let v: UIView = UIView()
        v.backgroundColor = .orange
        v.clipsToBounds = true
        v.layer.cornerRadius = tabBarHeight/2
        return v
    }()
    
    ///Used to control indicator location.
    private var indicatorLeftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private let tabBarHeight: CGFloat = 4
    
    ///Used to check current tab.
    private var isOnCalculatorTab: Bool = true
    
    required init(){
        super.init(frame: .zero)
        
        self.addSubview(calculatorTab)
        self.addSubview(historyTab)
        self.addSubview(tabBar)
        self.addSubview(selectedTabIndicator)
        
        setConstraints()
    }
    
    private func setConstraints() {
        calculatorTab.translatesAutoresizingMaskIntoConstraints = false
        historyTab.translatesAutoresizingMaskIntoConstraints = false
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        selectedTabIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        calculatorTab.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        calculatorTab.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        calculatorTab.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        calculatorTab.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        
        historyTab.leftAnchor.constraint(equalTo: self.calculatorTab.rightAnchor).isActive = true
        historyTab.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        historyTab.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        historyTab.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        
        tabBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tabBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
        
        indicatorLeftConstraint = selectedTabIndicator.leftAnchor.constraint(equalTo: tabBar.leftAnchor)
        indicatorLeftConstraint.isActive = true
        selectedTabIndicator.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 0.5).isActive = true
        selectedTabIndicator.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
        selectedTabIndicator.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Handles tap to switchViews
    @objc private func switchTabs(){
        if let d = delegate {
            d.handleTabToggle()
            switchTabsAnimation()
            isOnCalculatorTab.toggle()
        }
    }
    
    ///Animates switch of tabs.
    private func switchTabsAnimation(){
        if isOnCalculatorTab {
            indicatorLeftConstraint.constant = self.bounds.width/2
            
            UIView.animate(withDuration: 0.25, animations: {
                self.calculatorTab.setTitleColor(.lightGray, for: .normal)
                self.calculatorTab.titleLabel?.font = .systemFont(ofSize: 18)
                self.historyTab.setTitleColor(.orange, for: .normal)
                self.historyTab.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
                self.layoutIfNeeded()
            })
        } else {
            indicatorLeftConstraint.constant = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                self.calculatorTab.setTitleColor(.orange, for: .normal)
                self.calculatorTab.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
                self.historyTab.setTitleColor(.lightGray, for: .normal)
                self.historyTab.titleLabel?.font = .systemFont(ofSize: 18)
                self.layoutIfNeeded()
            })
        }
    }
}

