//
//  StationOccupancy.swift
//  Charger
//
//  Created by Hande Kara on 8/2/22.
//

import Foundation

struct StationOccupancyEndpoint: Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token
    
    var path: String {
        return "stations/\(DateSelectionViewModel.shared.stationID!)?userID=\(userID!)&date=\(DateSelectionViewModel.shared.date!)"
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
