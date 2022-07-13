//
//  DeleteAppointmentEndpoint.swift
//  Charger
//
//  Created by Hande Kara on 7/13/22.
//

import Foundation

struct DeleteAppointmentEndpoint : Endpoint {
    
    private let userID = LoginViewModel.shared.userAccount?.userID
    private let token = LoginViewModel.shared.userAccount?.token
    private let appointmentID = AppointmentsViewModel.shared.appointmentID
    
    var path: String {
        return "appointments/cancel/\(appointmentID!)?userID=\(userID!)"
    }
    
    var method: HTTPRequest {
        .delete
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "token": token!
        ]
    }
    
    var body: [String : Any]?
    
    
}
