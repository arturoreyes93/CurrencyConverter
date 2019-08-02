//
//  currencyCell.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import UIKit
import SDWebImage

class RateCell: UITableViewCell {
    
    static let reuseIdentifier = "RateCell"

    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var currencyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(for rate: Rate) {
        self.flagImageView.sd_setImage(with: rate.currency.flagURL, completed: nil)
        self.currencyLabel.text = "\(rate.conversion) " + rate.currency.code
    }
}
