//
//  ProfileModel.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import Foundation

class ProfileModel {
    
    func fetchUserEmail() -> String {
        return LoginViewModel.shared.user?.email ?? "null"
    }
    
    func fetchUserDeviceID() -> String {
        return LoginViewModel.shared.user?.deviceUDID ?? "null"
    }

}
