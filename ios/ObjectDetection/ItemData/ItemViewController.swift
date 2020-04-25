//
//  ItemViewController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Toast_Swift

class ItemViewController: UIViewController {

    var item: String!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.tapPlus)), animated: true)
        itemName.text = item
    }
    
    @objc func tapPlus() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartTableView") as! TableViewController
        print(vc)
        print(self.navigationController)
        self.navigationController?.pushViewController(vc, animated: true)
        print("hello")
//        self.navigationController?.performSegue(withIdentifier: "goToCart", sender: self)
    }
    
    @IBAction func tapAddCart(_ sender: Any) {
        self.view.makeToast("Added to cart")
        let itemData = ItemData(name: item)
        cart.addItem(item: itemData)
        print(cart.items)
    }
    
    @IBAction func goToCart(_ sender: Any) {
        tapPlus()
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
