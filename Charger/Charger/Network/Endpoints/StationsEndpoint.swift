//
//  StationsEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import Foundation

struct StationsEndpoint: Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token
    
    var path: String {
        if(LoginViewModel.shared.isLocationPermissionGiven){
            return "stations?userID=\(userID!)&userLatitude=\(LoginViewModel.shared.location!.latitude)&userLongitude=\(LoginViewModel.shared.location!.longitude)"
        }else{
            return "stations?userID=\(userID!)"
        }
        
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
