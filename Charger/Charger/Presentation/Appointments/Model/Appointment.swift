//
//  Appointment.swift
//  Charger
//
//  Created by Hande Kara on 7/12/22.
//

import Foundation

struct Appointment: Decodable {
    var time, date: String
    var station: Station
    var stationCode, stationName: String
    var userID, appointmentID, socketID: Int
    var hasPassed: Bool
}
