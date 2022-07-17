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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        setupUI()
        Task.init{
            await viewModel.getStationList()
        }
    }
    
    private func setupUI(){
        
        self.stationListTableView.delegate = self
        self.stationListTableView.dataSource = self
        
        stationListTableView.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentTableViewCell")
    }
}

//MARK: - UITableViewDelegate funcs
extension StationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stationList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
       
        cell.miniImageView.image = UIImage(named: viewModel.getImageName(stationList[indexPath.section].sockets))
        cell.titleLabel.text = stationList[indexPath.section].stationName
        cell.deleteButton.isHidden = true
        cell.dateLabel.text = "Hizmet saatleri: 24 Saat"
        
        // if there is no location permission then hides km info
        if LoginViewModel.shared.isLocationPermissionGiven {
            cell.alarmLabel.text = String(format: "%.1f", stationList[indexPath.section].distanceInKM) + " km"
        }else{
            cell.alarmLabel.isHidden = true
        }
        
        cell.socketNumberLabel.text = "Uygun soket sayısı:  \(stationList[indexPath.section].socketCount - stationList[indexPath.section].occupiedSocketCount) / \(stationList[indexPath.section].socketCount)"
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
