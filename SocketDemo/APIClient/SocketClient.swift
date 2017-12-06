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
   
    let  manager = SocketManager(socketURL: URL(string: "http://107.174.238.50:10015/")!, config: [.log(false)])
    var socket:SocketIOClient?
    var user: User?
    
    func connect(){
        self.socket = manager.defaultSocket
        self.socket?.on(clientEvent: .connect) {data, ack in
            self.socket?.emitWithAck("canUpdate", 1).timingOut(after: 0) {data in
                self.socket?.emit("update", ["amount": 1 + 2.50])
            }
            ack.with("Got your currentAmount", "dude")
            self.retryLogin()
        }
        
        self.socket?.connect()
    }
    
    func retryLogin() {
        let sendData = [[ "email":  user?.email,
                              "password": user?.password,
                              "device_type": user?.device_type,
                              "device_token": "",
                              "user_lat": user?.lat,
                              "user_long": user?.long]]
        self.socket?.emit("login", ["test","test"])
    }
    
    func login(_ user:User){
        self.user = user
    }

    }


// self.socket?.handleEvent("Login", data: sendData, isInternalMessage:true , withAck: 1)
//self.socket?.on("AllDriverInfo") {data, ack in
//    print("Hey \(data)")
//}
//Dict
//["email": user.email,
// "password": user.password,
// "device_type": user.device_type,
// "device_token": user.device_type,
// "user_lat": user.lat,
// "user_long": user.long]

//JSON
//{
//    "email": "paraspahwa08@gmail.com",
//    "password": "123456",
//    "device_type": "IOS",
//    "device_token": "",
//    "user_lat": "1234.23",
//    "user_long": "1234.23"
//}

