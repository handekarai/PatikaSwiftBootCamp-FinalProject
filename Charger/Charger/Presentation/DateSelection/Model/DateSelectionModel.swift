//
//  DateSelectionModel.swift
//  Charger
//
//  Created by Hande Kara on 8/2/22.
//

import Foundation

class DateSelectionModel: HTTPClient {
    
    // fetches occupancy of station
    func fecthStationOccupancy(_ completion: @escaping (Result<StationTimeDetail,RequestError>)-> Void) async {
        let endpoint = StationOccupancyEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: StationTimeDetail.self)
        
        switch result{
        case .success(let stationTimeDetail):
            completion(.success(stationTimeDetail))
        case .failure(let error):
            completion(.failure(error))
        }

    }

}
