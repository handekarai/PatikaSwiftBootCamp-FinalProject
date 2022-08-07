//
//  Appointment.swift
//  Charger
//
//  Created by Hande Kara on 8/6/22.
//

import Foundation

struct AppointmentToMake: Encodable {
    var stationID: Int
    var socketID: Int
    var timeSlot: String
    var appointmentDate: String
}

// MARK: - AppointmentSummary
struct AppointmentSummary: Decodable {
    var time, date: String
    var station: Station
    var stationCode: String
    var userID, socketID: Int
}

