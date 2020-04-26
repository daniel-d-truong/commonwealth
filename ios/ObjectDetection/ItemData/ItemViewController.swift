//
//  ItemViewController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Toast_Swift
import PopupDialog

class ItemViewController: UIViewController {

    var item: String!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var socialFactorLabel: UILabel!
    @IBOutlet weak var healthcareLabel: UILabel!
    @IBOutlet weak var demandLevelLabel: UILabel!
    @IBOutlet weak var covidProximityLabel: UILabel!
    
    @IBOutlet weak var sustainableFactorLabel: UILabel!
    @IBOutlet weak var waterFootprintLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var impactPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!

  let POPUP_TITLES = ["WATER FOOTPRINT", "HEALTHCARE USAGE", "DEMAND", "LOCATION"]
    let POPUP_VALUES = ["liters", "high, medium, low, none", "high, medium, low, none", "high, medium, low, none"]
    let POPUP_DESCRIPTIONS = ["how much water goes into producing this item", "how essential this item is for healthcare professionals", "how in demand this product is", "the risk associated with confirmed cases in the region"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.tapPlus)), animated: true)
        
        // Components
        itemName.text = item
        imageView.image = UIImage(named: item.lowercased()) ?? UIImage(named: "chicken")
        
        let sevData = calculator.getSeverity(item: item)
        healthcareLabel.text = sevData?.heathNeed
        demandLevelLabel.text = sevData?.demand
        covidProximityLabel.text = sevData?.locationSeverity
        waterFootprintLabel.text = "\(sevData!.waterUsage)"
        let susString = String(format: "%.2f", (calculator.calcEnvCostRate() - 1) * 100) + "%"
        let socString = String(format: "%.2f", (calculator.calcSocialCostRate(item: item) - 1) * 100) + "%"
        sustainableFactorLabel.text = susString
        socialFactorLabel.text = socString
        
        setPrices()
        let wftap = UITapGestureRecognizer(target: self, action: #selector(self.wftapFunction))
        waterFootprintLabel.isUserInteractionEnabled = true
        waterFootprintLabel.addGestureRecognizer(wftap)
        
        let medtap = UITapGestureRecognizer(target: self, action: #selector(self.medtapFunction))
        healthcareLabel.isUserInteractionEnabled = true
        healthcareLabel.addGestureRecognizer(medtap)
        
        let demandtap = UITapGestureRecognizer(target: self, action: #selector(self.demandtapFunction))
        demandLevelLabel.isUserInteractionEnabled = true
        demandLevelLabel.addGestureRecognizer(demandtap)
        
        let covtap = UITapGestureRecognizer(target: self, action: #selector(self.covtapFunction))
        covidProximityLabel.isUserInteractionEnabled = true
        covidProximityLabel.addGestureRecognizer(covtap)
    }
    
    @objc func wftapFunction(sender:UITapGestureRecognizer) {
        createPopup(index: 0)
        print("tap working")
    }
    
    @objc func medtapFunction(sender:UITapGestureRecognizer) {
        createPopup(index: 1)
        print("tap working")
    }
    
    @objc func demandtapFunction(sender:UITapGestureRecognizer) {
        createPopup(index: 2)
        print("tap working")
    }
    
    @objc func covtapFunction(sender:UITapGestureRecognizer) {
        createPopup(index: 3)
        print("tap working")
    }
    
    func createPopup(index: Int) {
        let title = POPUP_TITLES[index]
        let message = POPUP_DESCRIPTIONS[index] + "\n\n" + POPUP_VALUES[index]
        
        let popup = PopupDialog(title: title, message: message)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func tapPlus() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartTableView") as! TableViewController
        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.performSegue(withIdentifier: "goToCart", sender: self)
    }
    
    func addToCart() {
//        self.view.makeToast("Added to cart")
        let itemData = ItemData(name: item)
        cart.addItem(item: itemData, quantity: self.stepperControl.value)
//        print(cart.items)
    }
    
    @IBAction func addCart(_ sender: Any) {
        addToCart()
        tapPlus()
    }
    
    @IBAction func stepperChange(_ sender: Any) {
        self.quantityLabel.text = String(Int(self.stepperControl.value))
        setPrices()
    }
    
    func setPrices() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$\(calculator.getPriceString(item: item, quantity: Int(self.stepperControl.value)))")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        self.originalPrice.attributedText = attributeString
        self.impactPrice.text = "+\(calculator.getSocialCostAmountString(item: item, quantity: Int(self.quantityLabel.text!)!))"
        self.totalPrice.text = String(format: "$%.2f", calculator.calcActualTotalCost(item: item, quantity: Int(self.stepperControl.value)))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
