//
//  StationListViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import UIKit

class StationListViewController: UIViewController {

    @IBOutlet weak var stationListTableView: UITableView!
    
    let viewModel = StationSelectionViewModel()

    var stationList: [Station] = []                 // list coming from api
    var searchedStationList: [Station] = []         // filtered list
    var searching: Bool = false                     // determines which list will be used in table view delegate funcs
    var selectedCity: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        getStationList()
        setupUI()
        addNotificationCenterObserver()
    }
    
  
    
    // adds observers to notification center to observe filtering mechanism
    private func addNotificationCenterObserver () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilteredStaionListNotification(_:)), name: NSNotification.Name(rawValue: "FilteredStationListNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoStationFilterNotification(_:)), name: NSNotification.Name(rawValue: "NoStationFilterNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedCityNotification(_:)), name: NSNotification.Name(rawValue: "SelectedCityNotification"), object: nil)
        
        // observes filter options
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilterOptionsNotification(_:)), name: NSNotification.Name(rawValue: "FilterOptionsNotification"), object: nil)
    }
    
    private func getStationList(){
        Task.init{
            await viewModel.getStationList(for: selectedCity)
        }
    }
    
    private func setupUI(){
        
        self.stationListTableView.delegate = self
        self.stationListTableView.dataSource = self
        
        stationListTableView.register(UINib(nibName: "InfoCard", bundle: nil), forCellReuseIdentifier: "InfoCardCell")
    }
    
    //MARK: - @objc funcs
    // change search bar border color and view's visibility acccording to station list data
    @objc func handleFilteredStaionListNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let list = dict["filteredList"] as? [Station] {
                self.searchedStationList = list
                self.searching = true
                self.stationListTableView.reloadData()
            }
        }
    }
    
    @objc func handleFilterOptionsNotification(_ notification: NSNotification) {
        
        var filteredList: [Station] = []
        var filterForChargeType : Bool = true
        var filterForSocketType : Bool = true
        var filterForService : Bool = true
        var filterForDistance : Bool = true
        
        if let dict = notification.userInfo as NSDictionary? {
            if let filter = dict["filter"] as? Filter {
                
                // if filter is reset
                if filter.chargeType.isEmpty && filter.socketType.isEmpty && filter.service.isEmpty && filter.distanceKM == 15 {
                    self.getStationList()
                }else {
                    for station in stationList {
                        var chargeTypes = Set<String>()
                        
                        for socket in station.sockets {
                            chargeTypes.update(with: socket.chargeType ?? "")
                        }
                        
                        var socketTypes = Set<String>()
                        for socket in station.sockets {
                            socketTypes.update(with: socket.socketType ?? "")
                        }
                        
                        let services = Set(station.services)
                        
                        // filterForChargeType is true when station has selected charges types
                        if !filter.chargeType.isEmpty {
                            filterForChargeType = Set(filter.chargeType).isSubset(of: chargeTypes)
                        }
                        // filterForSocketType is true when station has selected socket types
                        if !filter.socketType.isEmpty {
                            filterForSocketType = Set(filter.socketType).isSubset(of: socketTypes)
                        }
                        // filterForService is true when station has selected services
                        if !filter.service.isEmpty {
                            filterForService = Set(filter.service).isSubset(of: services)
                        }
                        
                        if LoginViewModel.shared.isLocationPermissionGiven && filter.distanceKM != 15 {
                            filterForDistance = Int(station.distanceInKM!) <= Int(filter.distanceKM)
                        }
                        
                        // if all cases are true than add station to filtered list
                        if filterForChargeType && filterForSocketType && filterForService && filterForDistance{
                            filteredList.append(station)
                        }
                    }
                    
                    self.stationList = filteredList
                    self.stationListTableView.reloadData()
                }
            
            }
        }
       
    }
    
    // change view to initial state
    @objc func handleNoStationFilterNotification(_ notification: NSNotification) {
        self.searching = false
        self.stationListTableView.reloadData()
    }
    
    // sets value of selectedCity that is coming from StationSelectionViewController
    @objc func handleSelectedCityNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            self.selectedCity = dict["selectedCity"] as! String
        }
    }
}

//MARK: - UITableViewDelegate funcs
extension StationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searching ? searchedStationList.count : stationList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCardCell", for: indexPath) as! InfoCardTableViewCell
       
        // set list that will be used by cell for filling cell's fields
        let listWillBeUsedForCell: [Station] = searching ? self.searchedStationList : self.stationList
        
        cell.deleteButton.isHidden = true
        
        // change "Hizmet saatleri:" to greyscale color, rest of them are white
        cell.firstSubInfoStackLeadingLabel.attributedText =  "Hizmet saatleri: 24 Saat".changeTextAttributesWithSpecificRange(with: "Hizmet saatleri:".count)
        
        // if there is no location permission then hides km info
        if LoginViewModel.shared.isLocationPermissionGiven {
            cell.firstSubInfoStackTrailingLabel.text = String(format: "%.1f", listWillBeUsedForCell[indexPath.section].distanceInKM ?? 0) + " km"
        }else{
            cell.firstSubInfoStackTrailingLabel.isHidden = true
        }
        
        // set image according to socket types of station
        cell.miniImageView.image = UIImage(named: viewModel.getImageName(listWillBeUsedForCell[indexPath.section].sockets))
        
        // change "Uygun soket sayısı:" to greyscale color, rest of them are white
        cell.secondSubInfoStackLeadingLabel.attributedText = "Uygun soket sayısı: \(listWillBeUsedForCell[indexPath.section].socketCount - listWillBeUsedForCell[indexPath.section].occupiedSocketCount) / \(listWillBeUsedForCell[indexPath.section].socketCount)".changeTextAttributesWithSpecificRange(with: "Uygun soket sayısı:".count)
        
        // nothing will be shown in secondSubInfoStackTrailingLabel
        cell.secondSubInfoStackTrailingLabel.isHidden = true
        
        // set station name
        cell.titleLabel.text = listWillBeUsedForCell[indexPath.section].stationName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    // for spaces beetwen cells in table view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // open date selection page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DateSelectionViewController") as? DateSelectionViewController {
            vc.selectedStation = searching ? self.searchedStationList[indexPath.section] : self.stationList[indexPath.section]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - StationSelectionViewModelDelegate funcs
extension StationListViewController: StationSelectionViewModelDelegate {
    
    // reloads station table view
    func didStationListFetched(data: [Station]) {
        DispatchQueue.main.async {
            self.stationList = data
            self.stationListTableView.reloadData()
        }
    }
}
