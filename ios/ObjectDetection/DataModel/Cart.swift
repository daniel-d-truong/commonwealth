//
//  Cart.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation

class Cart {
    var items: [String: (ItemData, Double)]
    var totalCost: Double
    
    init() {
        items = [:]
        totalCost = 0
    }
    
    func addItem(item: ItemData, quantity: Double) {
        totalCost += item.getSocialCost().totalCost + item.getEnvironmentalCost().totalCost
        if items[item.name] == nil {
            items[item.name] = (item, quantity)
        } else {
            items[item.name]!.1 += quantity
        }
        
    }
    
    // TODO: Implement remove items
}

let cart = Cart();
