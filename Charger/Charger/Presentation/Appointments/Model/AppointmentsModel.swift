//
//  AppointmentsModel.swift
//  Charger
//
//  Created by Hande Kara on 7/11/22.
//

import Foundation

class AppointmentsModel: HTTPClient {
    
    // delete specific appointment
    // my network layer returns decode error when there are success code 200 and no object returns from network
    // for that reason implemented delegation pattern in failure part with decode error
    // it means delete appointment succesfully done, if something returns with 200 code it would be nice
    func deleteAppointment(_ completion: @escaping (Result<Appointment,RequestError>)-> Void) async {
        let endpoint = DeleteAppointmentEndpoint()
        let result =  await sendRequest(endpoint: endpoint, responseModel: Appointment.self)
       
        switch result{
        case .success(_): break
        case .failure(let error):
            completion(.failure(error))
        }

    }
    
    // fetches appointments
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
