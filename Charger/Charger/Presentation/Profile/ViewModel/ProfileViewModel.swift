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
    func didUserLogout()
}


class ProfileViewModel: NSObject {
    
    var model = ProfileModel()
    
    weak var delegate: ProfileViewModelDelegate?
    
    // gets user's email info from model layer and triggers delegate func
    func getUserEmail() {
        self.delegate?.didUserEmailFecthed(data: model.fetchUserEmail())
    }
    
    // gets user's device id info from model layer and triggers delegate func
    func getUserDeviceID(){
        self.delegate?.didUserDeviceIDFecthed(data: model.fetchUserDeviceID())
    }
    
    /* my network layer returns successCodeWithNoReturnObject error
     when there are success code 200 and no object returns from network
     for that reason implemented delegation pattern in failure part with successCodeWithNoReturnObject error
     it means user logouts succesfully, if something returns with 200 code it would be nice*/
    func doLogout() async {
            await model.logout(){ [weak self] result in
                
                switch result{
                case .success(_): break

                case .failure(let error):
                    if error.self == .successCodeWithNoReturnObject{
                        self?.delegate?.didUserLogout()
                    }
                }
            }
    }
}
