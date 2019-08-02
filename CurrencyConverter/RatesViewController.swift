//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit
import SDWebImage

class RatesViewController: UIViewController {
    
    static let identifier = "CurrenciesViewController"
    
    @IBOutlet private var baseCurrencyFlagImageView: UIImageView!
    @IBOutlet private var baseCurrencyCodeLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    
    private var service: CurrencyService? {
        return (self.navigationController as? CurrencyNavigationController)?.currencyService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let basecurrencyRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectBasecurrency))
        self.baseCurrencyFlagImageView.addGestureRecognizer(basecurrencyRecognizer)
        self.baseCurrencyFlagImageView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBasecurrencyUI()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        DispatchQueue.main.async {[unowned self] in
            self.tableView.reloadData()
        }
    }
    
    @objc private func selectBasecurrency() {
        if let service = self.service {
            let selectBaseController = BaseCurrencyTableController(service: service)
            self.present(selectBaseController, animated: true, completion: nil)
        }
    }
    
    private func setBasecurrencyUI() {
        if let service = self.service {
            self.baseCurrencyFlagImageView.sd_setImage(with: service.base.flagURL, completed: nil)
            self.baseCurrencyCodeLabel.text = service.base.code
        }
    }

}

extension RatesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.service?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RateCell.reuseIdentifier, for: indexPath) as! RateCell
        
        if let rate = self.service?.rates[indexPath.row] {
            cell.configure(for: rate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let rate = self.service?.rates[indexPath.row] {
            (self.navigationController as? CurrencyNavigationController)?.showCalculator(for: rate)
        }
    }
    
    
}

extension RatesViewController: CurrencyServiceDelegate {
    func didFetchRates() {
        DispatchQueue.main.async {[unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func didFailFetch(with error: Error) {
        print("error")
    }
    
}
