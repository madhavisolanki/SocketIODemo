//
//  Driver.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import Foundation
import ObjectMapper

struct Driver:Mappable {
    var   driverRequestID: Int?
    var   user: User?
    var distance: String?
    var driverAddress: String?
    var driverCarName : String?
    var driverCarNo: Int?
    var  driverContactNo: Int16?
    var driverID: Int?
    var driverLat: String?
    var driverLng: String?
    var driverName: String?
    var driverPic: String?
    var driverRating: Int?
    var duty_status: String?
    var socketID: String?
    var  userID: Int?
    var v_seat: String?
    var v_type: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
       driverRequestID <- map["driverRequestID"]
        user <- map["celsius"]
        distance <- map["distance"]
        driverAddress <- map["driverAddress"]
        driverCarName <- map["driverCarName"]
        driverCarNo <- map["driverCarNo"]
        driverContactNo <- map["driverContactNo"]
        driverID <- map["driverID"]
        driverLat <- map["driverLat"]
        driverLng <- map["driverLng"]
        driverName <- map["driverName"]
        driverPic <- map["driverPic"]
        driverRating <- map["driverRating"]
        duty_status <- map["duty_status"]
        socketID <- map["socketID"]
        userID <- map["userID"]
        v_seat <- map["v_seat"]
        v_type <- map["v_type"]
    }
}

//["driverName": nitun singh, "driverCarNo": 526273, "socketID": y9KbJckFw3d38G1wAAAA, "driverContactNo": 918427377809, "driverCarName": vshshs, "driverRating": 4, "driverLat": 18.5655683, "driverPic": , "driverID": 59, "driverRequestID": 5959, "v_seat": 6, "v_type": Luxuary, "userID": 59, "distance": 0.01581045596540366, "driverLng": 73.9121383, "duty_status": 1, "driverAddress": ]

