//
//  CitySelectionViewModel.swift
//  Charger
//
//  Created by Hande Kara on 7/16/22.
//

import Foundation

protocol CitySelectionViewModelDelegate: AnyObject {
    func didCityListFetched(data: [String])
}

class CitySelectionViewModel: NSObject {
    
    var model = CitySelectionModel()
    
    weak var delegate: CitySelectionViewModelDelegate?
    
    // gets city list and transfers it with delegation 
    func getCityList() async {
        
        await model.fecthCityList(){  [weak self] result in
            
            switch result{
            case .success(let cityList):
                self?.delegate?.didCityListFetched(data: cityList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // filters citylist and notifies view controllers to change their views
    func filterCityList(searchedText: String, cityList: [String]) {
        let searchedCityList = cityList.filter { $0.lowercased().prefix(searchedText.count) == searchedText.lowercased() }
        let notificationDict: [String : [String]] = ["filteredList":searchedCityList]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilteredListNotification"), object: nil, userInfo: notificationDict)
    }
    
    // notifies view controllers to restart their views to first state
    func noFilter(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NoFilterNotification"), object: nil)
    }
    
}
