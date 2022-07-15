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
    func didAppointmentDeleted(sectionID: Int)
}

enum MonthNameType{
    case short
    case long
}

class AppointmentsViewModel: NSObject {
    
    static let shared = AppointmentsViewModel()             // singleton for its endpoint
    let model = AppointmentsModel()                         // appointments model instance
    var appointmentID: Int?                                 // appointment ID it is for singleton pattern
    weak var delegate: AppointmentsViewModelDelegate?       // for delegation pattern to its view controllers
    
    /* my network layer returns successCodeWithNoReturnObject error
     when there are success code 200 and no object returns from network
     for that reason implemented delegation pattern in failure part with successCodeWithNoReturnObject error
     it means delete appointment succesfully done, if something returns with 200 code it would be nice */
    func deleteAppointment( appointmentID : Int,  sectionID: Int) async {
        
        // deleteAppointmentEndpoint.swift takes that argument to put the Url path
        AppointmentsViewModel.shared.appointmentID = appointmentID
        
        await model.deleteAppointment(){ [weak self] result in
            
            switch result{
            case .success(_): break

            case .failure(let error):
                if error.self == .successCodeWithNoReturnObject{
                    self?.delegate?.didAppointmentDeleted(sectionID: sectionID)
                }
            }
        }
    }
    
    // gets appointments from network
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
    
    // splits passed and current appointments
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
    
    // formats date like "14 Temmuz 2022" or "14 Tem 2022" according to type, if it is today then returns "Bugün"
    func formatDate(_ date: String, monthNameType: MonthNameType ) -> String {
                
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        if Calendar.current.isDateInToday(dateFormatterGet.date(from: date) ?? Date()){ return "Bugün" }
        
        let dateFormatterPrint = DateFormatter()
        
        switch monthNameType{
        case .short:
            dateFormatterPrint.dateFormat = "dd MMM yyyy"
        case .long:
            dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        }
        
        if let newDate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: newDate)
        } else {
           return date
        }
    }
    
    // returns image name according to charge type of socket
    func getImage(_ appointment: Appointment) -> String {
        let socket = appointment.station.sockets.filter({ $0.socketID == appointment.socketID})
        
        switch socket.first?.chargeType{
        case "AC":
            return "avatar2"
        case "DC":
            return "avatar"
        case .none:
            return "avatar1"  // cant find documantation that AC/DC(avatar1) situation, it may be wrong
        case .some(_):
            return "avatar1"  // cant find documantation that AC/DC(avatar1) situation, it may be wrong
        }
        
    }
    
    // returns socket's type and charge type
    func getSocketAndChargeType(_ appointment: Appointment) -> String {
        let socket = appointment.station.sockets.filter({ $0.socketID == appointment.socketID})
        return (socket.first?.chargeType ?? "null") + " · " + (socket.first?.socketType ?? "null")
    }
    
    // returns socket's power info
    func getPowerInfo(_ appointment: Appointment) -> String {
        let socket = appointment.station.sockets.filter({ $0.socketID == appointment.socketID})
        return "\(socket.first?.power ?? 0) " +  (socket.first?.powerUnit ?? "")
    }
}
