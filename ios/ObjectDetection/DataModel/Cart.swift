//
//  Cart.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation

class Cart {
    var items: [ItemData]
    var totalCost: Double
    
    init() {
        items = []
        totalCost = 0
    }
    
    func addItem(item: ItemData) {
        items.append(item)
        totalCost += item.getSocialCost().totalCost + item.getEnvironmentalCost().totalCost
    }
    
    // TODO: Implement remove items
}

let cart = Cart();
