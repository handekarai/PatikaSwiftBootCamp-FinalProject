//
//  AppointmentDetailModel.swift
//  Charger
//
//  Created by Hande Kara on 8/6/22.
//

import Foundation

class AppointmentDetailModel : HTTPClient {
    
    func makeAppointment(with appointment: AppointmentToMake, _ completion: @escaping (Result<AppointmentSummary,RequestError>)-> Void) async {
        var endpoint = MakeAppointmentEndpoint()
        endpoint.body = (try? appointment.toDictionary(JSONEncoder())) ?? [:]
        let result =  await sendRequest(endpoint: endpoint, responseModel: AppointmentSummary.self)
        
        switch result{
        case .success(let appointment):
            completion(.success(appointment))
        case .failure(let error):
            completion(.failure(error))
        }
        

    }
}
