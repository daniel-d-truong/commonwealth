//
//  StoreItemCollectionViewCell.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class StoreItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storeItemName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var navigateToItemController: ((String) -> Void )!
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        navigateToItemController(storeItemName.text!)
    }
}
