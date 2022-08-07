//
//  AppointmentDetailViewModel.swift
//  Charger
//
//  Created by Hande Kara on 8/6/22.
//

import Foundation

protocol AppointmentDetailViewModelDelegate: AnyObject {
    func didAppointmentCreated(data: AppointmentSummary)
}


class AppointmentDetailViewModel: NSObject {
    
    let model = AppointmentDetailModel()
    
    weak var delegate: AppointmentDetailViewModelDelegate?
    
    func doAppointment( stationID: Int, socketID: Int, timeSlot: String,appointmentDate: String) async {
               
        let appointmentToMake = AppointmentToMake(stationID: stationID, socketID: socketID, timeSlot: timeSlot, appointmentDate: appointmentDate)
        
        await model.makeAppointment(with: appointmentToMake ){ [weak self] result in
            
            switch result{
            case .success(let appointment):
                self?.delegate?.didAppointmentCreated(data: appointment)
            case .failure(let error):
                print(error)
                }
            }
        }
}
