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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(item: ItemData?) {
//        print(self.titleLabel)
//        print(item)
//        print("Name: " + item!.name)
        self.titleLabel.text = item?.name
    }

}
