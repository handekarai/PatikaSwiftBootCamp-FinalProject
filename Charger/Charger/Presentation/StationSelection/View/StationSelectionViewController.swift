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
        addNotificationCenter()
    }
    
    private func addNotificationCenter(){
        
        // post selected city name to StationListViewController
        let notificationDict = ["selectedCity": selectedCity]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedCityNotification"), object: nil, userInfo: notificationDict)
        
        // observers for station name filtering
        NotificationCenter.default.addObserver(self, selector: #selector(handleFilteredStaionListNotification(_:)), name: NSNotification.Name(rawValue: "FilteredStationListNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoStationFilterNotification(_:)), name: NSNotification.Name(rawValue: "NoStationFilterNotification"), object: nil)
    }
    
    // gets station list according to selected city. If location permission is given, list will be sorted otherwise not 
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
        
        // filter image has not given in assets for that reason i put "line.horizontal.3.decrease" image, it looks like filter image
        navigationBarItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .done, target: self, action: #selector(goToFilterScreen(_:)))
        navigationBarItem.rightBarButtonItem?.tintColor = Theme.navigationBarTitleColor
        
        
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
    
    //MARK: - Objc functions
    // change search bar border color and view's visibility acccording to station list data
    @objc func handleFilteredStaionListNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let list = dict["filteredList"] as? [Station] {
                if list.isEmpty {
                    self.stationView.alpha = 0
                    self.noStationView.alpha = 1
                    self.searchBar.layer.borderColor = UIColor.securityOnColor.cgColor
                }else {
                    self.stationView.alpha = 1
                    self.noStationView.alpha = 0
                    self.searchBar.layer.borderColor = UIColor.primaryColor.cgColor
                }
            }
        }
    }
    
    // change view to initial state
    @objc func handleNoStationFilterNotification(_ notification: NSNotification) {
        self.stationView.alpha = 1
        self.noStationView.alpha = 0
        self.searchBar.layer.borderColor = UIColor.greyScaleColor.cgColor
    }
    
    // goes to filter screen
    @objc func goToFilterScreen(_ sender: UIBarButtonItem) {
        // open filter screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
            viewModel.noFilter()
        }else{
            viewModel.filterStationList(searchedText: searchText, stationList: self.stationList)
        }
    }
}

// MARK: - StationSelectionViewModelDelegate funcs
extension StationSelectionViewController: StationSelectionViewModelDelegate {
    
    // makes invisible noStationView , shows stationView
    func didStationListFetched(data: [Station]) {
        
        // UI changes must be in main thread
        DispatchQueue.main.async {
            /* if selected city has no station, shows noStationView,
             search bar and filter button are disabled to user interaction (disabling search bar is my approach
             because there is no information about that situtaion in documents) */
            if data.isEmpty {
                self.navigationBarItem.rightBarButtonItem?.isEnabled = false
                self.searchBar.isUserInteractionEnabled = false
                self.searchBar.alpha = 0.5
                self.noStationView.alpha = 1
                self.stationView.alpha = 0
            }else {
                self.navigationBarItem.rightBarButtonItem?.isEnabled = true
                self.searchBar.isUserInteractionEnabled = true
                self.searchBar.alpha = 1
                self.stationList = data
                self.noStationView.alpha = 0
                self.stationView.alpha = 1
            }
        }
    }
}
