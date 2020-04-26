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
    var totalCost: Float
    var totalImpact: Float
    var totalOriginal: Float
    
    init() {
        items = [:]
        totalCost = 0
        totalImpact = 0
        totalOriginal = 0
    }
    
    func addItem(item: ItemData, quantity: Double) {
        let itemStr = item.name
        totalCost += calculator.calcActualTotalCost(item: itemStr, quantity: Int(quantity))
        totalImpact += Float(calculator.getSocialCostAmountString(item: itemStr, quantity: Int(quantity)))!
        totalOriginal += Float(calculator.getPriceString(item: itemStr))! * Float(quantity)
        
        if items[item.name] == nil {
            items[item.name] = (item, quantity)
        } else {
            items[item.name]!.1 += quantity
        }
        
    }
    
    // TODO: Implement remove items
}

let cart = Cart();
