//
//  currency.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import Foundation

protocol Currency {
    var name: String { get }
    var code: String { get }
    var flagCode: String { get }
}

extension Currency {
    var flagURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.currencyflags.io"
        components.path = "/" + self.flagCode + "/flat/64.png"
        return components.url!
    }
}


struct Currencies {
    
    static let list: [Currency] = [USA(), Mexico(), Canada()]
    
    struct USA: Currency {
        var name: String { return "United States" }
        var code: String { return "USD" }
        var flagCode: String { return "us" }
    }
    
    struct Mexico: Currency {
        var name: String { return "Mexico" }
        var code: String { return "MXN" }
        var flagCode: String { return "mx" }
    }
    
    struct Canada: Currency {
        var name: String { return "Canada" }
        var code: String { return "CAD" }
        var flagCode: String { return "ca" }
    }
    
    struct Europe: Currency {
        var name: String { return "Europe" }
        var code: String { return "EUR" }
        var flagCode: String { return "EU" }
    }
    
    struct GreatBritain: Currency {
        var name: String { return "Great Britain" }
        var code: String { return "GBP" }
        var flagCode: String { return "gb" }
    }
    
    struct Australia: Currency {
        var name: String { return "Australia" }
        var code: String { return "AUD" }
        var flagCode: String { return "au" }
    }
    
    
}
