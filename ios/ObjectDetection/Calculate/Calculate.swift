//
//  Calculate.swift
//  ObjectDetection
//
//  Created by Jesse Liang on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import SwiftCSV

struct CSVData {
    var water = Int()
    var need = Int()
    var medNeed = Int()
    var price = Float()
}

struct SeverityData {
    var waterUsage = Int()
    var locationSeverity = String()
    var heathNeed = String()
    var demand = String()
}

public class Calculate {
    
    let SEVERITY_LEVELS = ["High", "Medium", "Low", "None"]
    
    var csv:CSV? = nil
    var csvData:[String:CSVData]? = [:]
    
    var covidCsv:CSV? = nil
    var covidData:[String: Float]? = [:]
    
    var droughtCsv:CSV? = nil
    var droughtData:[String: Float]? = [:]
    
    var currentCounty: String? = nil
    var currentCoeff: Float = -1.0
    
    init() {
        do {
            let urlPath = Bundle.main.url(forResource: "foodprint", withExtension: "csv")
            csv = try CSV(url: urlPath!)
    //        csv = try CSV(url: URL(fileURLWithPath: "./ViewControllers/emergency-supplies.csv"))
            let namedRows = csv!.namedRows
            for i in 0...namedRows.count - 1 {
                let currRow = namedRows[i]
//                print(currRow)
                let waterFactor = Int(currRow["WF"]!)!
//                print(waterFactor)
                let need = Int(currRow["RD"]!)!
                let medNeed = Int(currRow["MD"]!)!
                let price = Float(currRow["P"]!)!
                csvData![currRow["Product"]!] = CSVData(water: waterFactor, need: need, medNeed: medNeed, price: price)
            }
            
            // loads covid data
            let covidUrlPath = Bundle.main.url(forResource: "covid_county", withExtension: "csv")
            covidCsv = try CSV(url: covidUrlPath!)
            let countyRows = covidCsv!.namedRows
            for i in 0...countyRows.count - 1 {
                let currRow = countyRows[i]
//                let cases = Int(currRow["4/24/20"]!)
                let coeff = Float(currRow["Scaled"]!)
                covidData![currRow["County Name"]!] = coeff
            }
            
            // loads drought data
            let droughtPath = Bundle.main.url(forResource: "droughts", withExtension: "csv")
            droughtCsv = try CSV(url: droughtPath!)
            let droughtRows = droughtCsv!.namedRows
            for i in 0...droughtRows.count - 1 {
                let currRow = droughtRows[i]
//                let cases = Int(currRow["4/24/20"]!)
                let coeff = Float(currRow["Water"]!)
                droughtData![currRow["County"]!] = coeff
            }
                        
        } catch {
            print(error)
        }
    }
    
    func calcWaterCost(item: String) -> Float {
        let currData = csvData![item]
        
        if (currData == nil) {
            return 0
        }
        
        let wf = currData?.water
        return Float(wf!) / 2880.0
    }
    
    func calcSocialCostRate(item: String) -> Float {
        let currData = csvData![item]
        
        if (currData == nil) {
            return 0
        }
        
        let casesCoeff = currentCoeff
        
        let need = currData?.need
        let medNeed = currData?.medNeed
        
        let rd = 1.0 + (1.0/Float(need!))
        let md = 1.0 + ((1.0/Float(medNeed!)) * 2)
        let locationFactor = 1.0 + (1.0/Float(casesCoeff))
        print (rd, md, locationFactor, currentCounty, currentCoeff)
        
        return rd * md * locationFactor
        
//        let need = currData!["Need"]!
//        let medNeed = currData!["MedNeed"]!
//        let demand = currData!["Demand"]!
//        let demPerc:Float = (Float(demand) + 100.0)/100.0
//        let demandMult:Float = (currData!["Demand"]!) >= 40 ? demPerc : 1.0
//        let med:Float = (Float(medNeed)*1.5 - Float(need))/400.0
//        let medDemand = med >= 0.0 ? med : 0.0
//        let rate = Float(quantity*2)/Float(demand) * pow(demPerc, Float(quantity - 1) * (medDemand + 1) * demandMult) + medDemand
//        let needFactor:Float = Float((need + 40 >= 100) ? 100 : need + 40) / 150.0
        // TODO: Include location as part of calculation somehow
//        Product,WF,MD,RD,Price
        //return rate * needFactor
    }
    
    func calcEnvCostRate() -> Float {
        return (droughtData?[currentCounty!] ?? 1.0)
    }
    
    func calcActualTotalCost(item: String, quantity: Int) -> Float {
        let socRate = self.calcSocialCostRate(item: item)
        let envRate = self.calcEnvCostRate()
        let wf = self.calcWaterCost(item: item)
        let price = csvData?[item]?.price ?? 0.0
        
//        print(socRate, envRate, wf, price)
        return (Float(quantity) * (price + wf)) * socRate * envRate
    }
    
    func getSeverity(item: String) -> SeverityData? {
        let data = csvData?[item]
        if (data == nil) {
            return nil
        }
        let locSev = SEVERITY_LEVELS[Int(currentCoeff.rounded()) - 1]
        let medDem = SEVERITY_LEVELS[data!.medNeed - 1]
        let dem = SEVERITY_LEVELS[data!.medNeed - 1]
        let water = data!.water
        return SeverityData(waterUsage: water, locationSeverity: locSev, heathNeed: medDem, demand: dem)
    }
    
    func getSocialCostAmountString(item: String, quantity: Int) -> String {
        let amount = self.calcActualTotalCost(item: item, quantity: 1)
        let price = csvData?[item]?.price
        if (price == nil) {
            return "0.00"
        }
        return String(format: "%.2f", (Float(quantity) * (amount - price!)))
    }
    
    /// Original price of the item
    func getPriceString(item: String) -> String {
        let price = csvData?[item]?.price
        if (price == nil) {
            return "0.00"
        }
        return String(format: "%.2f", price!)
    }
    
    func getPriceString(item:String, quantity:Int) -> String {
        let price = csvData?[item]?.price
        if (price == nil) {
            return "0.00"
        }
        return String(format: "%.2f", price!*Float(quantity))
    }
      
    func getItemNames() -> Array<String> {
        var value = Array<String>()
        for i in csvData!.keys {
          value.append(i)
        }
        return value
    }
    
    func getCountyCoeff() -> Int {
        return Int(covidData![self.currentCounty!] ?? -1.0)
    }
    
    func setCounty(_ county: String) {
        self.currentCounty = county
        self.currentCoeff = covidData?[county] ?? -1.0
    }
}

var calculator = Calculate()
