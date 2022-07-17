//
//  StationSelectionViewModel.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import Foundation

protocol StationSelectionViewModelDelegate: AnyObject {
    func didStationListFetched(data: [Station])
}

enum ChargeType: String {
    case ac = "AC"
    case dc = "DC"
}

enum ImageName: String {
    case ac = "avatar2"     // ac image
    case dc = "avatar"      // dc image
    case acdc = "avatar1"   // ac/dc image
    case none = "03"        // charger image
}

class StationSelectionViewModel: NSObject {
    
    var model = StationSelectionModel()
    
    weak var delegate: StationSelectionViewModelDelegate?
    
    // gets image name according to socket types of station
    func getImageName(_ sockets: [Socket]) -> String {
        
        let acSocket = sockets.filter({ $0.chargeType! == ChargeType.ac.rawValue})
        let dcSocket = sockets.filter({ $0.chargeType! == ChargeType.dc.rawValue})

        if !acSocket.isEmpty && !dcSocket.isEmpty {
            return ImageName.acdc.rawValue
        }
        
        if !acSocket.isEmpty && dcSocket.isEmpty{
            return ImageName.ac.rawValue
        }
        
        if acSocket.isEmpty && !dcSocket.isEmpty{
            return ImageName.dc.rawValue
        }
        return ImageName.none.rawValue
    }
    
    // gets Station list and transfers it with delegation
    func getStationList() async {
        
        await model.fecthStationList(){  [weak self] result in
            
            switch result{
            case .success(let stationList):
                self?.delegate?.didStationListFetched(data: stationList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
