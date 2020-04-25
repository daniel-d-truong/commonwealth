//
//  SearchViewController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import ModernSearchBar

//Suppose this is your datamodel
struct Item {
  var name: String
  var city: String
}


class SearchViewController: UIViewController, ModernSearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: ModernSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded")
        
        // Do any additional setup after loading the view.
        self.searchBar.delegateModernSearchBar = self
        
        // 1 - With an Array<String>
        let itemList = calculator.getItemNames()

        self.searchBar.setDatas(datas: itemList)
    }
    
    func onClickItemSuggestionsView(item: String) {
        print("User touched " + item)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "itemViewController") as! ItemViewController
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func createSearchController() {
        
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
