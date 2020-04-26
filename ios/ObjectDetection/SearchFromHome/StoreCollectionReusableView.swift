//
//  StoreCollectionReusableView.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import ModernSearchBar

class StoreCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var searchBar: ModernSearchBar!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cartIcon: UIImageView!
    
    func configure(places: [Store]) {
//        let insets = UIEdgeInsets(top: 0, left: 0.0, bottom: 0.0, right: 0.0)
//
//        self.scrollView.contentInset = insets
//        self.scrollView.scrollIndicatorInsets = insets
        print(places)
        for place in places {
            print(place)
            let button = UIButton()
            button.setTitle(place.name, for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
//            button.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
            stackView.addArrangedSubview(button)
        }
    }
}
