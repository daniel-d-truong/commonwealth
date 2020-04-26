//
//  ChooseViewController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import CoreLocation

class ChooseViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var atHomeButton: UIButton!
    @IBOutlet weak var atStoreButton: UIButton!
    
    let locationManager = CLLocationManager()
    var county: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func homeTap(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func storeTap(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cameraController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
 
            print("Current location: \(currentLocation)")
            getZipCode(location: currentLocation, completionHandler: self.setCounty)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getZipCode(location: CLLocation, completionHandler: @escaping (String) -> Void){
        
        let url = URL(string: "https://geo.fcc.gov/api/census/area?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&format=json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            let resultJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            
            if let dictionary = resultJson as? [String: Any] {
                if let nestedList = dictionary["results"] as? [[String: Any]] {
                    // access nested dictionary values by key
                    if let obj = nestedList[0] as? [String: Any] {
                        let county = "\(obj["county_name"]!) County"
//                        print("\(obj["county_name"]!) County")
                        completionHandler(county)
                    }
                }
            }
        }
        task.resume()
    }
    
    func setCounty(_ county: String) {
        self.county = county
        print(self.county!)
        print(calculator.getCountyCovid(self.county!))
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
