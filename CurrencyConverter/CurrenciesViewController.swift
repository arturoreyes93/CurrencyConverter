//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit
import SDWebImage

class CurrenciesViewController: UIViewController {
    
    static let identifier = "CurrenciesViewController"
    
    @IBOutlet weak var baseCurrencyFlagImageView: UIImageView!
    @IBOutlet weak var baseCurrencyCodeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var service: CurrencyService? {
        return (self.navigationController as? CurrencyNavigationController)?.currencyService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let basecurrencyRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectBasecurrency))
        self.baseCurrencyFlagImageView.addGestureRecognizer(basecurrencyRecognizer)
        self.baseCurrencyFlagImageView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBasecurrencyUI()
    }
    
    @objc private func selectBasecurrency() {
        if let service = self.service {
            let selectBaseController = BasecurrencyTableViewController(service: service, delegate: self)
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

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currencies.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier, for: indexPath) as! CurrencyCell
        let currency = Currencies.list[indexPath.row]
        cell.configure(for: currency)
        return cell
    }
    
    
}

extension CurrenciesViewController: CurrencyServiceDelegate, UpdateBaseCurrencyDelegate {
    func didFetchRates() {
        self.tableView.reloadData()
    }
    
    func didFailFetch(with error: Error) {
        print("error")
    }
    
    func didUpdateBase() {
        self.setBasecurrencyUI()
        self.tableView.reloadData()
    }
    
}
