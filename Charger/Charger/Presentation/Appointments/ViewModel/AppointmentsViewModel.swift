//
//  AppointmentsViewModel.swift
//  Charger
//
//  Created by Hande Kara on 7/10/22.
//

import Foundation

protocol AppointmentsViewModelDelegate : AnyObject{
    func passedAppointments(data: [Appointment])
    func currentAppointments(data: [Appointment])
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
                    self?.splitAppointmentsAccordingToType(appointments)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // split passed and current appointments
    private func splitAppointmentsAccordingToType(_ appointmentsList: [Appointment]){
        
        let currentAppointmentsList = appointmentsList.filter({ $0.hasPassed == false})
        let passedAppointmentsList = appointmentsList.filter({ $0.hasPassed == true})
        
        if (!currentAppointmentsList.isEmpty){
            self.delegate?.currentAppointments(data: currentAppointmentsList)
        }
        if (!passedAppointmentsList.isEmpty){
            self.delegate?.passedAppointments(data: passedAppointmentsList)
        }
    }
    
    func formatDate(_ date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        if let newDate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: newDate)
        } else {
           return date
        }
    }
    
    func getImage(_ appointment: Appointment) -> String {
        let socket = appointment.station.sockets.filter({ $0.socketID == appointment.socketID})
        
        switch socket.first?.chargeType{
        case "AC":
            return "avatar2"
        case "DC":
            return "avatar"
        case .none:
            return "avatar1"  // cant find documantation that AC/DC situation, it may be wrong
        case .some(_):
            return "avatar1"  // cant find documantation that AC/DC situation, it may be wrong
        }
        
    }
    
    func getSocketAndChargeType(_ appointment: Appointment) -> String {
        let socket = appointment.station.sockets.filter({ $0.socketID == appointment.socketID})
        return (socket.first?.chargeType ?? "null") + " · " + (socket.first?.socketType ?? "null")
    }
}
