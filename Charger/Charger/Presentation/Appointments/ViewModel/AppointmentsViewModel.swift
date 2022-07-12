//
//  AppointmentsViewModel.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import Foundation

protocol AppointmentsViewModelDelegate : AnyObject{
    func passedAppointments(data: [Any])
    func currentAppointments(data: [Any])
    func noAppointments()
}


class AppointmentsViewModel: NSObject {
    
    weak var delegate: AppointmentsViewModelDelegate?

    // appointments model
    let model = AppointmentsModel()
    
    func getAppointments() async{
        await model.fecthAppointments(){ [weak self] result in
            
            switch result{
            case .success(let appointments):
                if(appointments.isEmpty){
                    self?.delegate?.noAppointments()
                }else{
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
