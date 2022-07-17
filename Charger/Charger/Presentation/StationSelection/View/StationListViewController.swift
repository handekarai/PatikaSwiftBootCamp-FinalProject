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
        
        setupUI()
        addNotificationCenterObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task.init{
            await viewModel.getStationList(for: selectedCity)
        }
    }
    
    // adds observers to notification center to observe filtering mechanism
    private func addNotificationCenterObserver () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilteredStaionListNotification(_:)), name: NSNotification.Name(rawValue: "FilteredStationListNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoStationFilterNotification(_:)), name: NSNotification.Name(rawValue: "NoStationFilterNotification"), object: nil)
    }
    
    
    private func setupUI(){
        
        self.stationListTableView.delegate = self
        self.stationListTableView.dataSource = self
        
        stationListTableView.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedCityNotification(_:)), name: NSNotification.Name(rawValue: "SelectedCityNotification"), object: nil)
    }
    
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
    
    // change view to initial state
    @objc func handleNoStationFilterNotification(_ notification: NSNotification) {
        self.searching = false
        self.stationListTableView.reloadData()
    }
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
       
        // set list that will be used by cell for filling cell's fields
        let listWillBeUsedForCell: [Station] = searching ? self.searchedStationList : self.stationList
        
        cell.miniImageView.image = UIImage(named: viewModel.getImageName(listWillBeUsedForCell[indexPath.section].sockets))
        cell.titleLabel.text = listWillBeUsedForCell[indexPath.section].stationName
        cell.deleteButton.isHidden = true
        cell.dateLabel.text = "Hizmet saatleri: 24 Saat"
        
        // if there is no location permission then hides km info
        if LoginViewModel.shared.isLocationPermissionGiven {
            cell.alarmLabel.text = String(format: "%.1f", listWillBeUsedForCell[indexPath.section].distanceInKM ?? 0) + " km"
        }else{
            cell.alarmLabel.isHidden = true
        }
        
        cell.socketNumberLabel.text = "Uygun soket sayısı:  \(listWillBeUsedForCell[indexPath.section].socketCount - listWillBeUsedForCell[indexPath.section].occupiedSocketCount) / \(listWillBeUsedForCell[indexPath.section].socketCount)"
        cell.socketTypeLabel.isHidden = true
        
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
