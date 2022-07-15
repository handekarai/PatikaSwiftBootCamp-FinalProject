//
//  ProfileModel.swift
//  Charger
//
//  Created by Hande Kara on 7/15/22.
//

import Foundation

class ProfileModel: HTTPClient {

    // fetches email info from singleton pattern of Login ViewModel
    func fetchUserEmail() -> String {
        return LoginViewModel.shared.user?.email ?? "null"
    }
    
    // fetches device id info from singleton pattern of Login ViewModel
    func fetchUserDeviceID() -> String {
        return LoginViewModel.shared.user?.deviceUDID ?? "null"
    }
    
    /* my network layer returns decode error when there are success code 200 and no object returns from network
       for that reason implemented delegation pattern in failure part with decode error
       it means user logouts succesfully, if something returns with 200 code it would be nice*/
    func logout(_ completion: @escaping (Result<Account,RequestError>)-> Void) async {
        let endpoint = LogoutEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: Account.self)
        
        switch result{
        case .success(_): break
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
