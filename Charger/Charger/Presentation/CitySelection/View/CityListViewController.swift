//
//  CityListViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/16/22.
//

import UIKit

class CityListViewController: UIViewController {

    @IBOutlet weak var cityListTableView: UITableView!
    
    let viewModel = CitySelectionViewModel()
    var cityList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
        
        self.cityListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            await viewModel.getCityList()
        }
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)


        // set the text from the data model
        cell.textLabel?.text = self.cityList[indexPath.row]
        cell.textLabel?.textColor = Theme.cityListItemColor
        cell.textLabel?.font = Theme.cityListItemFont
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.cityList[indexPath.row])
    }
    
}

extension CityListViewController: CitySelectionViewModelDelegate {
    
    func didCityListFetched(data: [String]) {
        
        DispatchQueue.main.async {
            self.cityList = data
            self.cityListTableView.reloadData()
        }
    }
}
