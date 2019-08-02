//
//  BasecurrencyTableViewController.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit

class BaseCurrencyTableController: UITableViewController {
    
    private var service: CurrencyService
    init(service: CurrencyService) {
        self.service = service
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currencies.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currency = Currencies.list[indexPath.row]
        cell.imageView?.sd_setImage(with: currency.flagURL, completed: nil)
        cell.textLabel?.text = currency.name
        cell.accessoryType = (currency.name == service.base.name) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = Currencies.list[indexPath.row]
        self.service.updateBase(with: currency)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .black
        headerLabel.font = .systemFont(ofSize: 28)
        headerLabel.textColor = .white
        headerLabel.numberOfLines = 0
        headerLabel.adjustsFontSizeToFitWidth = true
        headerLabel.textAlignment = .center
        headerLabel.text = "Select a base currency"
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

}
