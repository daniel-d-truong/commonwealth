//
//  TableViewController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var cartData: [(ItemData, Double)] = []
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var impactPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.refreshData()
        self.navigationItem.title = "My List"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cartData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ran here")
        print(indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        cell.setCell(itemTuple: (cartData[indexPath.row]))
        // Configure the cell...
        return cell
    }
    


    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    func refreshData() {
        var newArr: [(ItemData, Double)] = []
        for item in cart.items {
            newArr.append(item.value)
        }
        self.cartData = newArr
        setPrices()
        self.tableView.reloadData()
    }
    
    func setPrices() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: String(format: "$%.2f", cart.totalOriginal))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        self.originalPrice.attributedText = attributeString
        self.impactPrice.text = String(format: "+%.2f", cart.totalImpact)
        self.totalPrice.text = String(format: "$%.2f", cart.totalCost)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
