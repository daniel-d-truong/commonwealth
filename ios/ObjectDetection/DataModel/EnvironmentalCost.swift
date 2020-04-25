//
//  EnvironmentalCost.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation

class EnvironmentalCost {
    var totalCost: Double
    var waterFootprint: Double
    var co2Contained: Double
    
    init() {
        self.waterFootprint = self.calcWaterFootprint()
        self.co2Contained = self.calcCO2Contained()
        self.totalCost = self.waterFootprint + self.co2Contained
    }
    
    func calcWaterFootprint() -> Double {
        return 5
    }
    
    func calcCO2Contained() -> Double {
        return 5
    }
}
