//
//  currencyCell.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit
import SDWebImage

class CurrencyCell: UITableViewCell {
    
    static let reuseIdentifier = "currencyCell"

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(for currency: Currency) {
        self.flagImageView.sd_setImage(with: currency.flagURL, completed: nil)
        self.currencyLabel.text = currency.code
    }
}
