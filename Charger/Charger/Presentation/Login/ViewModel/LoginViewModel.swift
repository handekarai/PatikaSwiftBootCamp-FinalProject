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
    
    // login model instance
    private var model = LoginModel()
    
    var user: User?
    var userAccount: Account?
    var location: CLLocationCoordinate2D?
    var isLocationPermissionGiven: Bool = false
    var isNotificationPermissionGiven: Bool = false
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
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            
            if let error = error {
               print("notification error")
            }
            
            if granted {
                LoginViewModel.shared.isNotificationPermissionGiven = true
            }
        }
    }
    
    // login user with email and uuid
    func doLogin(_ email: String, _ uudi: String) async {
        
        let currentUser = User(email: email, deviceUDID: uudi)
        LoginViewModel.shared.user = currentUser
        
        await model.login(with: currentUser) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let userAccount):
                self.userAccount = userAccount
                LoginViewModel.shared.userAccount = userAccount
            case .failure(let error):
                print(error)
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
            self.location = location.coordinate
            LoginViewModel.shared.location = location.coordinate

        }
    }
    
    // failure to getting user's location
    func locationManager( _ manager: CLLocationManager,didFailWithError error: Error) {
        print(error)
    }
    
    // permission status
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus{
        case .authorizedAlways:
            LoginViewModel.shared.isLocationPermissionGiven = true
        case .authorizedWhenInUse:
            LoginViewModel.shared.isLocationPermissionGiven = true
        case .denied:
            LoginViewModel.shared.isLocationPermissionGiven = false
        case .notDetermined:
            LoginViewModel.shared.isLocationPermissionGiven = false
        case .restricted:
            LoginViewModel.shared.isLocationPermissionGiven = false
        @unknown default:
            print("error")
        }
    }
}

