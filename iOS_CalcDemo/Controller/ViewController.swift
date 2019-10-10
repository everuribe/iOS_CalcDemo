//
//  ViewController.swift
//  iOS_CalcDemo
//
//  Created by Ever Uribe on 10/9/19.
//  Copyright © sideMargin19 Ever Uribe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, CalculationStoreDelegate {
    
    ///Tab toggle view.
    let tabControl: TabControl = TabControl()
    ///Calculator view.
    let calcView: CalculatorView = CalculatorView()
    ///History view.
    let historyView: HistoryView = HistoryView()
    
    //Constraints used to control animation/location of views when tabs are toggled.
    var calcViewLeftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var historyViewLeftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    ///Reference to Core Data object storing past calculations. This is fetched or initiated via loadData()
    var calcStorage: PastCalculations?
    ///Context used to fetch, save, delete data
    lazy var context: NSManagedObjectContext = initiateContext()
    
    lazy var sideMargin: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 40 : 20
    
    //An iOS13 currently requires this to properly show statusbar. 
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.view.backgroundColor = .black
        
        //setup all delegates
        tabControl.delegate = self
        calcView.delegate = self
        historyView.storageDelegate = self
        
        self.view.addSubview(tabControl)
        self.view.addSubview(calcView)
        self.view.addSubview(historyView)
        
        setConstraints()
        loadData()
    }

    //MARK: VIEW HANDLING
    private func setConstraints() {
        tabControl.translatesAutoresizingMaskIntoConstraints = false
        calcView.translatesAutoresizingMaskIntoConstraints = false
        historyView.translatesAutoresizingMaskIntoConstraints = false
        
        tabControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tabControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sideMargin).isActive = true
        tabControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -sideMargin).isActive = true
        tabControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        calcViewLeftConstraint = calcView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sideMargin)
        calcViewLeftConstraint.isActive = true
        calcView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -sideMargin*2).isActive = true
        calcView.topAnchor.constraint(equalTo: tabControl.bottomAnchor, constant: sideMargin).isActive = true
        calcView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -sideMargin).isActive = true
        
        historyViewLeftConstraint = historyView.leftAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
        historyViewLeftConstraint.isActive = true
        historyView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -sideMargin*2).isActive = true
        historyView.topAnchor.constraint(equalTo: calcView.topAnchor).isActive = true
        historyView.bottomAnchor.constraint(equalTo: calcView.bottomAnchor).isActive = true
    }
    
    //MARK: CORE DATA HANDLING
    ///Initiate context.
    private func initiateContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///Initiate new Core Data object if doesn't exist.
    private func initiateData() {
        calcStorage = NSEntityDescription.insertNewObject(forEntityName: "PastCalculations", into: context) as? PastCalculations
    }
    
    ///Save Core Data object.
    func saveData() {
        do {
           try context.save()
          } catch let error {
            print("Failed saving: \(error)")
        }
    }
    
    ///Load Core Data object via fetch else call initiateData()
    func loadData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PastCalculations")
        
        do {
            if let calculationsArray = try context.fetch(fetchRequest) as? [PastCalculations] {
                if calculationsArray.isEmpty {
                    initiateData()
                } else {
                    calcStorage = calculationsArray[0]
                }
            } else {
                initiateData()
            }
        } catch let error {
           print("Failed fetch: \(error)")
        }
    }
    
    ///Clears calculations in Core Data object.
    func clearData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PastCalculations")
        
        do {
            if let calculationsArray = try context.fetch(fetchRequest) as? [PastCalculations] {
                for calc in calculationsArray {
                    calc.calculations = nil
                }
                saveData()
            }
        } catch let error {
           print("Failed fetch: \(error)")
        }
    }
}

//MARK: TABCONTROLDELEGATE
extension ViewController: TabControlDelegate {
    func handleTabToggle() {
        if calcViewLeftConstraint.constant == sideMargin {
            
            historyView.tableView.reloadData()
            calcViewLeftConstraint.constant = -self.view.bounds.width
            historyViewLeftConstraint.constant = -self.view.bounds.width + sideMargin
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            calcViewLeftConstraint.constant = sideMargin
            historyViewLeftConstraint.constant = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}
