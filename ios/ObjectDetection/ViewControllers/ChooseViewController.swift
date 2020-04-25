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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
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
