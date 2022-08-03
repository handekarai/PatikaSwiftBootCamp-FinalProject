//
//  StationWithTime.swift
//  Charger
//
//  Created by Hande Kara on 8/1/22.
//

import Foundation

// MARK: - StationTimeDetail
struct StationTimeDetail: Decodable {
    var stationID: Int
    var stationCode: String
    var sockets: [SocketWithTime]
    var geoLocation: GeoLocation
    var services: [String]
    var stationName: String
}

// MARK: - Socket
struct SocketWithTime: Decodable {
    var socketID: Int
    var day: Day
    var socketType, chargeType: String
    var power, socketNumber: Int
    var powerUnit: String
}

// MARK: - Day
struct Day: Decodable {
    var id: Int
    var date: String
    var timeSlots: [TimeSlot]
}

// MARK: - TimeSlot
struct TimeSlot: Decodable {
    var slot: String
    var isOccupied: Bool
}
