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
import TTGTagCollectionView

//Suppose this is your datamodel
struct Store {
    var name: String
    var lat: Double
    var lng: Double
}


class SearchViewController: UICollectionViewController, ModernSearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: ModernSearchBar!
    var currentLocation: CLLocation!
    var storeList: [Store] = []
    var itemList: [String] = []
    var ogItemList: [String] = []
    
    var placeInventoryMap: [String: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded")
        
        // Do any additional setup after loading the view.
        
        // 1 - With an Array<String>
        itemList = calculator.getItemNames()
        ogItemList = calculator.getItemNames()

        placeInventoryMap["general"] = itemList
        
        self.collectionView.reloadData()

//        self.searchBar.setDatas(datas: itemList)
        
        self.loadPlacesNearBy()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "storeItemCell", for: indexPath) as! StoreItemCollectionViewCell
        let itemStr = self.itemList[indexPath.row]
        cell.storeItemName.text = itemStr
        
        let image = UIImage(named: itemStr.lowercased())
        cell.imageView.image = image ?? UIImage(named: "chicken")
        
        cell.navigateToItemController = self.navigateToItemController
        cell.addGestureRecognizer(UITapGestureRecognizer(target: cell, action: #selector(cell.handleTap(gestureRecognizer:))))

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableCell", for: indexPath) as? StoreCollectionReusableView else {
                    fatalError("Invalid view type")
            }
            headerView.configure(places: self.storeList, delegate: self)
            headerView.searchBar.delegateModernSearchBar = self
            headerView.searchBar.setDatas(datas: self.itemList)
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.itemList = self.ogItemList
            self.collectionView.reloadData()
        }
    }
    
    func onClickItemSuggestionsView(item: String) {
        print("User touched " + item)
        self.itemList = self.ogItemList.filter{ $0.contains(item) }
        self.collectionView.reloadData()
    }
    
    func navigateToItemController(item: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "itemViewController") as! ItemViewController
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(itemList)
//        self.itemList = self.ogItemList.filter{
//            $0.hasPrefix(searchText)
//        }
//        print(itemList)
//    }

    func loadPlacesNearBy() {
        if self.currentLocation == nil {
            return
        }
        self.storeList = []
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
//                    print(self.storeList)
                }
        
        task.resume()
    }

    

}

extension SearchViewController: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        print(tagText)
        self.itemList = self.placeInventoryMap[tagText] ?? self.itemList.shuffled()
        self.placeInventoryMap[tagText] = self.itemList
        self.collectionView.reloadData()
    }
}
