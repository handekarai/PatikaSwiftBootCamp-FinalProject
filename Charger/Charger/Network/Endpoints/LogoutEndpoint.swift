//
//  LogoutEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import Foundation

struct LogoutEndpoint: Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token
    
    var path: String {
        return "auth/logout/\(userID!)"
    }
    
    var method: HTTPRequest {
        return .post
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "token": token!
        ]
    }
    
    var body: [String : Any]?
    
    
}
