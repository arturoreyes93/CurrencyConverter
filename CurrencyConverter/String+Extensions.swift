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
}
