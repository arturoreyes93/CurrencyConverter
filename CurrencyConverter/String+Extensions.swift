//
//  String+Extensions.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/2/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit

extension String {
    
    func addingDigit(_ digit: Int) -> String {
        
        var newString = self + String(digit)
        newString = newString.replacingOccurrences(of: ".", with: "")
        let periodIndex = newString.index(newString.endIndex, offsetBy: -2)
        newString.insert(".", at: periodIndex)
        
        if newString.count > 4 {
            while newString.first! == Character("0") {
                newString.removeFirst()
            }
        }
        
        return newString
        
    }
    
    mutating func deleteDigit() -> String {
        
        if var number = Double(self) {
            number = number * 0.1
            number = round(number*100)/100
            return String(number)
        }
        
        return self
    }
    
    mutating func removingDigit() -> String {
        var newString = self.replacingOccurrences(of: ".", with: "")
        newString.removeLast()
        newString.addZeroesTail()
        newString.addZeroesHead()
        
        let periodIndex = newString.index(newString.endIndex, offsetBy: -2)
        newString.insert(".", at: periodIndex)
        
        
        
        return newString
        
    }
    
    mutating func addZeroesTail() {
        if self.count < 2 {
            self = self + "0"
            if self.count < 3 {
                self = self + "0"
            }
        }
    }
    
    mutating func addZeroesHead() {
        if self.count < 2 {
            self = "0" + self
            if self.count < 3 {
                self = "0" + self
            }
        }
    }
    
    func cashAttributedString(fontSize: CGFloat, fontColor: UIColor) -> NSAttributedString {
        
        let isNegative = self.hasPrefix("-")
        let attributedText = NSMutableAttributedString()
        var cashStringAttributes = [NSAttributedString.Key:Any]()
        cashStringAttributes[NSAttributedString.Key.foregroundColor] = fontColor
        cashStringAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 29)
        
        var centStringAttributes = cashStringAttributes
        centStringAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 29)
        
        let period = NSAttributedString(string: ".", attributes: cashStringAttributes)
        let negativeSign = NSAttributedString(string: "-", attributes: centStringAttributes)
        
        let digits = CharacterSet.decimalDigits
        var digitText = ""
        for c in (self.unicodeScalars) {
            if digits.contains(UnicodeScalar(c.value)!) {
                digitText.append("\(c)")
            }
        }
        
        // Format the new string
        if let numOfPennies = Int(digitText) {
            if isNegative {
                attributedText.append(negativeSign)
            }
            
            attributedText.append(dollarStringFromInt(numOfPennies, attributes: cashStringAttributes))
            attributedText.append(period)
            attributedText.append(centsStringFromInt(numOfPennies, attributes: centStringAttributes))
        } else {
            attributedText.append(NSAttributedString(string: "0.00", attributes: cashStringAttributes))
        }
        
        
        return attributedText
    }
    
    func dollarStringFromInt(_ value: Int, attributes: [NSAttributedString.Key:Any]) -> NSAttributedString {
        return NSAttributedString(string: String(value / 100), attributes: attributes)
    }
    
    func centsStringFromInt(_ value: Int, attributes: [NSAttributedString.Key:Any]) -> NSAttributedString {
        
        let cents = value % 100
        var centsString = String(cents)
        
        if cents < 10 {
            centsString = "0" + centsString
        }
        
        return NSAttributedString(string: centsString, attributes: attributes)
    }
    
    mutating func convertCurrencytoDouble() -> Double? {
        var isNegative = false
        
        if self.hasPrefix("-") {
            isNegative = true
            self.removeFirst()
        }
        
        if self.hasPrefix("$") {
            self.removeFirst()
        }
        
        if let doubleType = Double(self) {
            return isNegative ? doubleType * -1.0 : doubleType
        }
        
        return nil
    }
}
