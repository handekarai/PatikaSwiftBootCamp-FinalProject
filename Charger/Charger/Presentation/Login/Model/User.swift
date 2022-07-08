//
//  User.swift
//  Charger
//
//  Created by Hande Kara on 7/8/22.
//

import Foundation

struct User: Encodable{
    var email: String
    var deviceUDID: String
}

struct Account: Decodable{
    var email: String
    var token: String
    var userID: Int
}
