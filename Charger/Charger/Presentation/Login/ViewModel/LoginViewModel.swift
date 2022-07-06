//
//  SplashViewModel.swift
//  Charger
//
//  Created by Hande Kara on 7/5/22.
//

import CoreLocation
import UserNotifications

class LoginViewModel: NSObject {
    
    // singleton pattern to access the location data anywhere in the project
    static let shared = LoginViewModel()
    
    var location: Location?
    var isLocationPermissionGiven: Bool = false
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationPermissionSetup()
    }

    private func locationPermissionSetup(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // requests user's location, notification permission
    func requestPermission() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // notification permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
               print("notification error")
            }
            
            if granted {
                print("İzin verdi")
            } else {
                print("Vermedi")
            }
        }
    }
}

extension LoginViewModel: CLLocationManagerDelegate{
    
    // gets user's location
    func locationManager( _ manager: CLLocationManager,didUpdateLocations locations:[CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("\(latitude) \(longitude)");
            self.location? = Location(latitude: location.coordinate.latitude, longitude:location.coordinate.longitude)
        }
    }
    
    // failure to getting user's location
    func locationManager( _ manager: CLLocationManager,didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus{
        case .authorizedAlways:
            self.isLocationPermissionGiven = true
        case .authorizedWhenInUse:
            self.isLocationPermissionGiven = true
        case .denied:
            self.isLocationPermissionGiven = false
        case .notDetermined:
            self.isLocationPermissionGiven = false
        case .restricted:
            self.isLocationPermissionGiven = false
        @unknown default:
            print("error")
        }
    }
}
