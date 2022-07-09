//
//  Location.swift
//  Charger
//
//  Created by Hande Kara on 7/5/22.
//

import CoreLocation

struct Location{
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
