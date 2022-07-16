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
    
    var cityList: [String] = []                     // list coming from api
    var searchedCityList: [String] = []             // filtered list
    var searching: Bool = false                     // determines which list will be used in table view delegate funcs
    var searchedTextLength: Int = 0                 // searched text length during filtering
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        setupUI()
        addNotificationCenterObserver()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            await viewModel.getCityList()
        }
    }
    
    // adds observers to notification center to observe filtering mechanism
    private func addNotificationCenterObserver () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilteredListNotification(_:)), name: NSNotification.Name(rawValue: "FilteredListNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoFilterNotification(_:)), name: NSNotification.Name(rawValue: "NoFilterNotification"), object: nil)
    }
    
    private func setupUI(){
        
        self.cityListTableView.delegate = self
        self.cityListTableView.dataSource = self
        
        self.cityListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // changes specific part of text to bold
    private func changeTextAttributesWithSpecificRange(with searchedTextLength: Int, _ completeStringWithAttributedText: String) -> NSMutableAttributedString {
        
        // bold attribute
        let boldAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .heavy)]
  
        // create mutable attributed string & bold matching part
        let newAttributedText = NSMutableAttributedString(string: completeStringWithAttributedText)
        newAttributedText.setAttributes(boldAttribute, range: NSMakeRange(0, searchedTextLength))
    
        return newAttributedText
    }
    
    // changes searching to true so tableview uses searchedCityList data, reloads table view
    @objc func handleFilteredListNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let list = dict["filteredList"] as? [String] {
                self.searchedTextLength = dict["searchedTextLength"] as! Int
                self.searchedCityList = list
                self.searching = true
                self.cityListTableView.reloadData()

            }
        }
    }
    
    // changes boolean value to false so table view uses cityList data, reloads table view
    @objc func handleNoFilterNotification(_ notification: NSNotification) {
        self.searching = false
        self.cityListTableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate funcs
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchedCityList.count : cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
       
        // set the text value
        let cellTextLabel = searching ? self.searchedCityList[indexPath.row] : self.cityList[indexPath.row]
        
        // arrange text's font according to searching situation
        if searching {
            cell.textLabel?.attributedText = changeTextAttributesWithSpecificRange(with: self.searchedTextLength, cellTextLabel)
        }else{
            cell.textLabel?.text = cellTextLabel
            cell.textLabel?.textColor = Theme.cityListItemColor
            cell.textLabel?.font = Theme.cityListItemFont
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // open station selection page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "StationSelectionViewController") as? StationSelectionViewController{
            vc.selectedCity =  searching ? self.searchedCityList[indexPath.row] : self.cityList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// MARK: - CitySelectionViewModelDelegate funcs
extension CityListViewController: CitySelectionViewModelDelegate {
    
    // sets table view data and reloads table view
    func didCityListFetched(data: [String]) {
        DispatchQueue.main.async {
            self.cityList = data
            self.cityListTableView.reloadData()
        }
    }
}
