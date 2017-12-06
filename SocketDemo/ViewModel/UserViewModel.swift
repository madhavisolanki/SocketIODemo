//
//  LoginViewModel.swift
//  SocketDemo
//
//  Created by Madhavi Solanki on 06/12/17.
//  Copyright © 2017 Madhavi Solanki. All rights reserved.
//

import Foundation
import UIKit

public class UserViewModel {
    let socketClient = SocketClient.sharedInstance
    
    func loginUser(_ latitude: String, _ longitude:String){
        let user: User = User(email: "paraspahwa08@gmail.com",
                                 password: "123456",
                                 device_type: "IOS",
                                 device_token: "",
                                 lat: latitude,
                                 long: longitude,
                                 userID: 1)
        
        self.loginWithSocket(user)
    }

    func loginWithSocket(_ user:User){
        self.socketClient.login(user)
    }
}
