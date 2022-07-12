//
//  Appointment.swift
//  Charger
//
//  Created by Hande Kara on 7/12/22.
//

import Foundation

struct Appointment: Codable {
    var time, date: String
    var station: Station
    var stationCode, stationName: String
    var userID, appointmentID, socketID: Int
    var hasPassed: Bool
}

// MARK: - Station
struct Station: Codable {
    var id: Int
    var stationCode: String
    var sockets: [Socket]
    var socketCount, occupiedSocketCount: Int
    var distanceInKM: Double
    var geoLocation: GeoLocation
    var services: [String]
    var stationName: String
}

// MARK: - GeoLocation
struct GeoLocation: Codable {
    var longitude, latitude: Double
    var province, address: String
}

// MARK: - Socket
struct Socket: Codable {
    var socketID: Int?
    var socketType, chargeType: String?
    var power: Int?
    var powerUnit: String?
    var socketNumber: Int?
}
