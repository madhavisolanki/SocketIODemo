//
//  SocketDemoLocationManager.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol SocketDemoLocationManagerDelegate {
    func currentLocation()
    func getLocationName()
}

class SocketDemoLocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = SocketDemoLocationManager()
    var manager = CLLocationManager()
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var locationName: String?
    
    public var delegate:SocketDemoLocationManagerDelegate?
    
    func setUpLocationManager() {
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            startUpdatingLocation()
        }
    }
    private func locationManager(manager: CLLocationManager,
                                 didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
            }
        }
    }
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates: CLLocationCoordinate2D = (locations.first?.coordinate)!
        self.latitude    = coordinates.latitude
        self.longitude = coordinates.longitude
        self.manager.stopUpdatingLocation()
        reverseGeocoding()
        self.delegate?.currentLocation()
    }
    
    internal func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
    }
    
    func triggerLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            if self.manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)){
                self.manager.requestWhenInUseAuthorization()
            } else {
                self.startUpdatingLocation()
            }
        }
    }
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    func reverseGeocoding() {
        let location = CLLocation(latitude: self.latitude!, longitude: self.longitude!)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.locationName = pm?.subLocality
                self.stopUpdatingLocation()
                self.delegate?.getLocationName()
                print(pm?.locality ?? "Unable to fetch")
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
}
