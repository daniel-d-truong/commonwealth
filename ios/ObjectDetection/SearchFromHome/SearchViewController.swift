//
//  SearchViewController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import ModernSearchBar
import CoreLocation

//Suppose this is your datamodel
struct Store {
    var name: String
    var lat: Double
    var lng: Double
}


class SearchViewController: UIViewController, ModernSearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: ModernSearchBar!
    var currentLocation: CLLocation!
    var storeList: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded")
        
        // Do any additional setup after loading the view.
        self.searchBar.delegateModernSearchBar = self
        
        // 1 - With an Array<String>
        let itemList = calculator.getItemNames()

        self.searchBar.setDatas(datas: itemList)
        
        self.loadPlacesNearBy()
    }
    
    func onClickItemSuggestionsView(item: String) {
        print("User touched " + item)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "itemViewController") as! ItemViewController
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func loadPlacesNearBy() {
        if self.currentLocation == nil {
            return
        }
                let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(googleKey)&location=\(self.currentLocation.coordinate.latitude),\(self.currentLocation.coordinate.longitude)&radius=1500&type=grocery_or_supermarket")
                let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let data = data else { return }
                    
                    let resultJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    
                    if let dictionary = resultJson as? [String: Any] {
                        if let nestedList = dictionary["results"] as? [[String: Any]] {
                            // access nested dictionary values by key
                            for i in 0...nestedList.count-1 {
                                if let obj = nestedList[i] as? [String: Any] {
                                    let storeName = obj["name"] as! String
                                    
                                    if let locObj = obj["geometry"] as? [String: [String: Any]] {
                                        let storeLat = locObj["location"]!["lat"] as! Double
                                        let storeLng = locObj["location"]!["lng"] as! Double
                                        self.storeList.append(Store(name: storeName, lat: storeLat, lng: storeLng))
                                    }
                                }
                            }
                            
                        }
                    }
                    print(self.storeList)
                }
        
        task.resume()
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
