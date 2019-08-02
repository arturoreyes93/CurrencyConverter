//
//  CashTextFieldDelegate.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/2/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import Foundation

import UIKit

protocol CashAmountDelegate: class {
    func amountDidChange(_ amountString: inout String)
}

// MARK: - CashTextFieldDelegate: NSObject, UITextFieldDelegate
class CashTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var fontSize: CGFloat
    var fontColor: UIColor
    weak var cashDelegate: CashAmountDelegate?
    
    init(fontSize: CGFloat, fontColor: UIColor) {
        self.fontSize = fontSize
        self.fontColor = fontColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        
        textField.attributedText = newText.cashAttributedString(fontSize: fontSize, fontColor: fontColor)
        
        if textField.text!.isEmpty || textField.attributedText?.string == "0.00" || textField.attributedText?.string == "-0.00" {
            textField.attributedText = "0.00".cashAttributedString(fontSize: fontSize, fontColor: fontColor)
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.attributedText = "0.00".cashAttributedString(fontSize: fontSize, fontColor: fontColor)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if var amount = textField.text {
            self.cashDelegate?.amountDidChange(&amount)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if var amount = textField.text {
            self.cashDelegate?.amountDidChange(&amount)
        }
    }

}
