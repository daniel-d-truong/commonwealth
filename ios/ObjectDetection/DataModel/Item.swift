//
//  Item.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation

struct EnvironmentalCost {
    var totalCost: Double
    var waterFootprint: Double
    var co2Contained: Double
}

struct SocialCost {
    var totalCost: Double
}

class ItemData {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getSocialCost() -> SocialCost {
        let totalCost = 10.0
        return SocialCost(totalCost: totalCost)
    }
    
    func getEnvironmentalCost() -> EnvironmentalCost {
        let co2Contained = self.calcCO2Contained()
        let waterFootprint = self.calcWaterFootprint()
        let totalCost = co2Contained + waterFootprint
        return EnvironmentalCost(totalCost: totalCost, waterFootprint: waterFootprint, co2Contained: co2Contained)
    }
    
    func calcWaterFootprint() -> Double {
        return 5
    }
    
    func calcCO2Contained() -> Double {
        return 5
    }
}
