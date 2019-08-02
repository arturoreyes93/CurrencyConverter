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
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(root: CurrenciesViewController, service: CurrencyService) {
        self.currencyService = service
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers([root], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
