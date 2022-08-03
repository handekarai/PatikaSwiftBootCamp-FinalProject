//
//  DateSelectionViewModel.swift
//  Charger
//
//  Created by Hande Kara on 8/2/22.
//

import Foundation

class DateSelectionViewModel: NSObject {
    
    // singleton pattern to access the location data anywhere in the project
    static let shared = DateSelectionViewModel()
    
    let model = DateSelectionModel()
    
    var stationID: Int!
    var date: String!
    
    func getStationOccupancy(stationID: Int, date: String) async{
        
        DateSelectionViewModel.shared.stationID = stationID
        DateSelectionViewModel.shared.date = date

        
        await model.fecthStationOccupancy(){ [weak self] result in
            
            switch result{
            case .success(let stationTimeDetail):
                print(stationTimeDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
}
