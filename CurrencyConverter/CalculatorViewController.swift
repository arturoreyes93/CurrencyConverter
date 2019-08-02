//
//  CalculationViewController.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit
import LBTATools
import SDWebImage

class CalculatorViewController: UIViewController, NumberKeyPadDelegate {

    static let identifier = "CalculatorViewController"
    
    private var service: CurrencyService? {
        return (self.navigationController as? CurrencyNavigationController)?.currencyService
    }
    
    var rate: Rate?

    @IBOutlet private var targetFlagImageView: UIImageView!
    @IBOutlet private var targetAmountLabel: UILabel!
    @IBOutlet private var targetCurrencyLabel: UILabel!
    
    @IBOutlet private var baseFlagImageView: UIImageView!
    @IBOutlet private var baseAmountLabel: UILabel!
    @IBOutlet private var baseCurrencyLabel: UILabel!
    @IBOutlet private var padView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rate = rate, let service = self.service else { return }
        self.targetFlagImageView.sd_setImage(with: rate.currency.flagURL, completed: nil)
        self.baseFlagImageView.sd_setImage(with: service.base.flagURL, completed: nil)
        self.targetAmountLabel.text = "\(rate.conversion)"
        self.targetCurrencyLabel.text = rate.currency.code
        self.baseAmountLabel.text = "\(rate.multiplier)"
        self.baseCurrencyLabel.text = service.base.code
        self.setNumberPad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setNumberPad() {
        let keyPad = NumberKeyPad(delegate: self)
        self.padView.addSubview(keyPad)
        keyPad.fillSuperview()
        
    }
    
    private func amountUpdated() {
        guard let rate = self.rate else { return }
        if let text = self.baseAmountLabel.text, let multiplier = Double(text) {
            let targetAmount = rate.rate * multiplier
            let rounded = round(targetAmount * 1000)/1000
            self.targetAmountLabel.text = String(rounded)
        }
    }
    
    func numberKeyPressed(number: Int) {
        if let currentText = self.baseAmountLabel.text {
            self.baseAmountLabel.text = currentText.addingDigit(number)
            self.amountUpdated()
        }
    }
    
    func didDeleteLastNumber() {
        self.baseAmountLabel.text?.removeLast()
        if var currentText = self.baseAmountLabel.text {
            self.baseAmountLabel.text = currentText.deleteDigit()
            self.amountUpdated()
        }
    }
    
    func didFinishEditing() {
        guard let text = self.baseAmountLabel.text else { return }
        if let newMultiplier = Double(text) {
            self.rate?.multiplier = newMultiplier
            self.navigationController?.popViewController(animated: true)
        }
    }

}
