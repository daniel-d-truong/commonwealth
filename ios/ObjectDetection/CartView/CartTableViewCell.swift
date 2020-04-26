//
//  CartTableViewCell.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    static let identifier = "CartCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(itemTuple: (ItemData, Double)) {
//        print(self.titleLabel)
//        print(item)
//        print("Name: " + item!.name)
        let item = itemTuple.0
        let quantity = Int(itemTuple.1)
        
        titleLabel.text = item.name
        quantityLabel.text = String(quantity)
        priceLabel.text = "$\(calculator.getPriceString(item: item.name))"
        totalLabel.text = String(format: "$%.2f", calculator.calcActualTotalCost(item: item.name, quantity: quantity))
    }

}
