//
//  FilterEnums.swift
//  Charger
//
//  Created by Hande Kara on 7/21/22.
//

import Foundation

struct Filter {
    var chargeType: [String]
    var socketType: [String]
    var distanceKM: Int
    var service: [String]
}

enum Service: String, Encodable {
    case buffet = "Büfe"
    case carPark = "Otopark"
    case wifi = "Wi-Fi"
}

enum ChargeType: String, Encodable {
    case ac = "AC"
    case dc = "DC"
}

enum SocketType: String, Encodable {
    case chademo = "CHAdeMO"
    case csc = "CSC"
    case type2 = "Type-2"
}
