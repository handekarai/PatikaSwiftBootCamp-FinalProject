//
//  ProfileViewModel.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func didUserEmailFecthed(data: String)
    func didUserDeviceIDFecthed(data: String)
}


class ProfileViewModel: NSObject {
    
    var model = ProfileModel()
    
    weak var delegate: ProfileViewModelDelegate?
    
    func getUserEmail() {
        self.delegate?.didUserEmailFecthed(data: model.fetchUserEmail())
    }
    
    func getUserDeviceID(){
        self.delegate?.didUserDeviceIDFecthed(data: model.fetchUserDeviceID())
    }
}
