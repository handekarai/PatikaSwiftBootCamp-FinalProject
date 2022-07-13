//
//  AppointmentsModel.swift
//  Charger
//
//  Created by Hande Kara on 7/11/22.
//

import Foundation

class AppointmentsModel: HTTPClient {
    
    func deleteAppointment(_ completion: @escaping (Result<Appointment,RequestError>)-> Void) async {
        let endpoint = DeleteAppointmentEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: Appointment.self)
       
        switch result{
        case .success(let appointments):
            completion(.success(appointments))
        case .failure(let error):
            completion(.failure(error))
        }

    }
    
    
    func fecthAppointments(_ completion: @escaping (Result<[Appointment],RequestError>)-> Void) async {
        let endpoint = AppointmentsEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: [Appointment].self)
        
        switch result{
        case .success(let appointments):
            completion(.success(appointments))
        case .failure(let error):
            completion(.failure(error))
        }

    }
}
