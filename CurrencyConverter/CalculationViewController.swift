//
//  CalculationViewController.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit

class CalculationViewController: UIViewController {
    
    static let identifier = "CalculationViewController"
    
    var targetcurrency: Currency?

    @IBOutlet weak var targetFlagImageView: UIImageView!
    @IBOutlet weak var targetAmountLabel: UILabel!
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    
    @IBOutlet weak var baseFlagImageView: UIImageView!
    @IBOutlet weak var baseAmountTextField: UITextField!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
        @IBOutlet weak var padView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
