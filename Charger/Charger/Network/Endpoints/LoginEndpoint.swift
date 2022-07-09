//
//  LoginEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/9/22.
//

import Foundation

struct LoginEndpoint : Endpoint {    
    
    var body: [String : Any]?
    
    var path: String {
        return "auth/login"
    }
    
    var method: HTTPRequest {
        .post
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
