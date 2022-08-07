//
//  MakeAppointmentEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 8/6/22.
//

import Foundation

struct MakeAppointmentEndpoint : Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token
    
    var body: [String : Any]?
    
    var path: String {
        return "appointments/make?userID=\(userID!)"
    }
    
    var method: HTTPRequest {
        .post
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "token": token!
        ]
    }
}
