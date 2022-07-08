//
//  LoginModel.swift
//  Charger
//
//  Created by Hande Kara on 7/8/22.
//

import Foundation

class LoginModel : HTTPClient {
    
    
    func login(with user: User, _ completion: @escaping (Account)-> Void) async {
        
        let result =  await sendRequest(endpoint: LoginEndpoint(), responseModel: Account.self)
        
        switch result{
        case .success(let userAccount):
            completion(userAccount)
        case .failure(let error):
            print(error)
        }
        

    }
}
