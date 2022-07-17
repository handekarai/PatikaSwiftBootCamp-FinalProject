//
//  StationSelectionModel.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import Foundation

class StationSelectionModel: HTTPClient {
        
    // fetches Station list from api
    func fecthStationList(_ completion: @escaping (Result<[Station],RequestError>)-> Void) async {
        let endpoint = StationsEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: [Station].self)
        
        switch result{
        case .success(let stationList):
            completion(.success(stationList))
        case .failure(let error):
            completion(.failure(error))
        }

    }
}
