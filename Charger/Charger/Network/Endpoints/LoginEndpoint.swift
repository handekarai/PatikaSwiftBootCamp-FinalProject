//
//  LoginEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/9/22.
//

import Foundation

struct LoginEndpoint : Endpoint {    
    
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
    
    var body: [String : String]? {
        return [
            "email":"arcelikiotdev@arcelik.com",
            "deviceUDID":"FFFF424242"
        ]
    }
}
