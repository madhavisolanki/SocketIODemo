//
//  SocketClient.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import Foundation
import SocketIO
import UIKit

public class SocketClient {
   
    let  manager = SocketManager(socketURL: URL(string: "http://107.174.238.50:10015/")!, config: [.log(true)])
    var socket:SocketIOClient?
    var user: User?
    static let sharedInstance = SocketClient()

    func connect(){
        self.socket = manager.defaultSocket
        self.socket?.connect()
        self.retryLogin() 
    }
    
    func login(_ user:User){
        self.user = user
    }

    // MARK: - Login User
    func retryLogin() {
        self.socket?.emitWithAck("login", [ "email":  user?.email,
                                            "password": user?.password,
                                            "device_type": user?.device_type,
                                            "device_token": "",
                                            "user_lat": user?.lat,
                                            "user_long": user?.long]).timingOut(after: 100, callback: { data in
                                                print("Here is data\(data)")
                                            })
    }
    
    // MARK: - Get All Driver Info
    func getDriverInfo(completion: @escaping ([Any]) -> Void){
        self.socket?.on("AllDriverInfo") { (dataArray, socketAck) -> Void in
            completion(dataArray)
            self.socket?.disconnect()
        }
    }
    
    // MARK: - Set Driver Info
    func setDriverInfo(){
        self.socket?.emitWithAck("AllDriver", [ "userID":  "59",
                                            "userLat": user?.lat,
                                            "userLng": user?.long,
                                            "driverRequestID": "59"]).timingOut(after: 100, callback: { data in
                                                print("Here is data\(data)")
                                            })
        }
}
