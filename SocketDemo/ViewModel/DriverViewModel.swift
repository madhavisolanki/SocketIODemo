//
//  DriverViewModel.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

public class DriverViewModel {
    let socketClient = SocketClient.sharedInstance
    var arrayDriver:[Driver] = [Driver]()
    
    func getAllDriverLocation(completion: @escaping ([CLLocationCoordinate2D]) -> Void){
        self.socketClient.getDriverInfo { drivers in
            if drivers.count > 0 {
                for driver in drivers {
                    let dict: Dictionary = driver as! Dictionary<String, Any>
                    let driversArray: NSArray = dict["allDriver"]  as! NSArray
                    if driversArray.count > 0 {
                        let driverDict:Dictionary = driversArray[0] as! Dictionary<String, Any>
                        print(driverDict)
                        let driverObj = Mapper<Driver>().map(JSON: driverDict)
                        self.arrayDriver.append(driverObj!)
                        defer{
                            self.addMarkerOnMap(completion: { arrayCoordinates in
                                completion(arrayCoordinates)
                            })
                        }
                    }
                }
            }
        }
    }
    
    func addMarkerOnMap(completion: @escaping ([CLLocationCoordinate2D]) -> Void) {
        var locationArray : [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        for driver in self.arrayDriver {
            let cordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:Double(driver.driverLat!)!, longitude: Double(driver.driverLng!)!)
                locationArray.append(cordinate)
        }
        completion(locationArray)
    }
}
