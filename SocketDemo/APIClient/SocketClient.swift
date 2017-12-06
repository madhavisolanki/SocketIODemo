//
//  SocketClient.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import Foundation
import Starscream
import UIKit

public class SocketClient {
    
    let socket = WebSocket(url: URL(string: "http://107.174.238.50:10015/")!)
   
    func connect(){
        socket.delegate = self 
        socket.onConnect = {
            print("websocket is connected")
        }
        //websocketDidDisconnect
        socket.onDisconnect = { (error: Error?) in
            print("websocket is disconnected: \(error?.localizedDescription)")
        }
        //websocketDidReceiveMessage
        socket.onText = { (text: String) in
            print("got some text: \(text)")
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            print("got some data: \(data.count)")
        }

        socket.connect()
        
    }
    
    func setAllDriverInfo(_driver: Driver){
        
    }
    
    func getAllDriverInfo(_driver: Driver){
        
    }
    
    func pingServer(){
        socket.write(string: "Hi Server!")
    }
    func login(_ user:User){
        let dict = [ "email":  user.email,
                                                "password": user.password,
                                                "device_type": user.device_type,
                                                "device_token": "",
                                                "user_lat": user.lat,
                                                "user_long": user.long]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            self.socket.write(data: jsonData) {
                print("Login")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension SocketClient:WebSocketDelegate {
    public func newBytesInStream() {
        
    }
    
    public func streamDidError(error: Error?) {
        
    }
    
    public func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
    }
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
}
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

