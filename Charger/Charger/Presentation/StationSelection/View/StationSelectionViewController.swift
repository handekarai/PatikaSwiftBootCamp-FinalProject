//
//  StationSelectionViewController.swift
//  Charger
//
//  Created by Hande Kara on 7/17/22.
//

import UIKit

class StationSelectionViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bodyBackgroundView: UIView!
    @IBOutlet weak var noStationView: UIView!
    @IBOutlet weak var stationView: UIView!
        
    let viewModel = StationSelectionViewModel()
    
    var selectedCity: String = ""
    var stationList: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getStationList(for: selectedCity)
        
        let notificationDict = ["selectedCity": selectedCity]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedCityNotification"), object: nil, userInfo: notificationDict)
    }
    
    private func getStationList(for selectedCity : String) {
        Task.init{
            await viewModel.getStationList(for: selectedCity)
        }
    }
    
    private func setupUI () {
        
        viewModel.delegate = self
        
        // needed for safe area background color
        view.backgroundColor = UIColor.charcoalGrey
        
        //navigation bar appearance to avoid different appearance which comes with ios15
        navigationBar.addAppearance()
        
        // set back button image and color
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goToBack(_:)))
        navigationBarItem.leftBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        // add gradient color to background
        bodyBackgroundView.addGradient()
        
        // set search bar properties
        searchBar.delegate = self
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string:"İstasyon Ara", attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)])
        searchBar.layer.cornerRadius = 22.5
        searchBar.clipsToBounds = true
        searchBar.layer.borderColor = UIColor.greyScaleColor.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.backgroundImage = UIImage.imageWithColor(color: UIColor.darkColor)
        searchBar.searchTextField.backgroundColor = Theme.searchTextFieldBgColor
        searchBar.searchTextField.leftView?.tintColor = UIColor.whiteColor
        searchBar.searchTextField.textColor = UIColor.whiteColor
    }
    
    // goes back to previous screen
    @objc func goToBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UISearchBarDelegate funcs
extension StationSelectionViewController: UISearchBarDelegate {
    
    // triggered when user writes something to search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // if clear(X) button is pressed , do not need filter
        if searchText.isEmpty{

        }else{
            
        }
    }
}

// MARK: - StationSelectionViewModelDelegate funcs
extension StationSelectionViewController: StationSelectionViewModelDelegate {
    
    // makes invisible noStationView , shows stationView
    func didStationListFetched(data: [Station]) {
        // UI changes must be in main thread
        DispatchQueue.main.async {
            // if selected city has no station, show noStationView
            if data.isEmpty {
                self.noStationView.alpha = 1
                self.stationView.alpha = 0
            }else {
                self.stationList = data
                self.noStationView.alpha = 0
                self.stationView.alpha = 1
            }
        }
    }
}
