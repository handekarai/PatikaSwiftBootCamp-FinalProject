//
//  AppointmentsEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/11/22.
//

import Foundation

struct AppointmentsEndpoint : Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token    
    
    var body: [String : Any]?
    
    var path: String {
        if(LoginViewModel.shared.isLocationPermissionGiven){
            return "appointments/" + "\(userID!)?" +  "userLatitude=\(LoginViewModel.shared.location!.latitude)&userLongitude=\(LoginViewModel.shared.location!.longitude)"
        }else{
            return "appointments/" + "\(userID!)"
        }
    }
    
    var method: HTTPRequest {
        .get
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "token": token!
        ]
    }
}
