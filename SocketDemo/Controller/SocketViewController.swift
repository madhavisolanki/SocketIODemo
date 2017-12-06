//
//  ViewController.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class SocketViewController: UIViewController {

    var loginViewModel: UserViewModel = UserViewModel()
    var locationManager = SocketDemoLocationManager.sharedInstance
    var marker = GMSMarker()

    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 4.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        self.marker.title = "Pune"
        self.marker.snippet = "India"
        self.marker.map = mapView
    }
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
    
    func setDriversNewLocation(location:CLLocation) {
        
    }
}

extension SocketViewController:SocketDemoLocationManagerDelegate{
    func getLocationName() {
        
    }
   
    func currentLocation() {
        self.login(latitude: (self.locationManager.latitude?.description)!, longitude: (self.locationManager.longitude?.description)!)
        if self.locationManager.longitude != nil{
            self.marker.map?.animate(to: GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude:self.locationManager.latitude!, longitude: self.locationManager.longitude!), zoom: 10.0))
            self.marker.position = CLLocationCoordinate2D(latitude:self.locationManager.latitude!, longitude: self.locationManager.longitude!)
        }
    }
}

