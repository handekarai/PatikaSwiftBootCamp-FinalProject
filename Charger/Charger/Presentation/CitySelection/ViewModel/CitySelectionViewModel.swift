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
}
