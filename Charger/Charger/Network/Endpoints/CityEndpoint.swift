//
//  CityEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/16/22.
//

import Foundation

struct CityEndpoint: Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token
    
    var path: String {
        return "provinces?userID=\(userID!)"
    }
    
    var method: HTTPRequest {
        return .get
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "token": token!
        ]
    }
    
    var body: [String : Any]?
    
    
}
