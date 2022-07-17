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
    
    // filters stationlist and notifies view controllers to change their views
    func filterStationList(searchedText: String, stationList: [Station]) {
        let searchedStationList = stationList.filter { $0.stationName.lowercased().prefix(searchedText.count) == searchedText.lowercased() }
        let notificationDict: [String : [Station]] = ["filteredList": searchedStationList]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilteredStationListNotification"), object: nil, userInfo: notificationDict)
    }
    
    // notifies view controllers to restart their views to first state
    func noFilter(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NoStationFilterNotification"), object: nil)
    }
    
    
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
    func getStationList(for selectedCity : String) async {
        
        await model.fecthStationList(){  [weak self] result in
            
            switch result{
            case .success(var stationList):
                stationList = stationList.filter({ $0.geoLocation.province == selectedCity})
                
                if LoginViewModel.shared.isLocationPermissionGiven {
                    stationList = stationList.sorted(by: { ($0.distanceInKM) ?? 0 < ($1.distanceInKM) ?? 0 })
                }
                
                self?.delegate?.didStationListFetched(data: stationList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
