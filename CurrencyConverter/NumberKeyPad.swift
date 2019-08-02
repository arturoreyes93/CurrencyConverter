//
//  NumberKeyPad.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/2/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit

@objc protocol NumberKeyPadDelegate: class {
    func numberKeyPressed(number: Int)
    func didDeleteLastNumber()
    func didFinishEditing()
}

class NumberKeyPad: UIStackView {
    
    unowned private let delegate: NumberKeyPadDelegate
    
    let numberRows = [(1...3), (4...6), (7...9)]
    var columns: [UIView] = []
    var digitsColor: UIColor = .white
    var digitsBackgroundColor: UIColor = .clear
    
    
    init(delegate: NumberKeyPadDelegate, frame: CGRect? = nil) {
        self.delegate = delegate
        super.init(frame: frame ?? .zero)
        
        self.columns = numberRows.map({ row in
            self.createRow(with: row.map({self.createButton(number: $0)}))
        })
        
        self.columns.forEach { self.addArrangedSubview($0) }
        
        self.setLastRow()
        
        self.axis = .vertical
        self.spacing = 12
        self.distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButton(number: Int?)-> UIView {
        
        let buttonTitle: String = (number == nil) ? "" : String(number!)
        
        let button = UIButton(title: buttonTitle, titleColor: self.digitsColor, font: .boldSystemFont(ofSize: 33), backgroundColor: self.digitsBackgroundColor, target: self, action: #selector(keypadButtonTapped))
        button.layer.cornerRadius = 9
        button.clipsToBounds = true
        
        if let number = number {
            button.tag = number
        }
        
        return button
    }
    
    private func createRow(with subviews: [UIView]) -> UIView {
        let hStack = UIStackView(arrangedSubviews:subviews)
        hStack.distribution = .fillEqually
        hStack.spacing = 10
        return hStack
    }
    
    private func setLastRow() {
        
        let deleteButton = UIButton(title: "Delete", titleColor: self.digitsColor, font: .systemFont(ofSize: 18), backgroundColor: .clear, target: self, action: #selector(deleteButtonPressed))
        
        let doneButton = UIButton(title: "Done", titleColor: self.digitsColor, font: .systemFont(ofSize: 18), backgroundColor: .clear, target: self, action: #selector(doneButtonPressed))
        
        let lastRowItems = [doneButton, createButton(number: 0), deleteButton]
        let lastRow = createRow(with: lastRowItems)
        self.addArrangedSubview(lastRow)
        
    }
    
    @objc private func deleteButtonPressed() {
        self.delegate.didDeleteLastNumber()
    }
    
    @objc private func doneButtonPressed() {
        self.delegate.didFinishEditing()
    }
    
    @objc private func keypadButtonTapped(sender: UIButton) {
        self.delegate.numberKeyPressed(number: sender.tag)
    }
}
