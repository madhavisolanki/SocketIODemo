//
//  ViewController.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import UIKit
import CoreLocation

class SocketViewController: UIViewController {

    var loginViewModel: UserViewModel = UserViewModel()
    var locationManager = SocketDemoLocationManager.sharedInstance

    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.setUpLocationManager()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login (latitude: String, longitude:String){
        loginViewModel.loginUser(latitude,longitude)
    }

}

extension SocketViewController:SocketDemoLocationManagerDelegate{
    func getLocationName() {
        
    }
    
    func currentLocation() {
        self.login(latitude: (self.locationManager.latitude?.description)!, longitude: (self.locationManager.longitude?.description)!)
        self.locationManager.delegate = nil
    }
}

