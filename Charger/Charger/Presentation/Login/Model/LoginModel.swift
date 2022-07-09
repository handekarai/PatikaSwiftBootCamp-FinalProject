//
//  LoginModel.swift
//  Charger
//
//  Created by Hande Kara on 7/8/22.
//

import Foundation

class LoginModel : HTTPClient {
    
    
    func login(with user: User, _ completion: @escaping (Account)-> Void) async {
        var endpoint = LoginEndpoint()
        endpoint.body = (try? user.toDictionary(JSONEncoder())) ?? [:]
        let result =  await sendRequest(endpoint: endpoint, responseModel: Account.self)
        
        switch result{
        case .success(let userAccount):
            completion(userAccount)
        case .failure(let error):
            print(error)
        }
        

    }
}
