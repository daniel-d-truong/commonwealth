//
//  StoreCollectionReusableView.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import ModernSearchBar
import TTGTagCollectionView

class StoreCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var searchBar: ModernSearchBar!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cartIcon: UIImageView!
    
    var placesMap: [String: Store] = [:]
    var tagView: TTGTextTagCollectionView!
    
    func configure(places: [Store], delegate: TTGTextTagCollectionViewDelegate) {
//        let insets = UIEdgeInsets(top: 0, left: 0.0, bottom: 0.0, right: 0.0)
//
//        self.scrollView.contentInset = insets
//        self.scrollView.scrollIndicatorInsets = insets
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)

        let textConfig = TTGTextTagConfig()
        textConfig.backgroundColor = UIColor.white
        textConfig.borderColor = UIColor(hex: "#8E8E93")
        textConfig.borderWidth = 5
        textConfig.textColor = UIColor(hex: "#5F5F64")
        textConfig.exactHeight = 15
        textConfig.textFont = UIFont.systemFont(ofSize: 15)
        
        if tagView == nil {
            tagView = TTGTextTagCollectionView(frame: rect)
            tagView.scrollDirection = TTGTagCollectionScrollDirection.horizontal
            tagView.showsVerticalScrollIndicator = false
            tagView.delegate = delegate
            view.insertSubview(tagView, belowSubview: searchBar)
        }
        
        
        var tags: [String] = []
        for place in places {
            tags.append(place.name)
            placesMap[place.name] = place
        }
        
        tagView.addTags(tags, with: textConfig)
    
    }
        
}
