//
//  CurrencyNavigationController.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit

class CurrencyNavigationController: UINavigationController {
    
    var currencyService: CurrencyService
    
    init(root: CurrenciesViewController, base: Currency) {
        self.currencyService = CurrencyService(base: base, delegate: root)
        super.init(rootViewController: root)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
