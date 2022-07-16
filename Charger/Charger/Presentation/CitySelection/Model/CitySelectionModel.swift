//
//  CitySelectionModel.swift
//  Charger
//
//  Created by Hande Kara on 7/16/22.
//

import Foundation

class CitySelectionModel: HTTPClient {
    
    typealias City = [String]
    
    // fetches city list from api
    func fecthCityList(_ completion: @escaping (Result<City,RequestError>)-> Void) async {
        let endpoint = CityEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: City.self)
        
        switch result{
        case .success(let cityList):
            completion(.success(cityList))
        case .failure(let error):
            completion(.failure(error))
        }

    }
}
