//
//  NavigationController.swift
//  ObjectDetection
//
//  Created by Daniel Truong on 4/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("smthn happened")
        // Do any additional setup after loading the view.
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as! ViewController
        self.performSegue(withIdentifier: "initialSegue", sender: nil)
        print("segue performed")
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
