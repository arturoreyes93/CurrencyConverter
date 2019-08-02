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
    var flagURL: URL { get }
}

extension Currency {
    
    var code: String {
        return String(describing: self).replacingOccurrences(of: "()", with: "")
    }
    
    var flagURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.countryflags.io"
        components.path = "/" + self.flagCode + "/flat/64.png"
        return components.url!
    }
}

class Rate {
    let currency: Currency
    var rate: Double
    var multiplier: Double
    var conversion: Double { return rate * multiplier }
    
    init(for currency: Currency, rate: Double, multiplier: Double? = nil) {
        self.currency = currency
        self.rate = rate
        self.multiplier = multiplier ?? 1.0
    }
}


struct Currencies {
    
    static let list: [Currency] = [USD(), MXN(), CAD(), EUR(), GBP(), AUD(), BRL(), CLP(), CNY(), COU(), DKK(), PEN(), TRY(), JPY(), NZD(), CHF()]
    
    struct USD: Currency {
        var name: String { return "United States Dollar" }
        var flagCode: String { return "us" }
    }
    
    struct MXN: Currency {
        var name: String { return "Mexican Peso" }
        var flagCode: String { return "mx" }
    }
    
    struct CAD: Currency {
        var name: String { return "Canadian Dollar" }
        var flagCode: String { return "ca" }
    }
    
    struct EUR: Currency {
        var name: String { return "Euro" }
        var flagCode: String { return "EU" }
    }
    
    struct GBP: Currency {
        var name: String { return "Great Britain Pound" }
        var flagCode: String { return "gb" }
    }
    
    struct AUD: Currency {
        var name: String { return "Australian Dollar" }
        var flagCode: String { return "au" }
    }
    
    struct BRL: Currency {
        var name: String { return "Brazilian Real" }
        var flagCode: String { return "br" }
    }
    
    struct CLP: Currency {
        var name: String { return "Chilean Peso" }
        var flagCode: String { return "cl" }
    }
    
    struct CNY: Currency {
        var name: String { return "Yuan Renminbi" }
        var flagCode: String { return "cn" }
    }
    
    struct COU: Currency {
        var name: String { return "Unidad de Valor Real" }
        var flagCode: String { return "co" }
    }
    
    struct DKK: Currency {
        var name: String { return "Danish Krone" }
        var flagCode: String { return "dk" }
    }
    
    struct PEN: Currency {
        var name: String { return "Nuevo Sol" }
        var flagCode: String { return "pe" }
    }
    
    struct TRY: Currency {
        var name: String { return "Turkish Lira" }
        var flagCode: String { return "tr" }
    }
    
    struct JPY: Currency {
        var name: String { return "Yen" }
        var flagCode: String { return "jp" }
    }
    
    struct NZD: Currency {
        var name: String { return "New Zealand Dollar" }
        var flagCode: String { return "nz" }
    }
    
    struct CHF: Currency {
        var name: String { return "Swiss Franc" }
        var flagCode: String { return "au" }
    }
}
