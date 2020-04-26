//
//  Calculate.swift
//  ObjectDetection
//
//  Created by Jesse Liang on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import SwiftCSV

public class Calculate {
    
    var csv:CSV? = nil
    var csvData:[String:[String:Int]]? = [:]
    var priceData:[String:Float]? = [:]
    
    var covidCsv:CSV? = nil
    var covidData:[String: Int]? = [:]
    
    var currentCounty: String? = nil
    
    init() {
        do {
            let urlPath = Bundle.main.url(forResource: "emergency-supplies", withExtension: "csv")
            csv = try CSV(url: urlPath!)
    //        csv = try CSV(url: URL(fileURLWithPath: "./ViewControllers/emergency-supplies.csv"))
            let namedRows = csv!.namedRows
            for i in 0...namedRows.count - 1 {
                let currRow = namedRows[i]
//                print(currRow)
                let need = Int(currRow["Need"]!)!
                let medNeed = Int(currRow["MedNeed"]!)!
                let demand = Int(currRow["Demand"]!)!
                let price = Float(currRow["Price"]!)!
                csvData![currRow["Item"]!] = ["Need": need, "MedNeed": medNeed, "Demand": demand] as [String:Int]
                priceData![currRow["Item"]!] = price
            }
            
            // loads covid data
            let covidUrlPath = Bundle.main.url(forResource: "covid_county", withExtension: "csv")
            covidCsv = try CSV(url: covidUrlPath!)
            let countyRows = covidCsv!.namedRows
            for i in 0...countyRows.count - 1 {
                let currRow = countyRows[i]
                let cases = Int(currRow["4/24/20"]!)
                covidData![currRow["County Name"]!] = cases
            }
            
        } catch {
            print(error)
        }
    }
    
    func calcSocTaxRate(item: String, quantity: Int) -> Float {
        let currData = csvData![item]
        
        if (currData == nil) {
            return 0
        }
        
        let need = currData!["Need"]!
        let medNeed = currData!["MedNeed"]!
        let demand = currData!["Demand"]!
        let demPerc:Float = (Float(demand) + 100.0)/100.0
        let demandMult:Float = (currData!["Demand"]!) >= 40 ? demPerc : 1.0
        let med:Float = (Float(medNeed)*1.5 - Float(need))/400.0
        let medDemand = med >= 0.0 ? med : 0.0
        let rate = Float(quantity*2)/Float(demand) * pow(demPerc, Float(quantity - 1) * (medDemand + 1) * demandMult) + medDemand
        let needFactor:Float = Float((need + 40 >= 100) ? 100 : need + 40) / 150.0
        // TODO: Include location as part of calculation somehow
        return rate * needFactor
    }
    
    func calcSocCost(item: String, quantity: Int) -> Float {
        let rate = self.calcSocTaxRate(item: item, quantity: quantity)
        let price = priceData?[item]
        if (price == nil) {
            return 0.0
        }
        return (Float(quantity) * price!) * (1 + rate)
    }
    
    func calcEnvCost(item: String, quantity: Int, price: Float) -> Float {
        return 10.0
    }
      
    func getItemNames() -> Array<String> {
        var value = Array<String>()
        for i in csvData!.keys {
          value.append(i)
        }
        return value
    }
    
    func getCountyCovid() -> Int {
        return covidData![self.currentCounty!] ?? -1
    }
    
    func setCounty(_ county: String) {
        self.currentCounty = county
    }
}

var calculator = Calculate()
